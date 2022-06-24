//
//  Meal.h
//  eMeals
//
//  Created by Eduardo De La Cruz on 23/6/22.
//

#import <Foundation/Foundation.h>
#import "Dish.h"

NS_ASSUME_NONNULL_BEGIN

@interface Meal : NSObject <NSCoding>

@property (strong, nonatomic) Dish * main;
@property (strong, nonatomic) Dish * side;

- (instancetype) initWithDictionary: (NSDictionary *)dict;
- (void) encodeWithCoder : (NSCoder *)encode ;
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder;

@end

NS_ASSUME_NONNULL_END
