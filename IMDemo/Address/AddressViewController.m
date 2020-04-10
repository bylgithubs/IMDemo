//
//  AddressViewController.m
//  IMDemo
//
//  Created by Civet on 2020/4/10.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonnull,strong) UITableView *tableView;

@end

@implementation AddressViewController

@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource =self;
    [self.view addSubview:tableView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"AddressIdentifier";
    AddressTextCell *addrCell = (AddressTextCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (addrCell == nil) {
        addrCell = [[AddressTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [addrCell setCellStyle];
    return addrCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
