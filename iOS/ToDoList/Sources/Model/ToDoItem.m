#import "ToDoItem.h"


@implementation ToDoItem

#pragma mark - Properties

@synthesize identifier = _identifier;
@synthesize title = _title;
@synthesize text = _text;
@synthesize date = _date;

#pragma mark - Initialization

- (instancetype)init {
    return [self initWithIdentifier:nil
                              title:nil
                               text:nil
                               date:nil];
}

- (instancetype)initWithIdentifier:(NSNumber *)identifier
                             title:(NSString *)title
                              text:(NSString *)text
                              date:(NSDate *)date {
    self = [super init];
    if (self != nil) {
        _identifier = identifier;
        _title = title;
        _text = text;
        _date = date;
    }
    return self;
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(nullable NSZone *)zone {
    ToDoItem *copiedObj = [[[self class] alloc] initWithIdentifier:self.identifier
                                                             title:self.title
                                                              text:self.text
                                                              date:self.date];
    return copiedObj;
}

@end
