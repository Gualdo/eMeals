//
//  ImageStorageManager.h
//  eMeals
//
//  Created by Eduardo De La Cruz on 23/6/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageStorageManager : NSObject

+ (nonnull ImageStorageManager *) defaultManager;
- (nullable UIImage *) imageForKey:(nonnull NSString *) key;
- (void) setImage:(nonnull UIImage *) image forKey:(nonnull NSString *) key;

@end
