//
//  ViewController.h
//  Locator
//
//  Created by Marcel Stolz on 01.04.14.
//  Copyright (c) 2014 Marcel Stolz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreWLAN/CoreWLAN.h>
#import "smslib.h"

@interface AppController : NSViewController <NSTableViewDataSource>

@property (nonatomic, retain) CWInterface* interface;
@property (nonatomic, retain) NSSet* SSIDs;
@property (nonatomic, retain) NSArray* SSIDArray;

@property (nonatomic, retain) IBOutlet NSTableView* networkTableView;
    
- (void)starterMethod;
- (IBAction)rescanNetworks:(id)sender;

@end
