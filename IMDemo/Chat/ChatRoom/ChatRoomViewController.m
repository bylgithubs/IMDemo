//
//  ChatRoomViewController.m
//  IMDemo
//
//  Created by Civet on 2020/4/15.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import "ChatRoomViewController.h"

@interface ChatRoomViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation ChatRoomViewController

@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
}

- (void)initUI{
    self.tabBarController.tabBar.hidden = YES;
    if (self.addressDataModel.name!=nil) {
        [self.navigationItem setTitle:self.addressDataModel.name];
    } else {
        [self.navigationItem setTitle:self.addressDataModel.homePhone];
    }
    //设置聊天室导航栏标题样式
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.view.backgroundColor = [UIColor whiteColor];
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStyleDone) target:self action:@selector(initData)];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(initData)];
//    self.navigationItem.leftBarButtonItem.image = [UIImage imageNamed:@"left_back.png"];
    UIView *backBtnView = [CommonComponentMethods setLeftBarItems:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (void)clickBackBtn{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initData{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
    //return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ChatRoomTextCell";
    ChatRoomTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (textCell == nil) {
        textCell = [[ChatRoomTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    textCell.textLabel.text = [NSString stringWithFormat:@"this is %ld row",indexPath.row];
    return textCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
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
