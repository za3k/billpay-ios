//
//  FinishViewController.h
//  Bill Pay
//
//  Created by Zachary Vance on 7/5/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BillViewController.h"
#import "BillDataController.h"

@protocol MasterViewControllerDelegate;

@protocol MasterViewControllerDelegate
-(void)billChanged;
@end

@interface MasterViewController : UITableViewController <MasterViewControllerDelegate>
@property (strong, nonatomic) NSString *cost;
@property (weak, nonatomic) IBOutlet UILabel *totalCostLabel;
//@property (weak, nonatomic) id <MasterViewControllerDelegate> delegate;
@property (strong, nonatomic) BillDataController *dataController;
//- (IBAction)goBack:(id)sender;
@end
