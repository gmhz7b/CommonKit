import UIKit

extension UICollectionView {
    
    /// Registers a cell class using its type as an identifier.
    public func register<T: AnyObject>(_ type: T.Type)  {
        register(type, forCellWithReuseIdentifier: "\(type)")
    }
    
    /// Registers a cell class using its type as an identifier.
    public func dequeueReusableCell<T>(for indexPath: IndexPath) -> T? {
                
        return dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as? T
    }
    
    /// Dequeues a supplementary view using its type as an identifier.
    public func dequeueReusableSupplementaryView<T>(ofKind kind: String, for indexPath: IndexPath) -> T? {
        
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(T.self)", for: indexPath) as? T
    }
    
    /// Adds a `UILabel` as a background view.
    ///
    /// Basic implementation.
    public func addEmptyListLabel(withText text: String) {
        
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        let view = UIView()
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.constrain(to: view, padding: 16.0)
        
        backgroundView = view
    }
    
    
    /// Sets a `UICollectionView`'s `backgroundView` to `nil`.
    public func removeEmptyListLabel() {
        backgroundView = nil
    }
}
