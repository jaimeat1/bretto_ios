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
    [self dismissViewControllerAnimated:YES completion:^(void){
        
        NSString *sensibility = [NSString stringWithFormat:@"%d", [[NSNumber numberWithFloat:self.slider.value] integerValue]];
        
        NSLog(@"sensibility before %@",sensibility);
        while (sensibility.length < 3) {
            sensibility = [NSString stringWithFormat:@"0%@",sensibility];
        }
        NSLog(@"sensibility after %@",sensibility);
        
        NSMutableArray* params = [NSMutableArray arrayWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"passwordAlarm"], sensibility, nil];
        NSString *message = [BWCCommandBuilder buildCommand:BWCCommandSensibility withParameters:params];
        [(BWCAppDelegate *)[[UIApplication sharedApplication] delegate] composeMessage:message];
        
    }];
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
            minValue.textAlignment = NSTextAlignmentCenter;
            [aCell.contentView addSubview:minValue];
            
            // Configure slider
            aCell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.slider = [[UISlider alloc] initWithFrame:CGRectZero];
            [aCell.contentView addSubview:self.slider];
            
            self.slider.frame = CGRectMake(0, 0, aCell.contentView.frame.size.width - 100, 44);
            self.slider.center = CGPointMake(CGRectGetMidX(aCell.contentView.frame), CGRectGetMidY(aCell.contentView.frame));
            self.slider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            self.slider.minimumValue = 0;
            self.slider.maximumValue = 600;
            self.slider.value = 0;
            [self.slider addTarget:self action:@selector(sliderValueChanged:)
               forControlEvents:UIControlEventValueChanged];
            
            self.currentValue = [[UILabel alloc] initWithFrame:CGRectMake(self.slider.frame.origin.x + self.slider.frame.size.width + 5, 0, 40, 44)];
            self.currentValue.backgroundColor = [UIColor clearColor];
            self.currentValue.text = @"0";
            self.currentValue.textAlignment = NSTextAlignmentCenter;
            [aCell.contentView addSubview:self.currentValue];

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
