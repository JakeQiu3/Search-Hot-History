//
//  UIKeyboard.m
//  VinuxPay
//
//  Created by qsy on 15/4/23.
//  Copyright (c) 2015年 qsy. All rights reserved.
//

#import "UIKeyboardC.h"
#import "UIView+FirstResponderNotification.h"
#import "UIKeyboardC+animation.h"
#import "UIKeyboardC+AccessObject.h"

@interface UIKeyboardC ()
+ (void)keyboardWillShow:(NSNotification *)notification;
+ (void)keyboardWillHide:(NSNotification *)notification;
+ (void)addObservers;
+ (void)removeObservers;
@end

@implementation UIKeyboardC
#pragma mark -- private
+ (void)keyboardWillShow:(NSNotification *)notification
{
    [self setIsKeyboardShow:YES];
    
    NSDictionary *userInfo = [notification userInfo];
    
    [self setKeyboardAnimationWithDuration:[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];

    [self setKeyboardRect:[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue]];
    
    [self keyBoardAnimation];
}

+ (void)keyboardWillHide:(NSNotification *)notification
{
    [self setIsKeyboardShow:NO];
    [self keyBoardAnimation];
}

+ (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

+ (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -- class Method
+ (void)addRegisterOnKeyboardView:(UIView *)view
{
    [self setObserverView:view];
    [self setOriginalViewFrame:view.frame];
    [self setIsKeyboardShow:NO];
    [self addObservers];
}

+ (void)removeRegisterOnKeyboardView
{
    objc_removeAssociatedObjects(self);
    [self removeObservers];
}

@end
