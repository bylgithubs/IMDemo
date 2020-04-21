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

- (void)insertChatMessage:(ChatRoomModel *)model;

@end

NS_ASSUME_NONNULL_END
