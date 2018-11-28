import UIKit

final class ToDoItemCell: UITableViewCell {
    
    // MARK: - Private Prperties
    
    @IBOutlet private weak var identifierLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Internal Methods
    
    func fill(with todoItem: ToDoItemProtocol) {
        identifierLabel.text = todoItem.identifier
        titleLabel.text = todoItem.title
        descriptionLabel.text = todoItem.text
        dateLabel.text = formattedString(from: todoItem.date)
    }
    
    // MARK: - Private Methods
    
    private func formattedString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        let isTodayDate = (date as NSDate).isToday()
        
        dateFormatter.timeStyle = isTodayDate ? .short : .none
        dateFormatter.dateStyle = isTodayDate ? .none : .short
        
        return dateFormatter.string(from:date)
    }
    
}
