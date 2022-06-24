//
//  Dish.m
//  eMeals
//
//  Created by Eduardo De La Cruz on 24/6/22.
//

#import "Dish.h"

@implementation Dish

static NSString * const titleCodingKey = @"title";
static NSString * const typeCodingKey = @"type";
static NSString * const imageUrlCodingKey = @"imageURL";
static NSString * const imageCodingKey = @"image";
static NSString * const ingredientsCodingKey = @"ingredients";
static NSString * const instructionsCodingKey = @"instructions";

- (instancetype) initWithDictionary:(NSDictionary *)dict {
    if (self) {
        NSDictionary * ingredientsDict = [[NSDictionary alloc] initWithDictionary:[dict objectForKey:@"ingredients"]];
        NSDictionary * instructionsDict = [[NSDictionary alloc] initWithDictionary:[dict objectForKey:@"instructions"]];
        NSMutableArray<NSString *> * tempArray = NSMutableArray.new;
        self.title = [dict objectForKey:@"title"];
        self.type = [dict objectForKey:@"plan_title_without_size"]; // Need to be added
        self.imageUrl = [dict objectForKey:@"primary_picture_url"];
        
        for (int i = 1; i <= ingredientsDict.count; i++) {
            [tempArray addObject:ingredientsDict[[@(i) stringValue]]];
        }
        self.ingredients = [tempArray copy];
        [tempArray removeAllObjects];
        
        for (int i = 1; i <= instructionsDict.count; i++) {
            [tempArray addObject:instructionsDict[[@(i) stringValue]]];
        }
        self.instructions = [tempArray copy];
        [tempArray removeAllObjects];
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:self.title forKey:titleCodingKey];
    [coder encodeObject:self.type forKey:typeCodingKey];
    [coder encodeObject:self.imageUrl forKey:imageUrlCodingKey];
    [coder encodeObject:self.image forKey:imageCodingKey];
    [coder encodeObject:self.ingredients forKey:ingredientsCodingKey];
    [coder encodeObject:self.instructions forKey:instructionsCodingKey];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    if (self != nil)
    {
        self.title = [coder decodeObjectForKey:titleCodingKey];
        self.type = [coder decodeObjectForKey:typeCodingKey];
        self.imageUrl = [coder decodeObjectForKey:imageUrlCodingKey];
        self.image = [coder decodeObjectForKey:imageCodingKey];
        self.ingredients = [coder decodeObjectForKey:ingredientsCodingKey];
        self.instructions = [coder decodeObjectForKey:instructionsCodingKey];
    }
    return self;
}

@end
