// The Swift Programming Language
// https://docs.swift.org/swift-book
import UIKit

public let separatorDecorationView = "separator"

public final class SeparatorFlowLayout: UICollectionViewFlowLayout {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        register(SeparatorView.self, forDecorationViewOfKind: separatorDecorationView)
//    }

    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect) ?? []
        let lineWidth = self.minimumLineSpacing

        var decorationAttributes: [UICollectionViewLayoutAttributes] = []

        // skip first cell
        for layoutAttribute in layoutAttributes where layoutAttribute.indexPath.item > 0 {
            let separatorAttribute = UICollectionViewLayoutAttributes(forDecorationViewOfKind: separatorDecorationView,
                                                                      with: layoutAttribute.indexPath)
            let cellFrame = layoutAttribute.frame
            separatorAttribute.frame = CGRect(x: cellFrame.origin.x,
                                              y: cellFrame.origin.y - lineWidth,
                                              width: cellFrame.size.width,
                                              height: lineWidth)
            separatorAttribute.zIndex = Int.max
            decorationAttributes.append(separatorAttribute)
        }

        return layoutAttributes + decorationAttributes
    }

}

public final class SeparatorView: UICollectionReusableView {
    public init(frame: CGRect, color: UIColor = .systemGray6) {
        super.init(frame: frame)
        self.backgroundColor = color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray5
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        self.frame = layoutAttributes.frame
    }
}






import CoreMedia

// MARK: Initialization
public extension CMTime {
    public func xd_time(preferredTimeScale: Int32 = 600) -> CMTime {
        return CMTime(seconds: seconds, preferredTimescale: preferredTimeScale)
    }
}

// MARK: Add
func += ( left: inout CMTime, right: CMTime) -> CMTime {
    left = left + right
    return left
}

// MARK: Subtract
func -= ( minuend: inout CMTime, subtrahend: CMTime) -> CMTime {
    minuend = minuend - subtrahend
    return minuend
}

// MARK: Multiply
func * (time: CMTime, multiplier: Int32) -> CMTime {
    return CMTimeMultiply(time, multiplier: multiplier).xd_time()
}
func * (multiplier: Int32, time: CMTime) -> CMTime {
    return CMTimeMultiply(time, multiplier: multiplier).xd_time()
}
func * (time: CMTime, multiplier: Float64) -> CMTime {
    return CMTimeMultiplyByFloat64(time, multiplier: multiplier).xd_time()
}
func * (time: CMTime, multiplier: Float) -> CMTime {
    return CMTimeMultiplyByFloat64(time, multiplier: Float64(multiplier)).xd_time()
}
func * (multiplier: Float64, time: CMTime) -> CMTime {
    return time * multiplier
}
func * (multiplier: Float, time: CMTime) -> CMTime {
    return time * multiplier
}
func *= ( time: inout CMTime, multiplier: Int32) -> CMTime {
    time = time * multiplier
    return time
}
func *= ( time: inout CMTime, multiplier: Float64) -> CMTime {
    time = time * multiplier
    return time
}
func *= ( time: inout CMTime, multiplier: Float) -> CMTime {
    time = time * multiplier
    return time
}

// MARK: Divide
func / (time: CMTime, divisor: Int32) -> CMTime {
    return CMTimeMultiplyByRatio(time, multiplier: 1, divisor: divisor).xd_time()
}
func /= ( time: inout CMTime, divisor: Int32) -> CMTime {
    time = time / divisor
    return time
}

// MARK: - Convenience methods
extension CMTime {
    //    func isNearlyEqualTo(time: CMTime, _ tolerance: CMTime=CMTimeMake(1,600)) -> Bool {
    //        let delta = CMTimeAbsoluteValue(self - time)
    //        return delta < tolerance
    //    }
    //    func isNearlyEqualTo(time: CMTime, _ tolerance: Float64=1.0/600) -> Bool {
    //        return isNearlyEqualTo(time, CMTime(seconds: tolerance))
    //    }
    //    func isNearlyEqualTo(time: CMTime, _ tolerance: Float=1.0/600) -> Bool {
    //        return isNearlyEqualTo(time, CMTime(seconds: tolerance))
    //    }
}

extension CMTime {
    var f: Float {
        return Float(self.f64)
    }
    var f64: Float64 {
        return CMTimeGetSeconds(self)
    }
}

func == (time: CMTime, seconds: Float64) -> Bool {
    return time == CMTime(seconds: seconds, preferredTimescale: time.timescale)
}
func == (time: CMTime, seconds: Float) -> Bool {
    return time == Float64(seconds)
}
func == (seconds: Float64, time: CMTime) -> Bool {
    return time == seconds
}
func == (seconds: Float, time: CMTime) -> Bool {
    return time == seconds
}
func != (time: CMTime, seconds: Float64) -> Bool {
    return !(time == seconds)
}
func != (time: CMTime, seconds: Float) -> Bool {
    return time != Float64(seconds)
}
func != (seconds: Float64, time: CMTime) -> Bool {
    return time != seconds
}
func != (seconds: Float, time: CMTime) -> Bool {
    return time != seconds
}

public func < (time: CMTime, seconds: Float64) -> Bool {
    return time < CMTime(seconds: seconds, preferredTimescale: time.timescale)
}
public func < (time: CMTime, seconds: Float) -> Bool {
    return time < Float64(seconds)
}
public func <= (time: CMTime, seconds: Float64) -> Bool {
    return time < seconds || time == seconds
}
public func <= (time: CMTime, seconds: Float) -> Bool {
    return time < seconds || time == seconds
}
public func < (seconds: Float64, time: CMTime) -> Bool {
    return CMTime(seconds: seconds, preferredTimescale: time.timescale) < time
}
public func < (seconds: Float, time: CMTime) -> Bool {
    return Float64(seconds) < time
}
public func <= (seconds: Float64, time: CMTime) -> Bool {
    return seconds < time || seconds == time
}
public func <= (seconds: Float, time: CMTime) -> Bool {
    return seconds < time || seconds == time
}

public func > (time: CMTime, seconds: Float64) -> Bool {
    return time > CMTime(seconds: seconds, preferredTimescale: time.timescale)
}
public func > (time: CMTime, seconds: Float) -> Bool {
    return time > Float64(seconds)
}
public func >= (time: CMTime, seconds: Float64) -> Bool {
    return time > seconds || time == seconds
}
public func >= (time: CMTime, seconds: Float) -> Bool {
    return time > seconds || time == seconds
}
public func > (seconds: Float64, time: CMTime) -> Bool {
    return CMTime(seconds: seconds, preferredTimescale: time.timescale) > time
}
public func > (seconds: Float, time: CMTime) -> Bool {
    return Float64(seconds) > time
}
public func >= (seconds: Float64, time: CMTime) -> Bool {
    return seconds > time || seconds == time
}
public func >= (seconds: Float, time: CMTime) -> Bool {
    return seconds > time || seconds == time
}

// MARK: - Debugging
extension CMTime: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        return "\(CMTimeGetSeconds(self))"
    }
    public var debugDescription: String {
        return String(describing: CMTimeCopyDescription(allocator: nil, time: self))
    }
}







import Foundation
import QuartzCore

public enum ElementType : String {
    case Invalid = ""
    case MoveToPoint = "move"
    case AddLineToPoint = "line"
    case AddQuadCurveToPoint = "quad"
    case AddCurveToPoint = "curve"
    case CloseSubpath = "close"
}

public struct Element {
    var type: ElementType = .Invalid
    var points: [CGPoint] = []
    
    
#if os(macOS)

    public func toDictionary() -> [String: AnyObject] {
        return [
            "type": type.rawValue,
            "pts": points.map({point in
                return [point.x, point.y]
            })
        ]
    }
    
    public func toJSON(options: NSJSONWritingOptions) throws -> NSData {
        let data = try NSJSONSerialization.dataWithJSONObject(toDictionary(), options: options)
        return data
    }
#endif
#if os(iOS)
    public func toDictionary() -> [String: Any] {
        return [
            "type": type.rawValue,
            "pts": points.map({point in
                return [point.x, point.y]
            })
        ]
    }
    
    public func toJSON(options: JSONSerialization.WritingOptions) throws -> Data {
        let data = try JSONSerialization.data(withJSONObject: toDictionary(), options: options)
        return data
    }
#endif

    public func endPoint() -> CGPoint {
        if points.count >= 1 {
            return points[0]
        }
        return CGPointZero
    }
    
    public func ctrlPoint1() -> CGPoint {
        if points.count >= 2 {
            return points[1]
        }
        return CGPointZero
    }
    
    public func ctrlPoint2() -> CGPoint {
        if points.count >= 3 {
            return points[2]
        }
        return CGPointZero
    }
}


extension Element {
    public init(dictionary: [String: AnyObject]) {
        if let type = dictionary["type"] as? String {
            if let ptype = ElementType(rawValue: type) {
                self.type = ptype
            }
        }
        if let points = dictionary["pts"] as? [[CGFloat]] {
            self.points = points.map({pt in
                return CGPointMake(pt[0], pt[1])
            })
        }
    }
}

public struct Path {
    var elements: [Element] = []
    
 
    #if os(macOS)
    public func toArray() -> [[String: AnyObject]] {
        return elements.map({el in
            return el.toDictionary()
        })
    }
    public func toJSON(options: NSJSONWritingOptions) throws -> NSData {
        let data = try NSJSONSerialization.dataWithJSONObject(toArray(), options: options)
        return data
    }
    #endif
#if os(iOS)
    public func toArray() -> [[String: Any]] {
        return elements.map({el in
            return el.toDictionary()
        })
    }
    
    public func toJSON(options: JSONSerialization.WritingOptions) throws -> Data {
        let data = try JSONSerialization.data(withJSONObject: toArray(), options: options)
        return data
    }
    
#endif

    public func CGPath() -> QuartzCore.CGPath {
        let path = CGMutablePath()
        for el in elements {
            let endPoint = el.endPoint()
            let ctrl1 = el.ctrlPoint1()
            let ctrl2 = el.ctrlPoint2()
            
            switch el.type {
            case .MoveToPoint:
                path.move(to: endPoint)
            case .AddLineToPoint:
                path.addLine(to: endPoint)
                break
            case .AddQuadCurveToPoint:
                path.addQuadCurve(to: endPoint, control: ctrl1)
                break
            case .AddCurveToPoint:
                path.addCurve(to: endPoint, control1: ctrl1, control2: ctrl2)
                break
            case .CloseSubpath:
                path.closeSubpath()
                break
            case .Invalid:
                break
            }
        }
        return path
    }
}


extension Path {
#if os(macOS)

    public init?(JSON: NSData) {
        do {
            let obj = try NSJSONSerialization.JSONObjectWithData(JSON, options: NSJSONReadingOptions(rawValue: 0))
            if let arr = obj as? [[String: AnyObject]] {
                self.elements = arr.map({ el in
                    return Element(dictionary: el)
                })
            }
        } catch {
            return nil
        }
    }
#endif
#if os(iOS)

    public init?(JSON: Data) {
        do {
            let obj = try JSONSerialization.jsonObject(with: JSON, options: JSONSerialization.ReadingOptions(rawValue: 0))
            if let arr = obj as? [[String: AnyObject]] {
                self.elements = arr.map({ el in
                    return Element(dictionary: el)
                })
            }
        } catch {
            return nil
        }
    }
#endif
    
    public init(data: [[String: AnyObject]]) {
        self.elements = data.map({ el in
            return Element(dictionary: el)
        })
    }
}

typealias PathApplier = @convention(block) (UnsafePointer<CGPathElement>) -> Void

func pathApply(path: CGPath!, block: @escaping PathApplier) {
    let callback: @convention(c) (UnsafeMutablePointer<Void>, UnsafePointer<CGPathElement>) -> Void = { (info, element) in
        let block = unsafeBitCast(info, to: PathApplier.self)
        block(element)
    }
    
    path.apply(info: unsafeBitCast(block, to: UnsafeMutablePointer<Void>.self), 
               function: unsafeBitCast(callback, to: CGPathApplierFunction.self))
}

public func extract(path: CGPath) -> Path {
    var pathData = Path(elements: [])
    pathApply(path: path) { element in
        switch (element.pointee.type) {
        case CGPathElementType.moveToPoint:
            pathData.elements.append(Element(type: .MoveToPoint, points: [
                element.pointee.points[0]
            ]))
        case .addLineToPoint:
            pathData.elements.append(Element(type: .AddLineToPoint, points: [
                element.pointee.points[0],
            ]))
        case .addQuadCurveToPoint:
            pathData.elements.append(Element(type: .AddQuadCurveToPoint, points: [
                element.pointee.points[1], // end pt
                element.pointee.points[0], // ctlpr pt
            ]))
        case .addCurveToPoint:
            pathData.elements.append(Element(type: .AddCurveToPoint, points: [
                element.pointee.points[2], // end pt
                element.pointee.points[0], // ctlpr 1
                element.pointee.points[1], // ctlpr 2
            ]))
        case .closeSubpath:
            pathData.elements.append(Element(type: .CloseSubpath, points: []))
        }
    }
    return pathData
}

