import UIKit

extension UIView {
    
    /// Constrains a view to another view.
    public func constrain(
        to view: UIView,
        leadingAnchorOverride: NSLayoutXAxisAnchor? = nil,
        trailingAnchorOverride: NSLayoutXAxisAnchor? = nil,
        topAnchorOverride: NSLayoutYAxisAnchor? = nil,
        bottomAnchorOverride: NSLayoutYAxisAnchor? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: leadingAnchorOverride ?? view.leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchorOverride ?? view.trailingAnchor),
            topAnchor.constraint(equalTo: topAnchorOverride ?? view.topAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchorOverride ?? view.bottomAnchor)
        ])
    }
    
    /// Constrains a view to a given view, applying an even padding around all of its edges.
    /// 
    /// - Parameters:
    ///   - view: The view that the calling view will be constrained to.
    ///   - padding: A margin that will be set on all sides of the constrained view.
    public func constrain(to view: UIView, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
}
