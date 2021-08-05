//
//  BLVDemo.m
//  DemoOC
//
//  Created by bailong on 2021/7/8.
//

#import "BLVDemo.h"
#import "BLMCity.h"

@interface BLVDemo ()

@property (nonatomic, weak) IBOutlet UIImageView *ivIcon;
@property (nonatomic, weak) IBOutlet UILabel *lTitle;

@end

@implementation BLVDemo

// 一个view从 xib 或者 sb 创建，初始化就一定会调用此方法
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        NSLog(@"initWithCoder ivIcon - %@", self.ivIcon);
    }
    return self;
}

// 一个从 xib 或者 sb 创建的view加载完毕，就一定会调用此方法
// 所以，请在此方法中处理 UI 设置，因为 initWithCoder 可能会有子视图尚未创建完
- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"awakeFromNib ivIcon - %@", self.ivIcon);
}

+ (instancetype)viewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

// BLVDemo *view = [[BLVDemo alloc] init];
// BLVDemo *view = [BLVDemo new];
// 以上都会调用 initWithFrame 方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *icon = [[UIImageView alloc] init];
        icon.backgroundColor = [UIColor yellowColor];
        [self addSubview:icon];
        self.ivIcon = icon;
        
        UILabel *title = [[UILabel alloc] init];
        title.backgroundColor = [UIColor redColor];
        [self addSubview:title];
        self.lTitle = title;
        
        NSLog(@"--------- BLVDemo initWithFrame ---------");
    }
    return self;
}

#pragma mark - initWithData

- (instancetype) initWithData:(BLMCity *)data {
    if (self = [super init]) {
        self.data = data;
    }
    return self;
}
+ (instancetype) vdemoWithData:(BLMCity *)data {
    BLVDemo *view = [[self alloc] initWithData:data];
    return view;
}

// 重写父类方法
// apple 提供的 布局子视图的方法
// 当前控件的尺寸发生变化时一定会调用此方法
// 此控件第一次显示的时候一定会调用此方法
- (void)layoutSubviews {
    // 重写父类方法 所以 [super layoutSubviews]; 必须调用
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    self.ivIcon.frame = CGRectMake(0, 0, w, w);
    self.lTitle.frame = CGRectMake(0, w, w, h - w);
}

- (void)setData:(BLMCity *)data {
    _data = data;
    self.lTitle.text = data.city;
}

@end
