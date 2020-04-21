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
    BOOL result = nil;
    NSString *tableName = @"ChatMessage";
    NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(jid integer PRIMARY KEY AUTOINCREMENT,room_ID varchar,user_name varchar,content text,current_date varchar)",tableName];
    NSLog(@"===%@",sqlStr);
    result = [self.dbOperation executeUpdate:sqlStr];
    if (result) {
        NSLog(@"创建表 %@ 成功",tableName);
    } else {
        NSLog(@"创建表 %@ 失败",tableName);
    }
}

- (void)insertChatMessage:(ChatRoomModel *)model{
    
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sqlStr = @"insert into ChatMessage(room_ID,user_name,content,current_date) values(?,?,?,?)";
        [db executeUpdate:sqlStr,model.roomID,model.userName,model.content,model.currentDate];
    }];
    
}

@end
