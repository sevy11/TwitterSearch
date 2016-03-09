//
//  TweetCell.m
//  TwitterProject
//
//  Created by Michael Sevy on 3/6/16.
//  Copyright © 2016 Michael Sevy. All rights reserved.
//

#import "TweetCell.h"
#import "ViewController.h"
#import "Twitter.h"

@implementation TweetCell

- (IBAction)replyToTweet:(id)sender
{
    Twitter *twit = [Twitter new];
    NSString *tweetInfo = [NSString stringWithFormat:@"Tweet: %@", twit.twitterTweets];
    
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:@"Tweet:"
                                    message:@"Tweet Body"
                                    preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"Ok"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                             }];

    [alert addAction:ok];
    [self.delegate presentReplyAlertController:alert withTweetData:tweetInfo];
    //    [self presentViewController:alert animated:YES completion:nil];

}
@end
