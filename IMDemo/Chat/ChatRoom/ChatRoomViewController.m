//
//  ChatRoomViewController.m
//  IMDemo
//
//  Created by Civet on 2020/4/15.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import "ChatRoomViewController.h"
#import "KeyboardView.h"
#import "ChatRoomModel.h"

@interface ChatRoomViewController ()<UITableViewDelegate,UITableViewDataSource,KeyboardViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) KeyboardView *keyboard;
@property (nonatomic,strong) UITapGestureRecognizer *packUpKeyboard;

@end

@implementation ChatRoomViewController

@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    [self initData];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    self.packUpKeyboard = tapGesture;
    [tableView addGestureRecognizer:self.packUpKeyboard];
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

- (void)viewWillAppear:(BOOL)animated{
    [self addKeyBoard];
}

- (void)addKeyBoard{
    self.keyboard = [KeyboardView sharedInstance];
    self.keyboard.tag = 2020;
    self.keyboard.frame = CGRectMake(0, self.view.frame.size.height - 44 -SafeAreaBottom - 10, self.view.frame.size.width, 260);
    self.keyboard.delegate = self;
    self.keyboard.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.keyboard];
    
}

- (void)dismissKeyboard{
    [self.keyboard resignKeyboard];
}


-(void)KeyBoardViewHeightChange:(CGRect)keyboardFrame{
//    CGRect customKeyboardFrame = self.keyboard.frame;
//    customKeyboardFrame.origin.y =
    self.keyboard.frame = keyboardFrame;
}

- (void)KeyboardView:(KeyboardView *)keyboardView textFiledBegin:(UITextView *)textFiled{
    
}

-(void)KeyboardView:(KeyboardView *)keyboardView sendBtnClick:(UIButton *)sender text:(NSString *)text attribute:(NSAttributedString *)attr{
    NSString *string = text;
    if (text.length > 0) {
        if ([CommonMethods isEmptyString:text]) {
            return;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:DeleteKeyboardText object:nil];
        [self SendDataAndInsertDB:text];
    }
}

//发送和存储消息
- (void)SendDataAndInsertDB:(NSString *)message{
    dispatch_queue_t dispatchQueue = dispatch_queue_create("SendDataAndInsertDB", nil);
    dispatch_async(dispatchQueue, ^{
        ChatRoomModel *chatRoomModel = [[ChatRoomModel alloc] init];
        chatRoomModel.roomID = self.addressDataModel.jID;
        if (self.addressDataModel.name) {
            chatRoomModel.userName = self.addressDataModel.name;
        } else {
            chatRoomModel.userName = self.addressDataModel.homePhone;
        }
        if (message != nil) {
            chatRoomModel.content = message;
        }
        chatRoomModel.currentDate = [CommonMethods setDateFormat:[NSDate date]];
        dispatch_async(dispatch_get_main_queue(), ^{
            FMDBOperation *dbOperation = [FMDBOperation sharedDatabaseInstance];
            [dbOperation insertChatMessage:chatRoomModel];
        });
        
    });
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
