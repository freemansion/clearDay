//
//  CityGroup.h
//  ClearDay
//
//  Created by Stas Baranovskiy on 18/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityGroup : NSObject
@property (strong, nonatomic) NSString *cityId;
@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;
@property (strong, nonatomic) NSString *countryCode;
@end
