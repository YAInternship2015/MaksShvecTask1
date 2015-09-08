//
//  TMSAlerts.h
//  Table.Maks.Shvec
//
//  Created by Maks on 9/6/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#warning вы можете вынести создание алерта в отдельный класс-фабрику, но его отображением в UI должен все равно заниматься вью контроллер

@interface TMSAlerts : NSObject

+ (void)showAlertWithMethodIsValidModelTitle;

@end
