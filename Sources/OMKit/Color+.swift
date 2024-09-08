//
//  File.swift
//  
//
//  Created by John Knowles on 7/28/24.
//

import SwiftUI

#if os(macOS)
import AppKit
#endif

@available(iOS 13.0, *)
@available(macOS 10.15, *)
public extension Color {
    static let lightPink = Color(red: 255 / 255, green: 105 / 255, blue: 180 / 255)
    static let darkPurple = Color(red: 138 / 255, green: 43 / 255, blue: 226 / 255)
    static let darkBrown = Color(red: 157 / 255, green: 107 / 255, blue: 83 / 255)

#if os(iOS)
    static let background = Color(UIColor.systemBackground)
    static let gray1 = Color(UIColor.systemGray)
    static let gray2 = Color(UIColor.systemGray2)
    static let gray3 = Color(UIColor.systemGray3)
    static let gray4 = Color(UIColor.systemGray4)
    static let gray5 = Color(UIColor.systemGray5)
    static let gray6 = Color(UIColor.systemGray6)


#endif
#if os(macOS)
    static let background = Color(NSColor.windowBackgroundColor)
    static let gray1 = Color(NSColor.systemGray)
    static let gray2 = Color(NSColor.lightGray)
    static let gray3 = Color(NSColor.gray)
    static let gray4 = Color(NSColor.darkGray)
#endif
}


// Inspired by https://cocoacasts.com/from-hex-to-uicolor-and-back-in-swift
// Make Color codable. This includes support for transparency.
// See https://www.digitalocean.com/community/tutorials/css-hex-code-colors-alpha-values
@available(macOS 11, *)
@available(iOS 14.0, *)
extension Color: Codable {
    public init(hex: String) {
    let rgba = hex.toRGBA()
    
    self.init(.sRGB,
              red: Double(rgba.r),
              green: Double(rgba.g),
              blue: Double(rgba.b),
              opacity: Double(rgba.alpha))
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let hex = try container.decode(String.self)
    
    self.init(hex: hex)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(toHex)
  }
  
    public  var toHex: String? {
    return toHex()
  }
  
    public func toHex(alpha: Bool = false) -> String? {
        guard let components = UIColor(self).cgColor.components, components.count >= 3 else {
        print("FAILED TO COVERT COLOR TO HEX")
      return nil
    }
    
    let r = Float(components[0])
    let g = Float(components[1])
    let b = Float(components[2])
    var a = Float(1.0)
    
    if components.count >= 4 {
      a = Float(components[3])
    }
    
    if alpha {
      return String(format: "%02lX%02lX%02lX%02lX",
                    lroundf(r * 255),
                    lroundf(g * 255),
                    lroundf(b * 255),
                    lroundf(a * 255))
    }
    else {
      return String(format: "%02lX%02lX%02lX",
                    lroundf(r * 255),
                    lroundf(g * 255),
                    lroundf(b * 255))
    }
  }
}

extension String {
    public func toRGBA() -> (r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
    var hexSanitized = self.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
    
    var rgb: UInt64 = 0
    
    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 1.0
    
    let length = hexSanitized.count
    
    Scanner(string: hexSanitized).scanHexInt64(&rgb)
    
    if length == 6 {
      r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
      g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
      b = CGFloat(rgb & 0x0000FF) / 255.0
    }
    else if length == 8 {
      r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
      g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
      b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
      a = CGFloat(rgb & 0x000000FF) / 255.0
    }
    
    return (r, g, b, a)
  }
}

#if os(iOS)
extension UIColor {

    // Check if the color is light or dark, as defined by the injected lightness threshold.
    // Some people report that 0.7 is best. I suggest to find out for yourself.
    // A nil value is returned if the lightness couldn't be determined.
    public func isLight(threshold: Float = 0.5) -> Bool? {
        let originalCGColor = self.cgColor

        // Now we need to convert it to the RGB colorspace. UIColor.white / UIColor.black are greyscale and not RGB.
        // If you don't do this then you will crash when accessing components index 2 below when evaluating greyscale colors.
        let RGBCGColor = originalCGColor.converted(to: CGColorSpaceCreateDeviceRGB(), intent: .defaultIntent, options: nil)
        guard let components = RGBCGColor?.components else {
            return nil
        }
        guard components.count >= 3 else {
            return nil
        }

        let brightness = Float(((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000)
        return (brightness > threshold)
    }
    
    public var isLight: Bool {
          var white: CGFloat = 0
          getWhite(&white, alpha: nil)
          return white > 0.5
      }
}
#endif


public extension Color {
    public static func random() -> Color {
        [Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.purple, Color.pink].randomElement() ?? .blue
    }
}
