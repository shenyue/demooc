//
//  BLStickJelly.m
//  DemoOC
//
//  Created by bailong on 2021/8/9.
//

#import "BLStickJelly.h"

#import "BLStickJellyButton.h"

@interface BLStickJelly ()

@end

@implementation BLStickJelly

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUp];
}
- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setUp {
    BLStickJellyButton *btn = [[BLStickJellyButton alloc] initWithFrame:CGRectMake(100, 100, 40, 40)];
    [self addSubview:btn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
