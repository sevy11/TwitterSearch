//
//  AuthenticationManager.m
//  TwitterProject
//
//  Created by Michael Sevy on 3/6/16.
//  Copyright © 2016 Michael Sevy. All rights reserved.
//

#import "AuthenticationManager.h"
#import <STTwitter/STTwitter.h>

static NSString * const kTWITTER_CONSUMER_KEY = @"fx95oKhMHYgytSBmiAqQ";
static NSString * const kTWITTER_CONSUMER_SEC = @"0zfaijLMWMYTwVosdqFTL3k58JhRjZNxd2q0i9cltls";
static NSString * const kOAUTH_TOKEN = @"2305278770-GGw8dQQg3o5Vqfx9xHpUgJ0CDUe3BoNmUNeWZBg";
static NSString * const kOAUTH_SECRET = @"iEzxeJjEPnyODVcoDYt5MVvrg90Jx2TOetGdNeol6PeYp";

static NSString * const sevykTWITTER_CONSUMER_KEY = @"0OAfrSr5UaaVtxZskKvapJ9N0";
static NSString * const sevykTWITTER_CONSUMER_SEC = @"hq4QByDl3Cgf3nDxPMsRRizKTWpzJbuApfguUhcmeiV6d2nDHc";
static NSString * const sevykOAUTH_TOKEN = @"72962447-w4LPdlf6Agw7xslFFKELEyJvWC7HAcmT4POK6adB2";
static NSString * const sevykOAUTH_SECRET = @"unZ8LaKjAXxIy8zrRx7KHSfhlm8MrFMRqFgdG5aeqiT1A";

@interface AuthenticationManager ()

@property STTwitterAPI *twitter;

@end

@implementation AuthenticationManager

@dynamic userID;
@dynamic username;

-(void)authenticateWithKeys
{
    self.twitter = [STTwitterAPI twitterAPIWithOAuthConsumerKey:kTWITTER_CONSUMER_KEY consumerSecret:kTWITTER_CONSUMER_SEC oauthToken:kOAUTH_TOKEN oauthTokenSecret:kOAUTH_SECRET];
}

-(void)verifyCredentials:(AuthenticationManager *)twitter withresultBlock:(resultBlockWithSuccess)success
{
    [twitter verifyCredentialsWithUserSuccessBlock:^(NSString *username, NSString *userID) {

        if (userID)
        {
            success(YES, nil);
            self.username = username;
            self.userID = userID;
        }
        else
        {
            success(NO, nil);
            NSLog(@"authenticate failed");
        }

    } errorBlock:^(NSError *error) {

        NSLog(@"error: %@", error);
    }];
}
@end
