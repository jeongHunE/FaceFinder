//
//  CVWrapper.h
//  FaceFinder
//
//  Created by 이정훈 on 5/25/24.
//

#import <Foundation/Foundation.h>
#import "CVWrapper.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CVWrapper : NSObject

+ (UIImage *) convertToGrayScale: (UIImage *) image;
+ (UIImage *) drawRectangleTo: (UIImage *) image;

@end

NS_ASSUME_NONNULL_END
