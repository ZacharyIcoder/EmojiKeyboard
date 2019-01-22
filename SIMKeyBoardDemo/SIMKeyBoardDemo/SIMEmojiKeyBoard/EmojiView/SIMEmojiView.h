//
//  SIMEmojiView.h
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIMEmojiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIMEmojiView : UIView
- (void)setEmojiModles:(NSArray <SIMEmojiModel *>*)emojiModles selectEmojiModelBlock:(void(^)(SIMEmojiModel *selectModel))selectBlock deleteBlcok:(void(^)(void))deleteBlcok sendBlcok:(void(^)(void))sendBlock;

@end

NS_ASSUME_NONNULL_END
