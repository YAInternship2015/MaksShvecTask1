//
//  TMSAlerts.h
//  Table.Maks.Shvec
//
//  Created by Maks on 9/6/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TMSAlertsFactory : UIViewController

+ (UIAlertController *)showAlertWithTitle:(NSString *)title message:(NSString *)message;

@end
