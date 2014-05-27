//
//  DetailForecastInfo.h
//  ClearDay
//
//  Created by Stas Baranovskiy on 19/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailForecastInfo : NSObject
@property (strong, nonatomic) NSString *tempMorning;
@property (strong, nonatomic) NSString *tempDay;
@property (strong, nonatomic) NSString *tempEvening;
@property (strong, nonatomic) NSString *tempNight;
@property (strong, nonatomic) NSString *humidity;
@property (strong, nonatomic) NSString *pressure;
@property (strong, nonatomic) NSString *clouds;
@property (strong, nonatomic) NSString *windSpeed;
@property (strong, nonatomic) NSString *windDegree;
@property (strong, nonatomic) UIImage *weatherIcon;
@end
