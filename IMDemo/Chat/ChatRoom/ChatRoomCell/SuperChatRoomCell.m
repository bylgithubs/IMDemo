//
//  SuperChatRoomCell.m
//  IMDemo
//
//  Created by Civet on 2020/4/16.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import "SuperChatRoomCell.h"

@implementation SuperChatRoomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        
        //长按事件
        UITapGestureRecognizer *longTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(longTapClick:)];
        [self addGestureRecognizer:longTap];
    }
    return self;
}

- (void)longTapClick:(UILongPressGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateBegan) {
//        if ([]) {
//            <#statements#>
//        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
