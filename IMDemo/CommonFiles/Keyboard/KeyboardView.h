//
//  KeyboardView.h
//  IMDemo
//
//  Created by Civet on 2020/4/17.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KeyboardView;

@protocol KeyboardViewDelegate <NSObject>

- (void)KeyboardView:(KeyboardView *)keyboardView textFiledBegin:(UITextView *)textFiled;

@end

@interface KeyboardView : UIView

+ (KeyboardView *)sharedInstance;

@end

NS_ASSUME_NONNULL_END
