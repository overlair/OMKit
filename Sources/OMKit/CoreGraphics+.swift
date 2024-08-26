//
//  File.swift
//  
//
//  Created by John Knowles on 7/28/24.
//

import CoreGraphics
import Accelerate
import  SwiftUI

@inline(__always)
public func lerp<V: BinaryFloatingPoint, T: BinaryFloatingPoint>(_ v0: V, _ v1: V, _ t: T) -> V {
    return v0 + V(t) * (v1 - v0)
}

@inline(__always)
public func lerp<T: BinaryFloatingPoint>(_ v0: CGSize, _ v1: CGSize, _ t: T) -> CGSize {
    return CGSize(
        width: lerp(v0.width, v1.width, t),
        height: lerp(v0.height, v1.height, t)
    )
}


@inline(__always)
public func lerp<T: BinaryFloatingPoint>(_ v0: CGPoint, _ v1: CGPoint, _ t: T) -> CGPoint {
    return CGPoint(
        x: lerp(v0.x, v1.x, t),
        y: lerp(v0.y, v1.y, t)
    )
}

public extension CGFloat {
    public var formatted: String {
        let size = NSNumber(value: Float(self))
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 0
        return formatter.string(from: size) ?? "\(Int(truncating: size))"
    }
    
    public func lerping(to point: CGFloat, at rate: CGFloat) -> CGFloat {
       lerp(self, point, rate)
    }
}


public extension CGPoint {
    public func translatedBy(_ size: CGSize) -> CGPoint {
        return CGPoint(x: self.x + size.width,
                       y: self.y + size.height)
    }
    
    public func translatedBy(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x,
                       y: self.y + y)
      }
    
    public func lerping(to point: CGPoint, at rate: CGFloat) -> CGPoint {
        let x = lerp(point.x, self.x, rate)
        let y = lerp(point.y, self.y, rate)
        return CGPoint(x: x, y: y)
    }

}

public extension CGPoint {
    public func vector() -> CGVector {
        .init(dx: self.x, dy: self.y)
    }
    
    public func rect(of size: CGSize) -> CGRect {
        let origin = self.translatedBy(x: -size.width / 2.0,
                                       y: -size.height / 2.0)
        return CGRect(origin: origin, size: size)
    }
    
    public func transformCoordinates(_ canvas: CGSize, _ offset: CGSize, _ scale: CGFloat) -> CGPoint {
        self
            .alignCenterInCanvas(canvas)
            .scaledFrom(scale)
            .translatedBy(offset * -1)
    }
    
    public func alignCenterInParent(_ parent: CGSize) -> CGPoint {
       let dx = parent.width / 2.0
       let dy = parent.height / 2.0
       return self.applying(.init(translationX: dx, y: dy))
   }
    
    public func alignCenterInCanvas(_ parent: CGSize) -> CGPoint {
        let dx = -(parent.width / 2.0)
        let dy = -(parent.height / 2.0)
        return self.applying(.init(translationX: dx, y: dy))
    }
    

    
    
    public func alignCenterInCanvas(_ parent: CGRect) -> CGPoint {
        let dx = -(parent.width / 2.0)
        let dy = -(parent.height / 2.0)
        return self.applying(.init(translationX: dx, y: dy))
    }
    
    public func alignToScreen(_ parent: CGSize) -> CGPoint {
        let dx = (parent.width / 2.0)
        let dy = (parent.height / 2.0)
        return self.applying(.init(translationX: dx, y: dy))
    }


    
    
    public func getAsUnit(_ canvas: CGSize) -> CGPoint {
        let x = self.x / canvas.width
        let y = self.y / canvas.height
        return CGPoint(x: x, y: y)
    }
    
    public func scaledFrom(_ factor: CGFloat) -> CGPoint {
      return self.applying(.init(scaleX: factor, y: factor))
  }
    

 }

public extension CGRect {
    public func scaledFrom(_ factor: CGFloat) -> CGRect {
        self.applying(.init(scaleX: factor, y: factor))
    }
    
  
    public func centerScale(by factor: CGFloat) -> CGRect {
        let newWidth = self.width * factor
        let newHeight = self.height * factor
        let newRect = self.translatedBy(x: -(newWidth - self.width) / 2.0,
                                        y: -(newHeight - self.height) / 2.0)
        return newRect.scaledFrom(factor)
    }
    
    public func translatedBy(x: CGFloat, y: CGFloat) -> CGRect {
        self.applying(.init(translationX: x, y: y))
    }
    
    public func alignCenterInCanvas(_ canvas: CGSize) -> CGRect {
        self.translatedBy(x:  -canvas.width / 2.0, y:  -canvas.height / 2.0)
    }
    
}

public extension CGPoint {
    
    public static func +(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    public static func +(_ lhs: CGPoint, _ rhs: CGSize) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
    }
    
    public static func -(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    public static func -(_ lhs: CGPoint, _ rhs: CGSize) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.width, y: lhs.y - rhs.height)
    }
    
    public static func *(_ lhs: CGPoint, _ rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    public static func *(_ lhs: CGFloat, _ rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs * rhs.x, y: lhs * rhs.y)
    }
    
    public static func *(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y )
    }
    
    public static func /(_ lhs: CGPoint, _ rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
    
    
    public func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - x), 2) + pow((point.y - y), 2))
    }
    
    
    public func translation(from point: CGPoint) -> CGSize {
        return CGSize(width: self.x - point.x, height: self.y - point.y)
    }
    
    
    public func magnitude() -> CGFloat {
        return sqrt(pow(x, 2) + pow(y, 2))
    }
    
    public func getPointOnCircle(radius: CGFloat, radian: CGFloat) -> CGPoint {
        let x = self.x + radius * cos(radian)
        let y = self.y + radius * sin(radian)
        
        return CGPoint(x: x, y: y)
    }
    
    public func getRadianFromCenter(container: CGRect) -> CGFloat {
        self.getRadian(pointOnCircle: CGPoint(x: container.midX, y: container.midY))
    }
    
    public func getRadian(pointOnCircle: CGPoint) -> CGFloat {
        let originX = pointOnCircle.x - self.x
        let originY = pointOnCircle.y - self.y
        var radian = atan2(originY, originX)
        while radian < 0 {
            radian += CGFloat(2 * Double.pi)
        }
        return radian
    }
    
//    func getPolarPoint(from origin: CGPoint = CGPoint.zero) -> PolarPoint {
//        let deltaX = self.x - origin.x
//        let deltaY = self.y - origin.y
//        let radians = -1 * atan2(deltaY, deltaX)
//        let degrees = radians * (180.0 / CGFloat.pi)
//        let distance = self.distance(to: origin)
//
//        guard degrees < 0 else {
//            return PolarPoint(degrees: degrees, distance: distance)
//        }
//        return PolarPoint(degrees: degrees + 360.0, distance: distance)
//    }
}

extension CGPoint {
    public func offsetFrom(_ point: CGPoint) -> CGSize {
        CGSize(width: self.x - point.x, height: self.y - point.y)
    }
    
    public func size() -> CGSize {
        CGSize(width: self.x, height: self.y)

    }
}



extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
 
extension CGSize: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(width)
        hasher.combine(height)
    }
}


extension CGSize {
    public func max(_ size: CGSize) -> CGSize {
        CGSize(width: Swift.max(self.width,  size.width),
               height: Swift.max(self.height,  size.height))
    }
    public func point() -> CGPoint {
        CGPoint(x: self.width, y: self.height)
    }
    
    public func scaledDownTo(_ factor: CGFloat) -> CGSize {
     return CGSize(width: width/factor, height: height/factor)
   }

    public var length: CGFloat {
    return sqrt(pow(width, 2) + pow(height, 2))
  }

    public var inverted: CGSize {
    return CGSize(width: -width, height: -height)
  }

    public  static func +(_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
        
    }
    
    public  static func +(_ lhs: CGSize, _ rhs: CGPoint) -> CGSize {
        return CGSize(width: lhs.width + rhs.x, height: lhs.height + rhs.y)
        
    }
    
    public  static func -(_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
        
    }
    public  static func *(_ lhs: CGSize, _ rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
        
    }
}

extension CGSize {
    public func distance(_ size: CGSize) -> CGFloat {
        sqrt(pow(self.width - size.width, 2) + pow(self.height - size.height, 2))
    }
    
    
    public  static func +(_ lhs: CGSize, _ rhs: CGRect) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
        
    }
    
    public  static func /(_ lhs: CGSize, _ rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width / rhs, height: lhs.height / rhs )
    }
    
    public func positive() -> CGSize {
        CGSize(width: abs(self.width),
               height: abs(self.height))
    }
    
}


extension CGSize {
    public  mutating func lerp(to value: CGSize, at rate: CGFloat = 0.7) {
        self = self * rate + value * (1 - rate)
    }
    
    public func lerping(_ value: CGSize, at rate: CGFloat = 0.7) -> CGSize {
         self * rate + value * (1 - rate)
    }
    
    public var zeroWidth: CGSize {
        CGSize(width:  0, height: self.height)
    }
    
    public var zeroHeight: CGSize {
        CGSize(width:  self.width, height: 0)
    }
    
    public func scaledX(_ scale: Double) -> CGSize {
        CGSize(width:  self.width * scale, height: self.height)
    }
    
    public func scaledY(_ scale: Double) -> CGSize {
        CGSize(width:  self.width,
               height: self.height * scale)
    }
    
    public func power(_ power: CGFloat) -> CGSize {
        CGSize(width: pow(self.width, power),
               height: pow(self.height, power))

    }
}


extension CGPoint {
    public func distance(from point: CGPoint) -> CGFloat {
        return sqrt(pow((point.x - x), 2) + pow((point.y - y), 2))
    }
    

}


public extension CGSize {
  
    
    public  static func *(_ lhs: CGFloat, _ rhs: CGSize) -> CGSize {
        return CGSize(width: lhs * rhs.width ,
                      height: lhs * rhs.height)
        
    }
    public  static func /(_ lhs: CGSize, _ rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width / rhs.width,
                      height: lhs.height / rhs.height)
        
    }

    
    public func min(_ min: CGSize) -> CGSize {
        CGSize(width: Swift.min(self.width, min.width),
               height: Swift.min(self.height, min.height))
    }
    
    
    public func magnitude() -> CGFloat {
        sqrt(pow(self.width, 2) + pow(self.height, 2))
    }
}



import CoreGraphics

public extension CGRect {
    public func aspectFit(in rect: CGRect) -> CGRect {
        let size = self.size.aspectFit(in: rect.size)
        let x = rect.origin.x + (rect.size.width - size.width) / 2
        let y = rect.origin.y + (rect.size.height - size.height) / 2
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
    
    public func aspectFill(in rect: CGRect) -> CGRect {
        let size = self.size.aspectFill(in: rect.size)
        let x = rect.origin.x + (rect.size.width - size.width) / 2
        let y = rect.origin.y + (rect.size.height - size.height) / 2
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}

public extension CGSize {
    public func aspectFit(in size: CGSize) -> CGSize {
        var aspectFitSize = size
        let widthRatio = size.width / width
        let heightRatio = size.height / height
        if(heightRatio < widthRatio) {
            aspectFitSize.width = round(heightRatio * width)
        } else if(widthRatio < heightRatio) {
            aspectFitSize.height = round(widthRatio * height)
        }
        return aspectFitSize
    }
    
    public func aspectFill(in size: CGSize) -> CGSize {
        var aspectFillSize = size
        let widthRatio = size.width / width
        let heightRatio = size.height / height
        if(heightRatio > widthRatio) {
            aspectFillSize.width = heightRatio * width
        } else if(widthRatio > heightRatio) {
            aspectFillSize.height = widthRatio * height
        }
        return aspectFillSize
    }
}

public extension CGAffineTransform {
    public static func transform(by sourceRect: CGRect, aspectFitInRect fitTargetRect: CGRect) -> CGAffineTransform {
        let fitRect = sourceRect.aspectFit(in: fitTargetRect)
        let xRatio = fitRect.size.width / sourceRect.size.width
        let yRatio = fitRect.size.height / sourceRect.size.height
        return CGAffineTransform(translationX: fitRect.origin.x - sourceRect.origin.x * xRatio, y: fitRect.origin.y - sourceRect.origin.y * yRatio).scaledBy(x: xRatio, y: yRatio)
    }
    
    public static func transform(by size: CGSize, aspectFitInSize fitSize: CGSize) -> CGAffineTransform {
        let sourceRect = CGRect(origin: .zero, size: size)
        let fitTargetRect = CGRect(origin: .zero, size: fitSize)
        return transform(by: sourceRect, aspectFitInRect: fitTargetRect)
    }
    
    public static func transform(by sourceRect: CGRect, aspectFillRect fillTargetRect: CGRect) -> CGAffineTransform {
        let fillRect = sourceRect.aspectFill(in: fillTargetRect)
        let xRatio = fillRect.size.width / sourceRect.size.width
        let yRatio = fillRect.size.height / sourceRect.size.height
        return CGAffineTransform(translationX: fillRect.origin.x - sourceRect.origin.x * xRatio, y: fillRect.origin.y - sourceRect.origin.y * yRatio).scaledBy(x: xRatio, y: yRatio)
    }
    
    public static func transform(by size: CGSize, aspectFillSize fillSize: CGSize) -> CGAffineTransform {
        let sourceRect = CGRect(origin: .zero, size: size)
        let fillTargetRect = CGRect(origin: .zero, size: fillSize)
        return transform(by: sourceRect, aspectFillRect: fillTargetRect)
    }
}

public extension CGAffineTransform {
    public func rotationRadians() -> CGFloat {
        return atan2(b, a)
    }
    
    public  func translation() -> CGPoint {
        return CGPoint(x: tx, y: ty)
    }
    
    public func scaleXY() -> CGPoint {
        let scalex = sqrt(a * a + c * c)
        let scaley = sqrt(d * d + b * b)
        return CGPoint(x: scalex, y: scaley)
    }
}
