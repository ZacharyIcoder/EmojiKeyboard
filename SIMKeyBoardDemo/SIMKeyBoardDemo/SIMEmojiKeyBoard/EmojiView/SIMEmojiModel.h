//
//  SIMEmojiModel.h
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIMEmojiModel : NSObject
/**
 *  表情的文字描述
 */
@property (nonatomic, strong)  NSString *desc;

/**
 *  表情的png图片名称
 */
@property (nonatomic, strong)  NSString *png;

/**
 *  emoji表情的16进制编码
 */
@property (nonatomic, strong)  NSString *code;
@end

NS_ASSUME_NONNULL_END
