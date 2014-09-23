//
//  POTimer.h
//  Wired In
//
//  Created by Caleb Hicks on 6/23/14.
//  Copyright (c) 2014 Caleb Hicks. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const TimerCompleteNotification;
extern NSString * const SecondTickNotification;

@interface POTimer : NSObject

@property (assign, nonatomic) NSInteger minutes;
@property (assign, nonatomic) NSInteger seconds;

+ (POTimer *)sharedInstance;

- (void)startTimer;
- (void)cancelTimer;

@end
