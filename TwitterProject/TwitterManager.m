//
//  TwitterManager.m
//  TwitterProject
//
//  Created by Michael Sevy on 3/7/16.
//  Copyright © 2016 Michael Sevy. All rights reserved.
//

#import "TwitterManager.h"
#import <STTwitter/STTwitter.h>
#import "Twitter.h"

@implementation TwitterManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tweets = [NSMutableArray new];

    }

    return self;
}


-(void)loadTweetsWithSearch:(STTwitterAPI *)sttObj andSearch:(NSString *)search andCount:(NSString *)count withSuccess:(resultBlockWithSuccess)success
{
    [sttObj getSearchTweetsWithQuery:search geocode:nil count:count successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {

        if (statuses)
        {
            //NSLog(@"results from twitter manager: %@", statuses);
            [self parseTwitterArray:statuses];//this is working to parse data from array but it's stuck in this class
            [self.delegate didSearchTwitter:statuses];
            //[self.delegate parseData:statuses];

        }
    } errorBlock:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
}

-(void)parseTwitterArray:(NSArray *)tweets
{
    Twitter *tweet = [Twitter new];

    for (NSDictionary *dict in tweets)
    {
        NSDictionary *userData = dict[@"user"];
        NSDictionary *entity = dict[@"entities"];

        if (entity)
        {
            NSArray *mediaArr = entity[@"media"];
            NSDictionary *media = [mediaArr firstObject];
            NSString *inlineImage = media[@"media_url_https"];
            NSLog(@"inline Image: %@", inlineImage);
            tweet.inlinePhoto = YES;
        }
        tweet.createdAt = userData[@"created_at"];
        tweet.location = userData[@"location"];
        tweet.profileImage = userData[@"profile_image_url"];
        tweet.screeName = userData[@"screen_name"];
        tweet.timezone = userData[@"time_zone"];
        tweet.uTCOffset = userData[@"utc_offset"];
        tweet.tweetText = dict[@"text"];
        tweet.tweetID = dict[@"id_str"];
        tweet.userID = userData[@"id_str"];

        [self.tweets addObject:tweet];
         NSLog(@"screenName: %@, time: %@, loc: %@, image: %@, timeZone: %@, utcOff: %@, text: %@, TweetID: %@, userID: %@", tweet.screeName, tweet.createdAt, tweet.location, tweet.profileImage, tweet.timezone, tweet.uTCOffset, tweet.tweetText, tweet.tweetID, tweet.userID);
        //[self.delegate parseData:tweets];
        
    }
}


//NSString *geocodeStr = @"42.736948,-84.486663,5mi";
//    NSString *countStr = @"5";
//    [self.twitter getSearchTweetsWithQuery:@"josh+Jackson" geocode:nil count:countStr successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
//        NSLog(@"results: %@", statuses);
//        NSLog(@"meta: %@", searchMetadata);
//
//        for (NSDictionary *dict in statuses)
//        {
//            NSDictionary *userData = dict[@"user"];
//            NSDictionary *entity = dict[@"entities"];
//
//            if (entity)
//            {
//                NSArray *mediaArr = entity[@"media"];
//                NSDictionary *media = [mediaArr firstObject];
//                NSString *inlineImage = media[@"media_url_https"];
//                NSLog(@"inline Image: %@", inlineImage);
//                self.inlinePhoto = YES;
//            }
//            NSString *createdAt = userData[@"created_at"];
//            NSString *location = userData[@"location"];
//            NSString *profileImageURLStr = userData[@"profile_image_url"];
//            self.screenName = userData[@"screen_name"];
//            NSString *timeZone = userData[@"time_zone"];
//            NSString *utcOffset = userData[@"utc_offset"];
//            NSString *tweetText = dict[@"text"];
//            NSString *tweetID = dict[@"id_str"];
//            NSString *userID = userData[@"id_str"];
//            NSLog(@"screenName: %@, time: %@, loc: %@, image: %@, timeZone: %@, utcOff: %@, text: %@, TweetID: %@, userID: %@", self.screenName, createdAt, location, profileImageURLStr, timeZone, utcOffset, tweetText, tweetID, userID);
//
//            [self.tableView reloadData];
//
//        }
//
//    } errorBlock:^(NSError *error)  {
//        NSLog(@"error: %@", error);
//    }];
@end





