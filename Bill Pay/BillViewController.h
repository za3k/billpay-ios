//
//  Bill.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/3/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BillDataController.h"

@interface BillViewController : UITableViewController
@property (strong, nonatomic) BillDataController *dataController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
- (IBAction)editClicked:(id)sender;
@end
