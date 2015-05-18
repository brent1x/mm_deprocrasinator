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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {


        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete?" message:@"" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"delete");
            [self.todoListItems removeObjectAtIndex:indexPath.row];
            [self.todoListItemsColors removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];

        UIAlertAction *noButton = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.tableView setEditing:NO animated:YES];
        }];

        [alertController addAction:yesButton];
        [alertController addAction:noButton];

        [self presentViewController:alertController animated:YES completion:nil];


    }

}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSString *stringToMove = self.todoListItems[sourceIndexPath.row];
    UIColor *colorToMove = self.todoListItemsColors[sourceIndexPath.row];
    [self.todoListItems removeObjectAtIndex:sourceIndexPath.row];
    [self.todoListItems insertObject:stringToMove atIndex:destinationIndexPath.row];
    [self.todoListItemsColors removeObjectAtIndex:sourceIndexPath.row];
    [self.todoListItemsColors insertObject:colorToMove atIndex:destinationIndexPath.row];

}
#pragma mark - Add Method

- (IBAction)onAddButtonPressed:(UIButton *)sender {
    [self.todoListItems addObject:self.todoListTextField.text];
    [self.todoListItemsColors addObject:[UIColor blackColor]];
    NSLog(@"%@", self.todoListItems);
    [self.tableView reloadData];
    self.todoListTextField.text = nil;
    [self.view endEditing:YES];
}

#pragma mark - Edit Method

- (IBAction)onEditButtonPressed:(UIButton *)sender {
    if ([[sender currentTitle] isEqualToString:@"Done"]) {
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        [self.tableView setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self.tableView setEditing:YES animated:YES];
    }
}
- (IBAction)onSwipeChangePriority:(UISwipeGestureRecognizer *)sender {
    //NSLog(@"swipes");
//    if (sender.state == UISwipeGestureRecognizerDirectionRight) {
//        NSLog(@"swipes");
//    }
    CGPoint swipelocation = [sender locationInView:self.tableView];
    NSIndexPath *swipeIndexPath = [self.tableView indexPathForRowAtPoint:swipelocation];
    //UITableViewCell *swipedCell = [self.tableView cellForRowAtIndexPath:swipeIndexPath];
    if ([self.todoListItemsColors objectAtIndex:swipeIndexPath.row] == [UIColor blackColor]) {
        [self.todoListItemsColors replaceObjectAtIndex:swipeIndexPath.row withObject:[UIColor redColor]];
    } else if ([self.todoListItemsColors objectAtIndex:swipeIndexPath.row] == [UIColor redColor]){
        [self.todoListItemsColors replaceObjectAtIndex:swipeIndexPath.row withObject:[UIColor yellowColor]];
    }else if ([self.todoListItemsColors objectAtIndex:swipeIndexPath.row] == [UIColor yellowColor]){
        [self.todoListItemsColors replaceObjectAtIndex:swipeIndexPath.row withObject:[UIColor greenColor]];
    }else if ([self.todoListItemsColors objectAtIndex:swipeIndexPath.row] == [UIColor greenColor]){
        [self.todoListItemsColors replaceObjectAtIndex:swipeIndexPath.row withObject:[UIColor blackColor]];
    }
    //[self.todoListItemsColors replaceObjectAtIndex:swipeIndexPath.row withObject:[UIColor redColor]];
    [self.tableView reloadData];
    //NSLog(@"%@", [self.todoListItems objectAtIndex:swipeIndexPath.row]);

}

@end