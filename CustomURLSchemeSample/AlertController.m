//
//  AlertController.m
//  CustomURLSchemeSample
//
//  Created by Naoto Horiguchi on 2013/12/09.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import "AlertController.h"

@implementation AlertController

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

- (BOOL)showAction:(NSDictionary *)query
{
    if (query[@"title"] && query[@"message"]) {
        [[[UIAlertView alloc] initWithTitle:query[@"title"] message:query[@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        return YES;
    }
    return NO;
}

@end
