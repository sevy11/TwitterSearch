//
//  TwitterManager.h
//  TwitterProject
//
//  Created by Michael Sevy on 3/7/16.
//  Copyright © 2016 Michael Sevy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <STTwitter/STTwitter.h>

typedef void (^resultBlockWithSuccess)(BOOL success, NSError *error);

@protocol TwitterManagerDelegate <NSObject>

@optional
-(void)didSearchTwitter:(NSArray *)searchTerm;
-(void)parseData:(NSArray *)inputArray;
@end

@interface TwitterManager : NSObject

@property(nonatomic, weak)id<TwitterManagerDelegate>delegate;

@property(nonatomic, strong)NSMutableArray *tweets;

-(void)loadTweetsWithSearch:(STTwitterAPI *)sttObj andSearch:(NSString *)search andCount:(NSString *)count withSuccess:(resultBlockWithSuccess)success;
-(NSMutableArray *)parseTwitterArray:(NSMutableArray *)tweets;
-(NSData *)stringURLToData:(NSString *)urlString;

@end
