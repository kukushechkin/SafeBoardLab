import UIKit

final class TodoTableController: UITableViewController {
    
    // MARK: - Private Types
    
    private enum TableMode {
        case connecting
        case connected
    }
    
    // MARK: - Private Properties
    
    private let todoManager: ToDoManager = ToDoManager()
    private var currentMode: TableMode = .connecting {
        didSet {
            actualizeNavigationItem(due: currentMode)
        }
    }
    
    private var todoItems = [ToDoItemProtocol]()
    
    // MARK: - Outlets && Actions
    
    @IBOutlet private var progressView: UIView!
    @IBOutlet private var addItemButton: UIBarButtonItem!
    
    @IBAction func didTappedAddAction(_ sender: Any) {
        presentAddItemController()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actualizeNavigationItem(due: currentMode)
        configureTableView()
        
        todoManager.asyncConnect(completionHandler: { [weak self] success in
            if success {
                self?.currentMode = .connected
                self?.updateToDoItems()
            }
        })
    }
    
    // MARK: - UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem") as? ToDoItemCell else {
            return UITableViewCell()
        }
        
        cell.fill(with: todoItems[indexPath.row])
        return cell
    }
    
    // MARK: - Private Methods
    
    private func actualizeNavigationItem(due mode: TableMode) {
        switch mode {
        case .connecting:
            navigationItem.titleView = progressView
            navigationItem.rightBarButtonItem = nil
            
        case .connected:
            navigationItem.titleView = nil
            navigationItem.rightBarButtonItem = addItemButton
        }
    }
    
    private func updateToDoItems() {
        todoItems = todoManager.items()
        tableView.reloadData()
    }
    
}

extension TodoTableController {
    
    private func presentAddItemController() {
        let alertController = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Title"
            textField.becomeFirstResponder()
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Description"
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            let title = alertController.textFields?[0].text
            let description = alertController.textFields?[1].text
            
            self?.addToDoItem(title: title, description: description)
            self?.updateToDoItems()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func addToDoItem(title: String?, description: String?) {
        let todoItem = ToDoItem(identifier: nil, title: title, text: description, date: Date())
        todoManager.addItem(todoItem)
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
    }
    
}
