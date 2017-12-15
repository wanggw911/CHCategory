//
//  NSString+GWExtension.m
//  CHCategory
//
//  Created by Guowen Wang on 15/11/10.
//  Copyright © 2015年 Guowen Wang. All rights reserved.
//

#import "NSString+CHExtension.h"
//  系统库
#import <CommonCrypto/CommonHMAC.h>
//  Helper
#import "NSObject+CHExtension.h"
#import "NSData+CHExtension.h"


@implementation NSString (CHInstance)

- (NSString *)ch_ckeckIsNull {
    if ([self isEqualToString:@"(null)"] || self == nil || self.length == 0 || [self isEqualToString:@"<null>"]){
        return @"";
    }
    else{
        return self;
    }
}

- (NSString *)ch_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)ch_trimingAllWhitespace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)ch_deviceToken {
    NSError *error;
    NSRegularExpression *regex  = [NSRegularExpression regularExpressionWithPattern:@"[<> ]"
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:&error];
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length])  withTemplate:@""];
}

- (NSString *)ch_URLDecode {
    CFStringRef decoded = CFURLCreateStringByReplacingPercentEscapes( kCFAllocatorDefault,
                                                                     (__bridge CFStringRef)self,
                                                                     CFSTR(":/?#[]@!$&'()*+,;=") );
    if (decoded) {
        return [NSString stringWithString:(__bridge_transfer NSString *)decoded];
    }
    return nil;
}

- (NSString *)ch_decodeFromPercentEscapeString:(NSString *)input {
    if (input == nil) {
        return nil;
    }
    
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    
    
    NSString *decodestring = nil;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000
    decodestring = [outputStr stringByRemovingPercentEncoding];;
#else
    decodestring = [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#endif
    
    return decodestring;
}

- (NSString *)ch_substringFrom:(NSInteger)from to:(NSInteger)to {
    NSString *rightPart = [self substringFromIndex:from];
    return [rightPart substringToIndex:to-from];
}

- (NSString *)ch_stringOfTimeWithTimestamp:(NSString *)timestamp DateFormat:(NSString *)dateFormat {
    NSString *timeSting = nil;
    
    //计算时间只能按前十位的时间戳字符串来计算
    if (timestamp.length > 10) {
        timestamp = [timestamp substringToIndex:10];
    }
    
    NSTimeInterval dataIn = timestamp.doubleValue;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dataIn];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    timeSting = [dateFormatter stringFromDate:confromTimesp];
    
    return timeSting;
}

#pragma mark -

- (BOOL)ch_isEmpty {
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        return [[(NSString *)self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] <= 0;
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        return [(NSArray *)self count] <= 0;
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        return [(NSArray *)self count] <= 0;
    }
    
    if ([self isKindOfClass:[NSSet class]]) {
        return [(NSSet *)self count] <= 0;
    }
    
    if ([self isKindOfClass:[NSData class]]) {
        return [(NSData *)self length] <= 0;
    }
    
    return NO;
}

- (BOOL)ch_contains:(NSString *)string {
    return ( [self rangeOfString:string].location != NSNotFound );
}

#pragma mark - Predicate

- (BOOL)ch_isValidChinese {
    NSString *chineseRegex = @"^[\\u4e00-\\u9fa5]+$";
    NSPredicate *regextNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chineseRegex];
    return [regextNumber evaluateWithObject:self];
}

- (BOOL)ch_ckeckIsNumber {
    NSString *numberStr = @"^[0-9]*$";
    NSPredicate *regextNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberStr];
    return [regextNumber evaluateWithObject:self];
}

- (BOOL)ch_ckeckIsQQNumber {
    NSString *qqNum = @"^[1-9](\\d){4,9}$";
    NSPredicate *regextestQQ = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqNum];
    return [regextestQQ evaluateWithObject:self];
}

- (BOOL)ch_ckeckIsNumOrApha {
    NSString *qqNum = @"^[A-Za-z0-9]+$";
    NSPredicate *regextestQQ = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqNum];
    return [regextestQQ evaluateWithObject:self];
}

- (BOOL)ch_ckeckIsPhoneNum {
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(178)|(18[0,1,9]))\\d{8}$";//(178)是我自己加进去的
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    
    if (res2 || res3 || res4 ){
        return YES;
    }
    else{
        return NO;
    }
}

- (BOOL)ch_checkIsEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)ch_ckeckIsIDCard {
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}

- (BOOL)ch_ckeckIsContainsEmoji {
    __block BOOL returnValue =NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring,NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue =YES;
                }
            }
            
        }else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue =YES;
            }
            
        }else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue =YES;
                
            }else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue =YES;
                
            }else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue =YES;
                
            }else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue =YES;
                
            }else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue =YES;
            }
        }
    }];
    return returnValue;
}

#pragma mark - valid

- (BOOL)ch_validNumber {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    NSString*filtered = [[self componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [self isEqualToString:filtered];
}

- (BOOL)ch_validPassword {
    return [self ch_isMatchsRegex:@"^[\\S]{6,16}$"];
}

- (BOOL)ch_validPhoneNumber {
    return self.length==11 && [self hasPrefix:@"1"];
}

- (BOOL)ch_validVerificationCode {
    return self.length >= 6;
}

- (BOOL)ch_validAccount {
    return [self ch_isMatchsRegex:@"^[A-Za-z0-9]{6,16}+$"];
}

- (BOOL)ch_validNickname {
    return self.length > 0 && self.length < 12;
}

- (BOOL)ch_validIDNumber {
    return [[self uppercaseString] ch_isMatchsRegex:@"^(\\d{6})(\\d{4})(\\d{2})(\\d{2})(\\d{3})([0-9]|X)$"];
}

#pragma mark -

- (BOOL)ch_isMatchsRegex:(NSString *)regex {
    if ([self ch_isEmpty]) { // 需导入库 #import "NSObject-Extension.h"
        return NO;
    }
    NSPredicate *nicknameMatches = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    return [nicknameMatches evaluateWithObject:self];
}

#pragma mark - Crypto

- (NSString *)ch_md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ch_md5String];
}

- (NSString *)ch_sha224String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ch_sha224String];
}

- (NSString *)ch_sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ch_sha256String];
}

- (NSString *)ch_sha384String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ch_sha384String];
}

- (NSString *)ch_sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ch_sha512String];
}

- (NSData *)ch_base64EncodedData {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ch_base64EncodedData];
}

- (NSString *)ch_base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ch_base64EncodedString];
}

- (NSData *)ch_base64DecodedData {
    NSData *dataFromBase64String = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return dataFromBase64String;
}

- (NSString *)ch_base64DecodedString {
    return [[NSString alloc] initWithData:[self ch_base64DecodedData] encoding:NSUTF8StringEncoding];
}

- (NSString *)ch_aes256EncryptStringWithKey:(NSString *)key {
    if (self.length > 0) {
        //对数据进行加密
        NSData *result = [[self ch_base64EncodedData] ch_aes256EncryptDataWithKey:key];
        //转换为2进制字符串
        if (result && result.length > 0) {
            Byte *datas = (Byte*)[result bytes];
            NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
            for(NSUInteger i = 0; i < result.length; i++) {
                [output appendFormat:@"%02x", datas[i]];
            }
            return output;
        }
    }
    return nil;
}

- (NSString *)ch_aes256DecryptStringWithKey:(NSString *)key {
    if (self.length > 0) {
        NSUInteger aNumItems = self.length / 2;
        NSMutableData *data = [NSMutableData dataWithCapacity:aNumItems];
        unsigned char whole_byte;
        char byte_chars[3] = {'\0','\0','\0'};
        for (NSInteger i = 0; i < aNumItems; i++) {
            byte_chars[0] = [self characterAtIndex:i*2];
            byte_chars[1] = [self characterAtIndex:i*2+1];
            whole_byte = strtol(byte_chars, NULL, 16);
            [data appendBytes:&whole_byte length:1];
        }
        //对数据进行解密
        NSData* result = [data ch_aes256DecryptDataWithKey:key];
        if (result && result.length > 0) {
            return [result ch_base64DataDecodedString];
        }
    }
    return nil;
}

- (NSString *)ch_sha256 {
    const char *str = [self UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, (CC_LONG)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (NSString *)ch_decrypt:(NSString *)key {
    if (!key) {
        return nil;
    }
    
    NSData *plainData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    NSData * kData = [base64String dataUsingEncoding:NSUTF8StringEncoding];
    
    char * k = (char *)[kData bytes];
    NSData * sData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    char * s =(char *) [sData bytes];
    
    NSInteger mLength = sData.length -kData.length;
    
    char * m =(char *) malloc((mLength)*sizeof(char));
    
    NSInteger kLength =kData.length;
    NSInteger sLength = sData.length;
    for(NSInteger i=0;i<sLength;i++)
    {
        for(int j=0;j<kLength;j++)
        {
            s[i] ^=k[j];
        }
        if(i<kLength)
        {
            s[i] -=k[i];
        }
    }
    
    NSUInteger l=kData.length;
    NSUInteger o=mLength;
    sLength = sData.length;
    int z=0,c=0;
    for (int i = 0; i < sLength; i++) {
        if(z<o&i%2!=0){
            m[z++]=s[i];
        }else if(c<l){
            c++;
        }else if(z<o){
            m[z++]=s[i];
        }
    }
    NSData *content=[NSData dataWithBytes:m length:mLength];
    free(m);
    return  [[NSString alloc] initWithData:content  encoding:NSUTF8StringEncoding];
}

- (NSString *)ch_encrypt:(NSString *)key {
    if (self==nil||[self isEqualToString:@""]) {
        return self;
    }
    
    @synchronized (self) {
        
        NSData *nsdata = [key dataUsingEncoding:NSUTF8StringEncoding];
        // Get NSString from NSData object in Base64
        NSString * baseData =[nsdata base64EncodedStringWithOptions:0];
        const char *h = [baseData UTF8String];
        const char *e = [self UTF8String];
        int a = 0, r = 0, q = 0, w = 0, y = 0 ;
        int l = (int)self.length, o = (int)baseData.length;
        Byte * s =  (Byte*)malloc(o+l);//new byte[o + l];
        
        
        for (int i = 0; i < o+l; i++) {
            if (w < o && i % 2 == 0) {
                s[i] = h[w++];
            } else if (q < l) {
                s[i] = e[q++];
            } else {
                s[i] = h[w++];
            }
        }
        for (int i = 0; i < o+l; i++) {
            if (o < l) {
                if (r < o) {
                    if (i % 2 == 0)
                        r++;
                    else
                        a++;
                } else {
                    if (a < l)
                        a++;
                }
            } else {
                if (a < l) {
                    if (i % 2 == 0)
                        r++;
                    else
                        a++;
                } else {
                    if (r < o)
                        y++;
                }
            }
        }
        
        for (int i = 0; i < o+l; i++) {
            if (i < o)
                s[i] += h[i];
            for(int j =0;j<o;j++){
                Byte b = h[j];
                s[i] = (s[i] ^ b);
            }
        }
        return  [[NSData dataWithBytes:s length:o+l] base64EncodedStringWithOptions:0];
    }
}

#pragma mark - width Or height Of String

- (CGFloat)ch_widthWithSize:(CGSize)size font:(UIFont *)font {
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName : font}
                              context:NULL].size.width;
}

- (CGFloat)ch_heightWithSize:(CGSize)size font:(UIFont *)font {
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName : font}
                              context:NULL].size.height;
}

- (CGSize)ch_sizeGWSizeWithFont:(UIFont *)font Size:(CGSize)size {
    //----可以作为 nsstring 的扩展类：参数：字符串长度，字体大小，固定的宽度或长度 | 返回值：size或者直接返回高度或者长度
    //----注意：ios7情况下宽度计算貌似有点问题
    CGSize stringSize;
    CGSize constraintSize = size;//求长度就固定高度，就高度就固定长度
    CGRect stringRect = [self boundingRectWithSize:constraintSize
                                           options:(NSStringDrawingUsesFontLeading|  NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin)
                                        attributes:@{NSFontAttributeName: font}
                                           context:NULL];
    stringRect.size.width = stringRect.size.width + 1;
    stringSize = stringRect.size;
    if (stringSize.height == 0) {
        stringSize = stringRect.size;
    }
    
    return stringSize;
}

#pragma mark - Dictionary

- (NSDictionary *)ch_dictionaryWithJsonString {
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSDictionary *)ch_stringToDictionary {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSArray *array = [self componentsSeparatedByString:@"&"];
    if (array && array.count>0) {
        for (int i=0; i<[array count]; i++) {
            NSString *string = array[i];
            NSArray *curArray = [string componentsSeparatedByString:@"="];
            if (curArray.count>1) {
                dic[curArray[0]] = curArray[1];
            }
        }
    }
    return dic;
}



@end
