#import "ToDoItemCell.h"
#import "NSDate+Equality.h"


@implementation ToDoItemCell

- (void)fillWithToDoItem:(id<ToDoItem>)todoItem {
    self.identifierLabel.text = todoItem.identifier;
    self.titleLabel.text = todoItem.title;
    self.descriptionLabel.text = todoItem.text;
    self.dateLabel.text = [self formattedStringForDate:todoItem.date];
}

- (NSString *)formattedStringForDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    if ([date isToday]) {
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        dateFormatter.dateStyle = NSDateFormatterNoStyle;
    }
    else {
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
    }
    return [dateFormatter stringFromDate:date];
}

@end
