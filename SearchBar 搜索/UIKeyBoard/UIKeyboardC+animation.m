//
//  UIKeyboard+animation.m
//  VinuxPay
//
//  Created by MR-zhang on 15/4/23.
//  Copyright (c) 2015年 MR-zhang. All rights reserved.
//

#import "UIKeyboardC+animation.h"
#import "UIKeyboardC+AccessObject.h"

@implementation UIKeyboardC (animation)

#pragma mark -- classMethod
+ (void)changeFirstResponder:(UIView *)newFirstResponderView
{
    if ([self isKeyboardShow]) {
        [self createNewView:newFirstResponderView];
        [self setFirstResponderView:newFirstResponderView];
    } else {
        [self setFirstResponderView:newFirstResponderView];
    }
}

+ (void)keyBoardAnimation
{
    UIView *currentFirstResponder = [self firstResponderView];
    
    CGRect currentKeyboardRect = [[self observerView] convertRect:[self keyboardRect] fromView:nil];
    
    CGPoint objectLeftBottom = [currentFirstResponder convertPoint:CGPointMake(0, currentFirstResponder.frame.size.height) toView:[self observerView]];
    
    // UITextView work
    if ([currentFirstResponder isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)currentFirstResponder;
        objectLeftBottom.y += textView.contentOffset.y;
    }
    
    float shiftHeight = objectLeftBottom.y - currentKeyboardRect.origin.y;
    
    if (shiftHeight > 0) {
        [UIView animateWithDuration:[self keyboardAnimationWithDuration] animations:^{
            CGRect newFrame = [self observerView].frame;
            newFrame.origin.y = [self observerView].frame.origin.y - shiftHeight;
            [[self observerView] setFrame:newFrame];
        }];
    } else {
        [UIView animateWithDuration:[self keyboardAnimationWithDuration] animations:^{
            [[self observerView] setFrame:[self originalViewFrame]];
        }];
    }
}

#pragma mark -- private
+ (void)createNewView:(UIView *)newView
{
    CGRect currentKeyboardRect = [[self observerView] convertRect:[self keyboardRect] fromView:nil];
    CGPoint newObjectLeftBottom = [newView convertPoint:CGPointMake(0, newView.frame.size.height) toView:[self observerView]];
    //UITextView work
    if ([newView isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)newView;
        newObjectLeftBottom.y += textView.contentOffset.y;
    }
    
    float newShiftHeight = newObjectLeftBottom.y - currentKeyboardRect.origin.y;
    CGRect newFrame = [self observerView].frame;
    
    if (newFrame.origin.y-newShiftHeight < [self originalViewFrame].origin.y) {
        [UIView animateWithDuration:[self keyboardAnimationWithDuration] animations:^{
            CGRect newFrame = [self observerView].frame;
            newFrame.origin.y -= newShiftHeight;
            [[self observerView] setFrame:newFrame];
        }];
    } else {
        [UIView animateWithDuration:[self keyboardAnimationWithDuration] animations:^{
            [[self observerView] setFrame:[self originalViewFrame]];
        }];
    }
}
@end
