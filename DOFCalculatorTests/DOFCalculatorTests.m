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
    // Put setup code here. This method is called before the invocation of each test method in the class.
    dofCalc = [[DOFCalculator alloc] init];
}

- (void)tearDown
{
    dofCalc = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testHyperfocalDistanceCalculator
{
    double actual = [dofCalc calculateHyperfocalDistanceForFocalLength:50 fStop:@"2" imageFormat:@"Full Frame"];
    NSDecimalNumber *actualRounded = [DOFCalculatorTests roundDecimalNumber:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", actual]] toNumberOfDecimalPoints:1];
    XCTAssertTrue([actualRounded doubleValue]== 41.7, @"Hyperfocal distance should be 41.7 but was %@.", actualRounded);
}

- (void)testNearDistanceCalculator
{
    double actual = [dofCalc calculateNearDistanceForFocusDistance:10 hyperfocalDistance:41.7 focalLength:50];
    NSDecimalNumber *actualRounded = [DOFCalculatorTests roundDecimalNumber:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", actual]] toNumberOfDecimalPoints:2];
    XCTAssertTrue([actualRounded doubleValue] == 8.07, @"Near distance should be 8.07 but was %@.", actualRounded);
}

- (void)testFarDistanceCalculator
{
    double actual = [dofCalc calculateFarDistanceForFocusDistance:10 hyperfocalDistance:41.7 focalLength:50];
    NSDecimalNumber *actualRounded = [DOFCalculatorTests roundDecimalNumber:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f", actual]] toNumberOfDecimalPoints:1];
    XCTAssertTrue([actualRounded doubleValue] == 13.1, @"Far distance should be 13.1 but was %@.", actualRounded);
}

+(NSDecimalNumber*) roundDecimalNumber: (NSDecimalNumber*)decimalValue toNumberOfDecimalPoints: (int)floatSize
{
    NSDecimalNumberHandler *roundingStyle = [NSDecimalNumberHandler
                                             decimalNumberHandlerWithRoundingMode:
                                             NSRoundBankers scale:floatSize raiseOnExactness:NO raiseOnOverflow:NO
                                             raiseOnUnderflow:NO
                                             raiseOnDivideByZero:NO];
    NSDecimalNumber *roundedNumber = [decimalValue
                                      decimalNumberByRoundingAccordingToBehavior:
                                      roundingStyle];
    return roundedNumber;
}

@end