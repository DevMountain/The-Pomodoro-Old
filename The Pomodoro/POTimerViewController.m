//
//  POTimerViewController.m
//  The Pomodoro
//
//  Created by Joshua Howland on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "POTimerViewController.h"
#import "PORoundsViewController.h"

@interface POTimerViewController ()

@property (nonatomic, assign) BOOL active;

@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UIButton *button;

@property (nonatomic, assign) NSInteger minutes;
@property (nonatomic, assign) NSInteger seconds;

- (IBAction)startButton:(id)sender;

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

- (IBAction)startButton:(id)sender {
    self.button.enabled = NO;
    [self.button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.active = YES;
    [self performSelector:@selector(decreaseSecond) withObject:nil afterDelay:1.0];
}

- (void)decreaseSecond {
    
    if (self.seconds > 0) {
        self.seconds--;
    }

    if (self.minutes > 0) {
        if (self.seconds == 0) {
            self.seconds = 59;
            self.minutes--;
        }
    } else {
        if (self.seconds == 0) {

            // Re-enable the button
            self.button.enabled = YES;
            [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            // Stop the timer
            self.active = NO;
            
            // Post the notification that the round is complete
            [[NSNotificationCenter defaultCenter] postNotificationName:RoundCompleteNotificationName object:nil userInfo:nil];
            
        }
    }

    [self updateLabel];
    
    if (self.active) {
        [self performSelector:@selector(decreaseSecond) withObject:nil afterDelay:1.0];
    }
}

- (void)updateLabel {

    if (self.seconds < 10) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d:0%d", self.minutes, self.seconds];
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"%d:%d", self.minutes, self.seconds];
    }

}

- (void)newRound:(NSNotification *)notification {
    self.minutes = [notification.userInfo[UserInfoMinutesKey] integerValue];
    self.seconds = 0;
    
    // Re-enable the button
    self.button.enabled = YES;
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self updateLabel];
}

@end
