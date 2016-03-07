//
//  ViewController.m
//  TwitterProject
//
//  Created by Michael Sevy on 3/6/16.
//  Copyright © 2016 Michael Sevy. All rights reserved.
//

#import "ViewController.h"
#import <STTwitter/STTwitter.h>

static NSString * const kTWITTER_CONSUMER_KEY = @"fx95oKhMHYgytSBmiAqQ";
static NSString * const kTWITTER_CONSUMER_SEC = @"0zfaijLMWMYTwVosdqFTL3k58JhRjZNxd2q0i9cltls";
static NSString * const kOAUTH_TOKEN = @"2305278770-GGw8dQQg3o5Vqfx9xHpUgJ0CDUe3BoNmUNeWZBg";
static NSString * const kOAUTH_SECRET = @"iEzxeJjEPnyODVcoDYt5MVvrg90Jx2TOetGdNeol6PeYp";

static NSString * const sevykTWITTER_CONSUMER_KEY = @"0OAfrSr5UaaVtxZskKvapJ9N0";
static NSString * const sevykTWITTER_CONSUMER_SEC = @"hq4QByDl3Cgf3nDxPMsRRizKTWpzJbuApfguUhcmeiV6d2nDHc";
static NSString * const sevykOAUTH_TOKEN = @"72962447-w4LPdlf6Agw7xslFFKELEyJvWC7HAcmT4POK6adB2";
static NSString * const sevykOAUTH_SECRET = @"unZ8LaKjAXxIy8zrRx7KHSfhlm8MrFMRqFgdG5aeqiT1A";

@interface ViewController ()<STTwitterRequestProtocol>

@property STTwitterAPI *twitter;
@property BOOL inlinePhoto;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.inlinePhoto = NO;
    
    self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kTWITTER_CONSUMER_KEY consumerSecret:kTWITTER_CONSUMER_SEC oauthToken:kOAUTH_TOKEN oauthTokenSecret:kOAUTH_SECRET];
    [self.twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {
        NSLog(@"success, u:%@ ID:%@", username, userID);



    } errorBlock:^(NSError *error) {
        NSLog(@"error: %@", error);
        
    }];
    //NSString *geocodeStr = @"42.736948,-84.486663,5mi";
    NSString *countStr = @"5";
    [self.twitter getSearchTweetsWithQuery:@"josh+Jackson" geocode:nil count:countStr successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
        NSLog(@"results: %@", statuses);
        NSLog(@"meta: %@", searchMetadata);

        for (NSDictionary *dict in statuses)
        {
            NSDictionary *userData = dict[@"user"];
            NSDictionary *entity = dict[@"entities"];

            if (entity)
            {
                NSArray *mediaArr = entity[@"media"];
                NSDictionary *media = [mediaArr firstObject];
                NSString *inlineImage = media[@"media_url_https"];
                NSLog(@"inline Image: %@", inlineImage);
                self.inlinePhoto = YES;
            }
            NSString *createdAt = userData[@"created_at"];
            NSString *location = userData[@"location"];
            NSString *profileImageURLStr = userData[@"profile_image_url"];
            NSString *screenName = userData[@"screen_name"];
            NSString *timeZone = userData[@"time_zone"];
            NSString *utcOffset = userData[@"utc_offset"];
            NSString *tweetText = dict[@"text"];
            NSString *tweetID = dict[@"id_str"];
            NSString *userID = userData[@"id_str"];
            NSLog(@"screenName: %@, time: %@, loc: %@, image: %@, timeZone: %@, utcOff: %@, text: %@, TweetID: %@, userID: %@", screenName, createdAt, location, profileImageURLStr, timeZone, utcOffset, tweetText, tweetID, userID);
        }

    } errorBlock:^(NSError *error)  {
        NSLog(@"error: %@", error);
    }];

}

-(void)viewDidAppear:(BOOL)animated
{

}


@end
