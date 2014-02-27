//
//  BWCSensibilityViewController.m
//  BrettoWControl
//
//  Created by Jaime on 02/03/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BXCTimeAndSpeedViewController.h"
#import "BXCCommandBuilder.h"
#import "BXCAppDelegate.h"

@interface BXCTimeAndSpeedViewController ()

/* Flag to show time and speed (YES), or only time (NO) */
@property (nonatomic) BOOL *timeAndSpeed;
@property (nonatomic, strong) UILabel *currentValue;

@end

@implementation BXCTimeAndSpeedViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BXCAppDelegate *delegate = (BXCAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *currentCommand =  delegate.currentCommand;
    
    // Check time and speed, or only time
    if ([currentCommand compare:@"speed"] == 0) {
        self.timeAndSpeed = YES;
    } else {
        self.timeAndSpeed = NO;
    }

    // Set right title
    if ([currentCommand compare:@"speed"] == 0) {
        self.title = NSLocalizedString(@"Speed", @"");
    } else if ([currentCommand compare:@"climate"]) {
        self.title = NSLocalizedString(@"Climate", @"");
    } else if ([currentCommand compare:@"engine"]) {
        self.title = NSLocalizedString(@"Engine", @"");
    }
    
    // Cancel button
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed:)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    // Save button
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed:)];
    self.navigationItem.rightBarButtonItem = save;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)savePressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^(void){
        /*
        NSString *sensibility = [NSString stringWithFormat:@"%d", [[NSNumber numberWithFloat:self.slider.value] integerValue]];
        
        NSLog(@"sensibility before %@",sensibility);
        while (sensibility.length < 4) {
            sensibility = [NSString stringWithFormat:@"0%@",sensibility];
        }
        NSLog(@"sensibility after %@",sensibility);
        
        NSMutableArray* params = [NSMutableArray arrayWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"passwordAlarm"], sensibility, nil];
        NSString *message = [BXCCommandBuilder buildCommand:BWCCommandSensibility withParameters:params];
        [(BXCAppDelegate *)[[UIApplication sharedApplication] delegate] composeMessage:message];
        */
    }];
}

- (IBAction)sliderValueChanged:(UISlider *)slider
{
    self.currentValue.text = [NSString stringWithFormat:@"%d", [[NSNumber numberWithFloat:slider.value] integerValue]];
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if ((indexPath.section == 0) && (indexPath.row == 0)) {
        UITableViewCell* aCell = [tableView dequeueReusableCellWithIdentifier:@"sliderCell"];
        if( aCell == nil ) {
            aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"sliderCell"];
            
            // Configure labels
            UILabel *minValue = [[UILabel alloc] initWithFrame:CGRectMake(7, 0, 40, 44)];
            minValue.backgroundColor = [UIColor clearColor];
            minValue.text = @"0";
            minValue.textAlignment = UITextAlignmentCenter;
            [aCell.contentView addSubview:minValue];
            
            self.currentValue = [[UILabel alloc] initWithFrame:CGRectMake(257, 0, 40, 44)];
            self.currentValue.backgroundColor = [UIColor clearColor];
            self.currentValue.text = @"0";
            self.currentValue.textAlignment = UITextAlignmentCenter;
            [aCell.contentView addSubview:self.currentValue];
            
            // Configure slider
            aCell.selectionStyle = UITableViewCellSelectionStyleNone;
            UISlider *slider = [[UISlider alloc] initWithFrame:CGRectZero];
            
            slider.bounds = CGRectMake(0, 0, aCell.contentView.bounds.size.width - 100, slider.bounds.size.height);
            slider.center = CGPointMake(CGRectGetMidX(aCell.contentView.bounds), CGRectGetMidY(aCell.contentView.bounds));
            slider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            slider.minimumValue = 0;
            slider.maximumValue = 600;
            slider.value = 50;
            
            [slider addTarget:self action:@selector(sliderValueChanged:)
               forControlEvents:UIControlEventValueChanged];

            [aCell.contentView addSubview:slider];
            
            return aCell;
        }
    //}
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.timeAndSpeed) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedString(@"TimeHeader", @"");
    } else {
        return NSLocalizedString(@"SpeedHeader", @"");
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedString(@"TimeFooter", @"");
    } else {
        return NSLocalizedString(@"SpeedFooter", @"");
    }
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

@end
