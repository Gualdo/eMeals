//
//  ImageStorageManager.m
//  eMeals
//
//  Created by Eduardo De La Cruz on 23/6/22.
//

#import "ImageStorageManager.h"

@implementation ImageStorageManager

static NSMutableDictionary *dict;

+ (ImageStorageManager *) defaultManager {
    static ImageStorageManager * defaultManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[ImageStorageManager alloc] init];
        dict = [[NSMutableDictionary alloc] init];
    });
    return defaultManager;
}

- (UIImage *) imageForKey:(NSString *) key {
    return [dict objectForKey:key];
}
- (void) setImage:(UIImage *) image forKey:(NSString *) key {
    [dict setObject:image forKey:key];
}

@end
