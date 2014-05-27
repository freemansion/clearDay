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
    NSOperationQueue *_weatherQueue;
}

@end

@implementation WeatherAPI

+ (WeatherAPI *)sharedInstance {
    static WeatherAPI *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[WeatherAPI alloc] initWithAPIKey:APP_ID];
    });
    return _sharedInstance;
}

-(instancetype)initWithAPIKey:(NSString *)apiKey {
    self = [super init];
    if (self) {
        // prepare manager in backrgound thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                                 (unsigned long)NULL), ^(void) {
            persistencyManager = [[PersistencyManager alloc] init];
        });
        
        _baseURL = @"http://api.openweathermap.org/data/";
        _apiKey = apiKey;
        _apiVersion = @"2.5";
        _unitsType = @"&units=metric";
        
        _weatherQueue = [[NSOperationQueue alloc] init];
        _weatherQueue.name = @"WeatherQueue";
    }
    return self;
}

-(NSDate *)convertToDate:(NSNumber *)num {
    return [NSDate dateWithTimeIntervalSince1970:num.intValue];
}

#pragma mark Find City
-(NSArray *)getCityListBySearchString:(NSString *)searchString {
    return [persistencyManager getCityGroupByName:searchString];
}

-(void)cityListBySearchString:(NSString *)searchString {
    NSArray *cityList = [persistencyManager getCityGroupByName:searchString];
    [self.delegate receivedCityListArray:cityList];
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
