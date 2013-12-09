//
//  Routs.m
//  CustomURLSchemeSample
//
//  Created by Naoto Horiguchi on 2013/12/09.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import "Routs.h"

#import "ControllerProtocol.h"

@implementation Routs

- (BOOL)openURL:(NSURL *)url
{
    NSString *controllerName = [url host];
    
    // 先頭の一文字を大文字にする
    controllerName = [controllerName stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                             withString:[[controllerName substringToIndex:1] capitalizedString]];
    
    // Classを文字列から取得
    Class controllerClass = NSClassFromString([NSString stringWithFormat:@"%@Controller",controllerName]);
    
    // ClassがControllerProtocolを実装しているかチェック
    if ([controllerClass conformsToProtocol:@protocol(ControllerProtocol)]) {
        id<ControllerProtocol> controller = [[controllerClass alloc] init];
        return [controller action:[url lastPathComponent] query:[self _dictionaryFromQueryString:[url query]]];
    }
    return NO;
}


// 以下参考:http://qiita.com/hal_sk/items/413ec7902f48ec39821f
- (NSDictionary *)_dictionaryFromQueryString:(NSString *)query
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSRange range = [pair rangeOfString:@"="];
        NSString *key = range.length ? [pair substringToIndex:range.location] : pair;
        NSString *val = range.length ? [pair substringFromIndex:range.location+1] : @"";
        key = [key stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        val = [val stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        key = [self _decode:key];
        val = [self _decode:val];
        [dict setObject:val forKey:key];
    }
    return [dict copy];
}

- (NSString *)_decode:(NSString *)value
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                                                 NULL,
                                                                                                 (CFStringRef) value,
                                                                                                 CFSTR(""),
                                                                                                 kCFStringEncodingUTF8));
}


@end
