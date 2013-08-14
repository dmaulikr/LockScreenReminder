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

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreText/CoreText.h>

@interface TestViewController : UIViewController < UINavigationControllerDelegate, UIImagePickerControllerDelegate >
{
    UIButton *selectWallpaper;
    UITextView *enterReminder;
    
    UIImagePickerController *mediaUI;
    ALAssetsLibrary *lib;
    UIImage *result;
    
    UIButton *aboutButton;
}

@property (nonatomic, retain) IBOutlet UIButton *selectWallpaper;
@property (nonatomic, retain) IBOutlet UITextView *enterReminder;
@property (nonatomic, retain) UIImagePickerController *mediaUI;
@property (nonatomic, retain) ALAssetsLibrary *lib;
@property (nonatomic, retain) UIImage *result;
@property (nonatomic, retain) UIButton *aboutButton;

- (IBAction)chooseWallpaperAction;
- (IBAction)aboutTouched;

@end
