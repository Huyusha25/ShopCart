//
//  NSString+Extension.m
//  mbookTest
//
//  Created by HYS on 15/10/19.
//  Copyright © 2015年 HYS. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGRect)textRectWithSize:(CGSize)size attributes:(NSDictionary *)attributes{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}


@end
