//
//  ViewController.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/2/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
{
}
@property (readonly) NSInteger currentCostDollars;
@property (readonly) NSInteger currentCostCents;
@property (readonly) BOOL currentCostValid;
@property (readonly, nonatomic) NSString *description;
- (IBAction)updateDescription:(id)sender;
@end

@implementation AddViewController
{
}
@synthesize doneButton = _doneButton;
@synthesize textFieldDescription = _textFieldDescription;

@synthesize label;
@synthesize textFieldMoney;
@synthesize currentCost=_currentCost;
@synthesize currentCostValid = _valid;
@synthesize currentCostDollars = _dollars;
@synthesize currentCostCents = _cents;
@synthesize description = _description;

@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTextFieldMoney:nil];
    [self setTextFieldDescription:nil];
    [self setLabel:nil];
    [self setDoneButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)setCurrentCost:(NSString *)text
{
    _valid = NO;
    NSError *error = NULL;
    NSRegularExpression *dollarsAndCentsRegex = [NSRegularExpression regularExpressionWithPattern:@"^\\$?([0-9]+)\\.([0-9]{2})$" options:0 error:&error];
    NSRegularExpression *dollarsOnlyRegex = [NSRegularExpression regularExpressionWithPattern:@"^\\$?([0-9]+)$" options:0 error:&error];
    NSRegularExpression *centsOnlyRegex = [NSRegularExpression regularExpressionWithPattern:@"^\\$?\\.([0-9]{2})$" options:0 error:&error];
    
    NSTextCheckingResult *match = [dollarsAndCentsRegex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    if(match) {
        self.valid = YES;
        _dollars = [[text substringWithRange: [match rangeAtIndex:1]] integerValue];
        _cents = [[text substringWithRange: [match rangeAtIndex:2]] integerValue];
        return;
    }
    match = [centsOnlyRegex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    if(match) {
        self.valid = YES;
        _dollars = 0;
        _cents = [[text substringWithRange: [match rangeAtIndex:1]] integerValue];
        return;
    } 
    match = [dollarsOnlyRegex firstMatchInString:text options:0 range:NSMakeRange(0, [text length])];
    if(match) {
        self.valid = YES;
        _cents = 0;
        _dollars = [[text substringWithRange: [match rangeAtIndex:1]] integerValue];
        return;
    } else {
        self.valid = NO;
        _dollars = -1;
        _cents = -1;
        return;
    }
}

- (NSString *)currentCost
{
    if(self.currentCostValid) {
        return [[NSString alloc] initWithFormat:@"$%d.%02d", self.currentCostDollars, self.currentCostCents];
    } else {
        return @"Invalid";
    }
}

- (void)setValid:(BOOL)validity
{
    _valid = validity;
    if(_valid)
    {
        self.textFieldMoney.backgroundColor = [UIColor whiteColor];
    } else {
        self.textFieldMoney.backgroundColor = [UIColor redColor];
    }
    self.doneButton.enabled = _valid;
}

- (IBAction)updateCost:(id)sender {
    self.currentCost = self.textFieldMoney.text;
}

- (IBAction)updateDescription:(id)sender {
    _description = self.textFieldDescription.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.textFieldMoney) {
        [theTextField resignFirstResponder];
    }
    if (theTextField == self.textFieldDescription) {
        [self updateDescription:nil];
        [theTextField resignFirstResponder];
    }
    return YES;
}

- (IBAction)doneClicked:(id)sender {
    [self updateDescription:nil];
    [[self delegate] addViewControllerDidFinish:self dollars:self.currentCostDollars cents:self.currentCostCents description:self.description];
}

- (IBAction)cancelClicked:(id)sender {
    [[self delegate] addViewControllerDidCancel:self];
}

@end