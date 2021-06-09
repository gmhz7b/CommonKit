import Foundation
import Combine

extension Publisher {

    /// A method that merges `sink(receiveCompletion:receiveValue:)` into a single `Result` completion block.
    public func sink(completion: @escaping ((Result<Self.Output, Self.Failure>) -> ())) -> AnyCancellable {
        return sink(
            receiveCompletion: {
                guard case .failure(let error) = $0 else {
                    return
                }
                
                completion(.failure(error))
            },
            receiveValue: {
                completion(.success($0))
            }
        )
    }
}
