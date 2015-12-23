#import <Foundation/Foundation.h>


@protocol ToDoItem <NSObject, NSCopying>

@property (nonatomic, readonly, strong) NSString *identifier;
@property (nonatomic, readonly, strong) NSString *title;
@property (nonatomic, readonly, strong) NSString *text;
@property (nonatomic, readonly, strong) NSDate *date;

@end


@interface ToDoItem : NSObject<ToDoItem>

- (instancetype)initWithIdentifier:(NSString *)identifier
                             title:(NSString *)title
                              text:(NSString *)text
                              date:(NSDate *)date NS_DESIGNATED_INITIALIZER;

@end
