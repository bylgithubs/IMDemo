//
//  FMDBOperation.m
//  IMDemo
//
//  Created by Civet on 2020/4/21.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import "FMDBOperation.h"


@implementation FMDBOperation

static FMDBOperation *sharedInstance = nil;

+ (instancetype)sharedDatabaseInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (FMDatabaseQueue *)dbQueue{
    if (!_dbQueue) {
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:DATABASE_PATH];
    }
    return _dbQueue;
}

- (void)initDB{
    NSString *databasePath = DATABASE_PATH;
    self.dbOperation = [FMDatabase databaseWithPath:databasePath];
    BOOL isSuccess = [self.dbOperation open];
    if (!isSuccess) {
        NSLog(@"打开数据库 %@ 失败",DATABASE_NAME);
        return;
    }
    if (self.dbOperation != nil) {
        //建表
        [self initTable];
    }
}

- (void)initTable{
    NSString *tableName = @"ChatMessage";
    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(jid integer PRIMARY KEY AUTOINCREMENT,room_ID varchar,user_name varchar,content text,current_date varchar)",tableName];
    NSLog(@"===%@",sqlStr);
    BOOL result = [self.dbOperation executeUpdate:sqlStr];
    if (result) {
        NSLog(@"创建表 %@ 成功",tableName);
    } else {
        NSLog(@"创建表 %@ 失败",tableName);
    }
}

//插入聊天记录
- (void)insertChatMessage:(ChatRoomModel *)model{
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sqlStr = @"insert into ChatMessage(room_ID,user_name,content,current_date) values(?,?,?,?)";
        [db executeUpdate:sqlStr,model.roomID,model.userName,model.content,model.currentDate];
    }];
    
}

//取出聊天记录
- (NSMutableArray *)getChatRoomMessage:(NSString *)jID{
    NSMutableArray *dataArr = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sqlStr = @"select * from ChatMessage where room_ID = ?";
        FMResultSet *resultSet = [db executeQuery:sqlStr,jID];
        while ([resultSet next]) {
            ChatRoomModel *model = [[ChatRoomModel alloc] init];
            model.roomID = [resultSet stringForColumn:@"room_ID"];
            model.userName = [resultSet stringForColumn:@"user_name"];
            model.content = [resultSet stringForColumn:@"content"];
            model.currentDate = [resultSet stringForColumn:@"current_date"];
            [dataArr addObject:model];
        }
    }];
    
    return dataArr;
}

//删除聊天记录
- (BOOL)deleteChatRoomMessage:(NSString *)message_id{
    ChatRoomModel *model = [[ChatRoomModel alloc] init];
    @try {
        [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *sqlStr = @"delete from ChatMessage where current_date = ?";
            [db executeUpdate:sqlStr,message_id];
        }];
        return YES;
    } @catch (NSException *exception) {
        NSLog(@"dbOperatin ERROR:%@",exception.description);
        return NO;
    }
}
@end
