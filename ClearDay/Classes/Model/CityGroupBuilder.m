//
//  CityGroupBuilder.m
//  ClearDay
//
//  Created by Stas Baranovskiy on 18/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import "CityGroupBuilder.h"
#import "CityGroup.h"

@implementation CityGroupBuilder

+(NSArray *)getCityGroupByFromArray:(NSArray *)listArray {
    NSMutableArray *group = [[NSMutableArray alloc] init];

    NSCharacterSet *charsSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    for (NSString *groupStr in listArray) {
        NSArray *chars = [groupStr componentsSeparatedByCharactersInSet:[charsSet invertedSet]];
        NSArray *values = [groupStr componentsSeparatedByCharactersInSet:charsSet];
        
        NSMutableArray *charactersArr = [[NSMutableArray alloc] init];
        for (NSString *str in chars) {
//            NSLog(@"%@", str);
            if ([str length]>0) {
                [charactersArr addObject:str];
            }
        }
        
        // prepare cityId string and remove white spaces
        NSString *cityId = [values objectAtIndex:0];
        cityId = [cityId stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        
        // initialize City Group
        CityGroup *city = [[CityGroup alloc] init];
        city.cityId = cityId;
        city.countryCode = [charactersArr lastObject];
        
        // remove 'Country' from string and if city name consist > 1 word append remaining strings
        [charactersArr removeLastObject];
        NSString *cityNameStr = @"";
        for (NSString *name in charactersArr) {
            cityNameStr = [cityNameStr stringByAppendingString:[NSString stringWithFormat:@"%@ ", name]];
        }
        city.cityName = cityNameStr;
        
        [group addObject:city];
    }
    
    return group;
}

@end
