//
//  MasterViewController.h
//  HideawayMenu
//
//  Created by Srikanth Sombhatla on 21/02/13.
//  Copyright (c) 2013 Srikanth Sombhatla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UIViewController

- (id)initWithCentralController:(UIViewController*)centralController
                   leftController:(UIViewController*)leftController
                  rightController:(UIViewController*)rightContrller;

@property (nonatomic, retain, readonly) UIViewController* centralController;
@property (nonatomic, retain, readonly) UIViewController* leftController;
@property (nonatomic, retain, readonly) UIViewController* rightController;

@end
