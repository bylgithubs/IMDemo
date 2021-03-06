//
//  ChatRecordViewController.m
//  IMDemo
//
//  Created by Civet on 2020/4/10.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import "ChatRecordViewController.h"

@interface ChatRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ChatRecordViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self initData];
    [self notificationRegister:YES];
}

- (void)initUI{
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (void)initData{
    dispatch_queue_t chatRecordQueue = dispatch_queue_create("ChatRecordQueue", NULL);
    dispatch_async(chatRecordQueue, ^{
        [self getDataFromDB];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)notificationRegister:(BOOL)flag{
    if (flag) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadChatRecordData) name:UPDATE_CHAT_RECORD object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UPDATE_CHAT_RECORD object:nil];
    }
}

- (void)reloadChatRecordData{
    [self initData];
    //[tableView reloadData];
}

- (void)getDataFromDB{
    self.dataArr = [[FMDBOperation sharedDatabaseInstance] getChatRecordData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ChatRecordCell";
    ChatRecordCell *chatRecordCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (chatRecordCell ==nil) {
        chatRecordCell = [[ChatRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    ChatRecordModel *model = self.dataArr[indexPath.row];
    chatRecordCell.chatRecordModel = model;
    [chatRecordCell configData];
    return chatRecordCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatRoomViewController *chatRoomVC = [[ChatRoomViewController alloc] init];
    ChatRecordModel *model = self.dataArr[indexPath.row];
    AddressDataModel *addrModel = [[AddressDataModel alloc] init];
    addrModel.userID = model.userID;
    addrModel.userName = model.userName;
    chatRoomVC.addressDataModel = addrModel;

    [self.navigationController pushViewController:chatRoomVC animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BOOL result = [self deleteChatRecord:indexPath];
        if (result) {
            NSLog(@"删除成功");
        } else {
            NSLog(@"删除失败");
        }
    }
}



//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleDelete;
//}

//修改Delete按钮wei"删除"
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

//删除一条最新聊天记录
- (BOOL)deleteChatRecord:(NSIndexPath *)indexPath{
    FMDBOperation *db = [FMDBOperation sharedDatabaseInstance];
    ChatRecordModel *model = self.dataArr[indexPath.row];
    BOOL result = [db deleteChatRecordMessage:model.jID];
    if (result) {
        [self.dataArr removeObjectAtIndex:indexPath.row];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
    }
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)dealloc{
    [self notificationRegister:NO];
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
