//
//  MealsCollectionViewController.m
//  eMeals
//
//  Created by Eduardo De La Cruz on 22/6/22.
//

#import "MealsCollectionViewController.h"
#import "MealCollectionCell.h"
#import "ImageStorageManager.h"
#import "Meal.h"

@interface MealsCollectionViewController ()

@property (strong, nonatomic) NSMutableArray<Meal *> * meals;
@property (strong, nonatomic) MealCollectionCell * mealCell;
@property (nonatomic) int serviceCounter;

@end

@implementation MealsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self recoverDataFromDefaults];
    if (self.meals.count == 0) {
        [self fetchMeals];
    }
}

- (void)setupView {
    self.meals = [[NSMutableArray alloc] init];
    self.serviceCounter = 0;
    self.navigationItem.title = @"Meals";
}

- (void)updateMeals: (Meal *) meal {
    [self.meals addObject:meal];
    self.serviceCounter += 1;
    if (self.serviceCounter == 2) {
        [self updateDefaults];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }
}

- (void)updateDefaults {
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:[self.meals copy]];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"mealsObject"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)recoverDataFromDefaults {
    NSData * mealsData = [[NSUserDefaults standardUserDefaults] objectForKey:@"mealsObject"];
    NSArray * mealsArray = [NSKeyedUnarchiver unarchiveObjectWithData:mealsData];
    
    if (mealsArray) {
        self.meals = [mealsArray mutableCopy];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)fetchMeals {
    NSURL * mealOne = [[NSURL alloc] initWithString:@"https://emeals-menubuilder-public.s3.amazonaws.com/v1/recipes/46168/46168_295947.json"];
    NSURL * mealTwo = [[NSURL alloc] initWithString:@"https://emeals-menubuilder-public.s3.amazonaws.com/v1/recipes/37767/37767_241270.json"];
    NSArray<NSURL *> * mealUrls = @[
        mealOne,
        mealTwo
    ];
    
    for (NSURL * mealUrl in mealUrls) {
        [[NSURLSession.sharedSession dataTaskWithURL:mealUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSError * err;
            NSDictionary * mealJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingFragmentsAllowed error:&err];
            
            if (err) {
                NSLog(@"failed to serialize into JSON: %@", err);
                return;
            }
            
            [self updateMeals:[[Meal alloc] initWithDictionary:mealJSON]];
            
        }] resume];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.meals.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MealCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    cell.layer.shadowRadius = 5.0;
    cell.layer.shadowOpacity = 0.75;
    cell.layer.masksToBounds = NO;
    
    cell.backgroundColor = [UIColor whiteColor];
    [cell.activityIndicator startAnimating];
    
    Meal * meal = self.meals[indexPath.row];
    
    cell.titleLabel.text = meal.main.title;
    cell.typeLabel.text = meal.main.type;
    
    if (meal.main.image) {
        cell.imageView.image = [UIImage imageWithData:meal.main.image];
        [cell.activityIndicator stopAnimating];
    } else {
        if (meal.main.imageUrl)
        {
            if ([[ImageStorageManager defaultManager] imageForKey:meal.main.imageUrl])
            {
                //This condition means the current cell's image has been already downloaded and stored. So set the image to imageview
                [[cell imageView] setImage:[[ImageStorageManager defaultManager] imageForKey:meal.main.imageUrl]];
                [cell.activityIndicator stopAnimating];
            }
            else
            {
                //While reusing this imageView will have previous image that will be visible till the image is downloaded. So i am setting this image as pleaceholder.
                [[cell imageView] setImage:[UIImage imageNamed:@"ImagePlaceholder"]];
                
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                dispatch_async(queue, ^{
                    
                    //Called Immediately.
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:meal.main.imageUrl]]];
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        
                        //Called when the image is downloaded
                        //Store in any external object. So that next time reuse this will not be downloaded
                        [[ImageStorageManager defaultManager] setImage:image forKey:meal.main.imageUrl];
                        //Also set the image to the cell
                        [[cell imageView] setImage:image];
                        NSData * imageData = UIImageJPEGRepresentation(image, 1.0);
                        self.meals[indexPath.row].main.image = imageData;
                        [self updateDefaults];
                        [cell.activityIndicator stopAnimating];
                        [cell setNeedsLayout];
                    });
                });
            }
        } else {
            [[cell imageView] setImage:[UIImage imageNamed:@"ImagePlaceholder"]];
        }
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 32.0;
}

@end
