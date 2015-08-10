//
//  TableViewController.m
//  Table.Maks.Shvec
//
//  Created by Maks on 8/1/15.
//  Copyright (c) 2015 Maks. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
{
#warning нет никакой необходимости хранить ячейки для таблицы. У таблицы есть свой пулл ячеек, которые она успешно реюзает (то есть ячеек создается ровно столько, сколько их умещается в видимой части таблицы). Зранить необходимо только модели внутри датасорса
    NSMutableArray *arrayOfCells;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    arrayOfCells = [[NSMutableArray alloc]init];
    for (int i = 0; i<=9; i++)
    {
        NSString *tempString = [NSString stringWithFormat:@"%i",i];
        [arrayOfCells addObject:tempString];
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return arrayOfCells.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
    
#warning заполнение ячеек моделью нужно реализовывать в самой ячейке. Начать нужно с создания класса-модели, где будет храниться текст и картинка. Затем у ячейки нужно реализовать метод вроде setupWithModel:, в котором ячейка будет заполнять свой UI моделью
    cell.someLabel.text = [arrayOfCells objectAtIndex:indexPath.row];
    switch (indexPath.row)
    {
        case 0:
            cell.pic.image = [UIImage imageNamed:@"1.png"];
            break;
        case 1:
            cell.pic.image = [UIImage imageNamed:@"2.png"];
            break;
        case 2:
            cell.pic.image = [UIImage imageNamed:@"3.png"];
            break;
        case 3:
            cell.pic.image = [UIImage imageNamed:@"4.png"];
            break;
        case 4:
            cell.pic.image = [UIImage imageNamed:@"5.png"];
            break;
        case 5:
            cell.pic.image = [UIImage imageNamed:@"6.png"];
            break;
        case 6:
            cell.pic.image = [UIImage imageNamed:@"7.png"];
            break;
        case 7:
            cell.pic.image = [UIImage imageNamed:@"8.png"];
            break;
        case 8:
            cell.pic.image = [UIImage imageNamed:@"9.png"];
            break;
        case 9:
            cell.pic.image = [UIImage imageNamed:@"10.png"];
            break;
        default:
            break;
    }
    
    return cell;
}

@end
