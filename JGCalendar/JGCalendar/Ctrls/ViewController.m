//
//  ViewController.m
//  JGCalendar
//
//  Created by spring on 2019/11/29.
//  Copyright © 2019 spring. All rights reserved.
//

#import "ViewController.h"
#import "JGAvailableTimeController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)CalenderClick:(id)sender {
    
    JGAvailableTimeController *VC = [JGAvailableTimeController new];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
