//
//  PersistencyManager.m
//  ClearDay
//
//  Created by Stas Baranovskiy on 18/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import "PersistencyManager.h"

@implementation PersistencyManager {
    NSArray *cityList;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"city_list" ofType:@"txt"];
        NSString *linesFromFile = [[NSString alloc] initWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
        
        cityList = [linesFromFile componentsSeparatedByString:@"\n"];
    }
    return self;
}

-(NSArray *)getCityGroupByName:(NSString *)searchText {
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    NSArray *searchResults = [cityList filteredArrayUsingPredicate:resultPredicate];
    
    return searchResults;
}

@end
