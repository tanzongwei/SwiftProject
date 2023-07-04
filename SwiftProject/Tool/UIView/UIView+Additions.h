//
//  UIViewAdditions.h
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

- (id)initWithParent:(UIView *)parent;
+ (id)viewWithParent:(UIView *)parent;
-(void)removeAllSubViews;
- (void)setBackgroundImage:(UIImage*)image;
- (UIImage*)toImage;

- (void)setMaskLayerByRoundingCornersWithSize:(CGFloat)size;
- (void)setMaskLayerByRoundingCorners:(UIRectCorner)corners size:(CGFloat)size;
- (void)setMaskLayerWith:(UIView *)view byRoundingCorners:(UIRectCorner)corners size:(CGSize)size;

// Position of the top-left corner in superview's coordinates
@property CGPoint position;
@property CGFloat x;
@property CGFloat y;
@property CGFloat top;
@property CGFloat bottom;
@property CGFloat left;
@property CGFloat right;

// makes hiding more logical
@property BOOL	visible;

// Setting size keeps the position (top-left corner) constant
@property CGSize size;
@property CGFloat width;
@property CGFloat height;

@end

@interface UIView (Animation)
+ (CAAnimation *)hearAnimationFrom:(CGRect)frame;
@end

@interface UIImageView (MFAdditions)
- (void)setImageWithName:(NSString *)name;
- (void)setMaskLayerWith:(UIImageView *)view;
@end

@interface UIImage (MFAdditions)
+ (UIImage *)liveImage:(UIImage*)image byScalingToBitSize:(CGFloat)bitSize;
+ (UIImage *)getImageWithView:(UIView *)view rect:(CGRect)rect scale:(CGFloat)scale;
+ (UIImage *)generateWithURLString:(NSString *)urlString imageSize:(CGSize)size;
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;
@end
