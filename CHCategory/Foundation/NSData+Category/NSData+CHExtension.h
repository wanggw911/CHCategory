//
//  NSData+OPTCrypto.h
//  CHCategory 
//
//  Created by apple on 16/2/18.
//  Copyright © 2017年 Guowen Wang.. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CHExtension)

#pragma mark - 

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)ch_md5String;

/**W
 Returns an NSData for md5 hash.
 */
- (NSData *)ch_md5Data;

/**
 Returns a lowercase NSString for sha224 hash.
 */
- (NSString *)ch_sha224String;

/**
 Returns an NSData for sha224 hash.
 */
- (NSData *)ch_sha224Data;

/**
 Returns a lowercase NSString for sha256 hash.
 */
- (NSString *)ch_sha256String;

/**
 Returns an NSData for sha256 hash.
 */
- (NSData *)ch_sha256Data;

/**
 Returns a lowercase NSString for sha384 hash.
 */
- (NSString *)ch_sha384String;

/**
 Returns an NSData for sha384 hash.
 */
- (NSData *)ch_sha384Data;

/**
 Returns a lowercase NSString for sha512 hash.
 */
- (NSString *)ch_sha512String;

/**
 Returns an NSData for sha512 hash.
 */
- (NSData *)ch_sha512Data;

/**
 Returns a Data for base64 encoded hash.
 */
- (NSData *)ch_base64EncodedData;

/**
 Returns a lowercase NSString for base64 encoded hash.
 */
- (NSString *)ch_base64EncodedString;

/**
 Returns a NSData From base64 encoded hash.
 */
- (NSData *)ch_base64DecodedData;

/**
 Returns a NSString From base64 encoded hash.
 */
- (NSString *)ch_base64DataDecodedString;

/**
 Returns a NSData for AES256 hash.
 */
- (NSData *)ch_aes256EncryptDataWithKey:(NSString *)key;

/**
 Returns a NSData from AES256 Data hash.
 */
- (NSData *)ch_aes256DecryptDataWithKey:(NSString *)key;

@end
