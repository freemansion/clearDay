//
//  DailyInfo.h
//  ClearDay
//
//  Created by Stas Baranovskiy on 19/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DetailForecastInfo;

@interface DailyInfo : NSObject
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *main;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) UIImage *weatherIcon;
@property (strong, nonatomic) DetailForecastInfo *detailForecast;
@end
