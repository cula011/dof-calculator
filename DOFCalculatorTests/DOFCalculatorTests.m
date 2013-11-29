//
//  DOFCalculatorTests.m
//  DOFCalculatorTests
//
//  Created by Luka Kruscic on 25/11/2013.
//  Copyright (c) 2013 Luka Kruscic. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DOFCalculator.h"

@interface DOFCalculatorTests : XCTestCase
{
@private
    DOFCalculator *dofCalc;
}
@end

@implementation DOFCalculatorTests

- (void)setUp
{
    [super setUp];
    dofCalc = [[DOFCalculator alloc] init];
}

- (void)tearDown
{
    dofCalc = nil;
    [super tearDown];
}

- (void)testHyperfocalDistanceCalculator
{
    double actual = [dofCalc hyperfocalDistanceForFocalLength:50 fStop:Two imageFormat:Full_Frame];
    XCTAssertTrue([[NSNumber numberWithDouble: actual] compare:[NSNumber numberWithDouble:41.7]],
                  @"Hyperfocal distance should be 41.7 but was %f.", actual);
}

- (void)testNearDistanceCalculator
{
    double actual = [dofCalc nearDistanceForFocusDistance:10 hyperfocalDistance:41.7 focalLength:50];
    XCTAssertTrue([[NSNumber numberWithDouble: actual] compare:[NSNumber numberWithDouble:8.07]],
                  @"Near distance should be 8.07 but was %f.", actual);
}

- (void)testFarDistanceCalculator
{
    double actual = [dofCalc farDistanceForFocusDistance:10 hyperfocalDistance:41.7 focalLength:50];
    XCTAssertTrue([[NSNumber numberWithDouble: actual] compare:[NSNumber numberWithDouble:13.1]],
                  @"Far distance should be 13.1 but was %f.", actual);
}

-(void)testInFrontOfSubjectCalculation
{
    double actual = [dofCalc distanceInFrontOfSubjectForFocusDistance:10 nearDistance:8.07];
    XCTAssertTrue([[NSNumber numberWithDouble: actual] compare:[NSNumber numberWithDouble:1.93]],
                  @"Distance in front of subject should be 1.93 but was %f.", actual);
}

-(void)testBehindSubjectCalculation
{
    double actual = [dofCalc distanceBehindSubjectForFocusDistance:10 farDistance:13.1];
    XCTAssertTrue([[NSNumber numberWithDouble: actual] compare:[NSNumber numberWithDouble:3.1]],
                  @"Distance behind subject should be 3.1 but was %f.", actual);
}

-(void)testTotalDepthOfFieldCalculation
{
    double actual = [dofCalc totalDepthOfFieldForFarDistance:13.1 nearDistance:8.07];
    XCTAssertTrue([[NSNumber numberWithDouble: actual] compare:[NSNumber numberWithDouble:5.04]],
                  @"Distance behind subject should be 5.04 but was %f.", actual);
}

@end