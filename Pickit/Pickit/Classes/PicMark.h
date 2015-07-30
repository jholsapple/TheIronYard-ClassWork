#import "_PicMark.h"

@import CoreLocation;
@import UIKit;
@import MapKit;

@interface PicMark : _PicMark <MKAnnotation>
{
    CLLocation *theLocation;
    UIImage *image;
}

@end
