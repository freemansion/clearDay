//
//  DailyDetailCell.h
//  ClearDay
//
//  Created by Stas Baranovskiy on 19/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailForecastInfo;

@interface DailyDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (strong, nonatomic) DetailForecastInfo *detailForecastInfo;

@end
