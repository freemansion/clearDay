//
//  CityDetailCell.h
//  ClearDay
//
//  Created by Stas Baranovskiy on 19/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (strong, nonatomic) NSString *cityId;
@end
