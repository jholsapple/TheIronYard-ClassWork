#import "PicMark.h"

@interface PicMark ()

// Private interface goes here.

@end

@implementation PicMark

- (NSString *)title
{
    return @"A Picmark";
}

- (CLLocationCoordinate2D)coordinate
{
    return theLocation.coordinate;
}
@end
