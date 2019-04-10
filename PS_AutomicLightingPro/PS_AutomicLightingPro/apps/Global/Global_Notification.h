//
//  Global_Notification.h
//  PS_WisdomWork
//
//  Created by 李明明 on 2018/2/7.
//  Copyright © 2018年 www.psiot.com.cn. All rights reserved.
//

//全局标记字符串，用于 通知 存储

#ifndef Global_Notification_h
#define Global_Notification_h

#pragma mark - ——————— 用户相关 ————————
//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"

//自动登录成功
#define KNotificationAutoLoginSuccess @"KNotificationAutoLoginSuccess"

//被踢下线
#define KNotificationOnKick @"KNotificationOnKick"

//用户信息缓存 名称
#define KUserCacheName @"KUserCacheName"

//用户model缓存
#define KUserModelCache @"KUserModelCache"

////用户信息变更
#define KNotificationUpdateUserInfo @"KNotificationUpdateUserInfo"


#pragma mark - ——————— 网络状态相关 ————————

//网络状态变化
#define KNotificationNetWorkStateChange @"KNotificationNetWorkStateChange"


//用户图像更改成功
#define KUserAvatarChangeSuccessNoti @"KUserAvatarChangeSuccessNoti"



#endif /* Global_Notification_h */
