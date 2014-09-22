//
//  Routes.h
//  CustomURLSchemeSample
//
//  Created by Naoto Horiguchi on 2013/12/09.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Routes : NSObject

- (BOOL)openURL:(NSURL *)url;

// もし、error内容まで知りたいようであれば、こんな感じにしてもいいかもしれないですね。
//- (BOOL)openURL:(NSURL *)url error:(NSError **)error;

@end
