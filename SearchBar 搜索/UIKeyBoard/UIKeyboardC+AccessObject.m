//
//  UIKeyboard+AccessObject.m
//  VinuxPay
//
//  Created by MR-zhang on 15/4/23.
//  Copyright (c) 2015年 MR-zhang. All rights reserved.
//

#import "UIKeyboardC+AccessObject.h"

static const char OBSERVERVIEWPOINTER;
static const char FIRSTRESPONDERVIEWPOINTER;
static const char ORIGINALVIEWFRAMEPOINTER;
static const char KEYBOARDRECTPOINTER;
static const char KEYBOARDANIMATIONWITHDURATIONPOINTER;
static const char ISKEYBOARDSHOWPOINTER;

@implementation UIKeyboardC (AccessObject)

+ (void)setObserverView:(UIView *)observerView
{
    objc_setAssociatedObject(self, &OBSERVERVIEWPOINTER, observerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (UIView *)observerView
{
    return objc_getAssociatedObject(self, &OBSERVERVIEWPOINTER);
}

+ (void)setFirstResponderView:(UIView *)firstResponderView
{
    objc_setAssociatedObject(self, &FIRSTRESPONDERVIEWPOINTER, firstResponderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (UIView *)firstResponderView
{
    return objc_getAssociatedObject(self, &FIRSTRESPONDERVIEWPOINTER);
}

+ (void)setOriginalViewFrame:(CGRect)originalViewFrame
{
    objc_setAssociatedObject(self, &ORIGINALVIEWFRAMEPOINTER, [NSValue valueWithCGRect:originalViewFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (CGRect)originalViewFrame
{
    return [objc_getAssociatedObject(self, &ORIGINALVIEWFRAMEPOINTER) CGRectValue];
}

+ (void)setKeyboardRect:(CGRect)keyboardRect
{
    objc_setAssociatedObject(self, &KEYBOARDRECTPOINTER, [NSValue valueWithCGRect:keyboardRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (CGRect)keyboardRect
{
    return [objc_getAssociatedObject(self, &KEYBOARDRECTPOINTER) CGRectValue];
}

+ (void)setKeyboardAnimationWithDuration:(double)keyboardAnimationDuration
{
    objc_setAssociatedObject(self, &KEYBOARDANIMATIONWITHDURATIONPOINTER, [NSNumber numberWithDouble:keyboardAnimationDuration], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (double)keyboardAnimationWithDuration
{
    return [objc_getAssociatedObject(self, &KEYBOARDANIMATIONWITHDURATIONPOINTER) doubleValue];
}

+ (void)setIsKeyboardShow:(BOOL)isKeyboardShow
{
    objc_setAssociatedObject(self, &ISKEYBOARDSHOWPOINTER, [NSNumber numberWithBool:isKeyboardShow], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (BOOL)isKeyboardShow
{
    return [objc_getAssociatedObject(self, &ISKEYBOARDSHOWPOINTER) boolValue];
}

@end
