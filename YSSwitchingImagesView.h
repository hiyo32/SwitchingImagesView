//
//  YSSwitchingImagesView.h
//  ZWYProject
//
//  Created by hiyo on 2019/12/30.
//  Copyright © 2019 yesoul. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YSSwitchingImagesView : UIView

@property (nonatomic, strong) NSArray *imgUrlArr;

- (id)initWithImageUrlArr:(NSArray *)imgUrlArr;

- (void)startAnimate;
- (void)stopAnimate;

@end

NS_ASSUME_NONNULL_END
