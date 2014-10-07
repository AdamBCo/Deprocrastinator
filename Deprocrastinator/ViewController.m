//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Adam Cooper on 10/6/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *viewControllerTextField;
@property NSMutableArray *errandsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableViewErrands;
@property NSIndexPath *lastIndexPath;
@property NSMutableArray *checkedIndexPaths;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property NSArray *colorsArray;
@property CGPoint originalCenter;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.errandsArray = [NSMutableArray arrayWithObjects:@"Help old People",
                                                    @"Help people",
                                                    @"Help Don",
                                                    @"Help Humanity", nil];
    
    self.checkedIndexPaths = [NSMutableArray arrayWithCapacity:self.errandsArray.count];
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
    [self.editButton setTitle:@"Done" forState:UIControlStateNormal];
    if ([self.editButton.titleLabel.text containsString:@"Done"]) {
        [self.editButton setTitle:@"Edit" forState:UIControlStateNormal];
    }
    
}





-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.errandsArray removeObjectAtIndex:indexPath.row];
    
    [tableView reloadData];
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
            
            self.colorsArray = [NSArray arrayWithObjects:[UIColor greenColor], [UIColor yellowColor], [UIColor redColor],nil];
            if (cell.tag == 0) {
                cell.backgroundColor = [self.colorsArray objectAtIndex:0];
                cell.tag++;
            } else if(cell.tag == 1){
                cell.backgroundColor = [self.colorsArray objectAtIndex:1];
                cell.tag++;
            } else if(cell.tag == 2){
                cell.backgroundColor = [self.colorsArray objectAtIndex:2];
                cell.tag++;
            } else if(cell.tag == 3){
                cell.backgroundColor = [UIColor whiteColor];
                cell.tag = 0;
            }
        }
    NSLog(@"Hello");
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
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    
    if (cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        //This sets the array
        [self.checkedIndexPaths replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
        
    } else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        //This sets the array
        [self.checkedIndexPaths replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
        
    }
}

@end
