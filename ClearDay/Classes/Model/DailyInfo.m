//
//  DailyInfo.m
//  ClearDay
//
//  Created by Stas Baranovskiy on 19/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import "DailyInfo.h"
#import "DetailForecastInfo.h"

@implementation DailyInfo
-(DetailForecastInfo *)detailForecast {
    if (_detailForecast == nil) {
        _detailForecast = [[DetailForecastInfo alloc] init];
    }
    return _detailForecast;
}
@end
