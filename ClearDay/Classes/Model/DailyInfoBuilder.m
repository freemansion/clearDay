//
//  DailyInfoBuilder.m
//  ClearDay
//
//  Created by Stas Baranovskiy on 19/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import "DailyInfoBuilder.h"
#import "DailyInfo.h"
#import "DetailForecastInfo.h"

@implementation DailyInfoBuilder

+(NSArray *)getDailyListFromData:(NSData *)data error:(NSError *)error {
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSArray *results = [parsedObject valueForKey:@"list"];

    NSMutableArray *dailyForecastGroup = [[NSMutableArray alloc] init];
    for (NSDictionary *groupDic in results) {
        DailyInfo *daily = [[DailyInfo alloc] init];
        for (NSString *key in groupDic) {
            // here we fetch Date and convert from unix format to nedeed
            if ([key isEqualToString:@"dt"]) {
                double unixTimeStamp = [[groupDic valueForKey:@"dt"] floatValue];
                NSTimeInterval _interval=unixTimeStamp;
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
                NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
                [_formatter setLocale:[NSLocale currentLocale]];
                [_formatter setDateFormat:@"MMM d"];
                NSString *_date=[_formatter stringFromDate:date];
                daily.date = _date;
            }
            
            // set Detail Forecast
            if ([key isEqualToString:@"clouds"]) {
                float clouds = [[groupDic valueForKey:@"clouds"] floatValue];
                daily.detailForecast.clouds = [NSString stringWithFormat:@"%.f %%", clouds];
            }
            if ([key isEqualToString:@"deg"]) {
                
                daily.detailForecast.windDegree = [[groupDic valueForKey:@"deg"] stringValue];
            }
            if ([key isEqualToString:@"humidity"]) {
                float humidity = [[groupDic valueForKey:@"humidity"] floatValue];
                daily.detailForecast.humidity = [NSString stringWithFormat:@"%.f %%", humidity];
            }
            if ([key isEqualToString:@"pressure"]) {
                float pressure = [[groupDic valueForKey:@"pressure"] floatValue];
                daily.detailForecast.pressure = [NSString stringWithFormat:@"%.f hPa", pressure];
            }
            if ([key isEqualToString:@"speed"]) {
                float speed = [[groupDic valueForKey:@"speed"] floatValue];
                daily.detailForecast.windSpeed = [NSString stringWithFormat:@"%.f m/s", speed];
            }
        }
        
        // Set temperatures
        NSArray *tempArray = [groupDic valueForKey:@"temp"];
        for (NSString *key in tempArray) {
            if ([key isEqualToString:@"morn"]) {
                float morn = [[tempArray valueForKey:@"morn"] floatValue];
                daily.detailForecast.tempMorning = [NSString stringWithFormat:@"%.f Cº", morn];
            }
            if ([key isEqualToString:@"day"]) {
                float day = [[tempArray valueForKey:@"day"] floatValue];
                daily.detailForecast.tempDay = [NSString stringWithFormat:@"%.f Cº", day];
            }
            if ([key isEqualToString:@"eve"]) {
                float eve = [[tempArray valueForKey:@"eve"] floatValue];
                daily.detailForecast.tempEvening = [NSString stringWithFormat:@"%.f Cº", eve];
            }
            if ([key isEqualToString:@"night"]) {
                float night = [[tempArray valueForKey:@"night"] floatValue];
                daily.detailForecast.tempNight = [NSString stringWithFormat:@"%.f Cº", night];
            }
        }
        
        NSArray *forecast = [groupDic valueForKey:@"weather"];
        for (NSDictionary *forecastDic in forecast) {
            for (NSString *forecastKey in forecastDic) {
                // fetch short weather description
                if ([forecastKey isEqualToString:@"main"]) {
                    daily.main = [forecastDic valueForKey:@"main"];
                }
                // fetch full weather description
                if ([forecastKey isEqualToString:@"description"]) {
                    NSString *descript = [forecastDic valueForKey:@"description"];
                    NSString *firstCapChar = [[descript substringToIndex:1] capitalizedString];
                    NSString *cappedString = [descript stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstCapChar];
                    daily.description = cappedString;
                }
                // fetch iconID and prepare UIImage
                if ([forecastKey isEqualToString:@"icon"]) {
                    daily.weatherIcon = [self getImageByIconId:[forecastDic valueForKey:@"icon"]];
                    daily.detailForecast.weatherIcon = daily.weatherIcon;
                }
            }
        }
        [dailyForecastGroup addObject:daily];
    }
    
    return dailyForecastGroup;
}

+(UIImage *)getImageByIconId:(NSString *)iconId {
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", iconId]];
    NSData *data = [NSData dataWithContentsOfURL:imgUrl];
    UIImage *iconImage = [[UIImage alloc] initWithData:data];
    
    return iconImage;
}

@end

