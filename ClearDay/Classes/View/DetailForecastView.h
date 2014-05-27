//
//  DetailForecastView.h
//  ClearDay
//
//  Created by Stas Baranovskiy on 19/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailForecastView : UIView
@property (weak, nonatomic) IBOutlet UILabel *tempMorningLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempEveningLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempNightLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *cloudsLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (strong, nonatomic) NSString *windDegree;

@end
