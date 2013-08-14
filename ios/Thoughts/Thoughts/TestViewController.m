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

#import "TestViewController.h"
#import "ReminderViewController.h"
#import "AboutController.h"

@interface TestViewController ()

- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info;

@end

@implementation TestViewController

@synthesize selectWallpaper;
@synthesize enterReminder;
@synthesize mediaUI;
@synthesize lib;
@synthesize result;
@synthesize aboutButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.selectWallpaper = nil;
    self.enterReminder = nil;
    self.result = nil;
    self.aboutButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    self.selectWallpaper = nil;
    self.enterReminder = nil;
    self.result = nil;
    self.aboutButton = nil;
    
    [super dealloc];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [enterReminder resignFirstResponder];
    [self.view resignFirstResponder];
}

#pragma mark Actions

- (IBAction)chooseWallpaperAction
{
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (IBAction)aboutTouched
{
    AboutController *ctl = [[AboutController alloc] initWithNibName:@"AboutController" bundle:nil];
    [self.navigationController pushViewController:ctl animated:YES];
    [ctl release];
}


#pragma mark UIImagePickerController delegate

- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info
{
    UIImage *originalImage;
    NSURL *assetURL = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    originalImage = (UIImage *) [info objectForKey:
                                 UIImagePickerControllerOriginalImage];
    
    self.result = [[originalImage copy] autorelease];

    
    
    [picker dismissModalViewControllerAnimated: YES];
    self.mediaUI = nil;
    
    ReminderViewController *rvc = [[[ReminderViewController alloc] initWithNibName:@"ReminderViewController" bundle:nil] autorelease];
    rvc.assetUrl = assetURL;
    rvc.reminderText = self.enterReminder.text;
    rvc.backgroundImage = self.result;

    [self.navigationController pushViewController:rvc animated:YES];
}


#pragma mark private

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    self.mediaUI = [[[UIImagePickerController alloc] init] autorelease];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    mediaUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypePhotoLibrary];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = NO;
    
    mediaUI.delegate = self;
    
    [controller presentModalViewController: mediaUI animated: YES];
    return YES;
}

@end
