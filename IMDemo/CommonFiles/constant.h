//
//  constant.h
//  IMDemo
//
//  Created by Civet on 2020/4/15.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#ifndef constant_h
#define constant_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define Device_Is_iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define SafeAreaBottom (Device_Is_iPhoneX ? 34.f : 0.f) //底部安全距离

#define DATABASE_NAME @"InstanceMessage.sqlite"
#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#define DATABASE_PATH [DOCUMENT_PATH stringByAppendingPathComponent:DATABASE_NAME]



//通知
#define DeleteKeyboardText @"DeleteKeyboardText"

#endif /* constant_h */
