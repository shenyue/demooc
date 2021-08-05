//
//  TableCellDemo.m
//  DemoOC
//
//  Created by bailong on 2021/7/22.
//

#import "TableCellDemo.h"

@interface TableCellViewModelDemo ()

{
    CGFloat _space;
    CGFloat _avatarWH;
    CGFloat _nameSizeHeight;
    CGFloat _vipIconW;
    CGFloat _messageSizeMaxWidth;
    CGFloat _pictureWH;
    
    CGFloat _cellHeight;
    
    UIFont *_nameFont;
    UIFont *_messageFont;
}

@end

@implementation TableCellViewModelDemo

@synthesize nameFont = _nameFont;
@synthesize messageFont = _messageFont;

- (instancetype)init {
    if (self = [super init]) {
        _space = 20.f;
        _avatarWH = 48.f;
        _nameSizeHeight = 20.f;
        _vipIconW = 20.f;
        _pictureWH = 100.f;
        _messageSizeMaxWidth = MC_TableCellViewModelDemo_ScreenSize.width - _space * 2.f;
        _cellHeight = 0.f;
        
        _nameFont = MC_TableCellViewModelDemo_nameFont;
        _messageFont = MC_TableCellViewModelDemo_messageFont;
    }
    return self;
}

- (CGFloat)cellHeight:(TableCellModelDemo *)model {
    if (_cellHeight == 0.f) {
        CGFloat af_X = _space;
        CGFloat af_Y = _space;
        CGFloat af_W = _avatarWH;
        CGFloat af_H = _avatarWH;
        self.avatarFrame = CGRectMake(af_X, af_Y, af_W, af_H);
        
        CGFloat nf_X = CGRectGetMaxX(self.avatarFrame) + _space;
        CGFloat nf_Y = _space;
        CGSize tmpNameSize = [model.name sizeWithAttributes:@{NSFontAttributeName:_nameFont}];
        CGFloat nf_W = tmpNameSize.width;
        CGFloat nf_H = _nameSizeHeight;
        self.nameFrame = CGRectMake(nf_X, nf_Y, nf_W, nf_H);
        
        CGFloat vif_X = CGRectGetMaxX(self.nameFrame) + _space;
        CGFloat vif_Y = _space;
        CGFloat vif_W = _vipIconW;
        CGFloat vif_H = _nameSizeHeight;
        self.vipIconFrame = CGRectMake(vif_X, vif_Y, vif_W, vif_H);
        
        CGFloat mf_X = _space;
        CGFloat mf_Y = CGRectGetMaxY(self.avatarFrame) + _space;
        CGSize messageMaxSize = CGSizeMake(_messageSizeMaxWidth, MAXFLOAT);
        CGRect tmpMessageRect = [model.message boundingRectWithSize:messageMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_messageFont} context:nil];
        CGFloat mf_W = _messageSizeMaxWidth;
        CGFloat mf_H = tmpMessageRect.size.height;
        self.messageFrame = CGRectMake(mf_X, mf_Y, mf_W, mf_H);
        
        if (![@"" isEqual: model.picture]) {
            CGFloat pf_X = _space;
            CGFloat pf_Y = CGRectGetMaxY(self.messageFrame) + _space;
            CGFloat pf_W = _pictureWH;
            CGFloat pf_H = _pictureWH;
            self.pictureFrame = CGRectMake(pf_X, pf_Y, pf_W, pf_H);
            
            _cellHeight = CGRectGetMaxY(self.pictureFrame) + _space;
        } else {
            _cellHeight = CGRectGetMaxY(self.messageFrame) + _space;
        }
    }
    return _cellHeight;
}

- (NSString *)description {
    NSMutableString *desc = [NSMutableString string];
    [desc appendFormat:@"=================== TableCellViewModelDemo start ===================\r\n"];
    [desc appendFormat:@"avatarFrame: [%@]\r\n", NSStringFromCGRect(self.avatarFrame)];
    [desc appendFormat:@"nameFrame: [%@]\r\n", NSStringFromCGRect(self.nameFrame)];
    [desc appendFormat:@"vipIconFrame: [%@]\r\n", NSStringFromCGRect(self.vipIconFrame)];
    [desc appendFormat:@"messageFrame: [%@]\r\n", NSStringFromCGRect(self.messageFrame)];
    [desc appendFormat:@"pictureFrame: [%@]\r\n", NSStringFromCGRect(self.pictureFrame)];
    [desc appendFormat:@"_cellHeight: [%.2f]\r\n", _cellHeight];
    [desc appendFormat:@"=================== TableCellModelDemo end ===================\r\n"];
    
    NSLog(@"%@", desc);
    
    return desc;
}


@end
















@interface TableCellModelDemo ()

{
    CGFloat _cellHeight;
    TableCellViewModelDemo *_viewModel;
}

@end

@implementation TableCellModelDemo

- (CGFloat)cellHeight {
    if (_cellHeight == 0.f) {
        _viewModel = [self viewModel];
        _cellHeight = [_viewModel cellHeight:self];
//        [_viewModel description];
    }
    return _cellHeight;
}
- (TableCellViewModelDemo *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TableCellViewModelDemo alloc] init];
    }
    return _viewModel;
}
- (NSString *)description {
    NSMutableString *desc = [NSMutableString string];
    [desc appendFormat:@"=================== TableCellModelDemo start ===================\r\n"];
    [desc appendFormat:@"avatarIcon: [%@]\r\n", self.avatarIcon];
    [desc appendFormat:@"name: [%@]\r\n", self.name];
    [desc appendFormat:@"avatarIcon: [%@]\r\n", self.isVip?@"true":@"false"];
    [desc appendFormat:@"avatarIcon: [%@]\r\n", self.vipIcon];
    [desc appendFormat:@"avatarIcon: [%@]\r\n", self.message];
    [desc appendFormat:@"avatarIcon: [%@]\r\n", self.picture];
    [desc appendFormat:@"=================== TableCellModelDemo end ===================\r\n"];
    
    NSLog(@"%@", desc);
    
    return desc;
}

@end

















@interface TableCellDemo ()

{
    TableCellModelDemo *_model;
    TableCellViewModelDemo *_viewModel;
}

//@property(nonatomic, weak) IBOutlet UIImageView *imgAvatar;
//@property(nonatomic, weak) IBOutlet UILabel *labName;
//@property(nonatomic, weak) IBOutlet UIImageView *imgVipIcon;
//@property(nonatomic, weak) IBOutlet UILabel *labMessage;
//@property(nonatomic, weak) IBOutlet UIImageView *imgPicture;

@property(nonatomic, strong) UIImageView *imgAvatar;
@property(nonatomic, strong) UILabel *labName;
@property(nonatomic, strong) UIImageView *imgVipIcon;
@property(nonatomic, strong) UILabel *labMessage;
@property(nonatomic, strong) UIImageView *imgPicture;

@end

@implementation TableCellDemo

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.imgAvatar = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imgAvatar];
        
        self.labName = [[UILabel alloc] init];
        self.labName.textColor = [UIColor blackColor];
//        self.labName.backgroundColor = [UIColor yellowColor]; //
        [self.contentView addSubview:self.labName];
        
        self.imgVipIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imgVipIcon];
        
        self.labMessage = [[UILabel alloc] init];
        self.labMessage.textColor = [UIColor grayColor];
        self.labMessage.numberOfLines = 0;
//        self.labMessage.backgroundColor = [UIColor redColor]; //
        [self.contentView addSubview:self.labMessage];
        
        self.imgPicture = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imgPicture];
        
        NSLog(@"TableCellDemo  initWithStyle");
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

// 此方法会频繁调用
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"TableCellDemo  layoutSubviews");
    
    TableCellViewModelDemo *viewModel = [_model viewModel];
    self.imgAvatar.frame = viewModel.avatarFrame;
    self.labName.frame = viewModel.nameFrame;
    self.imgVipIcon.frame = viewModel.vipIconFrame;
    self.labMessage.frame = viewModel.messageFrame;
    self.imgPicture.frame = viewModel.pictureFrame;
}

- (void)setModel:(TableCellModelDemo *)model {
    _model = model;
    [_model cellHeight];
    TableCellViewModelDemo *viewModel = [_model viewModel];
    
    if (![@"" isEqualToString:_model.avatarIcon]) {
        UIImage *imgAvatar = [UIImage imageNamed:_model.avatarIcon];
        self.imgAvatar.image = imgAvatar;
    }
    
    self.labName.text = _model.name;
    self.labName.font = viewModel.nameFont;
    
    if (_model.isVip) {
        if (![@"" isEqualToString:_model.vipIcon]) {
            UIImage *imgVip = [UIImage imageNamed:_model.vipIcon];
            self.imgVipIcon.image = imgVip;
            self.imgVipIcon.contentMode = UIViewContentModeScaleToFill;
            self.imgVipIcon.hidden = NO;
        }
    } else {
        self.imgVipIcon.hidden = YES;
    }
    
    self.labMessage.text = _model.message;
    self.labMessage.font = viewModel.messageFont;
    
    if (![@"" isEqualToString:_model.picture]) {
        UIImage *imgPic = [UIImage imageNamed:_model.picture];
        self.imgPicture.image = imgPic;
        self.imgPicture.hidden = NO;
    } else {
        self.imgPicture.hidden = YES;
    }
}

@end
