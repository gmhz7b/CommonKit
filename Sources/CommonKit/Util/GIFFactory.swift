import UIKit

public struct GIFFactory {
    
    public init() {}
    
    /// Creates a __GIF__ of `UIImages` from `Data`.
    ///
    /// - Parameter data: The `Data` to be parsed.
    ///
    /// - Returns: A `UIImage` representation of the GIF
    /// data if one can be created, `nil` otherwise.
    public func gif(from data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            return nil
        }
        
        let count = CGImageSourceGetCount(source)
        
        let metadata = Array(0..<count)
            .reduce(into: (images: [CGImage](), delays: [Int]())) { result, index in
                CGImageSourceCreateImageAtIndex(source, index, nil).map { result.images.append($0) }
                
                result.delays.append(millisecondsDelay(at: index, fromSource: source))
            }
        
        let gcd = greatestCommonDenominator(using: metadata.delays)
        
        let frames = Array(0..<count)
            .reduce(into: [UIImage]()) { result, index in
                
                let frame = UIImage(cgImage: metadata.images[index])
                let count = Int(metadata.delays[index] / gcd)
                
                result.append(contentsOf: Array(repeating: frame, count: count))
            }
        
        let durationInSeconds = Double(metadata.delays.reduce(0, +)) / 1000.0

        return UIImage.animatedImage(with: frames, duration: durationInSeconds)
    }
}

extension GIFFactory {
    
    private func millisecondsDelay(at index: Int, fromSource source: CGImageSource!) -> Int {
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = bitCast(using: cfProperties, value: kCGImagePropertyGIFDictionary)
        
        let gifUnclampedObject: AnyObject = bitCast(using: gifProperties, value: kCGImagePropertyGIFUnclampedDelayTime)
        let gifDelayObject: AnyObject = bitCast(using: gifProperties, value: kCGImagePropertyGIFDelayTime)
        
        let delayObject = gifUnclampedObject.doubleValue == 0 ? gifDelayObject : gifUnclampedObject
        
        //swiftlint:disable:next force_cast
        let delay = max(0.1, delayObject as! Double) * 1000.0
        
        return Int(delay)
    }
    
    private func bitCast<T>(using dictionary: CFDictionary?, value: CFString) -> T {
        
        return unsafeBitCast(
            CFDictionaryGetValue(
                dictionary,
                Unmanaged.passUnretained(value).toOpaque()
            ),
            to: T.self
        )
    }
}

extension GIFFactory {
    
    private func greatestCommonDenominator(using array: [Int]) -> Int {
        
        return array.isEmpty ? 1 : array.reduce(array[0]) { greatestCommonDenominator(between: $1, and: $0) }
    }
    
    private func greatestCommonDenominator(between lhs: Int?, and rhs: Int?) -> Int {
        switch (lhs, rhs) {
        case (.none, .none):
            return 0
            
        case (.none, .some(let value)):
            return value
            
        case (.some(let value), .none):
            return value
            
        case (.some(let lhsValue), .some(let rhsValue)):
            var maximum = max(lhsValue, rhsValue)
            var minimum = min(lhsValue, rhsValue)
            
            var remainder: Int = -1 // Default value
            while true {
                remainder = maximum % minimum
                
                guard remainder != 0 else {
                    return minimum
                }
                
                maximum = minimum
                minimum = remainder
            }
        }
    }
}
