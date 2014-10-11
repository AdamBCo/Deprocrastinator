//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Adam Cooper on 10/6/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *viewControllerTextField;
@property NSMutableArray *errandsArray;

@property (weak, nonatomic) IBOutlet UITableView *tableViewErrands;

@property NSMutableArray *checkedIndexPaths;
@property NSMutableArray *colorIndexPaths;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property CGPoint originalCenter;
@property NSIndexPath *alertIndexPath;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.errandsArray = [[NSMutableArray alloc] initWithObjects:@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello",@"Hello", nil];
    
    self.colorIndexPaths = [[NSMutableArray alloc] init];
    self.checkedIndexPaths = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.errandsArray.count; i++) {
        [self.checkedIndexPaths addObject:[NSNumber numberWithBool:NO]];
        [self.colorIndexPaths addObject:@"White"];
    }
    
}

- (IBAction)onAddButtonPressed:(id)sender {
    
    
    [self.checkedIndexPaths addObject:[NSNumber numberWithBool:NO]];
    self.viewControllerTextField.text = @"";
    [self.viewControllerTextField resignFirstResponder];
    [self.tableViewErrands reloadData];
    
}
- (IBAction)onEditButtonPressed:(UIButton *)sender {
    if (self.tableViewErrands.editing) {
        [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
        [self.tableViewErrands setEditing:NO animated:YES];
    } else {
        [self.editButton setTitle:@"Done" forState:UIControlStateNormal];
        [self.tableViewErrands setEditing:YES animated:YES];
    }
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.alertIndexPath = indexPath;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                        message:@"Are you sure?"
                                                       delegate:self
                                              cancelButtonTitle:@"NO"
                                              otherButtonTitles:@"YES", nil];
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self.errandsArray removeObjectAtIndex:self.alertIndexPath.row];
        [self.checkedIndexPaths removeObjectAtIndex: self.alertIndexPath.row];
        [self.tableViewErrands reloadData];
    }
}


- (IBAction)prioritySwipeRight:(UISwipeGestureRecognizer*)swipegesture{
    //Get location of the swipe
    CGPoint location = [swipegesture locationInView:self.tableViewErrands];
    
    //Get the corresponding index path within the table view
    NSIndexPath *indexPath = [self.tableViewErrands indexPathForRowAtPoint:location];
    
    NSInteger cool = [[self.colorIndexPaths objectAtIndex:indexPath.row]integerValue];
    cool++;
    
    
    
    if (indexPath) {
        //Update the cell or model
        UITableViewCell *cell = [self.tableViewErrands cellForRowAtIndexPath:indexPath];
        if (cell.tag == 0) {
            [self.colorIndexPaths replaceObjectAtIndex:indexPath.row withObject:@"Green"];
            cell.tag++;
        } else if(cell.tag == 1){
            [self.colorIndexPaths replaceObjectAtIndex:indexPath.row withObject:@"Yellow"];
            cell.tag++;
        } else if(cell.tag == 2){
            [self.colorIndexPaths replaceObjectAtIndex:indexPath.row withObject:@"Red"];
            cell.tag++;
            NSLog(@"%@", [self.colorIndexPaths objectAtIndex:indexPath.row]);
        } else if(cell.tag == 3){
            [self.colorIndexPaths replaceObjectAtIndex:indexPath.row withObject:@"White"];
            cell.tag = 0;
        }

    }
    
    [self.tableViewErrands reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.errandsArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [self.errandsArray objectAtIndex:indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    
    BOOL shouldBeChecked = [[self.checkedIndexPaths objectAtIndex:indexPath.row] boolValue];
    
    if (shouldBeChecked)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    if (self.colorIndexPaths){
        
        if ([[self.colorIndexPaths objectAtIndex:indexPath.row] isEqualToString:@"White"]) {
            cell.backgroundColor = [UIColor whiteColor];
        } else if ([[self.colorIndexPaths objectAtIndex:indexPath.row] isEqualToString:@"Green"]){
            cell.backgroundColor = [UIColor greenColor];
        } else if ([[self.colorIndexPaths objectAtIndex:indexPath.row] isEqualToString:@"Yellow"]){
            cell.backgroundColor = [UIColor yellowColor];
        } else if ([[self.colorIndexPaths objectAtIndex:indexPath.row] isEqualToString:@"Red"]){
            cell.backgroundColor = [UIColor redColor];
        }
    }


    
    return cell;
}

    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    BOOL currentValue = [[self.checkedIndexPaths objectAtIndex:indexPath.row] boolValue];
    BOOL updatedValue = !currentValue;
    
    self.checkedIndexPaths[indexPath.row] = [NSNumber numberWithBool:updatedValue];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];

}

    
@end
