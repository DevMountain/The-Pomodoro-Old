//
//  POTimerViewController.m
//  The Pomodoro
//
//  Created by Joshua Howland on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "POTimerViewController.h"
#import "PORoundsViewController.h"
#import "POTimer.h"

@interface POTimerViewController ()

@property (nonatomic, assign) BOOL active;

@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UIButton *button;

@end

@implementation POTimerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self registerForNotifications];
    }
    return self;
    
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newRound:) name:NewRoundTimeNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLabel) name:SecondTickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateButton) name:TimerCompleteNotification object:nil];
}

- (void)unregisterForNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NewRoundTimeNotificationName object:nil];
}

- (void)dealloc {
    [self unregisterForNotifications];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Focus";
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self updateLabel];
    
}

- (IBAction)startTimer:(id)sender {
    [[POTimer sharedInstance] startTimer];
    self.button.enabled = NO;
    [self.button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (void)newRound:(NSNotification *)notification {    
    [self updateLabel];
    [self updateButton];
}

- (void)updateLabel {
    
    if ([POTimer sharedInstance].seconds < 10) {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld:0%ld", (long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"%ld:%ld", (long)[POTimer sharedInstance].minutes, (long)[POTimer sharedInstance].seconds];
    }
}

- (void)updateButton {
    
    // Re-enable the button
    self.button.enabled = YES;
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

@end
