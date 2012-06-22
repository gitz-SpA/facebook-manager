//
//  FacebookManager.h
//  FacebookManager
//
//  Created by Juan Eduardo Zumarán Salvatierra on 16-06-12.
//  Copyright (c) 2012 Juan Eduardo Zumarán Salvatierra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"
#import "FacebookManagerDelegate.h"

static NSString *const kFBAppId = @"313755492049888";
static NSString *const kFBAccessTokenKey = @"FBAccessTokenKey";
static NSString *const kFBExpirationDateKey = @"FBExpirationDateKey";

@interface FacebookManager : NSObject <FBSessionDelegate, FBDialogDelegate, FBRequestDelegate> {
    Facebook *_facebook;
    NSObject<FacebookManagerDelegate> *_delegate;
}

@property (nonatomic, strong) Facebook *facebook;
@property (nonatomic, strong) NSURL *openedURL;
@property (nonatomic, strong) NSObject<FacebookManagerDelegate> *delegate;

+ (FacebookManager *)sharedManager;

- (void)loginWithDelegate:(NSObject<FacebookManagerDelegate> *)delegate;
- (void)loginWithDelegate:(NSObject<FacebookManagerDelegate> *)delegate andPermissions:(NSArray *)permissions;
- (void)logoutWithDelegate:(NSObject<FacebookManagerDelegate> *)delegate;
- (void)sendRequest;
- (void)sendInvites:(NSString *)message;

@end