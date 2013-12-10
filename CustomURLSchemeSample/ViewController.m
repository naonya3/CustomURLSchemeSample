//
//  ViewController.m
//  CustomURLSchemeSample
//
//  Created by Naoto Horiguchi on 2013/12/09.
//  Copyright (c) 2013年 Naoto Horiguchi. All rights reserved.
//

#import "ViewController.h"
#import "Routes.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.webView loadHTMLString:@"<a href='me.naonya3.schemesample://open/page1'>present in web view</a>" baseURL:nil];
}

- (IBAction)didTouchPresentViewController:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"me.naonya3.schemesample://open/page1"]];
    
    // 以下の方法を検討したほうが良い
//    [[Routes new] openURL:[NSURL URLWithString:@"me.naonya3.schemesample://open/page1"]];
}

@end
