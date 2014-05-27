//
//  WeatherAPI.h
//  ClearDay
//
//  Created by Stas Baranovskiy on 17/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol APICommunicatorDelegate
@optional
- (void)receivedDataJSON:(NSData *)data;
- (void)fetchingDataFailedWithError:(NSError *)error;
- (void)receivedCityListArray:(NSArray *)array;
@end

@interface WeatherAPI : NSObject
@property (weak, nonatomic) id <APICommunicatorDelegate> delegate;

+ (WeatherAPI *)sharedInstance;

-(instancetype)initWithAPIKey:(NSString *)apiKey;

#pragma mark Find City
-(NSArray *)getCityListBySearchString:(NSString *)searchString;
-(void)cityListBySearchString:(NSString *)searchString;

#pragma mark Forecast
-(void)forecastWeatherByCoordinate:(CLLocationCoordinate2D)coordinate;
-(void)forecastWeatherByCityId:(NSString *)cityId;

#pragma mark Daily Forecast
-(void)dailyForecastWeatherByCoordinate:(CLLocationCoordinate2D)coordinate withCount:(int)count;
-(void)dailyForecastWeatherByCityId:(NSString *)cityId withCount:(int)count;
@end
