import UIKit

extension UITableView {
    
    /// Registers a cell class using its type as an identifier.
    public func register<T: AnyObject>(_ type: T.Type) {
        
        register(type, forCellReuseIdentifier: "\(type)")
    }
    
    /// Registers a cell class using its type as an identifier.
    public func dequeueReusableCell<T>() -> T? {
                
        return dequeueReusableCell(withIdentifier: "\(T.self)") as? T
    }
    
    /// Registers a cell class using its type as an identifier.
    public func dequeueReusableCell<T>(for indexPath: IndexPath) -> T? {
                
        return dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T
    }
    
    /// Adds a `UILabel` as a `backgroundView`.
    ///
    /// - Parameters:
    ///   - text: The text of the `UILabel` to be added.
    ///   - adjustSeparatorStyle: A flag indicating whether or not to adjust the `UITableView`'s `separatorStyle`.
    ///   If true, the `separatorStyle` will be set to `.none`.
    public func addEmptyListLabel(
        withText text: String,
        adjustsSeparatorStyle: Bool = true,
        reload: Bool = false
    ) {
        let label = UILabel(frame: bounds)
        label.text = text
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = label.font.withSize(28.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        backgroundView = label
        
        if adjustsSeparatorStyle {
           separatorStyle = .none
        }
        
        if reload {
            reloadData()
        }
    }
    
    /// Sets a `UITableView`'s `backgroundView` to `nil`.
    ///
    /// - Parameter adjustSeparatorStyle: A flag indicating whether or not to adjust the `UITableView`'s `separatorStyle`.
    /// If true, the `separatorStyle` will be set to `.singleLine`.
    public func removeEmptyListLabel(adjustsSeparatorStyle: Bool = true, reload: Bool = false) {
        backgroundView = nil
        
        if adjustsSeparatorStyle {
           separatorStyle = .singleLine
        }
        
        if reload {
            reloadData()
        }
    }
}
