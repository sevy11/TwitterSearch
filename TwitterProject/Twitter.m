//
//  Twitter.m
//  TwitterProject
//
//  Created by Michael Sevy on 3/7/16.
//  Copyright © 2016 Michael Sevy. All rights reserved.
//

#import "Twitter.h"

@implementation Twitter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.createdAt = [NSString new];
        self.location = [NSString new];
        self.profileImage = [NSString new];
        self.screeName = [NSString new];
        self.timezone = [NSString new];
        self.uTCOffset = [NSString new];
        self.tweetText = [NSString new];
        self.tweetID = [NSString new];
        self.userID = [NSString new];
        self.twitterTweets = [NSArray new];
        self.inlinePhoto = NO;
    }

    return self;
}
@end
