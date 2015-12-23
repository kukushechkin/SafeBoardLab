#import "ToDoTableViewController.h"
#import "ToDoManager.h"

typedef NS_ENUM(NSUInteger, ToDoTableViewControllerMode) {
    kToDoTableViewControllerMode_List,
    kToDoTableViewControllerMode_Connecting
};


@interface ToDoTableViewController () <ToDoManagerDelegate>

@property (nonatomic, strong) IBOutlet UIView *progressView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *addItemButton;

@property (nonatomic, assign) ToDoTableViewControllerMode mode;

@property (nonatomic, readonly, strong) ToDoManager *todoManager;
@property (nonatomic, strong) NSArray<id<ToDoItem>> *todoItems;

@end

@implementation ToDoTableViewController

#pragma mark - Properties

@synthesize mode = _mode;

- (void)setMode:(ToDoTableViewControllerMode)mode {
    if (_mode != mode) {
        _mode = mode;
        [self updateNavigationItemForMode:mode];
    }
}

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        _todoManager = [ToDoManager new];
    }
    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mode = kToDoTableViewControllerMode_Connecting;
    
    ToDoTableViewController * __weak weakSelf = self;
    [self.todoManager asyncConnectWithCompletionHandler:^(BOOL success) {
        weakSelf.mode = kToDoTableViewControllerMode_List;
        [weakSelf reloadToDoItems];
    }];
}

#pragma mark - Actions

- (IBAction)didClickAddItemButton:(id)sender {
    [self presentAddItemController];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todoItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<ToDoItem> todoItem = self.todoItems[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoItem" forIndexPath:indexPath];
    cell.textLabel.text = todoItem.title;
    cell.detailTextLabel.text = todoItem.text;
    return cell;
}

#pragma mark - ToDoManagerDelegate

- (void)todoManager:(ToDoManager *)todoManager didAddItem:(id<ToDoItem>)item {
    // TODO: reload table view
}

- (void)todoManager:(ToDoManager *)todoManager didUpdateItem:(id<ToDoItem>)item {
    // TODO: reload table view
}

- (void)todoManager:(ToDoManager *)todoManager didDeleteItemWithIdentifier:(NSString *)identifier {
    // TODO: reload table view
}

#pragma mark - Private

- (void)updateNavigationItemForMode:(ToDoTableViewControllerMode)mode {
    UINavigationItem *navigationItem = [self navigationItem];
    switch (mode) {
        case kToDoTableViewControllerMode_List:
            navigationItem.titleView = nil;
            navigationItem.rightBarButtonItem = self.addItemButton;
            break;
        case kToDoTableViewControllerMode_Connecting:
            navigationItem.titleView = self.progressView;
            navigationItem.rightBarButtonItem = nil;
            break;
        default:
            // Do nothing
            break;
    }
}

- (void)reloadToDoItems {
    self.todoItems = [self.todoManager items];
    [self.tableView reloadData];
}

- (void)presentAddItemController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Item"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Title";
        [textField becomeFirstResponder];
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Description";
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          NSString *title = alertController.textFields[0].text;
                                                          NSString *text = alertController.textFields[1].text;
                                                          [self addToDoItemWithTitle:title text:text];
                                                          [self reloadToDoItems];
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:nil]];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

- (void)addToDoItemWithTitle:(NSString *)title text:(NSString *)text {
    id<ToDoItem> todoItem = [[ToDoItem alloc] initWithIdentifier:nil
                                                           title:title
                                                            text:text
                                                            date:[NSDate date]];
    [self.todoManager addItem:todoItem];
}

@end
