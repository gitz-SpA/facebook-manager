//
//  ViewController.h
//  FacebookManager
//
//  Created by Juan Eduardo Zumarán Salvatierra on 16-06-12.
//  Copyright (c) 2012 Juan Eduardo Zumarán Salvatierra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookManagerDelegate.h"

@interface LoginViewController : UIViewController <FacebookManagerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *facebookButton;

- (IBAction)facebookButtonPressed:(UIButton *)button;

@end
