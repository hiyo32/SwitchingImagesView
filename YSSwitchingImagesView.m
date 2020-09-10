//
//  YSSwitchingImagesView.m
//  ZWYProject
//
//  Created by hiyo on 2019/12/30.
//  Copyright © 2019 yesoul. All rights reserved.
//

#import "YSSwitchingImagesView.h"

@interface YSSwitchingImagesView ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger loadIndex;

@property (nonatomic, strong) UIImageView *imgViewCurrent;
@property (nonatomic, strong) UIImageView *imgViewNext;

@end

@implementation YSSwitchingImagesView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.currentIndex = 0;
        
        [self initSubViews];
    }
    return self;
}

- (id)initWithImageUrlArr:(NSArray *)imgUrlArr {
    self = [super init];
    if (self) {
        if (imgUrlArr) {
            self.imgUrlArr = [NSArray arrayWithArray:imgUrlArr];
        }
        self.currentIndex = 0;
        self.loadIndex = 0;
        
        [self initSubViews];
    }
    return self;
}

- (void)setImgUrlArr:(NSArray *)imgUrlArr {
    if (imgUrlArr) {
        _imgUrlArr = [NSArray arrayWithArray:imgUrlArr];
        [self loadInitImages];
    }
}

- (void)dealloc {
    [self stopTimer];
}

- (void)startAnimate {
    [self startTimer];
}

- (void)stopAnimate {
    [self stopTimer];
}

- (void)layoutSubviews {
    self.imgViewCurrent.frame = self.bounds;
    self.imgViewNext.frame = self.bounds;
    self.imgViewNext.centerY = 1.5 * self.bounds.size.height;
}

#pragma mark - NSTimer
- (void)startTimer {
    if (self.imgUrlArr.count < 2) {
        return;
    }
    
    self.currentIndex = 0;
    self.loadIndex = 0;
    
    if (_timer) {
        [self stopTimer];
    }
    
    WEAKSELF;
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 block:^(NSTimer *timer) {
        [weakSelf showNext];
    } repeats:YES];
    [_timer fire];
}

- (void)stopTimer {
    if (_timer) {
        [_timer invalidate];
    }
    self.timer = nil;
}

#pragma mark - private
- (void)initSubViews {
    [self addSubview:self.imgViewNext];
    [self addSubview:self.imgViewCurrent];
    
    [self loadInitImages];
}

- (void)loadInitImages {
    if (self.imgUrlArr.count > 1) {
        [_imgViewNext sd_setImageWithURL:[NSURL URLWithString:legitString([self.imgUrlArr objectAtIndex:1])]];
    }
    if (self.imgUrlArr.count > 0) {
        [_imgViewCurrent sd_setImageWithURL:[NSURL URLWithString:legitString([self.imgUrlArr objectAtIndex:0])]];
    }
}

- (void)showNext {
    
    NSInteger nextIndex = self.currentIndex + 1;
    if (nextIndex >= self.imgUrlArr.count) {
        nextIndex = 0;
    }
    
    CGFloat height = self.bounds.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        self.imgViewCurrent.centerY -= height;
        self.imgViewNext.centerY -= height;
    } completion:^(BOOL finished) {
        if (self.imgViewCurrent.centerY < 0) {
            self.imgViewCurrent.centerY = 1.5 * height;
        }
        if (self.imgViewNext.centerY < 0) {
            self.imgViewNext.centerY = 1.5 * height;
        }
        
        NSInteger nextLoadIndex = self.currentIndex + 2;
        if (nextLoadIndex >= self.imgUrlArr.count) {
            nextLoadIndex = nextLoadIndex - self.imgUrlArr.count;
        }
        if (self.loadIndex % 2 == 0) {
            [self.imgViewCurrent sd_setImageWithURL:[NSURL URLWithString:legitString([self.imgUrlArr objectAtIndex:nextLoadIndex])]];
        }
        else {
            [self.imgViewNext sd_setImageWithURL:[NSURL URLWithString:legitString([self.imgUrlArr objectAtIndex:nextLoadIndex])]];
        }
        
        self.currentIndex = nextIndex;
        self.loadIndex++;
    }];
}

#pragma mark - lazy
- (UIImageView *)imgViewCurrent {
    if (_imgViewCurrent == nil) {
        _imgViewCurrent = [UIImageView new];
    }
    return _imgViewCurrent;
}

- (UIImageView *)imgViewNext {
    if (_imgViewNext == nil) {
        _imgViewNext = [UIImageView new];
    }
    return _imgViewNext;
}

@end
