//
//  Meal.h
//  eMeals
//
//  Created by Eduardo De La Cruz on 23/6/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Meal : NSObject <NSCoding>

@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * type;
@property (strong, nonatomic) NSString * imageUrl;
@property (strong, nonatomic) NSArray<NSString *> * instructions;
@property (strong, nonatomic) NSArray<NSString *> * ingredients;
@property (strong, nonatomic) NSData * image;

- (instancetype) initWithDictionary: (NSDictionary *)dict;
- (void) encodeWithCoder : (NSCoder *)encode ;
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder;

@end

NS_ASSUME_NONNULL_END
