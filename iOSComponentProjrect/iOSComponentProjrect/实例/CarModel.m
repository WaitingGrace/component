//
//  CarModel.m
//  CXLinkageSheetDemo
//
//

#import "CarModel.h"

@implementation CarModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"specColorList" : [CarSpeccolorlistModel class],
             @"groupParamsViewModelList" : [GroupParamsModel class]
             };
}


@end

@implementation CarSpeccolorlistModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"ID" : @"id"
             };
}

@end


@implementation GroupParamsModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{
             @"paramList" : [ParamlistModel class]
             };
}


@end


@implementation ParamlistModel


@end




