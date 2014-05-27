//
//  DailyForecastViewController.h
//  ClearDay
//
//  Created by Stas Baranovskiy on 18/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyForecastViewController : UIViewController
@property (strong, nonatomic) NSString *cityID;
@property (assign, nonatomic) CLLocationCoordinate2D cityCoordinates;

@end
