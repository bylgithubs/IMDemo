//
//  CommonMethods.m
//  IMDemo
//
//  Created by Civet on 2020/4/17.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import "CommonMethods.h"

@implementation CommonMethods

+(BOOL)isEmptyString:(NSString *)text{
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [text isEqualToString:@""];
}

@end
