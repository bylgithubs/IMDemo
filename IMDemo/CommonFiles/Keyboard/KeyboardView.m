//
//  KeyboardView.m
//  IMDemo
//
//  Created by Civet on 2020/4/17.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import "KeyboardView.h"
#import "CustomTextView.h"

@interface KeyboardView()<UITextViewDelegate>

@property (nonatomic,strong) UIView *toolView;
@property (nonatomic,strong) CustomTextView *customTV;
@property (nonatomic,strong) UIButton *sendBtn;

@end

@implementation KeyboardView

static KeyboardView *sharedInstance = nil;

+ (KeyboardView *)sharedInstance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.frame = CGRectMake(0, 0, SCREEN_WIDTH, 260);
        sharedInstance.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        [[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(keyboardHeightChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
        [sharedInstance initKeyboard];
    });
    
    return sharedInstance;
}

- (void)initKeyboard{
    self.toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    self.toolView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.toolView];
    
    if (!self.customTV) {
        self.customTV = [[CustomTextView alloc] initWithFrame:CGRectMake(10, 5, self.toolView.frame.size.width - 100, 40)];
        self.customTV.font = [UIFont systemFontOfSize:18];
        self.customTV.delegate = self;
        [self.toolView addSubview:self.customTV];
    }
    
    if (!self.sendBtn) {
        CGRect toolFrame = self.toolView.frame;
        self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sendBtn.frame = CGRectMake(toolFrame.size.width - 80, 5, 60, 40);
        [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        self.sendBtn.backgroundColor = [UIColor whiteColor];
        [self.sendBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.toolView addSubview:self.sendBtn];
    }
    
    
}

- (void)sendBtnClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(KeyboardView:sendBtnClick:text:attribute:)]) {
        [self.delegate KeyboardView:self sendBtnClick:button text:self.customTV.text attribute:self.customTV.attributedText];
    }
}

- (void)keyboardHeightChange:(NSNotification *)notification{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
