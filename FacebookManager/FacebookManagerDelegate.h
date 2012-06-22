//
//  FacebookManagerDelegate.h
//  FacebookManager
//
//  Created by Juan Eduardo Zumarán Salvatierra on 16-06-12.
//  Copyright (c) 2012 Juan Eduardo Zumarán Salvatierra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"

@protocol FacebookManagerDelegate <NSObject>

@optional

- (void)facebookLoginDidSucceed;
- (void)facebookLoginDidFailWithError:(NSError *)error;

- (void)facebookLogoutDidSucceed;
- (void)facebookLogoutDidFailWithError:(NSError *)error;

@end
