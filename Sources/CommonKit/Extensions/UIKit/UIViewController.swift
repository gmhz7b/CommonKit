import UIKit

extension UIViewController {
    
    /// Adds a child viewcontroller.
    ///
    /// If a parent view is supplied, the child's view is added to it.
    /// Otherwise it is added to the parent viewcontroller's view.
    ///
    /// - Parameters:
    ///   - child: The child viewcontroller to be added.
    ///   - parentView: An optional parent view
    ///   - frame: An optional frame for the child's view.
    ///   - belowSubview: A view that wehn specified, the child viewcontroller's view is inserted beneath it.
    public func add(_ child: UIViewController, parentView: UIView? = nil, frame: CGRect? = nil, belowSubview: UIView? = nil) {
        addChild(child)
        
        if let frame = frame { child.view.frame = frame }
        
        if let parentView = parentView, let belowSubview = belowSubview {
            parentView.insertSubview(child.view, belowSubview: belowSubview)
        } else {
            (parentView ?? view).addSubview(child.view)
        }
        
        child.didMove(toParent: self)
    }
    
    /// Adds a child viewcontroller with full screen constraints.
    /// 
    /// - Parameter child: The child viewcontroller to be added.
    public func addFullscreen(_ child: UIViewController) {
        add(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.constrain(to: view)
    }
    
    /// Removes `self` as a child viewcontroller.
    public func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    /// A convenience method for presenting a single action `UIAlert`.
    /// 
    /// - Parameters:
    ///   - alerTitle: The title of the alert. Should be short and sweet.
    ///   - message: The body of the alert. Supply an empty `String` if only a title is necessary.
    ///   - actionTitle: The text of the button displayed with the alert.
    ///   - completion: A closure called once the user taps the alert's action button.
    public func presentSingleActionAlert(
        alerTitle: String,
        message: String,
        actionTitle: String,
        completion: (() -> ())? = nil
    ) {
        let alert = UIAlertController(title: alerTitle, message: message, preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(title: actionTitle, style: .default) { _ in completion?() }
        )
        
        present(alert, animated: true, completion: nil)
    }
}
