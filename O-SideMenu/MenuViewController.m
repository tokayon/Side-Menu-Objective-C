//
//  MenuViewController.m
//  O-SideMenu
//
//  Created by SergeSinkevych on 20.04.16.
//  Copyright © 2016 Sergii Sinkevych. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate> {
    NSArray *menuItems;
    UIColor *notSelectedBackgroundColor;
    UIColor *selectedBackgroundColor;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuItems = @[@"First", @"Second", @"Third"];
    notSelectedBackgroundColor = [UIColor colorWithRed:26/255.f green:110/255.f blue:109/255.f alpha:1.0];
    selectedBackgroundColor = [UIColor colorWithRed:17/255.f green:72/255.f blue:71/255.f alpha:1.0];
    self.tableView.backgroundColor = notSelectedBackgroundColor;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:false scrollPosition:UITableViewScrollPositionTop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuButtonPressed:(UIBarButtonItem *)sender {
    if(self.containerView.frame.origin.x == 0) //only show the menu if it is not already shown
        [self showMenu];
    else
        [self hideMenu];

}

- (void)showMenu {
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.navigationBar.frame = CGRectMake(self.tableView.frame.size.width*0.8, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
        
        [self.containerView setFrame:CGRectMake(self.tableView.frame.size.width*0.8, self.containerView.frame.origin.y, self.containerView.frame.size.width, self.containerView.frame.size.height)];
    }];
}

- (void)hideMenu {
    [UIView animateWithDuration:.5 animations:^{
        self.navigationController.navigationBar.frame = CGRectMake(0, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
        
        [self.containerView setFrame:CGRectMake(0, self.containerView.frame.origin.y, self.containerView.frame.size.width, self.containerView.frame.size.height)];
    }];
}

//MARK: UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return menuItems.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    CALayer *separator = [CALayer layer];
    separator.backgroundColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.25].CGColor;
    separator.frame = CGRectMake(0, cell.frame.size.height - 1, cell.frame.size.width, .5);
    [cell.layer addSublayer:separator];
    cell.textLabel.text = menuItems[indexPath.row];
    
    return cell;
}

//MARK: UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:selectedBackgroundColor];
    
    UIViewController *previousVC = [self.childViewControllers lastObject];
    [previousVC removeFromParentViewController];
    [previousVC.view removeFromSuperview];
    UIViewController *nextVC;
    switch (indexPath.row) {
        case 0:
            nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"firstVC"];
            break;
        case 1:
            nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"secondVC"];
            break;
        case 2:
            nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"thirdVC"];
        default:
            break;
    }
    [self addChildViewController:nextVC];
    [self.containerView addSubview:nextVC.view];
    [self hideMenu];
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *currentSelectedIndexPath = [tableView indexPathForSelectedRow];
    if (currentSelectedIndexPath != nil) {
        [[tableView cellForRowAtIndexPath:currentSelectedIndexPath] setBackgroundColor:notSelectedBackgroundColor];
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (cell.isSelected == YES) {
        [cell setBackgroundColor:selectedBackgroundColor];
    } else {
        [cell setBackgroundColor:notSelectedBackgroundColor];
    }
}



@end
