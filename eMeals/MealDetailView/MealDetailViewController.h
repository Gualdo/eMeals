//
//  MealDetailViewController.h
//  eMeals
//
//  Created by Eduardo De La Cruz on 24/6/22.
//

#import <UIKit/UIKit.h>
#import "Meal.h"

NS_ASSUME_NONNULL_BEGIN

@interface MealDetailViewController : UIViewController

@property (strong, nonatomic) Meal * meal;
@property (strong, nonatomic) NSNumber * index;

@property (strong, nonatomic) IBOutlet UIImageView * imageView;
@property (strong, nonatomic) IBOutlet UILabel * titleLabel;
@property (strong, nonatomic) IBOutlet UIButton * editButton;
@property (strong, nonatomic) IBOutlet UIStackView * infoStackView;

@end

NS_ASSUME_NONNULL_END
