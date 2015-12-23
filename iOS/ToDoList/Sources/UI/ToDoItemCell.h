#import <UIKit/UIKit.h>
#import "ToDoItem.h"


@interface ToDoItemCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *identifierLabel;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

- (void)fillWithToDoItem:(id<ToDoItem>)todoItem;

@end
