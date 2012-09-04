//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Tanay Jaipuria on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringNumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) BOOL userEnteredPoint;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize textsofar;
@synthesize userIsInTheMiddleOfEnteringNumber;
@synthesize userEnteredPoint;

@synthesize brain = _brain;

- (CalculatorBrain *) brain {
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (userIsInTheMiddleOfEnteringNumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
        self.textsofar.text = [self.textsofar.text stringByAppendingString:digit];
    }
    else {
        self.textsofar.text = [[self.textsofar.text stringByAppendingString:@" "] stringByAppendingString:digit ];
        self.display.text = digit;
        userIsInTheMiddleOfEnteringNumber = YES;
    }
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringNumber = NO;
    self.userEnteredPoint = NO;
}

- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringNumber)
    {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    self.textsofar.text = [[self.textsofar.text stringByAppendingString:@" "] stringByAppendingString:operation ];

}
- (IBAction)pointPressed:(id)sender {
    if (!self.userEnteredPoint && self.userIsInTheMiddleOfEnteringNumber)
    {
        self.userEnteredPoint = YES;
        self.textsofar.text = [self.textsofar.text stringByAppendingString:@"."];
        self.display.text = [self.display.text stringByAppendingString:@"."];
    }
}
- (IBAction)clearPressed {
    self.userEnteredPoint = NO;
    self.userIsInTheMiddleOfEnteringNumber = NO;
    self.display.text = @"0";
    self.textsofar.text = @"";
    [self.brain clearState];
}
@end
