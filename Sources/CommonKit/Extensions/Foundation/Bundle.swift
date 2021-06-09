import Foundation
import class UIKit.NSDataAsset

/// - SeeAlso: `BundleProtocol`.
extension Bundle: BundleProtocol {
    
    public func data(forAssetNamed name: String) -> Data? {
        
        return NSDataAsset(name: name, bundle: self)?.data
    }
    
    public func localizedString(forKey key: String, comment: String?) -> String {
        
        return NSLocalizedString(key, bundle: self, comment: comment ?? "")
    }
    
    public func value<T>(forKey key: String, inPlistNamed name: String) -> T? {
        
        return (try? self.plist(named: name))?[key] as? T
    }
    
    public func plist(named name: String) throws -> [String: Any] {
        let url = self.url(forResource: name, withExtension: "plist")!
        let data = try Data(contentsOf: url)
        
        return try PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] ?? [:]
    }
}
