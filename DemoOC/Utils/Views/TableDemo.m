//
//  TableDemo.m
//  DemoOC
//
//  Created by Ares on 2021/7/20.
//

#import "TableDemo.h"

#import "TableCellDemo.h"

@interface TableDemo () <UITableViewDataSource, UITableViewDelegate>

{
    NSMutableArray *_list;
    UILabel *_labFPS;
}

@end

@implementation TableDemo

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 自定义的类需要注册
        [self registerClass:[TableCellDemo class] forCellReuseIdentifier:TableDemo_CellID];
        // 自定义的xib需要注册
//        [self registerNib:(nullable UINib *) forCellReuseIdentifier:(nonnull NSString *)]
        self.dataSource = self;
        self.delegate = self;
        self.estimatedRowHeight = 200;
        [self makeData];
    }
    return self;
}

// 开启编辑模式
- (void)openEdit {
    [self setEditing:!self.isEditing animated:YES];
}
// 多行操作
- (void)openMultipleEdit {
    self.allowsMultipleSelectionDuringEditing = YES;
}
- (void)doCommit {
    // 千万不要一边遍历，一边删除，因为元素在数组中的索引可能变化
    // 应该将元素放在数组中，一起删除
    NSMutableArray *arr = [NSMutableArray array];
    for (NSIndexPath *idx in self.indexPathsForSelectedRows) {
        [arr addObject:arr[idx.row]];
    }
    // 1 从数据源移除
    [_list removeObjectsInArray:arr];
    // 2 删除行
    [self deleteRowsAtIndexPaths:self.indexPathsForSelectedRows withRowAnimation:YES];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return @"德系";
//    }
//    return @"日系";
//}
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    if (section == 0) {
//        return @"费油";
//    }
//    return @"经济";
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell: %zd", indexPath.row);
    // dequeueReusableCellWithIdentifier 查找顺序
    // 缓存池 -> 注册 -> SB
    TableCellDemo *cell = [self dequeueReusableCellWithIdentifier:TableDemo_CellID];
    TableCellModelDemo *model = _list[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark UITableViewDelegate
// 此方法会频繁调用
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"height: %zd", indexPath.row);
    TableCellModelDemo *model = _list[indexPath.row];
    CGFloat h = [model cellHeight];
    return h;
}

#pragma mark Delete
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 删除数据源
    [_list removeObjectAtIndex:indexPath.row];
    // 删除行
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

// 左滑 多个按钮
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"收藏");
    }];
    return @[action];
}



#pragma mark 索引
// 索引
// sectionIndexColor
//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return @[@"德系", @"日系"];
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


static NSString *TableDemo_CellID = @"TableDemo_CellID";
static NSString *TableDemo_String_name = @"白龙白白龙百白宫丽宫白领";
static NSString *TableDemo_String_message = @"白龙白白龙白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领白龙白白龙百丽宫白领百丽宫白领";

- (NSInteger)random:(NSInteger)n add:(NSInteger)add {
    NSInteger x = arc4random() % n + add;
    return x;
}
- (NSString *)substr:(NSString *)str to:(NSInteger)to {
    return [str substringToIndex:to];
}
- (NSString *)name_r {
    NSInteger idx = [self random:6 add:2];
    return [self substr:TableDemo_String_name to:idx];
}
- (NSString *)message_r {
    NSInteger idx = [self random:200 add:5];
    return [self substr:TableDemo_String_message to:idx];
}
- (Boolean)picture_r {
    NSInteger num = [self random:2 add:0];
    return num % 2 == 0;
}
- (void)makeData {
    if (_list.count == 0) {
        NSMutableArray *ls = [[NSMutableArray alloc] init];
        for (NSInteger i=0; i<200; i++) {
            TableCellModelDemo *model = [[TableCellModelDemo alloc] init];
            model.avatarIcon = @"ava";
            model.name = [self name_r];
            model.isVip = i%2==0 ? YES : NO;
            model.vipIcon = @"vip";
            model.message = [self message_r];
            model.picture = [self picture_r] ? @"picture" : @"";
            [ls addObject:model];
        }
        _list = ls;
    }
}

- (void)displayLinkAction:(CADisplayLink *)link {
    static NSTimeInterval lastTime = 0;
    static int frameCount = 0;
    if (lastTime == 0) {
        lastTime = link.timestamp;
        return;
    }
    frameCount++; // 累计帧数
    NSTimeInterval passTime = link.timestamp - lastTime;// 累计时间
    if (passTime > 1) { // 1秒左右获取一次帧数
        int fps = round(frameCount / passTime); // 帧数 = 总帧数 / 时间
        lastTime = link.timestamp; // 重置
        frameCount = 0; // 重置
        _labFPS.text = [NSString stringWithFormat:@"%d/60 fps", fps];
//        NSLog(@"%d/60 fps", fps);
    }
}

- (void)addFPSLabel {
    [[CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction:)] addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CGRect frame = CGRectMake((size.width-100)/2.f, size.height-50, 100, 30);
    
    _labFPS = [[UILabel alloc] initWithFrame:frame];
    _labFPS.backgroundColor = [UIColor blueColor];
    _labFPS.textColor = [UIColor whiteColor];
    _labFPS.textAlignment = NSTextAlignmentCenter;
    _labFPS.layer.cornerRadius = 5;
    _labFPS.layer.masksToBounds = YES;

    [self.superview addSubview:_labFPS];
    [_labFPS bringSubviewToFront:self.superview];
}

@end
