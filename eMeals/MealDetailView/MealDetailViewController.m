//
//  MealDetailViewController.m
//  eMeals
//
//  Created by Eduardo De La Cruz on 24/6/22.
//

#import "MealDetailViewController.h"

@interface MealDetailViewController ()

@property (strong, nonatomic) Meal * meal;
@property (strong, nonatomic) NSMutableArray<NSString *> * totalLines;

@end

@implementation MealDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.navigationItem.title = @"Meal details";
    self.meal = [self.meals objectAtIndex:self.index.intValue];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.imageView setImage:[UIImage imageWithData:self.meal.main.image]];
    [self.titleLabel setText:self.meal.main.title];
    [self.editButton setTitle:@"" forState:UIControlStateNormal];
    self.editButton.layer.cornerRadius = self.editButton.frame.size.height / 4; // this value vary as per your desire
    self.editButton.clipsToBounds = YES;
    
    self.totalLines = [[NSMutableArray<NSString *> alloc] init];
    [self.totalLines addObject:@"Main dish"];
    [self.totalLines addObject:@"Ingredients"];
    [self.totalLines addObjectsFromArray:self.meal.main.ingredients];
    [self.totalLines addObject:@"Instructions"];
    [self.totalLines addObjectsFromArray:self.meal.main.instructions];
    [self.totalLines addObject:@"Side dish"];
    [self.totalLines addObject:@"Ingredients"];
    [self.totalLines addObjectsFromArray:self.meal.side.ingredients];
    [self.totalLines addObject:@"Instructions"];
    [self.totalLines addObjectsFromArray:self.meal.side.instructions];
}

- (IBAction)editButtonTapped:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Meal title edit" message: @"Input the new title" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Meal title";
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.borderStyle = UITextBorderStyleRoundedRect;
        }];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSArray * textfields = alertController.textFields;
            UITextField * titleTextfield = textfields[0];
            if (![titleTextfield.text isEqual:@""]) {
                [self updateMealTitle:titleTextfield.text];
            }
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
}

- (void)updateMealTitle:(NSString *) newTitle {
    self.meal.main.title = newTitle;
    [self.titleLabel setText:self.meal.main.title];
    [self updateDefaults];
}

- (void)updateDefaults {
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:[self.meals copy]];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"mealsObject"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.totalLines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if ([self.totalLines[indexPath.row]isEqual: @"Main dish"] || [self.totalLines[indexPath.row]isEqual: @"Side dish"]) {
        [cell.textLabel setFont:[UIFont systemFontOfSize:17.0 weight:UIFontWeightBold]];
    } else if ([self.totalLines[indexPath.row]isEqual: @"Ingredients"] || [self.totalLines[indexPath.row]isEqual: @"Instructions"]) {
        [cell.textLabel setFont:[UIFont systemFontOfSize:15.0 weight:UIFontWeightSemibold]];
    } else {
        [cell.textLabel setFont:[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular]];
    }
    
    [cell.textLabel setNumberOfLines:0];
    cell.textLabel.text =self.totalLines[indexPath.row];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
