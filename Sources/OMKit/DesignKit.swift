//
//  File.swift
//  
//
//  Created by John Knowles on 8/12/24.
//

import SwiftUI


public enum OMHeading {
    public static let size = CGFloat(36)
    public static let color = Color.primary
}

public enum OMSubheading {
    public static let size = CGFloat(28)
    public static let color = Color.primary
}

public enum OMTitle {
    public static let size = CGFloat(21)
    public static let vPadding = CGFloat(6)
    public static let lineSpacing = CGFloat(1)
    public static let color = Color(UIColor.label)
    public static let secondaryColor = Color(UIColor.secondaryLabel)
}


public enum OMFootnote {
    public static let size = CGFloat(13)
    public static let color = Color(UIColor.systemGray3)
}

public enum OMSubtitle {
    public static let size = CGFloat(16)
    public static let vPadding = CGFloat(6)

    #if os(iOS)
    public static let color = Color(UIColor.systemGray)
    public static let secondaryColor = Color(UIColor.systemGray2)
    #endif
    #if os(macOS)
    public static let color = Color(NSColor.lightGray)
    public static let secondaryColor = Color(NSColor.darkGray)
    #endif
    
}


public enum OMShadow {
#if os(iOS)
public static let primaryColor = Color(UIColor.systemGray3)
#endif

}
public enum OMBackground {
    #if os(iOS)
    public static let systemColor = Color(UIColor.systemBackground)

    public static let primaryColor = Color(UIColor(dynamicProvider: { trait in
        trait.userInterfaceStyle == .dark ? .systemGray5 : .systemGray6
    }))
    public static let secondaryColor = Color(UIColor(dynamicProvider: { trait in
        trait.userInterfaceStyle == .dark ? .systemGray4 : .systemGray5
    }))
    public static let tertiaryColor = Color(UIColor(dynamicProvider: { trait in
        trait.userInterfaceStyle == .dark ? .systemGray3 : .systemGray4
    }))
    #endif
    #if os(macOS)
    public static let color = Color(NSColor.controlBackgroundColor)
    public static let secondaryColor = Color(NSColor.textBackgroundColor)
    #endif
}

public enum OMHeader {
    public static let hPadding = CGFloat(12)
    public static let tPadding = CGFloat(4)
    public static let bPadding = CGFloat(8)
    public static let spacing = CGFloat(8)
}

public enum OMFooter {
    public static let bPadding = CGFloat(8)
}
public enum OMButton {
    public static let size = CGFloat(28)
    public static let radius = CGFloat(12)
}

public enum OMIcon {
    public static let hPadding = CGFloat(9.71)
}









public struct TextFieldView: View {
    let text: Value<String>
    let updateText = Message<String>()
    @Binding var isFocused: Bool
    var placeholder: String = "Search..."
    var background: Color = OMBackground.primaryColor
    var tint: Color? = nil
    var foreground: Color? = nil
    var hPadding: CGFloat = 8
    var vPadding: CGFloat = 4
    var radius: CGFloat = 12
    var opacity: CGFloat = 0.12
    
    public init(text: Value<String>, 
                isFocused: Binding<Bool>,
                placeholder: String = "Search...",
                tint: Color? = nil,
                foreground: Color? = nil,
                background: Color = .gray2,
                opacity: CGFloat = 0.12,
                hPadding: CGFloat = 8,
                vPadding: CGFloat = 4,
                radius: CGFloat = 12
    ) {
        self.text = text
        self._isFocused = isFocused
        self.placeholder = placeholder
        self.__isFocused = __isFocused
        self.tint = tint
        self.foreground = foreground
        self.background = background
        self.hPadding = hPadding
        self.vPadding = vPadding
        self.radius = radius
        self.opacity = opacity
    }
    
    @FocusState var __isFocused: Bool
    
    func changeFocused(_ isFocused: Bool) {
        DispatchQueue.main.async {
            self.isFocused = isFocused
        }
    }
    
    public var body: some View {
        HStack(spacing: 2) {
            Button(action: { __isFocused = true}) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle((tint ?? background).opacity(0.5))
                    .font(Font.system(size: OMSubtitle.size, weight: .semibold))
            }
            OMTextField(text: text,
                        placeholder: placeholder,
                        size: OMTitle.size,
                        write: updateText)
                .foregroundStyle(foreground ?? background)
                .tint(tint ?? background)
                .focused($__isFocused)
                
            ButtonView(icon: "xmark.circle.fill", 
                       hPadding: 0,
                       vPadding: 0,
                       tint: isFocused ? tint ?? background : .clear,
                       action: cancel)
        }
        .padding(.horizontal, hPadding)
        .padding(.vertical, vPadding)
        .background(background.opacity(opacity))
        .clipShape(RoundedRectangle(cornerRadius: radius,
                                    style: .continuous))
        .onChange(of: __isFocused, 
                  perform: changeFocused)

    }
    
    
    func cancel() {
        if isFocused {
            updateText.send("")
            __isFocused = false
        } else {
            __isFocused = true
        }
    }
}


public struct ButtonView: View {
    let icon: String
    
    var size: CGFloat = OMButton.size
    var weight: Font.Weight = .semibold
    var hPadding: CGFloat = 8
    var vPadding: CGFloat = 8
    var tint: Color? = .blue
    var opacity: CGFloat = 0
    
    var disabled: Bool = false
    let action: () -> ()

    public init(icon: String,
         size: CGFloat = OMButton.size,
                weight: Font.Weight = .semibold,
         hPadding: CGFloat = 8,
         vPadding: CGFloat = 8,
                tint: Color? = .blue,
         opacity: CGFloat = 0,
         disabled: Bool = false,
         action: @escaping () -> Void) {
        self.icon = icon
        self.size = size
        self.weight = weight
        self.hPadding = hPadding
        self.vPadding = vPadding
        self.tint = tint
        self.opacity = opacity
        self.disabled = disabled
        self.action = action
    }
    
    
    
    public var body: some View {
        Button(action: action) {
                Image(systemName:  icon)
                .font(Font.system(size: size, weight: weight))
                .button(size: size,
                        hPadding: hPadding,
                        vPadding: vPadding,
                        opacity: opacity,
                        tint: tint)
        }
        .opacity(disabled ? 0.4 : 1)
        .disabled(disabled)
    }
}

public struct MenuView: View {
    let icon: String
    
    var size: CGFloat = OMButton.size
    var weight: Font.Weight = .semibold
    var hPadding: CGFloat = 8
    var vPadding: CGFloat = 8
    var tint: Color? = .blue
    var opacity: CGFloat = 0
    
    let menu: UIMenu

    public init(icon: String,
         size: CGFloat = OMButton.size,
         weight: Font.Weight = .semibold,
         hPadding: CGFloat = 8,
         vPadding: CGFloat = 8,
         tint: Color = .blue,
        menu: UIMenu) {
        self.icon = icon
        self.size = size
        self.weight = weight
        self.vPadding = vPadding
        self.hPadding = hPadding
        self.tint = tint
        self.menu = menu
    }
   
    public  var body: some View {
        Image(systemName:  icon)
        .font(Font.system(size: size, weight: weight))
        .button(size: size,
                hPadding: hPadding,
                vPadding: vPadding,
                opacity: opacity,
                tint: tint)
        .menu(menu: menu)
    }
}


public struct CircleButtonView<S: ShapeStyle>: View {
    let icon: String
    var size: CGFloat = OMButton.size
    var weight: Font.Weight = .heavy
    var padding: CGFloat = 16
    var foregroundStyle: Color = .blue
    var fill: S?
    
    var _size: CGFloat {
        UIFont.systemFont(ofSize: size).lineHeight
    }
        
    var shadow: Color {
        if let fill = fill as? Color {
            return fill.opacity(0.4)
        }
        
        return OMShadow.primaryColor.opacity(0.4)
    }
    let action: () -> ()

    public init(icon: String,
         size: CGFloat = OMButton.size,
         weight: Font.Weight = .heavy,
         padding: CGFloat = 16,
                foregroundStyle: Color = .blue,
            fill: S? = Material.thick,
         action: @escaping () -> Void) {
        self.icon = icon
        self.size = size
        self.weight = weight
        self.padding = padding
        self.foregroundStyle = foregroundStyle
        self.fill = fill
        self.action = action
    }
    
    
    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundStyle(foregroundStyle)
                .font(Font.system(size: _size, weight: weight))
                .frame(width: _size, height: _size)
                .padding(padding)
                .background {
                    
                    Group {
                        if let fill {
                            Circle()
                                .fill(fill)
                                
                        }else {
                            Circle()
                                .fill(OMBackground.primaryColor)
                            
                        }
                    }
                    .shadow(color: shadow.opacity(0.3),
                            radius: 5,
                            y: 3)
                    
                }
        }
    }
}


import Defaults

public enum OMColor: Int, _DefaultsSerializable {
    
    case primary
    case veryDarkGray
    case darkGray
    case lightGray
    case darkBrown
    case lightBrown
    case darkCream
    case lightCream
    case yellow
    case orange
    case pink
    case red
    case blue
    case green
    case lightPurple
    case darkPurple
    
    public var color: Color {
        Color(uiColor)
    }
    
    public var uiColor: UIColor {
        switch self {
        case .primary: return UIColor.label
        case .veryDarkGray: return UIColor(red: 71 / 255, green: 70 / 255, blue: 68 / 255, alpha: 1)
        case .darkGray: return UIColor(red: 124 / 255, green: 125 / 255, blue: 128 / 255, alpha: 1)
        case .lightGray: return UIColor(red: 170 / 255, green: 171 / 255, blue: 177 / 255, alpha: 1)
            
        case .darkBrown: return UIColor(red: 133 / 255, green: 96 / 255, blue: 80 / 255, alpha: 1)
        case .lightBrown: return  UIColor(red: 193 / 255, green: 154 / 255, blue: 107 / 255, alpha: 1)
            
        case .darkCream: return  UIColor(red: 195 / 255, green: 176 / 255, blue: 145 / 255, alpha: 1)

        case .lightCream: return UIColor(red: 252 / 255, green: 229 / 255, blue: 192 / 255, alpha: 1)
            
            
        case .yellow: return UIColor(Color.yellow)
        case .orange: return UIColor(Color.orange)
        case .pink: return UIColor(red: 255 / 255, green: 105 / 255, blue: 180 / 255, alpha: 1)
        case .red: return UIColor(Color.red)
        case .blue: return UIColor(Color.blue)
        case .green: return UIColor(Color.green)
        case .lightPurple: return UIColor(red: 214 / 255, green: 180 / 255, blue: 252 / 255, alpha: 1)
        case .darkPurple: return UIColor(Color.darkPurple)
        }
    }
}

struct ColorView: View {
    let color: OMColor
    
    @Environment(\.colorScheme) var colorScheme
    var  body: some View {
        let color = Color(color.uiColor)
        HStack {
            color
            color.opacity(colorScheme.isDark ? 0.24 : 0.12)
            Image(systemName: "plus")
                .foregroundStyle(color)
                .font(Font.system(size: OMButton.size, weight: .semibold))
            Image(systemName: "checkmark.circle")
                .foregroundStyle(color)
                .font(Font.system(size: OMButton.size, weight: .semibold))
        }
//            .frame(height: 50)
            
    }
}

#Preview {
    VStack {
        ColorView(color: .primary)
                
        ColorView(color: .darkGray)
        ColorView(color: .lightGray)
        
        ColorView(color: .darkBrown)
        ColorView(color: .lightBrown)
        ColorView(color: .darkCream)
//        ColorView(color: .lightCream)
        ColorView(color: .lightPurple)
        ColorView(color: .yellow)
        ColorView(color: .orange)
        ColorView(color: .pink)
        ColorView(color: .red)
        ColorView(color: .blue)
        ColorView(color: .green)
        ColorView(color: .darkPurple)
        
        
        
    }
}
