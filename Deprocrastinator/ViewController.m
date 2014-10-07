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
@property NSIndexPath *lastIndexPath;
@property NSMutableArray *checkedIndexPaths;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property NSArray *colorsArray;
@property CGPoint originalCenter;
@property NSIndexPath *alertIndexPath;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.errandsArray = [NSMutableArray arrayWithObjects:@"Help old People",
                                                    @"Help people",
                                                    @"Help Don",
                                                    @"Help people",
                                                    @"Help Don",
                                                    @"Help people",
                                                    @"Help Don",
                                                    @"Help people",
                                                    @"Help Don",
                                                    @"Help people",
                                                    @"Help Don",
                                                    @"Help people",
                                                    @"Help Don",
                                                    @"Help people",
                                                    @"Help Don",
                                                    @"Help Humanity", nil];

    self.checkedIndexPaths = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.errandsArray.count; i++) {
        [self.checkedIndexPaths addObject:[NSNumber numberWithBool:NO]];
    }
    
    self.colorsArray = [NSMutableArray arrayWithObjects:[UIColor redColor], [UIColor yellowColor], [UIColor greenColor], nil];
    

    
}

- (IBAction)onAddButtonPressed:(id)sender {
    
    [self.errandsArray addObject:self.viewControllerTextField.text];
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
        
        //Check if index path is valid
        if(indexPath)
        {
            //Get the cell out of the table view
            UITableViewCell *cell = [self.tableViewErrands cellForRowAtIndexPath:indexPath];
            
            //Update the cell or model
            if (cell.tag == 0) {
                cell.backgroundColor = [UIColor greenColor];
                cell.tag++;
            } else if(cell.tag == 1){
                cell.backgroundColor = [UIColor yellowColor];
                cell.tag++;
            } else if(cell.tag == 2){
                cell.backgroundColor = [UIColor redColor];
                cell.tag++;
            } else if(cell.tag == 3){
                cell.backgroundColor = [UIColor whiteColor];
                cell.tag = 0;
            }
        }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.errandsArray.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deprocrastinatorCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.errandsArray objectAtIndex:indexPath.row];
    
    if ([indexPath compare:self.lastIndexPath] == NSOrderedSame)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.checkedIndexPaths replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];

    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.checkedIndexPaths replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
        
    }
    return cell;
    
}


-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{

    
    
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryNone){
        //This sets the array
        [self.checkedIndexPaths replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
        
    } else{
        //This sets the array
        [self.checkedIndexPaths replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
        
    }
    [self.tableViewErrands reloadData];
}



@end
