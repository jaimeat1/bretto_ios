//
//  BWCSettingsViewController.m
//  BrettoWControl
//
//  Created by Jaime on 03/02/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BWCSettingsViewController.h"
#import "BWCPasswordViewController.h"

@interface BWCSettingsViewController ()

@end

@implementation BWCSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Show current alarm number
    self.numberCell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"numberAlarm"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get reference to the destination view controller
    BWCPasswordViewController* passwordViewController = (BWCPasswordViewController*)[(UINavigationController*)[segue destinationViewController] topViewController];
    
    if ([[segue identifier] isEqualToString:@"appSegue"])
    {
        passwordViewController.isAppPassword = YES;
        
    } else if ([[segue identifier] isEqualToString:@"alarmSegue"])
    {
        passwordViewController.isAppPassword = NO;
    }
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 0) && (indexPath.row == 1)) {
        UITableViewCell* aCell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
        if( aCell == nil ) {
            aCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"switchCell"];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, 44)];
            label.backgroundColor = [UIColor clearColor];
            label.text = @"Pedir contraseña";
            [label setFont:[UIFont fontWithName:@"Arial-BoldMT" size:17]];
            [aCell addSubview:label];
            aCell.selectionStyle = UITableViewCellSelectionStyleNone;
            UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
            aCell.accessoryView = switchView;
            [switchView setOn:[[NSUserDefaults standardUserDefaults] boolForKey:@"askPassword"] animated:NO];
            [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
            return aCell;
        }
    }
   
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

#pragma mark - Switch delegate

-(void)switchChanged:(UISwitch *)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:@"askPassword"];
}

@end
