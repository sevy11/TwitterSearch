//
//  ViewController.m
//  TwitterProject
//
//  Created by Michael Sevy on 3/6/16.
//  Copyright © 2016 Michael Sevy. All rights reserved.
//

#import "ViewController.h"
#import "TweetCell.h"
#import "TwitterManager.h"
#import "Twitter.h"
#import <STTwitter/STTwitter.h>

static NSString * const kTWITTER_CONSUMER_KEY = @"fx95oKhMHYgytSBmiAqQ";
static NSString * const kTWITTER_CONSUMER_SEC = @"0zfaijLMWMYTwVosdqFTL3k58JhRjZNxd2q0i9cltls";
static NSString * const kOAUTH_TOKEN = @"2305278770-GGw8dQQg3o5Vqfx9xHpUgJ0CDUe3BoNmUNeWZBg";
static NSString * const kOAUTH_SECRET = @"iEzxeJjEPnyODVcoDYt5MVvrg90Jx2TOetGdNeol6PeYp";
static NSString * const kCell = @"Cell";

@interface ViewController ()<STTwitterRequestProtocol,
TwitterManagerDelegate,
TweetCellDelegate,
UITableViewDataSource,
UITableViewDelegate,
UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *parsedTwitterArray;
@property (strong, nonatomic) STTwitterAPI *twitter;

@property (strong, nonatomic) NSString *selectedTweet;
@property (strong, nonatomic) NSString *selectedTweetID;
@property (strong, nonatomic) NSString *selectedUserID;

@property (strong, nonatomic) NSString *searchTerm;
@property (strong, nonatomic) UISearchBar *searchBar;


@property BOOL inlinePhoto;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.parsedTwitterArray = [NSMutableArray new];

    self.inlinePhoto = NO;

    self.searchBar = [UISearchBar new];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search Twitter";
    [_searchBar becomeFirstResponder];

    self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kTWITTER_CONSUMER_KEY consumerSecret:kTWITTER_CONSUMER_SEC oauthToken:kOAUTH_TOKEN oauthTokenSecret:kOAUTH_SECRET];//    [self.twitter

    [self.twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
        NSLog(@"twitter user: %@", username);
    } errorBlock:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];



}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    TwitterManager *twitterMan = [[TwitterManager alloc]init];
    twitterMan.delegate = self;

    [twitterMan loadTweetsWithSearch:self.twitter andSearch:searchBar.text andCount:@"5" withSuccess:^(BOOL success, NSError *error) {

    }];
    [self.tableView reloadData];
}


-(void)didSearchTwitter:(NSArray *)searchTerm
{
    //1st object
    Twitter *twit = [searchTerm objectAtIndex:2];
    //NSLog(@"array from delegate: %@", twit.timeStamp);
    [self.tableView reloadData];
}

-(void)parseData:(NSArray *)inputArray
{
   // NSLog(@"inputArray: %@", inputArray);
    NSMutableArray *array = [inputArray copy];
    self.parsedTwitterArray = array;
    NSLog(@"prseData delegate: %@", self.parsedTwitterArray);
    [self.tableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.parsedTwitterArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    Twitter *twit = [self.parsedTwitterArray objectAtIndex:indexPath.row];
    cell.screenName.text = twit.screeName;
    cell.timeLabel.text = twit.timeStamp;
    cell.textView.text = twit.tweetText;
    cell.locationLabel.text = twit.location;
    cell.profileImage.image = [UIImage imageWithData:twit.profileData];
    cell.delegate = self;

    self.selectedTweet = twit.tweetText;
    return cell;
}

-(void)presentReplyAlertController:(UIAlertController *)controller withTweetData:(NSString *)tweetID
{
    tweetID = self.selectedTweet;
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Twitter *tweet = [self.parsedTwitterArray objectAtIndex:indexPath.row];
    self.selectedTweet = tweet.tweetText;
    self.selectedUserID = tweet.userID;
    self.selectedTweetID = tweet.tweetID;
    NSLog(@"tweet: %@\n%@\n%@", self.selectedTweet, self.selectedTweetID, self.selectedUserID);


    NSString *tweetInfo = [NSString stringWithFormat:@"Tweet: %@\nTweet ID: %@\nUser ID: %@", self.selectedTweet, self.selectedTweetID, self.selectedUserID];

    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Tweet:"
                                message:tweetInfo
                                preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                         }];

    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];

}

@end
