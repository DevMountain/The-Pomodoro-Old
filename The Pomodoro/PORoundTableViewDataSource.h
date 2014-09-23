//
//  PORoundTableViewDataSource.h
//  The Pomodoro
//
//  Created by Joshua Howland on 9/23/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PORoundTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, assign) NSInteger currentRound;

- (NSNumber *)roundAtIndex:(NSInteger)index;

- (void)registerTableView:(UITableView *)tableView;

@end
