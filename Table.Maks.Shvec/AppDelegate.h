//
//  AppDelegate.h
//  Table.Maks.Shvec
//
//  Created by Maks on 8/1/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import <UIKit/UIKit.h>

#warning Вы проигнорировали часть моих замечаний из темы https://groups.google.com/forum/#!topic/ios_yalantis/gNrPiQ40-hY . Нет префиксов у классов, нет .gitignore файла, нет модели, которая бы зранила в себе картинку и текст, нет класса-датасорса, который бы хранил все модели. Я не просто так писал эти замечания, это обязательные требования для решения задания

#warning также хочу заметить, что неплохо было бы соблюдать структуру проекта, то есть контроллеры должны находиться в папке Controllers, ячейки - в папке Views -> Cells, модели - в Models и т.д. Картинки должны находиться в папке Resources

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

