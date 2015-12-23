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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mode = kToDoTableViewControllerMode_Connecting;
    [self.todoManager asyncConnectWithCompletionHandler:^(BOOL success) {
        self.mode = kToDoTableViewControllerMode_List;
    }];
}

#pragma mark - Actions

- (IBAction)didClickAddItemButton:(id)sender {
    
}

#pragma mark - UI

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

- (void)presentAddItemController {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Item"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
}

#pragma mark - ToDoManagerDelegate

- (void)todoManager:(ToDoManager *)todoManager didAddItem:(id<ToDoItem>)item {
    
}

- (void)todoManager:(ToDoManager *)todoManager didUpdateItem:(id<ToDoItem>)item {
    
}

- (void)todoManager:(ToDoManager *)todoManager didDeleteItemWithIdentifier:(NSString *)identifier {
    
}

@end
