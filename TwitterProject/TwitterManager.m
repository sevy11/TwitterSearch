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
            //parse tweets and assign to delegate property
            //NSLog(@"array formthe raw: %@", statuses);
            NSMutableArray *mut = [NSMutableArray arrayWithArray:statuses];
            NSMutableArray *oldArray = [self parseTwitterArray:mut];

            [self.delegate didSearchTwitter:oldArray];
    
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"error: %@", error);
    }];
}

-(NSMutableArray *)parseTwitterArray:(NSMutableArray *)tweets
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
            if (inlineImage)
            {
                [self stringURLToData:inlineImage];
            }
            tweet.inlinePhoto = YES;
        }

        NSString *created = dict[@"created_at"];
        tweet.location = userData[@"location"];
        NSString *profilePic = userData[@"profile_image_url"];
        tweet.screeName = userData[@"screen_name"];
        tweet.timezone = userData[@"time_zone"];
        tweet.uTCOffset = userData[@"utc_offset"];
        tweet.tweetText = dict[@"text"];
        tweet.tweetID = dict[@"id_str"];
        tweet.userID = userData[@"id_str"];

        NSData *profileData = [self stringURLToData:profilePic];
        [self stringURLToData:tweet.profileImage];
        NSString *timeFromNow = [self createdAtToTimeFromNow:created];
        tweet.timeStamp = timeFromNow;
        tweet.profileData = profileData;

        [self.tweets addObject:tweet];
    }
    
    [self.delegate parseData:self.tweets];

    return self.tweets;
}

-(NSData *)stringURLToData:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];

    return data;
}
-(NSString *)createdAtToTimeFromNow:(NSString *)createdAt
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSDate *tweetDate = [NSDate new];
    tweetDate = [formatter dateFromString:createdAt];
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *format = [NSDateFormatter new];
    [format setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    float timingDiff = [nowDate timeIntervalSinceDate:tweetDate];

    if (timingDiff < 1)
    {
        NSString *sec = [NSString stringWithFormat:@"Error"];
        return sec;
    }
    else if (timingDiff < 60)
    {
        NSString *min = [NSString stringWithFormat:@"%fsec",timingDiff];
        return min;
    }
    else if (timingDiff < 3600)
    {
        int diffRound = round(timingDiff / 60);
        NSString *hour = [NSString stringWithFormat:@"%dmin", diffRound];
        return hour;
    }
    else if (timingDiff < 86400)
    {
        int diffRound = round(timingDiff / 60 / 60);
        NSString *day = [NSString stringWithFormat:@"%dh", diffRound];
        return day;
    }
    else if (timingDiff < 2629743)
    {
        int diffRound = round(timingDiff / 60 / 60 / 24);
        NSString *week = [NSString stringWithFormat:@"%ddays", diffRound];
        return week;
    }
    else if (timingDiff < 18408201)
    {
        int diffRound = round(timingDiff / 60 / 60 / 24 / 7);
        NSString *month = [NSString stringWithFormat:@"%dweeks", diffRound];
        return month;
    }
    else
    {
        NSString *overWeek = [NSString stringWithFormat:@"> week"];
        return overWeek;
    }
}
    @end
    
    
    
    
    
