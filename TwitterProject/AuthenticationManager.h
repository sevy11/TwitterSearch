//
//  AuthenticationManager.h
//  TwitterProject
//
//  Created by Michael Sevy on 3/6/16.
//  Copyright © 2016 Michael Sevy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <STTwitter/STTwitter.h>

@interface AuthenticationManager : STTwitterAPI

typedef void (^resultBlockWithSuccess)(BOOL success, NSError *error);

@property(nonatomic, strong)NSString *username;
@property(nonatomic, strong)NSString *userID;

-(void)authenticateWithKeys;
-(void)verifyCredentials:(AuthenticationManager *)twitter withresultBlock:(resultBlockWithSuccess)success;
@end
