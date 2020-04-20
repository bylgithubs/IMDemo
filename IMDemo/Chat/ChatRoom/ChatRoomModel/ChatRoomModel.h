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

@property (nonatomic,copy) NSString *jID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *content;

@end

NS_ASSUME_NONNULL_END
