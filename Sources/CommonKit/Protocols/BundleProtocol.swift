import Foundation

/// Convenience methods on a `Bundle` object.
public protocol BundleProtocol {

    /// Performs a localization lookup for the given `key`.
    ///
    /// - Returns: A localized string extracted from the bundle.
    /// If a value does not exist, the key is returned instead.
    func localizedString(forKey key: String, comment: String?) -> String
    
    /// Creates `Data` from a given asset.
    ///
    /// - Parameter name: The name of the asset.
    ///
    /// - Returns: `Data` if the asset is found and can be transformed, `nil` otherwise.
    func data(forAssetNamed name: String) -> Data?
    
    /// Locates a value of a specified type in the `Bundle`'s plist file.
    ///
    /// - Parameters:
    ///   - key: The key of the value.
    ///   - name: The name of the plist file.
    ///
    /// - Returns: The specified value, if it exists for the key, `nil` otherwise.
    func value<T>(forKey key: String, inPlistNamed name: String) -> T?
    
    /// Locates and parses a plist file into a `Dictionary` of `[String: Any]` if it exists.
    ///
    /// - Parameter name: The name of the plist file.
    ///
    /// - Returns: A `Dictionary` containing the keys and values of the plist file if it exists,
    /// `nil` otherwise.
    func plist(named name: String) throws -> [String: Any]
}
