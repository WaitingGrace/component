//
//  NSString+WGExpand.m
//
//  Created by 帅棋 on 2018/11/22.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "NSString+WGExpand.h"

@implementation NSString (WGExpand)

#pragma mark ---
#pragma mark ------------------------------------- 校验、判断

/**
 字符串判空

 @param string 字符串
 @return 结果
 */
+ (BOOL)stringIsNULL:(NSString *)string{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNumber class]]) {
        return NO;
    }
    if ([@([string length]) isEqual:@(0)]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    
    return NO;
}


/**
 对象判空

 @param obj 任意对象
 @return 是否为空
 */
+ (BOOL)objIsNULL:(id)obj{
    if (obj == nil || obj == NULL) {
        return YES;
    }
    if ([obj isEqual:[NSNull null]]) {
        return YES;
    }
    if ([obj isEqual:[NSNull class]]) {
        return YES;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        if ([obj isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        if ([obj isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([obj isKindOfClass:[NSArray class]]) {
        if ([obj isEqual:@[]]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([obj isKindOfClass:[NSDictionary class]]) {
        if ([obj isEqual:@{}]) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}


/**
 手机号、电话号码验证

 @param mobile 号码
 @return 结果
 */
+ (NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length != 11){
        if (mobile.length == 12) {//固话
            /**
             * 大陆地区固话
             * 区号：010,020,021,022,023,024,025,027,028,029
             * 号码：七位或八位
             */
            NSString *CG_NUM = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";//不带-
            NSString *CG__NUM = @"^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";//带-
            NSPredicate * pred4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CG_NUM];
            BOOL isMatch4 = [pred4 evaluateWithObject:mobile];
            NSPredicate * pred5 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CG__NUM];
            BOOL isMatch5 = [pred5 evaluateWithObject:mobile];
            if (isMatch4 || isMatch5){
                return @"请输入手机号码，以便接收验证码";
            }
        }
        return @"请输入11位手机号";
    }else{
        
        /**
         移动号段：
         134 135 136 137 138 139 147 150 151 152 157 158 159 172 178 182 183 184 187 188 198
         联通号段：
         130 131 132 145 155 156 166 171 175 176 185 186
         电信号段：
         133 149 153 173 177 180 181 189 199
         虚拟运营商:
         170
         */
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(17[2,8])|(18[2-4,7-8])|(198))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(166)|(17[1,5,6])|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(149)|(153)|(17[3,7])|(18[0,1,9])|(199))\\d{8}|(^1700\\d{7}$)";
        /**
         * 虚拟运营商号段正则表达式
         */
        NSString *VNO_NUM = @"^170\\d{7}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        NSPredicate *pred4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VNO_NUM];
        BOOL isMatch4 = [pred4 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3 || isMatch4) {
            return @"200";//正确
        }else {
            return @"请输入正确的电话号码";
        }
        
        /**
         NSString *regex = @"^(13[0-9]|14[5,7,9]|15[0-3,5-9]|16[6]|17[0-3,5-8]|18[0-9]|19[8,9])\\d{8}$";
         NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
         BOOL isMatch = [pred evaluateWithObject:mobile];
         if (isMatch) {
         return @"200";//正确
         }else {
         return @"请输入正确的电话号码";
         }
         */
    }
}

/**
 判断是否为邮箱格式
 
 @param email 邮箱
 @return 结果
 */
+ (NSString *)isEmail:(NSString *)email{
    NSString *Pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:Pattern options:0 error:nil];
    NSArray *results = [regex matchesInString:email options:0 range:NSMakeRange(0, email.length)];
    if (results.count > 0) {
        return @"200";
    }
    return @"请输入正确的邮箱";
}

/**
 身份证验证

 @param identityString 身份证
 @return 结果
 */
+ (NSString *)judgeIdentityStringValid:(NSString *)identityString {
    if (identityString.length != 18) {
        if (identityString.length == 15) {
            NSString * regex = @"^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}$";
            NSPredicate * idCode = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
            if (![idCode evaluateWithObject:identityString]) {
                return @"请输入正确的15位身份证号";
            }else{
                return @"200";
            }
        }
        return @"请输入18位身份证号码";
    }else{
        // 正则表达式判断基本 身份证号是否满足格式
        NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
        NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        //如果通过该验证，说明身份证格式正确，但准确性还需计算
        if(![identityStringPredicate evaluateWithObject:identityString]) return @"请输入正确身份证号码";
        
        //** 开始进行校验 *//
        //将前17位加权因子保存在数组里
        NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++) {
            NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            idCardWiSum+= subStrIndex * idCardWiIndex;
        }
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        //得到最后一位身份证号码
        NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2) {
            if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
                return @"请输入正确身份证号码";
            }
        }
        else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
                return @"请输入正确身份证号码";
            }
        }
        return @"200";
    }
}


/**
 密码校验

 @param password 密码
 @return 校验结果（6到20位字母、数字、下划线至少两种组合）
 */
+ (NSString *)verifyThatPasswordMeetsTheRules:(NSString *)password{
    if (password.length < 6 || password.length > 20) {
        return @"请输入长度为6到20位的密码";
    }
    NSString *passWordRegex = @"^(?=.*[a-zA-Z0-9])(?=.*[a-zA-Z0-9_])(?=.*[a-zA-Z_])(?=.*[0-9_]).{6,20}$"/*@"^[0-9a-zA-Z_]{6,20}$"*/;
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    
    NSString * specialRegex = @"[-()（）#—”“''`$&@%^*?+?=|{}?【】？??￥!！.<>/:;：；、,，。~]";
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:specialRegex options:NSRegularExpressionCaseInsensitive /*| NSRegularExpressionDotMatchesLineSeparators | NSRegularExpressionAnchorsMatchLines | NSRegularExpressionAllowCommentsAndWhitespace*/ error:&error];
    NSInteger resultCount = [regex numberOfMatchesInString:password                                                                        options:NSMatchingReportCompletion  range:NSMakeRange(0, password.length)];
    if ([pred evaluateWithObject:password]) {
        if (resultCount == 0) {
            return nil;
        }
        return @"不能有“_”以外的其他符号哦";
    }
    return @"请输入字母、数字、下划线至少两种组合的密码";
}

/**
 密码强度判断

 @param password 密码
 @return 强度
 */
+ (NSString*)judgePasswordStrength:(NSString*)password{
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    NSArray* termArray1 = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
    NSArray* termArray2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    NSArray* termArray3 = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    NSArray* termArray4 = [[NSArray alloc] initWithObjects:@"~",@"`",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",@"-",@"_",@"+",@"=",@"{",@"}",@"[",@"]",@"|",@":",@";",@"“",@"'",@"‘",@"<",@",",@".",@">",@"?",@"/",@"、", nil];
    NSString* result1 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray1 Password:password]];
    NSString* result2 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray2 Password:password]];
    NSString* result3 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray3 Password:password]];
    NSString* result4 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray4 Password:password]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result1]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result2]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result3]];
    [resultArray addObject:[NSString stringWithFormat:@"%@",result4]];
    int intResult=0;
    for (int j=0; j<[resultArray count]; j++){
        if ([[resultArray objectAtIndex:j] isEqualToString:@"1"]){
            intResult++;
        }
    }
    NSString* resultString = [[NSString alloc] init];
    if (intResult <2){
        resultString = @"密码强度低，建议修改";
    }else if (intResult == 2&&[password length]>=6){
        resultString = @"密码强度一般";
    }if (intResult > 2&&[password length]>=6){
        resultString = @"密码强度高";
    }
    return resultString;
}
//判断是否包含
+ (BOOL) judgeRange:(NSArray*)termArray Password:(NSString*)password{
    NSRange range;
    BOOL result =NO;
    for(int i=0; i<[termArray count]; i++){
        range = [password rangeOfString:[termArray objectAtIndex:i]];
        if(range.location != NSNotFound){
            result =YES;
        }
    }
    return result;
}

/**
 姓名校验

 @param userName 姓名
 @return 是否符合规则（20位以内汉字、英文）
 */
+ (NSString *)checkUserName:(NSString *)userName{
    if (userName.length > 20 || userName.length < 1) {
        return @"请输入1到20位汉字或英文字符!!!";
    }
    NSString *pattern = @"^(?:[\u4e00-\u9fa5]|[a-zA-Z](?:/[a-zA-Z])?)+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    if ([pred evaluateWithObject:userName]) {
        return nil;
    }
    return @"昵称只能是汉字或英文字母哦!!!";
}

/**
 判断字符串是否包含emoji

 @param string 字符串
 @return 结果
 */
+ (BOOL)stringContainsEmoji:(NSString *)string{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    return returnValue;
}

/*-------------------------------------------------------------------------------*/
/*===============================================================================*/
/*-------------------------------------------------------------------------------*/
#pragma mark ---
#pragma mark ---------------------------------- 获取
+ (NSString *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate{
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}
+ (NSString *)getCurrentTimeMM{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
+ (NSString *)getCurrentTimeSS{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
/*! 获取 x个年x个月x个日 后时间 x--任意整数/负数为之前 */
+ (NSString *)getDateWithYears:(NSInteger)year moths:(NSInteger)moth days:(NSInteger)day{
    NSDate * mydate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents * adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:moth];
    [adcomps setDay:day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    return beforDate;
}
/*! 获取之前的某一天0点0分 */
+ (NSDate *)getDateTimeWithYears:(NSInteger)year moths:(NSInteger)moth days:(NSInteger)day{
    NSDate * mydate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    NSString * hourStr = [dateFormatter stringFromDate:mydate];
    [dateFormatter setDateFormat:@"mm"];
    NSString * minuteStr = [dateFormatter stringFromDate:mydate];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * adcomps = [[NSDateComponents alloc] init];
    [adcomps setHour:-[hourStr integerValue]];
    [adcomps setMinute:-[minuteStr integerValue]];
    [adcomps setDay:day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:mydate options:0];
    return newdate;
}
/*! 根据身份证号获取生日 */
+ (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<14) return result;
    //**截取前14位
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 13)];
    //**检测前14位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9')) isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)  return result;
    year = [numberStr substringWithRange:NSMakeRange(6, 4)];
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    return result;
}
/*! 通过出生日期获取年龄 */
+ (NSString *)ageStrFormBirthday:(NSString *)birthday{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[format dateFromString:birthday]];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    return [NSString stringWithFormat:@"%ld",(long)iAge];
}
/*! 通过出生日期获取年龄,精确到天 */
+ (NSString *)dateToDetailOld:(NSString *)bornDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthDay = [dateFormatter dateFromString:bornDate];
    //获得当前系统时间
    NSDate *currentDate = [NSDate date];
    //创建日历(格里高利历)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置component的组成部分
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    //按照组成部分格式计算出生日期与现在时间的时间间隔
    NSDateComponents *date = [calendar components:unitFlags fromDate:birthDay toDate:currentDate options:0];
    //判断年龄大小,以确定返回格式
    if( [date year] > 0){
        return [NSString stringWithFormat:(@"%ld岁%ld月%ld天"),(long)[date year],(long)[date month],(long)[date day]];
    }
    else if([date month] >0){
        return [NSString stringWithFormat:(@"%ld月%ld天"),(long)[date month],(long)[date day]];
    }
    else if([date day]>0){
        return [NSString stringWithFormat:(@"%ld天"),(long)[date day]];
    }
    else {
        return @"0天";
    }
}
/*! 通过身份证获取性别 */
+ (NSString *)getSexFromIdentityCard:(NSString *)numberStr{
    int sexInt=[[numberStr substringWithRange:NSMakeRange(16,1)] intValue];
    if(sexInt%2!=0){
        return @"男";
    }else{
        return @"女";
    }
}
/*-------------------------------------------------------------------------------*/
/*===============================================================================*/
/*-------------------------------------------------------------------------------*/
#pragma mark ---
#pragma mark ---------------------------------- 转换

/**
 NSString 转 NSDate
 */
- (NSDate *)timeDateWith:(NSString *)timeStr formatter:(NSString *)formatter{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    return [dateFormatter dateFromString:timeStr];
}
/**
 字符窜转换--仿QQ时间显示
 */
+ (NSString *)dateCharacterChannelingWith:(NSString *)dataStr formatter:(NSString *)formatter{
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:formatter];
    NSDate*inputDate = [inputFormatter dateFromString:dataStr];
    //NSLog(@"startDate= %@", inputDate);
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:formatter];
    //get date str
    NSString *str= [outputFormatter stringFromDate:inputDate];
    //str to nsdate
    NSDate *strDate = [outputFormatter dateFromString:str];
    //修正8小时的差时
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: strDate];
    NSDate *endDate = [strDate  dateByAddingTimeInterval: interval];
    NSString *lastTime = [NSString compareDate:endDate];
    return lastTime;
}
+ (NSString *)compareDate:(NSDate *)date{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    //修正8小时之差
    NSDate *date1 = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date1];
    NSDate *localeDate = [date1  dateByAddingTimeInterval: interval];
    //NSLog(@"nowdate=%@\nolddate = %@",localeDate,date);
    NSDate *today = localeDate;
    NSDate *yesterday,*beforeOfYesterday;
    //今年
    NSString *toYears;
    toYears = [[today description] substringToIndex:4];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    beforeOfYesterday = [yesterday dateByAddingTimeInterval: -secondsPerDay];
    // 10 first characters of description is the calendar date:
    NSString *todayString = [[today description] substringToIndex:10];
    NSString *yesterdayString = [[yesterday description] substringToIndex:10];
    NSString *beforeOfYesterdayString = [[beforeOfYesterday description] substringToIndex:10];
    NSString *dateString = [[date description] substringToIndex:10];
    NSString *dateYears = [[date description] substringToIndex:4];
    NSString *dateContent;
    if ([dateYears isEqualToString:toYears]) {//同一年
        //今 昨 前天的时间
        NSString *time = [[date description] substringWithRange:(NSRange){11,5}];
        //其他时间
        NSString *time2 = [[date description] substringWithRange:(NSRange){5,11}];
        if ([dateString isEqualToString:todayString]){
            dateContent = [NSString stringWithFormat:@"%@",time];
            return dateContent;
        } else if ([dateString isEqualToString:yesterdayString]){
            dateContent = [NSString stringWithFormat:@"昨天 %@",time];
            return dateContent;
        }else if ([dateString isEqualToString:beforeOfYesterdayString]){
            dateContent = [NSString stringWithFormat:@"前天 %@",time];
            return dateContent;
        }else{
            return time2;
        }
    }else{
        return dateString;
    }
}

/*! dict 转JSON */
+ (NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
/*! JSON 转 dict */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err){
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/*! md5加密 */
+ (NSString *)MD5String:(NSString *)keyString{
    return  [self MD5ForLower32Bate:keyString];
}
// 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    return digest;
}
// 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    return digest;
}
// 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
// 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    NSString *md5Str = [self MD5ForLower32Bate:str];
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


/*-------------------------------------------------------------------------------*/
/*===============================================================================*/
/*-------------------------------------------------------------------------------*/

@end
