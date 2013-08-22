//
//  CentralViewController.m
//  HideawayMenu
//
//  Created by Srikanth Sombhatla on 21/02/13.
//  Copyright (c) 2013 Srikanth Sombhatla. All rights reserved.
//

#import "CentralViewController.h"

@interface CentralViewController ()

@end

@implementation CentralViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Central";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"%s %@ navitem %@ and navbar is%@ ",__PRETTY_FUNCTION__, self, self.navigationItem,    self.navigationController.navigationBar);
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
