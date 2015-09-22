//
//  ToastView.h
//  FreeTime
//
//  Created by Wilson Huang on 2015-07-18.
//  Copyright (c) 2015 Wilson Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToastView : UIView

@property (strong, nonatomic) NSString *text;

+ (void)showToastInParentView: (UIView *)parentView withText:(NSString *)text withDuaration:(float)duration;

@end