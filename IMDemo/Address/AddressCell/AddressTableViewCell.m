//
//  AddressTableViewCell.m
//  IMDemo
//
//  Created by Civet on 2020/4/14.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//
#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCellStyle{
    [super setCellStyle];
    [self initUI];
}

- (void)initUI{
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 30)];
    [self addSubview:self.nameLabel];
}

- (void)addAddressSideView{
    CGRect frame = self.frame;
    self.sideView = [[AddressSideView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.size.height/2, frame.size.width, frame.size.height/2)];
    [self addSubview:self.sideView];
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
