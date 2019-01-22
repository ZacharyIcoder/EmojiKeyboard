//
//  NSString+SIMEmojiKeyBoardTranscoding.h
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SIMEmojiKeyBoardTranscoding)
/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)simemojikeyboardemojiWithByIntCode:(int)intCode;

/**
 *  将十六进制字符串编码转为emoji字符
 */
+ (NSString *)simemojikeyboardemojiWithByStringCode:(NSString *)stringCode;

/**
 *  字符串对象转为emoji字符
 */
- (NSString *)simemojikeyboardEmoji;

/**
 *  字符串是否包含为emoji字符
 */
- (BOOL)simemojikeyboardisContainsEmoji;

@end

NS_ASSUME_NONNULL_END
