//
//  DetailScreenViewController.h
//  FreeTime
//
//  Created by Wilson Huang on 2015-07-15.
//  Copyright (c) 2015 Wilson Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface DetailScreenViewController : UIViewController


@property (weak, nonatomic) NSString* taskTitle;
@property (weak, nonatomic) NSString* descriptions;
@property (weak, nonatomic) NSString* urgent;
@property (weak, nonatomic) NSString* important;
@property (weak, nonatomic) NSIndexPath* tableRowPath;
@property (weak, nonatomic) ViewController* homePage;

@end
