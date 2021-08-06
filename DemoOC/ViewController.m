//
//  ViewController.m
//  DemoOC
//
//  Created by bailong on 2021/7/7.
//

#import "ViewController.h"

#import "Home/Models/BLMCity.h"
#import "Home/Views/BLVDemo.h"
//#import "UIImage+Resizing.h"
#import "BLScrollViewDelegate.h"
#import "TableDemo.h"
#import "TableCellDemo.h"

#import "App.h"

#import "BLDraggableView.h"
#import "BLGestureView.h"

#import "BLDrawerFrame.h"
#import "BLQuartz2dView.h"
#import "BLCADisplayLinkView.h"
#import "BLWatermarkView.h"
#import "BLClipView.h"
#import "BLGestureLock.h"
#import "BLLayer.h"
#import "BLClock.h"
#import "BLAnimations.h"
#import "BLTurntable.h"
#import "BLReplicator.h"
#import "BLInvertedImage.h"

@interface ViewController () <UIScrollViewDelegate>

{
    BLQuartz2dView *_vQ2d;
    
    UITextField *_tf;
    UIImageView *_imageView;
    BLWatermarkView *_wmView;
    
    BLClipView *_clipView;
}

// 自定义代理对象的时候，需要设置个强引用属性，因为scrollView的代理是weak的
@property(nonatomic, strong) BLScrollViewDelegate *svDelegate;
@property(nonatomic, weak) UIImageView *ivImg;
@property(nonatomic, weak) UIScrollView *svView;

@end

@implementation ViewController

//// 控制器重写此方法 控制式样
//- (UIStatusBarStyle)preferredStatusBarStyle {
////    return UIStatusBarStyleLightContent;
////    return UIStatusBarStyleDarkContent;
//    return UIStatusBarStyleDefault;
//}
//
//// 控制器重写此方法 控制是否隐藏
//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    [self makeBLInvertedImage];
//    [self makeBLReplicator];
//    [self makeBLTurntable];
//    [self makeBLAnimations];
//    [self makeBLClock];
//    [self makeBLLayer];
//    [self makeBLGestureLock];
//    [self makeBLClipViewEraser];
//    [self makeBLClipViewForCustomer];
//    [self makeBLClipView];
//    [self makeBLWatermarkView];
//    [self makeBLCADisplayLinkView];
//    [self makeBLQuartz2dView];
//    [self makeBLDrawerFrame];
//    [self makeGestureView];
//    [self makeEventViews];
//    [self makeBLDraggableView];
//    [self makeViewTranlate];
//    [self moniApplication];
//    [self dir];
//    [self createTable];
//    [self createVFL];
//    [self autoLayoutView];
//    [self autoResizeView];
//    [self makeScrollView];
//    [self kvo];
//    [self kvc];
//    [self createResizingImage];
//    [self createViewFromXib];
//    [self createCustomerView];
//    [self writeToPlistFile];
    // 先要将 Rs 文件夹加入到 bundle 中
//    [self readFromPlistFile];
//    [self createUIView];
//    [self createUIButton];
//    [self createUIImageView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)makeBLInvertedImage {
    
    NSArray *arr = @[@"avatar", @"bz1", @"bz2", @"bz3"];
    for (int i=0; i<arr.count; i++) {
        CGRect frame = CGRectMake(30.f + i * 40.f, 100.f, 100.f, 100.f);
        BLInvertedImage *view = [[BLInvertedImage alloc] initWithFrame:frame];
        [self.view addSubview:view];

        UIImage *img = [UIImage imageNamed:arr[i]];
        view.image = img;
        view.isLeft = YES;
    }
    for (int i=0; i<arr.count; i++) {
        CGRect frame = CGRectMake(50.f + i * 40.f, 400.f, 100.f, 100.f);
        BLInvertedImage *view = [[BLInvertedImage alloc] initWithFrame:frame];
        [self.view addSubview:view];

        UIImage *img = [UIImage imageNamed:arr[i]];
        view.image = img;
        view.isLeft = NO;
        view.layer.zPosition = 100.f - i;
    }
    
//    UIImage *img1 = [UIImage imageNamed:arr[0]];
//    UIImage *img2 = [UIImage imageNamed:arr[1]];
//    UIImage *img3 = [UIImage imageNamed:arr[2]];
//    UIImageView *ivImg1 = [[UIImageView alloc] initWithImage:img1];
//    UIImageView *ivImg2 = [[UIImageView alloc] initWithImage:img2];
//    UIImageView *ivImg3 = [[UIImageView alloc] initWithImage:img3];
//    [self.view addSubview:ivImg1];
//    [self.view addSubview:ivImg2];
//    [self.view addSubview:ivImg3];
//    ivImg1.layer.zPosition = 3;
//    ivImg2.layer.zPosition = 2;
//    ivImg3.layer.zPosition = 1;
//
//    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = 1 / 900.f;
//    CGFloat angle = M_PI_4;
//    ivImg1.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 0);
//    ivImg2.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 0);
//    ivImg3.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 0);
    
}
- (void)makeBLReplicator {
    BLReplicator *view = [[BLReplicator alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}

- (void)makeBLTurntable {
    BLTurntable *view = [[BLTurntable alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}

- (void)makeBLAnimations {
    BLAnimations *view = [[BLAnimations alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}

- (void)makeBLClock {
    BLClock *view = [[BLClock alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}

- (void)makeBLLayer {
    BLLayer *view = [[BLLayer alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}

- (void)makeBLGestureLock {
    BLGestureLock *view = [[BLGestureLock alloc] initWithFrame:CGRectMake(20, 120, 300.f, 300.f)];
    view.backgroundColor = [UIColor systemBlueColor];
    [self.view addSubview:view];
}

- (void)makeBLClipViewEraser {
    _clipView = [[BLClipView  alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_clipView];
    
    UIImage *img2 = [UIImage imageNamed:@"bz2"];
    UIImage *img3 = [UIImage imageNamed:@"bz3"];
    _clipView.sourceImage = img2;
    _clipView.sourceImage2 = img3;
    
    [_clipView addEraserPan];
}


- (void)makeBLClipViewForCustomer {
    _clipView = [[BLClipView  alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_clipView];
    
    UIImage *img = [UIImage imageNamed:@"bz2"];
    _clipView.sourceImage = img;
    
    [_clipView addCustomerClipPan];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80.f, 120.f, 200.f, 400.f)];
    _imageView.backgroundColor = [UIColor redColor];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];

    __block ViewController *blockSelf = self;
    _clipView.clipBlock = ^(BLClipView *view, UIImage *image) {
        blockSelf->_imageView.image = image;
    };
}

- (void)makeBLClipView {
    _clipView = [[BLClipView  alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_clipView];
    
    CGSize s = [[UIScreen mainScreen] bounds].size;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20.f, 150.f, s.width-40.f, 50);
    [btn setTitle:@"裁剪" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(createClip) forControlEvents:UIControlEventTouchUpInside];
    [_clipView addSubview:btn];
    
        
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.f, 220.f, s.width-40.f, 300.f)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
}
- (void)createClip {
    _clipView.sourceImage = [UIImage imageNamed:@"bz"];
//    _imageView.image = [_clipView createClipImage];
//    _imageView.image = [_clipView createClipImageWithBorder];
    _imageView.image = [_clipView createClipScreen];
}

- (void)makeBLWatermarkView {
    _wmView = [[BLWatermarkView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_wmView];
    
    CGSize s = [[UIScreen mainScreen] bounds].size;
    _tf = [[UITextField alloc] initWithFrame:CGRectMake(20.f, 80.f, s.width-40.f, 50)];
    _tf.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tf];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20.f, 150.f, s.width-40.f, 50);
    [btn setTitle:@"合成" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(createWatermark) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.f, 220.f, s.width-40.f, 300.f)];
    [self.view addSubview:_imageView];
}
- (void)createWatermark {
    [_tf resignFirstResponder];
    _wmView.watermarkText = _tf.text;
    _wmView.sourceImage = [UIImage imageNamed:@"bz"];
    _imageView.image = [_wmView createWatermarkImage];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)makeBLCADisplayLinkView {
    BLCADisplayLinkView *view = [[BLCADisplayLinkView alloc] initWithFrame:self.view.bounds];
    self.view = view;
//    [view openTimer];
//    [view openDisplayLink];
}



- (void)makeBLQuartz2dView {
    CGRect frame = self.view.bounds;
    _vQ2d = [[BLQuartz2dView alloc] initWithFrame:frame];
    _vQ2d.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_vQ2d];
    
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAdd.frame = CGRectMake(20.f, 100.f, 100.f, 40.f);
    [btnAdd setTitle:@"添加" forState:UIControlStateNormal];
    [btnAdd setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(addProgress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAdd];
    
    UIButton *btnClear = [UIButton buttonWithType:UIButtonTypeCustom];
    btnClear.frame = CGRectMake(140.f, 100.f, 100.f, 40.f);
    [btnClear setTitle:@"清除" forState:UIControlStateNormal];
    [btnClear setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btnClear addTarget:self action:@selector(clearProgress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnClear];
}
- (void)addProgress:(UIButton *)btn {
    _vQ2d.endArc += 5;
}
- (void)clearProgress:(UIButton *)btn {
    _vQ2d.endArc = 0;
}

- (void)makeBLDrawerFrame {
    CGRect frame = self.view.bounds;
//    frame = CGRectMake(20, 20, 300, 500);
    BLDrawerFrame *view = [[BLDrawerFrame alloc] initWithFrame:frame];
    view.ratio = 108;
//    view.scale = 0.7;
//    view.isScaleWithRatio = YES;
    
    UIImage *img = [UIImage imageNamed:@"avatar"];
    UIImageView *ivAvatar = [[UIImageView alloc] initWithImage:img];
    ivAvatar.frame = CGRectMake(20, 20, 68, 68);
    ivAvatar.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(open)];
    [ivAvatar addGestureRecognizer:tap];
    [view.vMain addSubview:ivAvatar];
    
    UIImage *img2 = [UIImage imageNamed:@"vip"];
    UIImageView *ivClose = [[UIImageView alloc] initWithImage:img2];
    ivClose.frame = CGRectMake(20, 60, 30, 30);
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(close)];
    [ivClose addGestureRecognizer:tap2];
    [view.vSecondary addSubview:ivClose];
    
    [self.view addSubview:view];
}

// 一个手势不能同时支持多个手势，想要支持，要设置代理
- (void)makeGestureView {
    CGRect frame = CGRectMake(100, 100, 200, 400);
    BLGestureView *vView = [[BLGestureView alloc] initWithFrame:frame];
    vView.backgroundColor = [UIColor greenColor];
    [vView addTapGestureRecognizer];
    [vView addGestureDelegate];
    [vView addSwipeGestureRecognizer];
    [vView addLongPressGestureRecognizer];
    [vView addPanGestureRecognizer];
    [vView addRotationGestureRecognizer];
    [vView addPinchGestureRecognizer];
    [self.view addSubview:vView];
}

- (void)makeEventViews {
    CGRect frame = self.view.bounds;
    BLDraggableView *vView1 = [[BLDraggableView alloc] initWithFrame:frame];
    vView1.tag = 1;
    [vView1 addText];
    vView1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:vView1];
    
    frame = CGRectMake(10, 100, 200, 200);
    BLDraggableView *vView2 = [[BLDraggableView alloc] initWithFrame:frame];
    vView2.tag = 2;
    [vView2 addText];
    vView2.backgroundColor = [UIColor redColor];
    [vView1 addSubview:vView2];
    
    frame = CGRectMake(100, 100, 50, 50);
    BLDraggableView *vView7 = [[BLDraggableView alloc] initWithFrame:frame];
    vView7.tag = 7;
    [vView7 addText];
    vView7.backgroundColor = [UIColor greenColor];
    [vView2 addSubview:vView7];
    
    frame = CGRectMake(100, 350, 200, 200);
    BLDraggableView *vView3 = [[BLDraggableView alloc] initWithFrame:frame];
    vView3.tag = 3;
    [vView3 addText];
    vView3.backgroundColor = [UIColor systemPinkColor];
    [vView1 addSubview:vView3];
    
    frame = CGRectMake(10, 10, 100, 100);
    BLDraggableView *vView4 = [[BLDraggableView alloc] initWithFrame:frame];
    vView4.tag = 4;
    [vView4 addText];
    vView4.backgroundColor = [UIColor orangeColor];
    [vView3 addSubview:vView4];

    frame = CGRectMake(0, 150, 100, 100);
    BLDraggableView *vView5 = [[BLDraggableView alloc] initWithFrame:frame];
    vView5.tag = 5;
    [vView5 addText];
    vView5.backgroundColor = [UIColor yellowColor];
    [vView3 addSubview:vView5];

    frame = CGRectMake(10, 10, 50, 50);
    BLDraggableView *vView6 = [[BLDraggableView alloc] initWithFrame:frame];
    vView6.tag = 6;
    [vView6 addText];
    vView6.backgroundColor = [UIColor greenColor];
    [vView4 addSubview:vView6];
}


- (void)makeBLDraggableView {
    CGRect frame = CGRectMake(100, 100, 100, 100);
    BLDraggableView *vView = [[BLDraggableView alloc] initWithFrame:frame];
    vView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:vView];
}


- (void)makeViewTranlate {
    UIView *vView = [[UIView alloc] init];
    vView.frame = CGRectMake(150, 150, 100, 100);
    vView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:vView];
    
    [UIView animateWithDuration:3 animations:^{
//        vView.transform = CGAffineTransformTranslate(vView.transform, 100.f, 300.f);
        vView.transform = CGAffineTransformRotate(vView.transform, M_PI*7);
    }];
    [UIView animateWithDuration:3 animations:^{
        vView.transform = CGAffineTransformTranslate(vView.transform, 100.f, 300.f);
//        vView.transform = CGAffineTransformRotate(vView.transform, M_PI*7);
    }];
}


- (void)moniApplication {
    App *app1 = [App shareApp];
    App *app2 = [App shareApp];
    blog(@"app1:[%p]   app2:[%p]", app1, app2);
    App *app3 = [[App alloc] init];
}


- (void)dir {
    blog(@"%@", NSHomeDirectory());
}

- (void)createTable {
    CGSize size = MC_TableCellViewModelDemo_ScreenSize;
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    TableDemo *vTable = [[TableDemo alloc] initWithFrame:frame];
    [self.view addSubview:vTable];
    [vTable addFPSLabel];
}

// Visual Format Language
// 苹果为了简化代码创建AutoLayout 发明的虚拟格式化语言
- (void)createVFL {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    UIView *vView = [[UIView alloc] init];
    vView.frame = CGRectMake(size.width-100, size.height-100, 100, 100);
    vView.backgroundColor = [UIColor redColor];
    [self.view addSubview:vView];
    // 禁止将autoresize转成约束
    vView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = @{@"vView": vView};
    NSDictionary *metrics = @{@"space": @20};
    NSString *h_vfl = @"H:|-space-[vView]-space-|";
    NSArray *h_cons = [NSLayoutConstraint constraintsWithVisualFormat:h_vfl options:kNilOptions metrics:metrics views:views];
    [self.view addConstraints:h_cons];
    
    NSString *v_vfl = @"V:[vView(40)]-20-|";
    NSArray *v_cons = [NSLayoutConstraint constraintsWithVisualFormat:v_vfl options:kNilOptions metrics:nil views:views];
    [self.view addConstraints:v_cons];
}

// iPhone6 iOS7 Xcode5
- (void)autoLayoutView {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    UIView *vView = [[UIView alloc] init];
    vView.frame = CGRectMake(size.width-100, size.height-100, 100, 100);
    vView.backgroundColor = [UIColor redColor];
    [self.view addSubview:vView];
    // 禁止将autoresize转成约束
    vView.translatesAutoresizingMaskIntoConstraints = NO;
    // 万能公式
    // 添加约束的原则
    // 1 同级兄弟间依赖的约束，添加到父控件上
    // 2 不同层级的依赖，添加到最小公父控件上，此父控件必须能找到他们两个
    // 父子之间的约束，添加到父控件上
    NSLayoutConstraint *wC = [NSLayoutConstraint constraintWithItem:vView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:100];
    [vView addConstraint:wC];
    NSLayoutConstraint *hC = [NSLayoutConstraint constraintWithItem:vView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:100];
    [vView addConstraint:hC];
    NSLayoutConstraint *rC = [NSLayoutConstraint constraintWithItem:vView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-30];
    [self.view addConstraint:rC];
    NSLayoutConstraint *bC = [NSLayoutConstraint constraintWithItem:vView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-30];
    [self.view addConstraint:bC];
}

// iPhone5 iOS6 Xcode4
- (void)autoResizeView {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    UIView *vView = [[UIView alloc] init];
    vView.frame = CGRectMake(size.width-100, size.height-100, 100, 100);
    vView.backgroundColor = [UIColor redColor];
    [self.view addSubview:vView];
    
    vView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
                                        | UIViewAutoresizingFlexibleLeftMargin
//                                        | UIViewAutoresizingFlexibleWidth
//                                        | UIViewAutoresizingFlexibleHeight
    ;
}

- (void)makeScrollView {
    UIScrollView *svView = [[UIScrollView alloc] init];
    svView.delegate = self;
    svView.frame = CGRectMake(0, 100, 300, 300);
    [self.view addSubview:svView];

    // Assigning retained object to weak property; object will be released after assignment
//    svView.delegate = [[BLScrollViewDelegate alloc] init];
    // 自定义代理对象的时候，需要设置个强引用属性，因为scrollView的代理是weak的
    // 苹果的代理为啥是 weak，为了防止 循环引用
    // viewController 强引用了 view对象 @property(null_resettable, nonatomic,strong) UIView *view;
    // view 强引用了subviews @property(nonatomic,readonly,copy) NSArray<__kindof UIView *> *subviews;
    // scrollView中被添加到了subviews，而scrollView中有delegate如果强引用controller，则引起循环引用，内存得不到释放
//    self.svDelegate = [[BLScrollViewDelegate alloc] init];
//    svView.delegate = self.svDelegate;
    
    
    // ScrollView 的滚动实际是 内容视图的滚动
//    svView.contentSize = CGSizeMake(500, 500);
    // 以下两个属性，即使不设置 contentSize， 总是有弹簧效果，但并非是滚动
//    svView.alwaysBounceVertical = YES;
//    svView.alwaysBounceHorizontal = YES;
    // 设置偏移，但是当用户交互时，自动会清除偏移
//    svView.contentOffset = CGPointMake(100, 100);
    // 边距，可增加滚动区域
//    svView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    
    UIImage *img2 = [UIImage imageNamed:@"svimg.png"];
    UIImageView *vImg = [[UIImageView alloc] initWithImage:img2];
    [svView addSubview:vImg];
    
    self.ivImg = vImg;
    svView.contentSize = img2.size;
    NSLog(@"%@", NSStringFromCGSize(img2.size));
    svView.maximumZoomScale = 2.0;
    svView.minimumZoomScale = 0.5;
    self.svView = svView;
    
    // 分页指示器属性
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    // 总页数
    pageControl.numberOfPages = 5;
    // 单页隐藏
    pageControl.hidesForSinglePage = YES;
//    // 设置显示式样 用kvc 不好用
//    [pageControl setValue:[UIImage imageNamed:@"btn1"] forKeyPath:@"_currentPageImage"];
//    // 设置显示式样 用kvc
//    [pageControl setValue:[UIImage imageNamed:@"btn1"] forKeyPath:@"_pageImage"];

}

// 缩放图片
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.ivImg;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidZoom");
}

// 用户即将开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scrollViewWillBeginDragging");
}
// 用户即将停止拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSLog(@"scrollViewWillEndDragging");
}
// 用户已经停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"scrollViewDidEndDragging");
    // 已停止滚动
    if (decelerate == NO) {
        // 分页
        int page = self.svView.contentOffset.x / self.svView.frame.size.width;
//        self.pageControl.currentPage = page;
    }
}
// 正在滚动的时候监听此方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollView scrolling");
    // 分页
    int page = (int)(self.svView.contentOffset.x / self.svView.frame.size.width + 0.5);
//        self.pageControl.currentPage = page;
}
// 减速完毕，已经停止滚动，
// 有时可能不会调用，因为手指松开那一刻已经停止了
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
    // 分页
    int page = self.svView.contentOffset.x / self.svView.frame.size.width;
//        self.pageControl.currentPage = page;
}



// Key Value Observer: 键值观察
//
- (void)kvo {
    BLMCity *c = [[BLMCity alloc] init];
    [c addObserver:self
        forKeyPath:@"area"
        options:NSKeyValueObservingOptionNew
            | NSKeyValueObservingOptionOld
//            | NSKeyValueObservingOptionInitial
//            | NSKeyValueObservingOptionPrior
        context:@"123"];
    c.area = @"beijing";
    NSLog(@"--------------------------------");
    c.area = @"shanghai";
    NSLog(@"--------------------------------");
    c.area = @"guangzhou";
    [c removeObserver:self forKeyPath:@"area"];
//    [c removeObserver:self forKeyPath:@"area" context:@"123"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"old: %@", change[NSKeyValueChangeOldKey]);
    NSLog(@"new: %@", change[NSKeyValueChangeNewKey]);
//    NSLog(@"kind: %@", change[NSKeyValueChangeKindKey]);
//    NSLog(@"Indexes: %@", change[NSKeyValueChangeIndexesKey]);
//    NSLog(@"NotificationIsPrior: %@", change[NSKeyValueChangeNotificationIsPriorKey]);
}

// Key Value Coding 键值编码
// kvc的核心价值是 可以改变私有成员变量
- (void)kvc {
    BLMCity *c = [[BLMCity alloc] init];
//    c->level = @"15"; // 'BLMCity' does not have a member named 'level'
    [c setValue:@"12" forKeyPath:@"level"];
    NSLog(@"%@", [c getLevel]);
    
    // 计算
    BLMCity *c1 = [[BLMCity alloc] init];
    c1.width = 100;
    c1.area = @"chaoyang";
    BLMCity *c2 = [[BLMCity alloc] init];
    c2.width = 200;
    c2.area = @"dachaoyang";
    BLMCity *c3 = [[BLMCity alloc] init];
    c3.width = 300;
    c3.area = @"fchaoyang";
    NSArray *list = @[c1, c2, c3];
    NSArray *areas = [list valueForKeyPath:@"area"];
    NSLog(@"areas: %@", areas);
    // @ 是运算符
    id count = [list valueForKeyPath:@"@count"];
    NSLog(@"count: %@",count);
    id avgWidth = [list valueForKeyPath:@"@avg.width"];
    NSLog(@"avgWidth: %@",avgWidth);
    id sumWidth = [list valueForKeyPath:@"@sum.width"];
    NSLog(@"sumWidth: %@",sumWidth);
    id maxWidth = [list valueForKeyPath:@"@max.width"];
    NSLog(@"maxWidth: %@",maxWidth);
    id minWidth = [list valueForKeyPath:@"@min.width"];
    NSLog(@"minWidth: %@",minWidth);
    
    id minArea = [list valueForKeyPath:@"@min.area"];
    NSLog(@"minArea: %@",minArea);
}

- (void)createResizingImage {
    UIImageView *ivImg = [[UIImageView alloc] init];
    ivImg.frame = CGRectMake(20, 100, 300, 600);
    ivImg.image = [UIImage resizingImageWithName:@"rimg"];
    [self.view addSubview:ivImg];
}

- (void)createViewFromXib {
    // 第一种方式
//    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"BLVDemo" owner:nil options:nil];
//    UIView *view = [views firstObject];
    // 第二种方式
//    UINib *nib = [UINib nibWithNibName:@"BLVDemo" bundle:nil];
//    NSArray *views2 = [nib instantiateWithOwner:nil options:nil];
//    UIView *view = [views2 firstObject];
    // 第三种方式
    BLVDemo *view = [BLVDemo viewFromXib];
    [self.view addSubview:view];
}

- (void)createCustomerView {
    NSDictionary *dic = @{@"city": @"大连", @"area": @"甘井子区"};
    BLMCity *data = [BLMCity cityWithDictionary:dic];
    
//    BLVDemo *view = [[BLVDemo alloc] init];
//    BLVDemo *view = [BLVDemo new];
//    view.data = city;
//    BLVDemo *view = [[BLVDemo alloc] initWithData:data];
    BLVDemo *view = [BLVDemo vdemoWithData:data];
    view.frame = CGRectMake(100, 100, 100, 120);
    [self.view addSubview:view];
}

- (void)writeToPlistFile {
    NSArray *citys = @[
        @{
            @"city": @"大连"
            , @"area": @"甘井子区"
        }
        , @{
            @"city": @"北京"
            , @"area": @"朝阳区区"
        }
    ];
    BOOL res = [citys writeToFile:@"/Users/bailong/Desktop/p_iOS/DemoOC/DemoOC/Rs/citys.plist" atomically:YES];
    if (res) {
        NSLog(@"文件写入成功");
    }
}
- (void)readFromPlistFile {
    NSBundle *main = [NSBundle mainBundle];
    NSString *path = [main pathForResource:@"Rs/citys" ofType:@"plist"];
    NSLog(@"%@", path);
    NSArray *list = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"%lu", (unsigned long)list.count);
    [list enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
        BLMCity *city = [BLMCity cityWithDictionary:dic];
        NSLog(@"%@ -- %@", city.city, city.area);
    }];
}

- (void)createUIImageView {
    UIImageView *view = [[UIImageView alloc] init];
    view.frame = CGRectMake(100, 100, 100, 100);
    // imageNamed 方法 有缓存，所以 如果使用 assets 中的图片，获取时也是使用 imageNamed 方法，所以也有缓存
//    UIImage *img = [UIImage imageNamed:@"btn"];
//    view.image = img;
    // imageWithContentsOfFile 方法 无缓存 结尾是file的方法，路径皆为全路径
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"images/1" ofType:@"png"];
    UIImage *img2 = [UIImage imageWithContentsOfFile:path];
    view.image = img2;
    
    [self.view addSubview:view];
}

- (void)createUIButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 100, 400, 30);
    NSString *title = @"Hello";
    UIColor *titleColor = [UIColor redColor];
    UIImage *img = [UIImage imageNamed:@"btn"];
//    btn.titleLabel.text = title; // 错误
    [btn setTitle:title forState:UIControlStateNormal]; // 正确
//    btn.titleLabel.textColor = titleColor; // 错误
    [btn setTitleColor:titleColor forState:UIControlStateNormal]; // 正确
//    btn.imageView.image = img; // 错误
    [btn setImage:img forState:UIControlStateNormal]; // 正确
    
    [self.view addSubview:btn];
}

- (void)createUIView {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(100, 100, 100, 100);
    view.backgroundColor = [UIColor redColor];
    // OC规定：不能直接修改OC对象的结构体属性的成员，需要局部变量
//    view.frame.origin.x = 100; // 错误
//    view.frame.size = CGSizeMake(300, 300); // 错误
    // 1 取出， 2 修改， 3 在赋值回去
    CGRect f = view.frame;
    f.size.height = 300;
    f.size.width = 300;
    view.frame = f;
    
    [self.view addSubview:view];
}


@end
