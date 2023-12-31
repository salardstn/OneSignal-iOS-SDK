/**
 * Modified MIT License
 *
 * Copyright 2019 OneSignal
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

#import "OSFocusTimeProcessorFactory.h"
#import "OneSignalCommonDefines.h"
#import "OSAttributedFocusTimeProcessor.h"
#import "OSUnattributedFocusTimeProcessor.h"
#import "OneSignalHelper.h"

@implementation OSFocusTimeProcessorFactory

static NSDictionary<NSString*, OSBaseFocusTimeProcessor*> *_focusTimeProcessors;
+ (NSDictionary<NSString*, OSBaseFocusTimeProcessor*>*)focusTimeProcessors {
    if (!_focusTimeProcessors)
        _focusTimeProcessors = [NSMutableDictionary new];
    return _focusTimeProcessors;
}

+ (void)cancelFocusCall {
    for (NSString* key in self.focusTimeProcessors) {
        let timeProcesor = [self.focusTimeProcessors objectForKey:key];
        [timeProcesor cancelDelayedJob];
    }
    [OneSignalLog onesignalLog:ONE_S_LL_DEBUG message:[NSString stringWithFormat:@"cancelFocusCall of %@", self.focusTimeProcessors]];
}

+ (void)resetUnsentActiveTime {
    for (NSString *key in self.focusTimeProcessors) {
        let timeProcesor = [self.focusTimeProcessors objectForKey:key];
        [timeProcesor resetUnsentActiveTime];
    }
    
    [OneSignalLog onesignalLog:ONE_S_LL_DEBUG message:[NSString stringWithFormat:@"resetUnsentActiveTime of %@", self.focusTimeProcessors]];
}

+ (OSBaseFocusTimeProcessor *)createTimeProcessorWithInfluences:(NSArray<OSInfluence *> *)lastInfluences focusEventType:(FocusEventType)focusEventType {
    BOOL isAttributed = NO;
    for (OSInfluence *influence in lastInfluences) {
        // At least one channel influenced this session
        if ([influence isAttributedInfluence]) {
            isAttributed = YES;
            break;
        }
    }
    let attributionState = isAttributed ? ATTRIBUTED : NOT_ATTRIBUTED;
    NSString *key = focusAttributionStateString(attributionState);
    
    var timeProcesor = [self.focusTimeProcessors objectForKey:key];
    if (!timeProcesor) {
        switch (attributionState) {
            case ATTRIBUTED:
                timeProcesor = [OSAttributedFocusTimeProcessor new];
                break;
             case NOT_ATTRIBUTED:
                // TODO: Clean up, this check should be for getting and not create
                if (focusEventType == END_SESSION)
                    break;
                timeProcesor = [OSUnattributedFocusTimeProcessor new];
                break;
        }
        
        [self.focusTimeProcessors setValue:timeProcesor forKey:key];
    }
    
    [OneSignalLog onesignalLog:ONE_S_LL_DEBUG
                     message:[NSString stringWithFormat:@"TimeProcessor %@ for session attributed %d", timeProcesor, isAttributed]];
    
    return timeProcesor;
}

@end
