//
//  DetailInformationViewController.h
//  IMDemo
//
//  Created by Civet on 2020/4/27.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressDataModel.h"
#import <Masonry.h>
#import "CommonComponentMethods.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailInformationViewController : UIViewController

@property (nonatomic,strong) AddressDataModel *detailInfoModel;

@end

NS_ASSUME_NONNULL_END
