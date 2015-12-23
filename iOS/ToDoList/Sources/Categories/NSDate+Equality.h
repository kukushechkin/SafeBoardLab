#import <Foundation/Foundation.h>


@interface NSDate (Equality)

- (BOOL)isToday;
- (BOOL)isSameDayWith:(NSDate *)date;

@end
