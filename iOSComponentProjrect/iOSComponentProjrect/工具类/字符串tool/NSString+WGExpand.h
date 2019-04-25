//
//  NSString+WGExpand.h
//
//  Created by 帅棋 on 2018/11/22.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (WGExpand)

#pragma mark ---
#pragma mark --- 判断
/**
 字符串是否为空,为空返回YES
 
 @param string 判断的字符串
 @return 判断结果
 */
+ (BOOL)stringIsNULL:(NSString *)string;

/**
 判断id对象是否为空
 
 @param obj 判定对象
 @return 判断结果
 */
+ (BOOL)objIsNULL:(id)obj;

/**
 判断手机号
 
 @param mobile 手机号
 @return 判断结果
 */
+ (NSString *)valiMobile:(NSString *)mobile;

/**
 判断是否为邮箱格式

 @param email 邮箱
 @return 结果
 */
+ (NSString *)isEmail:(NSString *)email;

/**
 判断身份证号
 
 @param identityString 身份证号
 @return 判断结果
 */
+ (NSString *)judgeIdentityStringValid:(NSString *)identityString;

/**
 校验密码是否符合规则（6-20 字母、数字、下划线至少两种组合）
 
 @param password 密码
 @return 校验结果
 */
+ (NSString *)verifyThatPasswordMeetsTheRules:(NSString *)password;
/**
 密码强度
 
 @param password 密码
 @return 强度 建议
 */
+ (NSString*)judgePasswordStrength:(NSString*)password;
/**
 判断用户名是否符合规则（1-20 字母、汉字）
 
 @param userName 用户名
 @return 校验结果
 */
+ (NSString *)checkUserName:(NSString *)userName;
/**
 是否包换emoji
 
 @param string 原始str
 @return 是否包含
 */
+ (BOOL)stringContainsEmoji:(NSString *)string;

#pragma mark ---
#pragma mark ---------------------------------- 获取
/*! 获取当时日期 */
+ (NSString *)getCurrentTime;
/*! 根据日期获取星期 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
/*! 获取当时时间（HH:mm） */
+ (NSString *)getCurrentTimeMM;
/*! 获取当时时间（HH:mm:ss） */
+ (NSString *)getCurrentTimeSS;

/**
 获取 x个年x个月x个日 后时间 x--任意整数/负数为之前
 
 @param year 年
 @param moth 月
 @param day 日
 @return 某段时间后的时间
 */
+ (NSString *)getDateWithYears:(NSInteger)year moths:(NSInteger)moth days:(NSInteger)day;
/*! 获取之前的某一天0点0分（负数为之后） */
+ (NSDate *)getDateTimeWithYears:(NSInteger)year moths:(NSInteger)moth days:(NSInteger)day;

/**
 根据身份证号获取生日
 
 @param numberStr 身份证号
 @return 出生日期
 */
+ (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;
/**
 通过出生日期获取年龄
 
 @param birthday 出生日期
 @return 年龄
 */
+ (NSString *)ageStrFormBirthday:(NSString *)birthday;

/**
 通过出生日期获取年龄
 
 @param bornDate 出生日期
 @return 年龄 精确到天
 */
+ (NSString *)dateToDetailOld:(NSString *)bornDate;
/**
 通过身份证号获取性别
 
 @param numberStr ID card
 @return 男 女
 */
+ (NSString *)getSexFromIdentityCard:(NSString *)numberStr;

#pragma mark ---
#pragma mark ---------------------------------- 转换

/**
 时间字符串转时间

 @param timeStr 字符串
 @param formatter 格式
 @return 时间NSDate
 */
- (NSDate *)timeDateWith:(NSString *)timeStr formatter:(NSString *)formatter;

/**
 时间转换（当天的显示时间、之前的显示日期和时间）
 
 @param dataStr 时间字符串格式
 @param formatter formatter(时间字符串格式)
 @return 结果string
 */
+ (NSString *)dateCharacterChannelingWith:(NSString *)dataStr formatter:(NSString *)formatter;

/**
 字典转json
 
 @param dict 字典
 @return jsonString
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

/**
 json转dict
 
 @param jsonString json
 @return dict
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 md5加密(可选择加密结果)
 
 @param keyString 要加密的字符串
 @return md5 string
 */
+ (NSString *)MD5String:(NSString *)keyString;

@end
