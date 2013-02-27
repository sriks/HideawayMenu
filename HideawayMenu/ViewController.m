//
//  ViewController.m
//  HideawayMenu
//
//  Created by Srikanth Sombhatla on 15/02/13.
//  Copyright (c) 2013 Srikanth Sombhatla. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
- (void)showMaster;
- (void)swiped:(id)swipe;

@end

@implementation ViewController

#pragma mark pimpl

- (void)showMaster {
//    if(self.masterViewController) {
//        UIView* v = self.masterViewController.view;
//        [[self.view superview] addSubview:v];
//        [self.view.superview bringSubviewToFront:self.view];
//        CGRect newFrame = self.view.frame;
//        newFrame.origin.x = 200;
//        [UIView animateWithDuration:3 animations:^(void) {
//            self.view.frame = newFrame;
//        }];
//    }
}

- (void)dealloc {
    [_masterViewController release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    UISwipeGestureRecognizer* swipeRight = [[[UISwipeGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(swiped:)] autorelease];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer* swipeLeft = [[[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(swiped:)] autorelease];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipeRight];
    [self.view addGestureRecognizer:swipeLeft];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIGestureRecognizer

- (void)swiped:(id)sender {
    UISwipeGestureRecognizer* swipe = (UISwipeGestureRecognizer*)sender;
    if(UISwipeGestureRecognizerDirectionRight == swipe.direction)
       [self showMaster];
}


@end
