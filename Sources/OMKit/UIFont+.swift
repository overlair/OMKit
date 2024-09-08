//
//  File.swift
//  
//
//  Created by John Knowles on 7/28/24.
//

import Foundation

#if os(iOS)
import UIKit
@available(iOS 13.0, *)
public extension UIFont {
    
    var bold: UIFont { return withWeight(.bold) }
    var heavy: UIFont { return withWeight(.heavy) }
    var black: UIFont { return withWeight(.black) }
    var semibold: UIFont { return withWeight(.semibold) }
    var medium: UIFont { return withWeight(.medium) }
    
    var light: UIFont { return withWeight(.light) }
    var ultraLight: UIFont { return withWeight(.ultraLight) }
    var thin: UIFont { return withWeight(.thin) }

    var round: UIFont { return withDesign(.rounded) }
    var regular: UIFont { return withDesign(.default) }
    var mono: UIFont { return withDesign(.monospaced) }
    var serif: UIFont { return withDesign(.serif) }

    
   

    public func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]

        traits[.weight] = weight

        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName

        let descriptor = UIFontDescriptor(fontAttributes: attributes)

        return UIFont(descriptor: descriptor, size: pointSize)
    }
    
    public func withDesign(_ design: UIFontDescriptor.SystemDesign) -> UIFont {
        if let descriptor = fontDescriptor.withDesign(design) {
            return UIFont(descriptor: descriptor, size: pointSize)
        }
        return self
    }
    
}
#endif
