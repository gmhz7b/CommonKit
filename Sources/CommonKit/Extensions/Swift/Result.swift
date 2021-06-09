import Foundation

extension Result where Failure == Error {
    
    /// Creates a new `Result` object by applying a `throwing` transform on its own `Success` case.
    public func mapThrowing<NewSuccess>(_ transform: (Success) throws -> NewSuccess) -> Result<NewSuccess, Failure> {
        
        return Result<NewSuccess, Failure> {
            let success = try get()
            
            return try transform(success)
        }
    }
}
