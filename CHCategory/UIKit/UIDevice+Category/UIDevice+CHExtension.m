//
//  UIDevice+CHExtension.m
//  CHCategory
//
//  Created by Guowen Wang on 2017/2/16.
//  Copyright © 2017年 Guowen Wang. All rights reserved.
//

#import "UIDevice+CHExtension.h"

//  获取内存信息，需要先导入的头文件
#import <sys/sysctl.h>
#import <mach/mach.h>

//  获取存储信息，需要先导入的头文件
#include <sys/param.h>
#include <sys/mount.h>

//  播放本地的铃声、震动，需要先导入的头文件
#import <AudioToolbox/AudioToolbox.h>

#import <sys/utsname.h>

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import <CoreLocation/CLLocationManager.h>

@implementation UIDevice (CHExtension)

+ (void)logHomeDirectoryAddress {
    NSLog(@"本地沙盒地址：");
    CFShow((__bridge CFTypeRef)(NSHomeDirectory()));
}

+ (NSString *)uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    
    NSString *resultString = [[result stringByReplacingOccurrencesOfString:@"-" withString:@""] uppercaseString];
    return resultString;
}

+ (void)jumpToAppStore {
    NSString *appUrl = @"http://phobos.apple.com/";
    NSURL *url = [NSURL URLWithString:appUrl];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

+ (void)jumpToAppStoreWith:(NSString *)appId {
    NSString *appUrl = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8", appId];
    NSURL *url = [NSURL URLWithString:appUrl];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

+ (void)jumpToAppStoreEvaluatePageWith:(NSString *)appId {
    NSString *appUrl = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appId];
    NSURL *url = [NSURL URLWithString:appUrl];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - 设备信息

// 需要
+ (NSString *)deviceModelName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    
    //iPhone 系列
    if ([deviceModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    
    
    //iPhone 系列：需要做下处理，可能会存在不在上面👆列表列举的返回之类的手机，但也是 iphone，国外版本之类的
    NSString *deviceInfo = [deviceModel copy];
    deviceInfo = [deviceInfo stringByReplacingOccurrencesOfString:@"iPhone" withString:@""];
    NSArray *phoneMessage = [deviceInfo componentsSeparatedByString:@","];
    if (phoneMessage.count > 0) {
        NSInteger phoneTag = [phoneMessage[0] integerValue];
        switch (phoneTag) {
            case 3:
                return @"iPhone 4";
                break;
            case 4:
                return @"iPhone 4s";
                break;
            case 5:
                return @"iPhone 5";
                break;
            case 6:
                return @"iPhone 5s";
                break;
            case 7:
                return @"iPhone 6";
                break;
            case 8:
                return @"iPhone 6s";
                break;
            case 9:
                return @"iPhone 7";
                break;
            case 10:
                return @"iPhone 8/iPhone X";
                break;
            default:
                return @"iPhone";
                break;
        }
    }
    

    //iPod 系列
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    //iPad 系列
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceModel isEqualToString:@"iPad4,4"]
        ||[deviceModel isEqualToString:@"iPad4,5"]
        ||[deviceModel isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    
    if ([deviceModel isEqualToString:@"iPad4,7"]
        ||[deviceModel isEqualToString:@"iPad4,8"]
        ||[deviceModel isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    
    return deviceModel;
}

+ (NSString *)deviceName {
    return [[UIDevice currentDevice] name];
}

+ (NSString *)deviceModel {
    return [[UIDevice currentDevice] model];
}

+ (NSString *)deviceLocalizedModel {
    return [[UIDevice currentDevice] localizedModel];
}

+ (NSString *)deviceSystemName {
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)deviceSystemVersion {
    return [[UIDevice currentDevice] systemVersion];
}


+ (NSString *)deviceLocaleLanguage {
    NSArray *languageArray = [NSLocale preferredLanguages];
    NSString *language = [languageArray objectAtIndex:0];
    return language;
}

+ (NSString *)deviceLocaleCountry {
    NSLocale *locale = [NSLocale currentLocale];
    NSString *country = [locale localeIdentifier];
    return country;
}


+ (double)deviceBatteryLevel {
    double batterLevel = [[UIDevice currentDevice] batteryLevel];
    return batterLevel * 100;
}

+ (UIDeviceBatteryState)deviceBatteryState {
    return [[UIDevice currentDevice] batteryState];
}

+ (double)deviceMemoryAvailable {
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
}

+ (double)deviceMemoryUsed {
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
}

+ (double)DiskFreeSpaceInBytes
{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
        freespace = (long long)(buf.f_bsize * buf.f_bsize);
    }
    
    return freespace / 1024.0 / 1024.0;
}

+ (double)DiskTotalSpaceInBytes
{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
        freespace = (long long)(buf.f_bsize * buf.f_blocks);
    }
    
    return freespace / 1024.0 / 1024.0;
}

+ (BOOL)deviceIsJailBreak {
    int res = access("/var/mobile/Library/AddressBook/AddressBook.sqlitedb", F_OK);
    if (res != 0)
        return NO;
    return YES;
}

#pragma mark - 设备功能

+ (void)makeACall:(NSString *)phoneNum {
    if (phoneNum.length == 0) {
        NSString *note = @"该号码无效，无法拨打电话";
        
        UIViewController *viewController = [[UIApplication sharedApplication].delegate window].rootViewController;
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:note preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [viewController presentViewController:alertController animated:YES completion:nil];
        return;
    }

    NSString *phoneUrl = [NSString stringWithFormat:@"tel://%@", phoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneUrl]];
}

+ (void)playingLocalAudo {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"msgIn" ofType:@"caf"];
        if (!path) {
            return;
        }
        
        NSURL *system_sound_url =[NSURL fileURLWithPath:path];
        SystemSoundID system_sound_id;
        AudioServicesCreateSystemSoundID((__bridge  CFURLRef)system_sound_url, &system_sound_id);
        
        AudioServicesPlaySystemSound(system_sound_id);
    });
}

+ (void)vibrationDevice {
    //tips：静音的时候才会响应啊，坑爹啊！！！
    //    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

+ (void)AwallysVibrationDevice {
    [UIDevice vibrationDevice];
    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL, soundCompleteCallback, NULL);
}

void soundCompleteCallback(SystemSoundID sound,void * clientData){
    [UIDevice vibrationDevice];
}

+ (void)StopVibrationDevice {
    //tips：静音的时候才会响应啊，坑爹啊！！！
    AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
}

#pragma mark - Access

+ (BOOL)accessOfPhoneMicro {
    __block BOOL isAvailable = NO;
    
    AVAudioSession *avSession = [AVAudioSession sharedInstance];
    if ([avSession respondsToSelector:@selector(requestRecordPermission:)]) {
        
        [avSession requestRecordPermission:^(BOOL available) {
            
            isAvailable = available;
        }];
    }
    
    return isAvailable;
}

+ (BOOL)accessOfPhonePhotoLibrary {
    BOOL isAvailable = NO;
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) {
        isAvailable = NO;
    }
    else{
        isAvailable = YES;
    }
    
    return isAvailable;
}

+ (BOOL)accessOfPhoneCamera {
    BOOL isAvailable = NO;
    AVAuthorizationStatus austatu = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (austatu == AVAuthorizationStatusRestricted || austatu == AVAuthorizationStatusDenied) {
        isAvailable = NO;
    }
    else{
        isAvailable = YES;
    }
    
    return isAvailable;
}

+ (BOOL)accessOfPhoneAddressBook {
    CFErrorRef *error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    __block BOOL accessGranted = NO;
    if (&ABAddressBookRequestAccessWithCompletion != NULL) {
        // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else {
        // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    if (accessGranted) {
        return YES;
    }
    else{
        return NO;
    }
}

+ (BOOL)accessOfPhoneLocation {
    BOOL isAvailable = NO;
    //if ([CLLocationManager locationServicesEnabled] == NO) {
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            
            //定位失败原因：有以下几个状态
            //CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            //kCLAuthorizationStatusRestricted
            //kCLAuthorizationStatusDenied
            
            //iOS8 以后可以直接跳转设置，设置定位
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
            isAvailable = YES;
    }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        isAvailable = NO;
    }
    
    
    return isAvailable;
}

@end
