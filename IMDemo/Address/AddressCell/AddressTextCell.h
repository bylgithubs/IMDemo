//
//  AddressTextCell.h
//  IMDemo
//
//  Created by Civet on 2020/4/10.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperAddressCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressTextCell : SuperAddressCell

@property (nonatomic,strong) NSMutableDictionary *dataDic;
@property (nonatomic,strong) NSMutableArray *dataArr;

- (void)setCellStyle;

@end

NS_ASSUME_NONNULL_END
