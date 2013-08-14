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
#import <QuartzCore/QuartzCore.h>

@interface ReminderViewController : UIViewController
{
    UIImageView *backgroundImageView;
    UITextView *enterReminder;
    UIImage *backgroundImage;
    NSString *reminderText;
    NSURL *assetUrl;
    
    UIActivityIndicatorView *indicator;

}

@property (nonatomic, retain) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, retain) IBOutlet UITextView *enterReminder;
@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, copy) NSString *reminderText;
@property (nonatomic, retain) NSURL *assetUrl;

@end
