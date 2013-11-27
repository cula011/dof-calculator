//
//  DOFCalculator.h
//  DOFCalculator
//
//  Created by Luka Kruscic on 25/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DOFCalculator : NSObject

// (http://www.dofmaster.com/equations.html)
// where:
// H is the hyperfocal distance, mm
// f is the lens focal length, mm (f-number is calculated by the definition N = 2^i/2, where i = 1, 2, 3,... for f/1.4, f/2, f/2.8,...)
// s is the focus distance
// Dn is the near distance for acceptable sharpness
// Df is the far distance for acceptable sharpness
// N is the f-number
// c is the circle of confusion, mm

// H = (f * f) / (N * c) + f
-(double) calculateHyperfocalDistanceForFocalLength: (double)fl fStop:(NSString *)f imageFormat: (NSString *)imageFormat;

// Dn = (s * (H - f)) / (H + s - 2 * f)
-(double) calculateNearDistanceForFocusDistance: (double)fs hyperfocalDistance: (double)hd focalLength: (double)fl;

// Df = (s * (H -f)) / (H - s)
-(double) calculateFarDistanceForFocusDistance: (double)fs hyperfocalDistance: (double)hd focalLength: (double)fl;

@end