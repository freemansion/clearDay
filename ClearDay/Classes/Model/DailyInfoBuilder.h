//
//  DailyInfoBuilder.h
//  ClearDay
//
//  Created by Stas Baranovskiy on 19/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyInfoBuilder : NSObject
+(NSArray *)getDailyListFromData:(NSData *)data error:(NSError *)error;
@end
