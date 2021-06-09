import Foundation

extension String {
    
    /// A convenience variable taht returns `nil` if the value of `self` is an empty `String`.
    public var nilIfEmpty: String? { isEmpty ? nil : self }

    /// Checks whether or not a `String` contains a `Collection` of `String`s.
    ///
    /// - Parameter elements: A list of strings to search for in a given `String`.
    ///
    /// - Returns: A `Bool` value representing the outcome of the check.
    public func contains(elements: [String]) -> Bool {
        for element in elements {
            guard contains(element) else { return false }
        }
        
        return true
    }
}
