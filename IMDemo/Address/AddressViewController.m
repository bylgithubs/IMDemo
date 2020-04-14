//
//  AddressViewController.m
//  IMDemo
//
//  Created by Civet on 2020/4/10.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressSegmentView.h"

@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource,SegmentViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableDictionary *dataDic;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) AddressSegmentView *segmentView;
@property (nonatomic,strong) NSIndexPath *ClickCellIndex;
@property (nonatomic,assign) BOOL sideSwitch;


@end

@implementation AddressViewController

@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataDic = [[NSMutableDictionary alloc] init];
    self.dataArr = [[NSMutableArray alloc] init];
    tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource =self;
    [self.view addSubview:tableView];
    self.ClickCellIndex = nil;
    self.sideSwitch = false;
    
    [self initUI];
    [self initData];
}

- (void)initUI{
    self.segmentView = [[AddressSegmentView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 75, (44 - 30)/2, 150, 30)];
    self.navigationItem.titleView = self.segmentView;
    self.segmentView.delegate = self;
}

- (void)initData{
    //获取通讯录数据
    [self requestContactAuthorAfterSystemVersion9];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"=========%@",self.dataArr);
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"AddressIdentifier";
    AddressTableViewCell *addrCell = (AddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (addrCell == nil) {
        addrCell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSLog(@"=========%@",self.dataDic);
    NSLog(@"=========%@",self.dataArr);
    addrCell.dataDic = self.dataDic;
    addrCell.dataArr = self.dataArr;
    [addrCell setCellStyle];
    if (self.ClickCellIndex.section == indexPath.section && self.ClickCellIndex.row == indexPath.row && self.sideSwitch) {
        [addrCell addAddressSideView];
    }
    addrCell.nameLabel.text = self.dataArr[indexPath.row];
    return addrCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"section======%ld,row======%ld",indexPath.section,indexPath.row);
    
    self.sideSwitch = !self.sideSwitch;
    self.ClickCellIndex = indexPath;
    [tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.ClickCellIndex.section == indexPath.section && self.ClickCellIndex.row == indexPath.row && self.sideSwitch) {
        return 100;
    }
    return 66;
}

- (void)selectSegmentAction:(ClickIndex)index{
    switch (index) {
        case SegmentOne:
            {
                tableView.hidden = NO;
                [tableView reloadData];
            }
            break;
         case SegmentTwo:
            {
                tableView.hidden = YES;
                self.view.backgroundColor = [UIColor grayColor];
            }
            break;
        default:
            break;
    }
}


//请求通讯录权限
#pragma mark 请求通讯录权限
- (void)requestContactAuthorAfterSystemVersion9{
    
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
            if (error) {
                NSLog(@"授权失败");
            }else {
                NSLog(@"成功授权");
                [self openContact];
            }
        }];
    }
    else if(status == CNAuthorizationStatusRestricted)
    {
        NSLog(@"用户拒绝");
        [self showAlertViewAboutNotAuthorAccessContact];
    }
    else if (status == CNAuthorizationStatusDenied)
    {
        NSLog(@"用户拒绝");
        [self showAlertViewAboutNotAuthorAccessContact];
    }
    else if (status == CNAuthorizationStatusAuthorized)//已经授权
    {
        //有通讯录权限-- 进行下一步操作
        [self openContact];
    }
    
}

//有通讯录权限-- 进行下一步操作
- (void)openContact{
    // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        NSLog(@"-------------------------------------------------------");
        
        AddressDataModel *model = [[AddressDataModel alloc] init];
        
        NSString *givenName = contact.givenName;
        NSString *familyName = contact.familyName;
        NSLog(@"givenName=%@, familyName=%@", givenName, familyName);
        //拼接姓名
        model.name = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        
        NSArray *phoneNumbers = contact.phoneNumbers;
        for (CNLabeledValue *labelValue in phoneNumbers) {
            //遍历一个人名下的多个电话号码
            NSString *phoneType = labelValue.label;
            //   NSString *    phoneNumber = labelValue.value;
            CNPhoneNumber *phoneNumber = labelValue.value;
            
            NSString *number = phoneNumber.stringValue ;
            
            //去掉电话中的特殊字符
            number = [number stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            number = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
            number = [number stringByReplacingOccurrencesOfString:@"(" withString:@""];
            number = [number stringByReplacingOccurrencesOfString:@")" withString:@""];
            number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
            number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSLog(@"姓名=%@, 电话号码是=%@", model.name, number);
        
            if ([phoneType containsString:@"Home"]) {
                model.homePhone = number;
            }
            else if([phoneType containsString:@"Work"]){
                model.workPhone = number;
            }
            else if([phoneType containsString:@"iPhone"]){
                model.iPhonePhone = number;
            }
            else if([phoneType containsString:@"Mobile"]){
                model.mobilePhone = number;
            }
            else if([phoneType containsString:@"Main"]){
                model.mainPhone = number;
            }
                            
        }
        [self.dataDic setObject:model forKey:model.name];
        if (model.name!=nil) {
            [self.dataArr addObject:model.name];
        } else {
            [self.dataArr addObject:model.homePhone];
        }
        
        NSLog(@"=========%@",self.dataArr);
        //    *stop = YES; // 停止循环，相当于break；
        
    }];
    
}

//提示没有通讯录权限
- (void)showAlertViewAboutNotAuthorAccessContact{
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"请授权通讯录权限"
                                          message:@"请在iPhone的\"设置-隐私-通讯录\"选项中,允许花解解访问你的通讯录"
                                          preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:OKAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
