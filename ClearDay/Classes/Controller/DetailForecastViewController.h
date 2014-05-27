//
//  DetailForecastViewController.h
//  ClearDay
//
//  Created by Stas Baranovskiy on 19/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailForecastView.h"
@class DetailForecastInfo;

@interface DetailForecastViewController : UIViewController
@property (strong, nonatomic) IBOutlet DetailForecastView *detailView;
@property (strong, nonatomic) DetailForecastInfo *detailForecastInfo;
@end
