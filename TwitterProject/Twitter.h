//
//  Twitter.h
//  TwitterProject
//
//  Created by Michael Sevy on 3/7/16.
//  Copyright © 2016 Michael Sevy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Twitter : NSObject

@property(nonatomic, strong)NSString *createdAt;
@property(nonatomic, strong)NSString *location;
@property(nonatomic, strong)NSString *profileImage;
@property(nonatomic, strong)NSString *screeName;
@property(nonatomic, strong)NSString *timezone;
@property(nonatomic, strong)NSString *uTCOffset;
@property(nonatomic, strong)NSString *tweetText;
@property(nonatomic, strong)NSString *tweetID;
@property(nonatomic, strong)NSString *userID;
@property(nonatomic, strong)NSArray *twitterTweets;

@property BOOL inlinePhoto;




@end
