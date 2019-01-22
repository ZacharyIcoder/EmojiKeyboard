//
//  SIMEmojiButton.m
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#import "SIMEmojiButton.h"
#import "SIMEmojiKeyBoardHead.h"
#import "NSString+SIMEmojiKeyBoardTranscoding.h"


@implementation SIMEmojiButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.adjustsImageWhenHighlighted = NO;
    self.titleLabel.font = [UIFont systemFontOfSize:32];
}


- (void)setModel:(SIMEmojiModel *)model
{
    _model = model;
    if (model.png) { // 有图片
        [self setImage:SIMEmojiKeyBoardBundleImage(model.png) forState:UIControlStateNormal];
    } else if (model.code) { // 是emoji表情
        // 设置emoji
        [self setTitle:model.code.simemojikeyboardEmoji forState:UIControlStateNormal];
    }
}

@end
