//
//  UIView+FirstResponderNotification.m
//  VinuxPay
//
//  Created by MR-zhang on 15/4/23.
//  Copyright (c) 2015年 MR-zhang. All rights reserved.
//

#import "UIView+FirstResponderNotification.h"
#import <objc/runtime.h>
#import "UIKeyboardC+AccessObject.h"
#import "UIKeyboardC+animation.h"


@implementation UIView (FirstResponderNotification)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 转移方法
        [self swizzle:@selector(becomeFirstResponder) to:@selector(swizzle_becomeFirstResponder)];
    });
}

#pragma mark -- method swizzling
- (BOOL)swizzle_becomeFirstResponder
{
    if ([UIKeyboardC observerView]) {
        if ([self isViewInSuper:[UIKeyboardC observerView]]) {
            [UIKeyboardC changeFirstResponder:self];
        }
    }
    return [self swizzle_becomeFirstResponder];
}

#pragma mark -- private method
- (BOOL)isViewInSuper:(UIView *)targetView
{
    if (self.superview) {
        if (self.superview == targetView) {
            return YES;
        } else {
            return [self.superview isViewInSuper:targetView];
        }
    } else return NO;
}

+ (void)swizzle:(SEL)before to:(SEL)after
{
    Class cls = [self class];
    
    SEL originalSelector = before;
    SEL swizzledSelector = after;
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
