//
//  BLDrawViewController.m
//  DemoOC
//
//  Created by bailong on 2021/8/4.
//

#import "BLDrawViewController.h"

#import "BLDrawView.h"
#import "BLHandleView.h"

@interface BLDrawViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet BLDrawView *vDraw;

@end

@implementation BLDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

// 清屏
- (IBAction)clear:(id)sender {
    [self.vDraw clear];
}
- (IBAction)undo:(id)sender {
    [self.vDraw undo];
}

- (IBAction)erase:(id)sender {
    [self.vDraw setLineColor:[UIColor whiteColor]];
}


- (IBAction)photo:(id)sender {
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
    pick.delegate = self;
    [self presentViewController:pick animated:YES completion:^{
        
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
//    NSLog(@"%@", info);
    /*
     {
         UIImagePickerControllerImageURL = "file:///private/var/mobile/Containers/Data/Application/00423C06-3610-4ABF-AA16-252265299E27/tmp/16FCB9C6-6FA1-4011-BF8A-A39BF2334B1C.jpeg";
         UIImagePickerControllerMediaType = "public.image";
         UIImagePickerControllerOriginalImage = "<UIImage:0x2804e3060 anonymous {1080, 1080}>";
         UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=B6A357B9-A36C-402C-8557-623A31765262&ext=JPG";
     }
     */
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    BLHandleView *vHandle = [[BLHandleView alloc] initWithFrame:self.vDraw.frame];
    vHandle.backgroundColor = [UIColor clearColor];
    vHandle.image = img;
    
//    __block BLDrawViewController *blockSelf = self;
    vHandle.clipBlock = ^(BLHandleView * _Nonnull view, UIImage * _Nonnull image) {
        self.vDraw.image = image;
        [self save:nil];
//        NSData *data = UIImageJPEGRepresentation(image, 1);
//        [data writeToFile:@"/Users/bailong/Desktop/photo.jpg" atomically:YES];
    };
    [self.view addSubview:vHandle];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)save:(id)sender {
    UIGraphicsBeginImageContextWithOptions(self.vDraw.bounds.size, YES, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.vDraw.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"保存成功");
}

- (IBAction)setLineColor:(UIButton *)sender {
    UIColor *color;
    switch (sender.tag) {
        case 0:
            color = [UIColor yellowColor];
            break;
        case 1:
            color = [UIColor orangeColor];
            break;
        case 2:
            color = [UIColor redColor];
            break;
        default:
            color = [UIColor blackColor];
            break;
    }
    [self.vDraw setLineColor:color];
}

- (IBAction)setLineWidth:(UISlider *)sender {
    [self.vDraw setLineWidth:sender.value];
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
