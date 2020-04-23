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

@end

NS_ASSUME_NONNULL_END
