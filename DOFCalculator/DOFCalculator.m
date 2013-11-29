//
//  DOFCalculator.m
//  DOFCalculator
//
//  Created by Luka Kruscic on 25/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import "DOFCalculator.h"

@implementation DOFCalculator

// circle of confusion to image sensor size mapping
// http://en.wikipedia.org/wiki/Circle_of_confusion#Circle_of_confusion_diameter_limit_based_on_d.2F1500
+(NSDictionary*) coc
{
    static NSDictionary *coc = nil;
    
    if (coc == nil)
    {
        coc = [NSDictionary dictionaryWithObjectsAndKeys:
               [NSNumber numberWithDouble:0.030], [NSNumber numberWithInteger: Full_Frame],
               nil];
    }
    return coc;
}

// aperture value to f-number mapping
// http://en.wikipedia.org/wiki/F-number#Standard_full-stop_f-number_scale
+(NSDictionary*) aperture
{
    static NSDictionary *aperture = nil;
    
    if (aperture == nil)
    {
        aperture = [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSNumber numberWithDouble:1], [NSNumber numberWithInteger:One_Point_Four],
                    [NSNumber numberWithDouble:2], [NSNumber numberWithInteger:Two],
                    [NSNumber numberWithDouble:3], [NSNumber numberWithInteger:Two_Point_Eight],
                    [NSNumber numberWithDouble:4], [NSNumber numberWithInteger:Four],
                    [NSNumber numberWithDouble:5], [NSNumber numberWithInteger:Five_Point_Six],
                    [NSNumber numberWithDouble:6], [NSNumber numberWithInteger:Eight],
                    [NSNumber numberWithDouble:7], [NSNumber numberWithInteger:Eleven],
                    [NSNumber numberWithDouble:8], [NSNumber numberWithInteger:Sixteen],
                    [NSNumber numberWithDouble:9], [NSNumber numberWithInteger:TwentyTwo],
                    nil];
    }
    return aperture;
}

-(double)hyperfocalDistanceForFocalLength:(double)fl fStop:(FNumber)f imageFormat: (ImageFormat) imageFormat;
{
    NSNumber *apertureValue = [[DOFCalculator aperture] objectForKey:[NSNumber numberWithInteger:f]];
    double fnumber = pow(2, [apertureValue doubleValue] / 2);
    NSNumber *cocValue = [[DOFCalculator coc] objectForKey:[NSNumber numberWithInteger:imageFormat]];
    double hd = (fl * fl) / (fnumber * [cocValue doubleValue]) + fl;
    return hd/1000;
}

-(double)nearDistanceForFocusDistance:(double)fd hyperfocalDistance:(double)hd focalLength: (double) fl
{
    double dn = (fd*1000 * (hd*1000 - fl)) / (hd*1000 + fd*1000 - 2 * fl);
    return dn/1000;
}

-(double)farDistanceForFocusDistance:(double)fd hyperfocalDistance:(double)hd focalLength: (double) fl
{
    double dr = (fd*1000 * (hd*1000 - fl)) / (hd*1000 - fd*1000);
    return dr/1000;
}

-(double)distanceInFrontOfSubjectForFocusDistance:(double)focus nearDistance: (double) near
{
    return focus - near;
}

-(double)distanceBehindSubjectForFocusDistance:(double)focus farDistance: (double) far
{
    return far - focus;
}

- (double)totalDepthOfFieldForFarDistance:(double)far nearDistance: (double)near
{
    return far - near;
}

@end