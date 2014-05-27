//
//  FoundCitiesViewController.m
//  ClearDay
//
//  Created by Stas Baranovskiy on 17/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import "FoundCitiesViewController.h"
#import "CityGroup.h"
#import "CityGroupBuilder.h"
#import "CityDetailCell.h"
#import "DailyForecastViewController.h"

@interface FoundCitiesViewController () <UITableViewDelegate, UITableViewDataSource, APICommunicatorDelegate> {
    NSArray *cityList;
}
@property (strong, nonatomic) IBOutlet UITableView *cityListTableView;

@end

@implementation FoundCitiesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [WeatherAPI sharedInstance].delegate = self;

    // get array with group of cities by search request
    [[WeatherAPI sharedInstance] cityListBySearchString:self.title];
    
    self.cityListTableView.delegate = self;
    [self.cityListTableView reloadData];
}

#pragma mark
#pragma mark API Communicator Delegate methods
-(void)receivedCityListArray:(NSArray *)array {
    cityList = [CityGroupBuilder getCityGroupByFromArray:array];
}

-(void)fetchingCityListFailed {
    NSLog(@"Nothing found by request");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Clear Day"
                                                    message:@"Nothing found.\nTry to correct request."
                                                   delegate:self cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark
#pragma mark Table View delegate methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cityList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CityGroup *group = cityList[indexPath.row];
    [cell.cityLabel setText:group.cityName];
    [cell.countryLabel setText:group.countryCode];
    cell.cityId = group.cityId;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CityDetailCell *cell = (CityDetailCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DailyForecastViewController *dailyForecastVC = (DailyForecastViewController *)[storyboard instantiateViewControllerWithIdentifier:@"dailyForecast"];
    dailyForecastVC.title = cell.cityLabel.text;
    dailyForecastVC.cityID = cell.cityId;
    [self.navigationController pushViewController:dailyForecastVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

@end
