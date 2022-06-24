//
//  MealDetailViewController.m
//  eMeals
//
//  Created by Eduardo De La Cruz on 24/6/22.
//

#import "MealDetailViewController.h"

@interface MealDetailViewController ()

@end

@implementation MealDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    self.navigationItem.title = @"Meal Detail";
    [self.editButton setTitle:@"" forState:normal];
    [self.titleLabel setText:[NSString stringWithFormat:@"%1$@ %2$@ %3$@", @" ", self.meal.main.title, @" "]];
    self.editButton.layer.cornerRadius = 25;
    self.editButton.clipsToBounds = YES;
    [self.imageView setImage:[UIImage imageWithData:self.meal.main.image]];
    // Main Dish
    [self setupStackViewLabel:@"Main dish" isTitle:YES isSubtitle:NO];
    [self setupStackViewLabel:@" " isTitle:NO isSubtitle:NO];
    [self setupStackViewLabel:@"Ingredients" isTitle:NO isSubtitle:YES];
    for (NSString * ingredient in self.meal.main.ingredients) {
        [self setupStackViewLabel:ingredient isTitle:NO isSubtitle:NO];
    }
    [self setupStackViewLabel:@" " isTitle:NO isSubtitle:NO];
    [self setupStackViewLabel:@"Instructions" isTitle:NO isSubtitle:YES];
    for (NSString * instructions in self.meal.main.instructions) {
        [self setupStackViewLabel:instructions isTitle:NO isSubtitle:NO];
    }
    [self setupStackViewLabel:@" " isTitle:NO isSubtitle:NO];
    // Side Dish
    [self setupStackViewLabel:@"Side dish" isTitle:YES isSubtitle:NO];
    [self setupStackViewLabel:@" " isTitle:NO isSubtitle:NO];
    [self setupStackViewLabel:@"Ingredients" isTitle:NO isSubtitle:YES];
    for (NSString * ingredient in self.meal.side.ingredients) {
        [self setupStackViewLabel:ingredient isTitle:NO isSubtitle:NO];
    }
    [self setupStackViewLabel:@" " isTitle:NO isSubtitle:YES];
    [self setupStackViewLabel:@"Instructions" isTitle:NO isSubtitle:YES];
    for (NSString * instructions in self.meal.side.instructions) {
        [self setupStackViewLabel:instructions isTitle:NO isSubtitle:NO];
    }
    UIView * spacer = [[UIView alloc] init];
    [spacer setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    [self.infoStackView addArrangedSubview:spacer];
}

- (void)setupStackViewLabel:(NSString *)text isTitle:(BOOL) isTitle isSubtitle:(BOOL) isSubtitle {
    UILabel * label = [[UILabel alloc] init];
    [self.infoStackView addArrangedSubview:label];
    [label setText:text];
    if (isTitle) {
        [label setFont:[UIFont systemFontOfSize:17.0 weight:UIFontWeightBold]];
    } else if (isSubtitle) {
        [label setFont:[UIFont systemFontOfSize:15.0 weight:UIFontWeightSemibold]];
    } else {
        [label setFont:[UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular]];
    }
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
