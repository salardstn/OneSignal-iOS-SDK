/**
 * Modified MIT License
 *
 * Copyright 2017 OneSignal
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * 1. The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * 2. All copies of substantial portions of the Software may only be used in connection
 * with services provided by OneSignal.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import <sys/utsname.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "OneSignalHelper.h"
#import <OneSignalCore/OneSignalCore.h>
#import <OneSignalExtension/OneSignalExtension.h>
#import <objc/runtime.h>
#import "OneSignalInternal.h"
#import "OneSignalDialogController.h"

#define NOTIFICATION_TYPE_ALL 7
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface OneSignal ()
+ (NSString*)mUserId;
@end

@implementation OneSignalHelper


+ (NSString*)getAppName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(id)kCFBundleNameKey];
}

//Shared instance as OneSignal is delegate CLLocationManagerDelegate
static OneSignal* singleInstance = nil;
+ (OneSignal*)sharedInstance {
    @synchronized( singleInstance ) {
        if (!singleInstance )
            singleInstance = [OneSignal new];
    }
    return singleInstance;
}

+ (void)displayWebView:(NSURL*)url {    
    __block let openUrlBlock = ^void(BOOL shouldOpen) {
        if (!shouldOpen)
            return;
        
        [OneSignalHelper dispatch_async_on_main_queue: ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // Keep dispatch_async. Without this the url can take an extra 2 to 10 secounds to open.
                [[UIApplication sharedApplication] openURL:url];
            });
        }];
    };
    openUrlBlock(true);
}

+ (void)runOnMainThread:(void(^)())block {
    if ([NSThread isMainThread])
        block();
    else
        dispatch_sync(dispatch_get_main_queue(), block);
}

+ (void)dispatch_async_on_main_queue:(void(^)())block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (void)performSelector:(SEL)aSelector onMainThreadOnObject:(nullable id)targetObj withObject:(nullable id)anArgument afterDelay:(NSTimeInterval)delay {
    [self dispatch_async_on_main_queue:^{
        [targetObj performSelector:aSelector withObject:anArgument afterDelay:delay];
    }];
}

+ (BOOL)isValidEmail:(NSString*)email {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\])|(([a-zA-Z\\-0-9]+\\.)+[a-zA-Z]{2,}))$"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:email
                                                        options:0
                                                          range:NSMakeRange(0, [email length])];
    return numberOfMatches != 0;
}

+ (NSString*)hashUsingSha1:(NSString*)string {
    const char *cstr = [string UTF8String];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(cstr, (CC_LONG)strlen(cstr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

+ (NSString*)hashUsingMD5:(NSString*)string {
    const char *cstr = [string UTF8String];
    uint8_t digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

+ (BOOL)isTablet {
    return UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

#pragma clang diagnostic pop
#pragma clang diagnostic pop
#pragma clang diagnostic pop
@end
