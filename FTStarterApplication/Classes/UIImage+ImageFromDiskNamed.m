#import "UIImage+ImageFromDiskNamed.h"

@implementation UIImage (ImageFromDiskNamed)

+ (UIImage *)imageFromDiskNamed:(NSString *)imageName {
    NSRange r = [imageName rangeOfString:@"."];
    NSString *fileName = imageName;
    NSString *fileType = @"png"; //default
    if (r.location != NSNotFound) {
        fileName = [imageName substringToIndex:r.location];
        fileType = [imageName substringFromIndex:(r.location + 1)];
    }
    CGFloat scale = 1.0;
    UIScreen *screen = [UIScreen mainScreen];
    if ([screen respondsToSelector:@selector(scale)]) {
        scale = screen.scale;
    }
    if (scale == 2.0) {
        fileName = [fileName stringByAppendingString:@"@2x"];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
    return [[UIImage alloc] initWithContentsOfFile:path];
}

@end
