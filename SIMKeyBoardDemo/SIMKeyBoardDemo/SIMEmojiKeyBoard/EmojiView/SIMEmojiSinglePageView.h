//
//  SIMEmojiSinglePageView.h
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIMEmojiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMEmojiSinglePageView : UIView
//data
@property (nonatomic, strong) NSArray <SIMEmojiModel *> *emojiSignlePageModles;  //表情赋值
@property (nonatomic, copy) void (^emojiDidDeleteBlock)(void);   //表情删除回调
@property (nonatomic, copy) void (^emojiDidSelectBlock)(SIMEmojiModel *emojiModel);   //选中某个表情回调

@end

NS_ASSUME_NONNULL_END
