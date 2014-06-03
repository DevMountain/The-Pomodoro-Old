//
//  PORoundsViewController.m
//  The Pomodoro
//
//  Created by Joshua Howland on 6/3/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "PORoundsViewController.h"
#import "POTimerViewController.h"

static NSString * const CurrentRoundKey = @"CurrentRound";

@interface PORoundsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger currentRound;

@end

@implementation PORoundsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.currentRound = [[NSUserDefaults standardUserDefaults] integerForKey:CurrentRoundKey];
        
        [self registerForNotifications];
    }
    return self;
}

- (void)registerForNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRound:) name:RoundCompleteNotificationName object:nil];
}

- (void)unregisterForNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RoundCompleteNotificationName object:nil];
}

- (void)dealloc {
    [self unregisterForNotifications];
}

- (void)setCurrentRound:(NSInteger)currentRound {
    _currentRound = currentRound;
    
    [[NSUserDefaults standardUserDefaults] setValue:@(currentRound) forKeyPath:CurrentRoundKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Rounds";

    [self postMinutes];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
 
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
 
    [self selectCurrentRound];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self times] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"Round %d - %@ min", indexPath.row + 1, [[[self times] objectAtIndex:indexPath.row] stringValue]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentRound = indexPath.row;
    [self postMinutes];
}

- (void)postMinutes {
    [[NSNotificationCenter defaultCenter] postNotificationName:NewRoundTimeNotificationName object:nil userInfo:@{UserInfoMinutesKey: [self times][self.currentRound]}];
}

- (NSArray *)times {
    return @[@25, @5, @25, @5, @25, @5, @25, @15];
}

- (void)endRound:(NSNotification *)notification {

    self.currentRound++;
    if (self.currentRound == [[self times] count]) {
        self.currentRound = 0;
    }
    
    [self selectCurrentRound];
    
    [self postMinutes];
    
}

- (void)selectCurrentRound {

    // Let's select the current round
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentRound inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath
                                animated:NO
                          scrollPosition:UITableViewScrollPositionTop];

}

@end
