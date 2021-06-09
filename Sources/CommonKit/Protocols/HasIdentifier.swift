import Foundation

/// A `protocol` descibing an object that *has* an `identifier` property.
@objc public protocol HasIdentifier {
    
    /// A `String` value used to uniquely identify the object.
    @objc var identifier: String { get }
}
