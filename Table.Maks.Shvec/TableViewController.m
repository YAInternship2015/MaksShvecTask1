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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return arrayOfCells.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *CellIdentifier = @"customCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
    
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
