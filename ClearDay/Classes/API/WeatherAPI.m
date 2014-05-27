//
//  WeatherAPI.m
//  ClearDay
//
//  Created by Stas Baranovskiy on 17/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import "WeatherAPI.h"
#import "PersistencyManager.h"

@interface WeatherAPI () {
    PersistencyManager *persistencyManager;
    NSString *_baseURL;
    NSString *_apiKey;
    NSString *_apiVersion;
    NSString *_unitsType;
}

@end

@implementation WeatherAPI

+ (WeatherAPI *)sharedInstance {
    static WeatherAPI *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[WeatherAPI alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // prepare manager in backrgound thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                                 (unsigned long)NULL), ^(void) {
            persistencyManager = [[PersistencyManager alloc] init];
        });
        
        _baseURL = BASE_URL;
        _apiKey = APP_ID;
        _apiVersion = API_VERSION;
        _unitsType = UNITS_TYPE;
    }
    return self;
}

-(NSDate *)convertToDate:(NSNumber *)num {
    return [NSDate dateWithTimeIntervalSince1970:num.intValue];
}

#pragma mark Find City
-(void)cityListBySearchString:(NSString *)searchString {
    NSArray *cityList = [persistencyManager getCityGroupByName:searchString];
    if (cityList.count > 0) {
        [self.delegate receivedCityListArray:cityList];
    } else {
        [self.delegate fetchingCityListFailed];
    }

}

#pragma mark forecast
-(void)forecastWeatherByCoordinate:(CLLocationCoordinate2D)coordinate {
    NSString *method = [NSString stringWithFormat:@"/forecast?lat=%f&lon=%f", coordinate.latitude, coordinate.longitude ];
    [self callMethod:method];
}

-(void)forecastWeatherByCityId:(NSString *)cityId {
    NSString *method = [NSString stringWithFormat:@"/forecast?id=%@", cityId];
    [self callMethod:method];
}

#pragma mark Daily Forecast
-(void)dailyForecastWeatherByCoordinate:(CLLocationCoordinate2D)coordinate withCount:(int)count {
    NSString *method = [NSString stringWithFormat:@"/forecast/daily?lat=%f&lon=%f&cnt=%d",
                        coordinate.latitude, coordinate.longitude, count ];
    [self callMethod:method];
}

-(void)dailyForecastWeatherByCityId:(NSString *)cityId withCount:(int)count {
    NSString *method = [NSString stringWithFormat:@"/forecast/daily?id=%@&cnt=%d", cityId, count];
    [self callMethod:method];
}


- (void)callMethod:(NSString *)method {
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@&APPID=%@", _baseURL, _apiVersion, method, _unitsType, _apiKey];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSLog(@"Request Url: %@", request);
    
     [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            [self.delegate fetchingDataFailedWithError:error];
        }
        else {
            [self.delegate receivedDataJSON:data];
        }
    }];
}

@end
