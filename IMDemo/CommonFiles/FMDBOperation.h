//
//  FMDBOperation.h
//  IMDemo
//
//  Created by Civet on 2020/4/21.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>
#import "ChatRoomModel.h"
#import "ChatRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMDBOperation : NSObject

+ (instancetype) sharedDatabaseInstance;
- (void)initDB;
@property (nonatomic,strong) FMDatabase *dbOperation;
@property (nonatomic,strong) FMDatabaseQueue *dbQueue;

//插入聊天记录
- (void)insertChatMessage:(ChatRoomModel *)model;
//取出聊天记录
- (NSMutableArray *)getChatRoomMessage:(NSString *)jID;
//删除聊天记录
- (BOOL)deleteChatRoomMessage:(NSString *)jid;
//插入最新聊天记录
- (void)insertChatRecord:(ChatRecordModel *)model;
//查询最新聊天消息
- (NSMutableArray *)getChatRecordData;

@end

NS_ASSUME_NONNULL_END
