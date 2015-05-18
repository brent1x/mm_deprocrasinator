//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Brent Dady on 5/18/15.
//  Copyright (c) 2015 Brent Dady. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *todoListTextField;
@property NSMutableArray *todoListItems;
@property NSMutableArray *todoListItemsColors;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.todoListItems = [NSMutableArray new];
    self.todoListItemsColors = [NSMutableArray new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todoListItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.todoListItems objectAtIndex:indexPath.row]];
    cell.textLabel.textColor = [self.todoListItemsColors objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.textLabel.textColor = [UIColor greenColor];
    [self.todoListItemsColors replaceObjectAtIndex:indexPath.row withObject:[UIColor greenColor]];
    [self.tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)onAddButtonPressed:(UIButton *)sender {
    [self.todoListItems addObject:self.todoListTextField.text];
    [self.todoListItemsColors addObject:[UIColor blackColor]];

    NSLog(@"%@", self.todoListItems);
    [self.tableView reloadData];
    self.todoListTextField.text = nil;
    [self.view endEditing:YES];
}

- (IBAction)onEditButtonPressed:(UIButton *)sender {
}
@end