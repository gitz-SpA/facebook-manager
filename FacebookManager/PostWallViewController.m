//
//  PostWallViewController.m
//  FacebookManager
//
//  Created by Juan Eduardo Zumarán Salvatierra on 22-06-12.
//  Copyright (c) 2012 Juan Eduardo Zumarán Salvatierra. All rights reserved.
//

#import "PostWallViewController.h"

@interface PostWallViewController ()

@end

@implementation PostWallViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
