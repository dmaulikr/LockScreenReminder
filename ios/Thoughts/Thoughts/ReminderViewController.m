/*  Lock Screen Reminder for iOS
 Copyright (C) 2013 Мобилен прогрес ЕООД, София, България
 
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License along
 with this program; if not, write to the Free Software Foundation, Inc.,
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#import "ReminderViewController.h"

@interface ReminderViewController ()

- (void)captureReminder;

@end

@implementation ReminderViewController
@synthesize backgroundImageView, enterReminder, backgroundImage, reminderText, assetUrl;

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
    
    self.title = @"Saving reminder";
    
    enterReminder.text = reminderText;
    
    CGSize size = [reminderText sizeWithFont:[UIFont boldSystemFontOfSize:18.0f] constrainedToSize:enterReminder.frame.size];
    size.height = size.height + 20.0f;
    size.width = size.width + 20.0f;
    CGPoint oldCenter = enterReminder.center;
    CGRect oldRect = enterReminder.frame;
    oldRect.size.width = size.width;
    oldRect.size.height = size.height;
    enterReminder.frame = oldRect;
    enterReminder.center = oldCenter;
    self.backgroundImageView.image = self.backgroundImage;
    [[enterReminder layer] setCornerRadius:5.0f];
    
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}

- (void)viewDidUnload
{
    self.backgroundImageView = nil;
    self.enterReminder = nil;
    self.backgroundImage = nil;
    self.reminderText = nil;
    self.assetUrl = nil;
    [indicator release];
    indicator = nil;
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self captureReminder];
}

- (void)dealloc
{
    self.backgroundImageView = nil;
    self.enterReminder = nil;
    self.backgroundImage = nil;
    self.reminderText = nil;
    self.assetUrl = nil;
    [indicator release];
    indicator = nil;

    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark private

- (void)captureReminder
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Iterate over every window from back to front
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            
    [[self.view layer] renderInContext:context];
            
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    ALAssetsLibrary *lib = [[[ALAssetsLibrary alloc] init] autorelease];
    [lib writeImageToSavedPhotosAlbum:image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error)
     {
     }
     ];

    self.backgroundImageView.image = nil;
    [self.view addSubview:indicator];
    indicator.center = self.view.center;
    [indicator startAnimating];
    CGRect rect = self.enterReminder.frame;
    rect.size.height = 90.0f;
    self.enterReminder.frame = rect;
    self.enterReminder.text = @"Saving reminder to your Camera Roll....";
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController popViewControllerAnimated:YES];
    });
}


@end
