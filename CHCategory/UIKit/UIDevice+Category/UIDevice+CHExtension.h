//
//  UIDevice+CHExtension.h
//  CHCategory
//
//  Created by Guowen Wang on 2017/2/16.
//  Copyright © 2017年 Guowen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (CHExtension)

+ (void)logHomeDirectoryAddress;    /**< 打印本地沙盒的地址 */

+ (NSString *)uuid; /**< 返回一个唯一的uuid */

+ (void)jumpToAppStore;
+ (void)jumpToAppStoreWith:(NSString *)appId;
+ (void)jumpToAppStoreEvaluatePageWith:(NSString *)appId;

#pragma mark - 设备信息

+ (NSString *)deviceModelName;          /**< 获取设备名称:ihoneX */
+ (NSString *)deviceName;               /**< 获取设备所有者的名称 */
+ (NSString *)deviceModel;              /**< 获取设备的类别 */
+ (NSString *)deviceLocalizedModel;     /**< 获取本地化版本 */
+ (NSString *)deviceSystemName;         /**< 获取当前运行的系统 */
+ (NSString *)deviceSystemVersion;      /**< 获取当前系统的版本  */

+ (NSString *)deviceLocaleLanguage;     /**< 当前语言  */
+ (NSString *)deviceLocaleCountry;      /**< 当前国家代码  */

+ (double)deviceBatteryLevel;                   /**< 电池电量  */
+ (UIDeviceBatteryState)deviceBatteryState;     /**< 电池状态  */

+ (double)deviceMemoryAvailable;        /**< 获取当前设备可用内存(单位：MB） */
+ (double)deviceMemoryUsed;             /**< 获取当前任务所占用的内存（单位：MB） */

+ (double)DiskFreeSpaceInBytes;         /**< 获取剩余存储空间函数 */
+ (double)DiskTotalSpaceInBytes;        /**< 获取总的存储空间函数 */

+ (BOOL)deviceIsJailBreak;              /**< 是否越狱 */

#pragma mark - 设备功能

+ (void)makeACall:(NSString *)phoneNum; /** 打电话，参数说明：代理传当前的VC */
+ (void)playingLocalAudo;               /**< 播放本地的铃声 */
+ (void)vibrationDevice;                /**< 让设备震动Vibration */
+ (void)AwallysVibrationDevice;         /**< 让设备一直震动 */
+ (void)StopVibrationDevice;            /**< 让设备停止震动 */

#pragma mark - Access

+ (BOOL)accessOfPhoneMicro;         /**< 麦克风权限 */
+ (BOOL)accessOfPhonePhotoLibrary;  /**< 照片库权限 */
+ (BOOL)accessOfPhoneCamera;        /**< 相机权限 */
+ (BOOL)accessOfPhoneAddressBook;   /**< 通讯录权限 */
+ (BOOL)accessOfPhoneLocation;      /**< 定位权限 */

@end
