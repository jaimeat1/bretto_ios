//
//  BWCSensibilityViewController.m
//  BrettoWControl
//
//  Created by Jaime on 02/03/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BWCSensibilityViewController.h"
#import "BWCCommandBuilder.h"
#import "BWCAppDelegate.h"

@interface BWCSensibilityViewController ()

@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *currentValue;

@end

@implementation BWCSensibilityViewController

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

    self.title = NSLocalizedString(@"SensibilityShort", @"");
    
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
    [self dismissModalViewControllerAnimated:YES];
    
    NSString *sensibility = [NSString stringWithFormat:@"%d", [[NSNumber numberWithFloat:self.slider.value] integerValue]];
    NSMutableArray* params = [NSMutableArray arrayWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"parsswordAlarm"], sensibility, nil];
    NSString *message = [BWCCommandBuilder buildCommand:BWCCommandSetDevices withParameters:params];
    [(BWCAppDelegate *)[[UIApplication sharedApplication] delegate] composeMessage:message];
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 0) && (indexPath.row == 0)) {
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
            self.slider = [[UISlider alloc] initWithFrame:CGRectZero];
            [aCell.contentView addSubview:self.slider];
            self.slider.bounds = CGRectMake(0, 0, aCell.contentView.bounds.size.width - 100, self.slider.bounds.size.height);
            self.slider.center = CGPointMake(CGRectGetMidX(aCell.contentView.bounds), CGRectGetMidY(aCell.contentView.bounds));
            self.slider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            self.slider.minimumValue = 0;
            self.slider.maximumValue = 600;
            self.slider.value = 0;
            [self.slider addTarget:self action:@selector(sliderValueChanged:)
               forControlEvents:UIControlEventValueChanged];

            return aCell;
        }
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)sliderValueChanged:(UISlider *)slider
{
    self.currentValue.text = [NSString stringWithFormat:@"%d", [[NSNumber numberWithFloat:slider.value] integerValue]];
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

@end
