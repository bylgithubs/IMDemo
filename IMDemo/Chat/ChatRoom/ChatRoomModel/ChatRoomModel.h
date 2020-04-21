//
//  ChatRoomModel.h
//  IMDemo
//
//  Created by Civet on 2020/4/15.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatRoomModel : NSObject

//@property (nonatomic,copy) NSString *jID;
@property (nonatomic,copy) NSString *roomID;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *currentDate;

@end

NS_ASSUME_NONNULL_END
