//
//  NSString+Extension.h
//  mbookTest
//
//  Created by HYS on 15/10/19.
//  Copyright © 2015年 HYS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  计算当前字符串显示所需的实际frame，返回值的x = 0, y = 0
 */
- (CGRect)textRectWithSize:(CGSize)size attributes:(NSDictionary *)attributes;
@end
