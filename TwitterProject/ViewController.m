//
//  ViewController.m
//  TwitterProject
//
//  Created by Michael Sevy on 3/6/16.
//  Copyright © 2016 Michael Sevy. All rights reserved.
//

#import "ViewController.h"
#import "TweetCell.h"
#import "AuthenticationManager.h"
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
UITableViewDataSource,
UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *fullTweets;
@property (strong, nonatomic) STTwitterAPI *twitter;
@property BOOL inlinePhoto;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.delegate = self;
    
    self.inlinePhoto = NO;
    self.fullTweets = [NSArray new];


    self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kTWITTER_CONSUMER_KEY consumerSecret:kTWITTER_CONSUMER_SEC oauthToken:kOAUTH_TOKEN oauthTokenSecret:kOAUTH_SECRET];//    [self.twitter

    [self.twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
        NSLog(@"twitter user: %@", username);
    } errorBlock:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];

    TwitterManager *twitter = [[TwitterManager alloc]init];
    twitter.delegate = self;
    [twitter loadTweetsWithSearch:self.twitter andSearch:@"izzo" andCount:@"3" withSuccess:^(BOOL success, NSError *error) {
        TwitterManager *tweet = [TwitterManager new];
        NSLog(@"from VC: %@", tweet.tweets);
    }];

}

-(void)didSearchTwitter:(NSArray *)searchTerm
{
    self.fullTweets = searchTerm;
    TwitterManager *tweet = [TwitterManager new];
    NSLog(@"from VC: %@", self.fullTweets);//this works but want to parase data on model, not here
}

-(void)parseData:(NSArray *)inputArray
{
    self.fullTweets = inputArray;
    Twitter * twit = [Twitter new];
    NSLog(@"username: %@", twit.screeName);
}


- (IBAction)onButtonTap:(UIButton *)sender
{
//    TwitterManager *twitM = [TwitterManager new];
//    NSLog(@"saerches: %@", twitM.tweets);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fullTweets.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    Twitter *twit = [self.fullTweets objectAtIndex:indexPath.row];
    cell.screenName.text = twit.screeName;
    cell.timeLabel.text = twit.tweetID;
    cell.textLabel.text = twit.tweetText;

    return cell;
}


#pragma mark -- helpers

-(void)loadTweetsWithSearch:(NSString *)search andCount:(NSString *)count withSuccess:(resultBlockWithSuccess)success
{
    STTwitterAPI *tweet = [[STTwitterAPI alloc]init];
    [tweet getSearchTweetsWithQuery:search geocode:nil count:count successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {

        if (statuses)
        {
            NSLog(@"results from twitter manager: %@", statuses);
            //self.tweets = statuses;
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
}

@end
