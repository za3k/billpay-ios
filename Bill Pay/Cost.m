//
//  Cost.m
//  Bill Pay
//
//  Created by Zachary Vance on 7/5/12.
//  Copyright (c) 2012 Ridejoy. All rights reserved.
//

#import "Cost.h"

@interface Cost ()
    @property (readwrite) NSInteger dollars;
    @property (readwrite) NSInteger cents;
@end

@implementation Cost
{
}

@synthesize dollars = _dollars, cents = _cents;

- (NSString *)asString
{
    return [[NSString alloc] initWithFormat:@"$%d.%02d", self.dollars, self.cents];
}

-(id)init
{
    return [self initFromCostInCents:0];
}

-(id)initFromDollars:(NSInteger)dollars cents:(NSInteger)cents
{
    self = [super init];
    if(self)
    {
        self.dollars = dollars;
        self.cents = cents;
        return self;
    }
    return nil;
}

-(id)initFromCostInCents:(NSInteger)cents
{
    self = [super init];
    if(self)
    {
        self.cents = cents % 100;
        self.dollars = (cents - self.cents) / 100;
        return self;
    }
    return nil;
}

-(NSInteger)inCents
{
    return self.dollars * 100 + self.cents;
}

+(NSSet *)keyPathsForValuesAffectingInCents
{
    return [NSSet setWithObjects:@"dollars", @"cents", nil];
}

-(Cost *)costByMultiplyingBy:(NSDecimalNumber *)percent
{
    NSDecimalNumber *costInCents = [NSDecimalNumber decimalNumberWithDecimal:[[NSNumber numberWithInteger:self.inCents] decimalValue]];
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *product = [costInCents decimalNumberByMultiplyingBy:percent withBehavior:handler];
    return [[Cost alloc] initFromCostInCents: [product integerValue]];   
}

-(Cost *)costByAdding:(Cost *)other
{
    return [[Cost alloc] initFromCostInCents:self.inCents+other.inCents];
}

@end
