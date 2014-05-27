//
//  MasterViewController.m
//  ClearDay
//
//  Created by Stas Baranovskiy on 17/03/14.
//  Copyright (c) 2014 Stas Baranovskiy. All rights reserved.
//

#import "MasterViewController.h"
#import "FoundCitiesViewController.h"

@interface MasterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *cityNameTextField;
- (IBAction)searchBtnTouch:(id)sender;
@end

@implementation MasterViewController {
    UITapGestureRecognizer *tapRecognizer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self handleKeyboard];
    
    // 
    [WeatherAPI sharedInstance];
}

#pragma mark
#pragma mark Text Field handler methods
-(void)handleKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(didTapAnywhere:)];
}

-(void) keyboardWillShow:(NSNotification *) note {
    [self.view addGestureRecognizer:tapRecognizer];
}

-(void) keyboardWillHide:(NSNotification *) note
{
    [self.view removeGestureRecognizer:tapRecognizer];
}

-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [self.cityNameTextField resignFirstResponder];
}

#pragma mark
#pragma mark Button methods
- (IBAction)searchBtnTouch:(id)sender {
    // check for correct search text
    if ([self.cityNameTextField.text length] != 0 && [self isTextCorrect]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FoundCitiesViewController *foundCitiesVC = (FoundCitiesViewController *)[storyboard instantiateViewControllerWithIdentifier:@"foundCities"];
        foundCitiesVC.title = self.cityNameTextField.text;
        [self.navigationController pushViewController:foundCitiesVC animated:YES];
    } else {
        // if text contain illegal characters
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Clear Day" message:@"Wrong text" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(BOOL)isTextCorrect {
    NSString *aphabet = @"[A-Za-z ]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", aphabet];
    NSString *string = self.cityNameTextField.text;
    BOOL valid = [predicate evaluateWithObject:string];
    
    return valid;
}

#pragma mark
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

@end
