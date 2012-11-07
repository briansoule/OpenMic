//
//  ScoresViewController.h
//  Critic
//
//  Created by Brian Soule on 11/5/12.
//  Copyright (c) 2012 Brian Soule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoresViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {
    NSDictionary *scoresDictionary;
}

@end
