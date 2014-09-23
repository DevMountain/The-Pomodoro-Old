//
//  PORoundTableViewDataSource.m
//  The Pomodoro
//
//  Created by Joshua Howland on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "PORoundTableViewDataSource.h"

static NSString * const CurrentRoundKey = @"CurrentRound";

@implementation PORoundTableViewDataSource

- (id)init {
    if (self = [super init]) {
        self.currentRound = [[NSUserDefaults standardUserDefaults] integerForKey:CurrentRoundKey];
    }
    return self;
}

- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self times] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"Round %ld - %@ min", indexPath.row + 1, [[[self times] objectAtIndex:indexPath.row] stringValue]];
    
    return cell;
}

- (NSNumber *)roundAtIndex:(NSInteger)index {
    return [self times][index];
}

- (NSArray *)times {
    return @[@25, @5, @25, @5, @25, @5, @25, @15];
}

- (void)setCurrentRound:(NSInteger)currentRound {

    if (currentRound >= [[self times] count]) {
        _currentRound = 0;
    } else {
        _currentRound = currentRound;
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:@(currentRound) forKeyPath:CurrentRoundKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
