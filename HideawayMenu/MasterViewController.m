//
//  MasterViewController.m
//  HideawayMenu
//
//  Created by Srikanth Sombhatla on 21/02/13.
//  Copyright (c) 2013 Srikanth Sombhatla. All rights reserved.
//

#import "MasterViewController.h"

#define kWidthOfSideView 200
#define kAnimDuration 0.5

#define kTagTapOverlayView 1024

@interface MasterViewController ()

- (void)didSwipe:(id)sender;
- (void)didTap:(id)sender;
- (void)showLeftView;
- (void)hideLeftView;
- (void)resizeLeftView;
- (void)addController:(UIViewController*)controller;

@property (nonatomic, retain, readwrite) UIViewController* centralController;
@property (nonatomic, retain, readwrite) UIViewController* leftController;
@property (nonatomic, retain, readwrite) UIViewController* rightController;

@property (nonatomic, assign, readwrite) UISwipeGestureRecognizer* leftSwipe;
@property (nonatomic, assign, readwrite) UISwipeGestureRecognizer* rightSwipe;
@property (nonatomic, assign, readwrite) UITapGestureRecognizer* tap;

@property (nonatomic, assign, readwrite) BOOL isLeftViewShown;
@property (nonatomic, assign, readwrite) CGFloat widthOfLeftView;
@property (nonatomic, assign, readwrite) CGFloat widthOfRightView;
@property (nonatomic, assign, readwrite) CGFloat animationDuration;

@end

@implementation MasterViewController

#pragma mark pimpl

- (void)didSwipe:(id)sender {
    UISwipeGestureRecognizer* swipe = (UISwipeGestureRecognizer*)sender;
    
    if((UISwipeGestureRecognizerDirectionRight == swipe.direction) && (!self.isLeftViewShown)) {
         [self showLeftView];
    }
    
    if((UISwipeGestureRecognizerDirectionLeft == swipe.direction) && (self.isLeftViewShown)) {
        [self hideLeftView];
    }
}

- (void)didTap:(id)sender {
    if(self.isLeftViewShown) {
        [self hideLeftView];
    }
}

- (void)showLeftView {
    self.isLeftViewShown = YES;
    [self resizeLeftView];
    CGPoint newP = self.centralController.view.center;
    newP.x += self.widthOfLeftView;
    [UIView animateWithDuration:self.animationDuration animations:^(void) {
        self.centralController.view.center = newP;
    } completion:^(BOOL finished) {
        [self.tap setEnabled:YES];
        [self.rightSwipe setEnabled:NO];
        [self.leftSwipe setEnabled:YES];
    }];
}

- (void)hideLeftView {
    self.isLeftViewShown = NO;
    CGPoint newP = self.centralController.view.center;
    newP.x -= self.widthOfLeftView;
    [UIView animateWithDuration:self.animationDuration animations:^(void) {
        self.centralController.view.center = newP;
    } completion:^(BOOL finished) {
        [self.tap setEnabled:NO];
        [self.rightSwipe setEnabled:YES];
        [self.leftSwipe setEnabled:NO];
    }];
}

- (void)resizeLeftView {
    if(self.leftController.view) {
        UIView* v = self.leftController.view;
        CGRect newF = v.frame;
        newF.size.width = self.widthOfLeftView;
        v.frame = newF;
    }
}

- (void)addController:(UIViewController*)controller {
    if(!controller) {
        NSLog(@"%s Not adding nil controller",__PRETTY_FUNCTION__);
        return;
    }
    CGRect newF = controller.view.frame;
    newF.origin.x = 0; // just make sure it is at 0
    controller.view.frame = newF;
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
}

- (id)initWithCentralController:(UIViewController*)centralController
                   leftController:(UIViewController*)leftController
                  rightController:(UIViewController*)rightContrller {
    self = [super init];
    if(self) {
        _centralController = [centralController retain];
        _leftController = [leftController retain];
        _rightController = [rightContrller retain];
        
        self.widthOfLeftView = kWidthOfSideView;
        self.widthOfRightView = kWidthOfSideView;
        self.animationDuration = kAnimDuration;
    }
    return self;
}

- (void)dealloc {
    [_centralController release];
    [_leftController release];
    [_rightController release];
    [super dealloc];
}

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
    self.view.autoresizesSubviews = NO;
    self.view.backgroundColor = [UIColor redColor];
    
    /*!
    Place the left, center and right in the respective order
    When swiped move center view either right/left depending on the swipe direction, so that left/right is visible.
    **/
    
    [self addController:self.leftController];
    // TODO:Right controller is not yet supported
    //[self addController:self.rightController];
    if(self.rightController) {
        NSLog(@"%s Right controller is not yet supported!",__PRETTY_FUNCTION__);
    }
    [self addController:self.centralController];
    
    // add gestures
    self.rightSwipe = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)] autorelease];
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipe];
    
    self.leftSwipe = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)] autorelease];
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.leftSwipe setEnabled:NO];
    [self.view addGestureRecognizer:self.leftSwipe];
    
    self.tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)] autorelease];
    [self.centralController.view addGestureRecognizer:self.tap];
    
}

- (void)viewWillAppear:(BOOL)animated {
    // Do something important before appearing
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
