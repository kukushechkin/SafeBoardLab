#import "NSDate+Equality.h"


@implementation NSDate (Equality)

- (BOOL)isToday {
    return [self isSameDayWith:[NSDate date]];
}

- (BOOL)isSameDayWith:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];

    const NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date];
    
    return [comp1 year] == [comp2 year] &&
        [comp1 month] == [comp2 month] &&
        [comp1 day] == [comp2 day];
}

@end
