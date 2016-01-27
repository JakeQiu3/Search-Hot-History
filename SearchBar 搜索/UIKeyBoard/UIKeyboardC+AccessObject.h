//
//  UIKeyboard+AccessObject.h
//  VinuxPay
//
//  Created by MR-zhang on 15/4/23.
//  Copyright (c) 2015年 MR-zhang. All rights reserved.
//

@import UIKit;

#import "UIKeyboardC.h"
#import <objc/runtime.h>

@interface UIKeyboardC (AccessObject)

+ (void)setObserverView:(UIView *)observerView;
+ (UIView *)observerView;

+ (void)setFirstResponderView:(UIView *)firstResponderView;
+ (UIView *)firstResponderView;

+ (void)setOriginalViewFrame:(CGRect)originalViewFrame;
+ (CGRect)originalViewFrame;

+ (void)setKeyboardRect:(CGRect)keyboardRect;
+ (CGRect)keyboardRect;

+ (void)setKeyboardAnimationWithDuration:(double)keyboardAnimationDuration;
+ (double)keyboardAnimationWithDuration;

+ (void)setIsKeyboardShow:(BOOL)isKeyboardShow;
+ (BOOL)isKeyboardShow;

@end
