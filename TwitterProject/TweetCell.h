//
//  TweetCell.h
//  TwitterProject
//
//  Created by Michael Sevy on 3/6/16.
//  Copyright © 2016 Michael Sevy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TweetCellDelegate <NSObject>

@optional
-(void)presentReplyAlertController:(UIAlertController *)controller withTweetData:(NSString *)tweetID;

@end

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *screenName;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *replyImage;
@property (nonatomic, retain) id<TweetCellDelegate> delegate;

@end
