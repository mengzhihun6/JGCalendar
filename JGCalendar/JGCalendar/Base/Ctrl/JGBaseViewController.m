//
//  JGBaseViewController.m
//  FileConversion
//
//  Created by 郭军 on 2019/8/26.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JGBaseViewController.h"

@interface JGBaseViewController ()

@end

@implementation JGBaseViewController

-(NSString *)backItemImageName{
    return @"navigator_btn_back";
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    
    [self configUI];
    
}

- (void)configUI {}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
