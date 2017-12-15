//
//  NSString+GWExtension.h
//  CHCategory
//
//  Created by Guowen Wang on 15/11/10.
//  Copyright © 2015年 Guowen Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (CHInstance)

- (NSString *)ch_ckeckIsNull;
- (NSString *)ch_trim;
- (NSString *)ch_trimingAllWhitespace;
- (NSString *)ch_deviceToken;
- (NSString *)ch_URLDecode;
- (NSString *)ch_decodeFromPercentEscapeString:(NSString *)input;
- (NSString *)ch_substringFrom:(NSInteger)from to:(NSInteger)to;
- (NSString *)ch_stringOfTimeWithTimestamp:(NSString *)timestamp DateFormat:(NSString *)dateFormat;

#pragma mark -

- (BOOL)ch_isEmpty;
- (BOOL)ch_contains:(NSString *)string;

#pragma mark - Predicate

- (BOOL)ch_isValidChinese;
- (BOOL)ch_ckeckIsNumber;
- (BOOL)ch_ckeckIsQQNumber;
- (BOOL)ch_ckeckIsNumOrApha;
- (BOOL)ch_ckeckIsPhoneNum;
- (BOOL)ch_checkIsEmail;
- (BOOL)ch_ckeckIsIDCard;
- (BOOL)ch_ckeckIsContainsEmoji;

#pragma mark - Valid

- (BOOL)ch_validNumber;
- (BOOL)ch_validPassword;
- (BOOL)ch_validPhoneNumber;
- (BOOL)ch_validVerificationCode;
- (BOOL)ch_validAccount;
- (BOOL)ch_validNickname;
- (BOOL)ch_validIDNumber;

#pragma mark - Crypto

- (NSString *)ch_md5String;
- (NSString *)ch_sha224String;
- (NSString *)ch_sha384String;
- (NSString *)ch_sha512String;
- (NSString *)ch_base64EncodedString;
- (NSString *)ch_base64DecodedString;
- (NSString *)ch_sha256;
- (NSString *)ch_sha256String;
- (NSString *)ch_aes256EncryptStringWithKey:(NSString *)key;
- (NSString *)ch_aes256DecryptStringWithKey:(NSString *)key;

#pragma mark - Encrypt/Decrypt

- (NSString *)ch_encrypt:(NSString *)key;
- (NSString *)ch_decrypt:(NSString *)key;

#pragma mark - WidthOrHeight Of String

- (CGFloat)ch_widthWithSize:(CGSize)size font:(UIFont *)font;
- (CGFloat)ch_heightWithSize:(CGSize)size font:(UIFont *)font;
- (CGSize)ch_sizeGWSizeWithFont:(UIFont *)font Size:(CGSize)size;

#pragma mark - Dictionary

- (NSDictionary *)ch_dictionaryWithJsonString;
- (NSDictionary *)ch_stringToDictionary;

@end
