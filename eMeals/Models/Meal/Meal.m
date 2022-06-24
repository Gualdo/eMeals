//
//  Meal.m
//  eMeals
//
//  Created by Eduardo De La Cruz on 23/6/22.
//

#import "Meal.h"

@implementation Meal

static NSString * const mainCodingkey = @"main";
static NSString * const sideCodingKey = @"side";

- (instancetype) initWithDictionary:(NSDictionary *)dict {
    if (self) {
        NSMutableDictionary * mainTemp = [[NSMutableDictionary alloc] initWithDictionary:dict[@"main"]];
        [mainTemp setValue:dict[@"plan_title_without_size"] forKey:@"plan_title_without_size"];
        self.main = [[Dish alloc] initWithDictionary:[mainTemp copy]];
        
        NSMutableDictionary * sideTemp = [[NSMutableDictionary alloc] initWithDictionary:dict[@"side"]];
        [sideTemp setValue:dict[@"plan_title_without_size"] forKey:@"plan_title_without_size"];
        self.side = [[Dish alloc] initWithDictionary:[sideTemp copy]];
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.main forKey:mainCodingkey];
    [coder encodeObject:self.side forKey:sideCodingKey];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    if (self != nil)
    {
        self.main = [coder decodeObjectForKey:mainCodingkey];
        self.side = [coder decodeObjectForKey:sideCodingKey];
    }
    return self;
}

@end
