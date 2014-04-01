//
//  ViewController.m
//  Locator
//
//  Created by Marcel Stolz on 01.04.14.
//  Copyright (c) 2014 Marcel Stolz. All rights reserved.
//

#import "AppController.h"
#import <CoreWLAN/CoreWLAN.h>
#import "smslib.h"

@interface AppController ()

@end

@implementation AppController

@synthesize interface;
@synthesize SSIDs;
@synthesize SSIDArray;

@synthesize networkTableView;

#pragma mark initialisation methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self starterMethod];
        NSLog(@"Initiated AppController With Nib");
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self starterMethod];
        NSLog(@"Initiated AppController With Coder");
    }
    return self;
}

- (void)starterMethod {
    self.interface = [CWInterface interfaceWithName:nil];
    self.SSIDs = [self.interface scanForNetworksWithSSID:nil error:nil];
    NSLog(@"Called starterMethod");
}

#pragma mark accelerometer helper methods

#pragma mark Network helper methods

- (void) orderSSIDArrayBySortDescriptors:(NSArray *)sortDescriptors {
    self.SSIDArray = [SSIDs sortedArrayUsingDescriptors:sortDescriptors];
}

- (void) rescanSSIDs {
    self.SSIDs = [self.interface scanForNetworksWithSSID:nil error:nil];
}


#pragma mark Tableview Data Source methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.SSIDs count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)rowIndex {
    if ([tableView.sortDescriptors count] == 0) {
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"ssid" ascending:YES];
        [tableView setSortDescriptors:[NSArray arrayWithObject:descriptor]];
    }
    [self orderSSIDArrayBySortDescriptors:tableView.sortDescriptors];
    CWNetwork *network = [SSIDArray objectAtIndex:rowIndex];
    if ([tableColumn.identifier isEqualTo:@"ssid"]) {
        return network.ssid;
    } else if ([tableColumn.identifier isEqualTo:@"rssiValue"]) {
        return [NSString stringWithFormat:@"%ld dBm",(long)network.rssiValue];
    } else {
        return @"";
    }
}

- (void)tableView:(NSTableView *)tableView sortDescriptorsDidChange:(NSArray *)oldDescriptors {
    [self orderSSIDArrayBySortDescriptors:tableView.sortDescriptors];
    [tableView reloadData];
}

#pragma mark IBAction methods

- (IBAction)rescanNetworks:(id)sender {
    [self rescanSSIDs];
    [self.networkTableView reloadData];
}

@end
