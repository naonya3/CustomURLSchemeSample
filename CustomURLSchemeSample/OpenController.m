//
//  OpenController.m
//  CustomURLSchemeSample
//
//  Created by Naoto Horiguchi on 2013/12/09.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import "OpenController.h"
#import "Page1ViewController.h"

@implementation OpenController

- (BOOL)action:(NSString *)action query:(NSDictionary *)query
{
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@Action:", action]);
    if ([self respondsToSelector:sel]) {
        BOOL (*actionImp)(id, SEL, NSDictionary *);
        actionImp = (BOOL (*)(id, SEL, NSDictionary *))[self methodForSelector:sel];
        return actionImp(self, sel, query);
    }
    return NO;
}

- (BOOL)page1Action:(NSDictionary *)query
{
    // 現在表示されているViewControllerの親を探す
    UIViewController *viewController = [[UIApplication sharedApplication] keyWindow].rootViewController;
    while ([viewController presentedViewController]) {
        viewController = [viewController presentedViewController];
    }
    
    [viewController presentViewController:[Page1ViewController new] animated:YES completion:nil];
    return YES;
}

@end
