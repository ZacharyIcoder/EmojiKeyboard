//
//  SIMEmojiKeyBoardHead.h
//  SIMKeyBoardDemo
//
//  Created by ZIKong on 2019/1/18.
//  Copyright © 2019 ZIKong. All rights reserved.
//

#ifndef SIMEmojiKeyBoardHead_h
#define SIMEmojiKeyBoardHead_h

// 此枚举: 弹出哪个视图的一个状态值
typedef NS_ENUM(NSInteger , SIMEmojiKeyBoardShowViewState)
{
    SIMEmojiKeyBoardShowViewStateVoice = 0,    //录音
    SIMEmojiKeyBoardShowViewStateKeyBoard,     //键盘
    SIMEmojiKeyBoardShowViewStateEmojiFace,    //表情
    SIMEmojiKeyBoardShowViewStateChatTool      //其他
};


#define SIMEmojiKeyBoardBundleImage(name) [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",@"SIMEmojiKeyboardBundle.bundle/",name]]

//表情最大的行数
#define SIMEmojKeyBoardSignlePageView_Emjoi_MaxRow 3
//表情最大的列数
#define SIMEmojKeyBoardSignlePageView_Emjoi_MaxCol 7
//单页最多的表情个数
#define SIMEmojKeyBoardSignlePageView_AllEmjoiCount ((SIMEmojKeyBoardSignlePageView_Emjoi_MaxRow * SIMEmojKeyBoardSignlePageView_Emjoi_MaxCol) - 1)

//颜色转换
#define SIMEmojKeyBoardColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
//键盘输入字体
#define SIMEmojKeyBoardFontValue 17
#define SIMEmojKeyBoardViewHeight 216  // 表情键盘高度
#define SIMEmojKeyBoardViewToolBarHeight   50   // 默认键盘输入工具条的高度

// 按钮宽度
#define SIMEmojKeyBoardButtonWidth 35
// 按钮高度
#define SIMEmojKeyBoardButtonHeight 44
// 输入框 Y值
#define SIMEmojKeyBoardTextViewY 7
// 默认输入框字体大小
#define SIMEmojKeyBoardTextViewFont SIMEmojKeyBoardFontValue
// 默认输入框字体颜色
#define SIMEmojKeyBoardTextViewColor [UIColor blackColor]



//屏幕的宽高
#define SIMEmojKeyBoardUIScreenWidth                              [UIScreen mainScreen].bounds.size.width
#define SIMEmojKeyBoardUIScreenHeight                             [UIScreen mainScreen].bounds.size.height

//iPhoneX / iPhoneXS
#define  SIMEmojKeyBoardisIphoneX_XS        (SIMEmojKeyBoardUIScreenWidth == 375.f && SIMEmojKeyBoardUIScreenHeight == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define  SIMEmojKeyBoardisIphoneXR_XSMax    (SIMEmojKeyBoardUIScreenWidth == 414.f && SIMEmojKeyBoardUIScreenHeight == 896.f ? YES : NO)
//异性全面屏
#define   SIMEmojKeyBoardisFullProfiledScreen    (SIMEmojKeyBoardisIphoneX_XS || SIMEmojKeyBoardisIphoneXR_XSMax)

#define SIMEmojKeyBoardiPhoneX (SIMEmojKeyBoardisFullProfiledScreen)


//竖屏状态
//iPhoneX状态栏的高度 44
#define SIMEmojKeyBoardkState_Height (SIMEmojKeyBoardisFullProfiledScreen ? 44.0 : 20.0)
//NavigationBar的高度 44
#define SIMEmojKeyBoardkNavigationBar_Height 44.0
#define SIMEmojKeyBoardSafeAreaTopHeight (SIMEmojKeyBoardisFullProfiledScreen ? 88 : 64)
//底部非安全区域的高度 34
#define SIMEmojKeyBoardkBottomNOSafeArea_Height (SIMEmojKeyBoardisFullProfiledScreen ? 34.0 :0.0)
#define SIMEmojKeyBoardkTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

#define SIMEmojKeyBoardkStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define SIMEmojKeyBoardkTopHeight (SIMEmojKeyBoardkStatusBarHeight + SIMEmojKeyBoardkNavigationBar_Height)

#endif /* SIMEmojiKeyBoardHead_h */
