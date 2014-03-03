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

#define MAX_TIME 99;
#define MAX_SPEED 999;

@interface BXCTimeAndSpeedViewController ()

/* Flag to show time and speed (YES), or only time (NO) */
@property (nonatomic) BOOL *timeAndSpeed;
@property (nonatomic, copy) NSString *currentCommand;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *speedLabel;

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
    self.currentCommand =  delegate.currentCommand;
    
    // Check time and speed, or only time
    if ([self.currentCommand compare:@"speed"] == 0) {
        self.timeAndSpeed = YES;
    } else {
        self.timeAndSpeed = NO;
    }

    // Set right title
    if ([self.currentCommand compare:@"speed"] == 0) {
        self.title = NSLocalizedString(@"Speed", @"");
    } else if ([self.currentCommand compare:@"climate"]) {
        self.title = NSLocalizedString(@"Climate", @"");
    } else if ([self.currentCommand compare:@"engine"]) {
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

        NSMutableArray *params;
        NSString *message;
        NSInteger command;
        if ([self.currentCommand compare:@"speed"] == 0) {
            
        } else if ([self.currentCommand compare:@"climate"]) {
            NSString *time = [NSString stringWithFormat:@"%@", self.timeLabel.text];
            params = [NSMutableArray arrayWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"passwordAlarm"], time, nil];
            command = BWCCommandClimateOn;
        } else if ([self.currentCommand compare:@"engine"]) {
            NSString *time = [NSString stringWithFormat:@"%@", self.timeLabel.text];
            params = [NSMutableArray arrayWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"passwordAlarm"], time, nil];
            command = BWC;
        }
        
        
        
        NSString *message = [BXCCommandBuilder buildCommand:command withParameters:params];
        [(BXCAppDelegate *)[[UIApplication sharedApplication] delegate] composeMessage:message];

    }];
}

- (IBAction)timeValueChanged:(UISlider *)slider
{
    self.timeLabel.text = [NSString stringWithFormat:@"%d", [[NSNumber numberWithFloat:slider.value] integerValue]];
}

- (IBAction)speedValueChanged:(UISlider *)slider
{
    self.speedLabel.text = [NSString stringWithFormat:@"%d", [[NSNumber numberWithFloat:slider.value] integerValue]];
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* aCell = [tableView dequeueReusableCellWithIdentifier:@"sliderCell"];

    // section 0, time
    // section 1, speed
    
    if( aCell == nil ) {
        aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"sliderCell"];
        
        // Configure slider
        aCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectZero];
        
        slider.frame = CGRectMake(0, 0, aCell.contentView.frame.size.width - 100, 44);
        slider.center = CGPointMake(CGRectGetMidX(aCell.contentView.frame), CGRectGetMidY(aCell.contentView.frame));
        slider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        slider.minimumValue = 0;
        
        // Max. value differs from slider
        if (indexPath.section == 0) slider.maximumValue = MAX_TIME
        else slider.maximumValue = MAX_SPEED;
        
        slider.value = 0;
        
        // Different selectors for each slider
        if (indexPath.section == 0) {
            [slider addTarget:self action:@selector(timeValueChanged:) forControlEvents:UIControlEventValueChanged];
        } else {
            [slider addTarget:self action:@selector(speedValueChanged:) forControlEvents:UIControlEventValueChanged];
        }
        
        [aCell.contentView addSubview:slider];
        
        // Configure labels
        
        UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake(slider.frame.origin.x - 5 - 40, 0, 40, 44)];
        minLabel.backgroundColor = [UIColor clearColor];
        minLabel.text = @"0";
        minLabel.textAlignment = UITextAlignmentCenter;
        [aCell.contentView addSubview:minLabel];
        
        // Due versions issue, coordinates change in iOS7 and iOS6 or lower
        CGFloat labelOrigin;
        if ([[[UIApplication sharedApplication] delegate] respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)])
        {
            // iOS7 and later
            labelOrigin = slider.frame.origin.x + slider.frame.size.width + 5;
        } else {
            // lower than iOS7
            labelOrigin = slider.frame.origin.x + slider.frame.size.width - 15;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelOrigin, 0, 40, 44)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"0";
        label.textAlignment = UITextAlignmentCenter;
        
        if (indexPath.section == 0) {
            self.timeLabel = label;
        } else {
            self.speedLabel = label;
        }
        
        [aCell.contentView addSubview:label];
        
        return aCell;
    }
    
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
