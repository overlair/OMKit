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









struct TextFieldView: View {
    let text: Value<String>
    @Binding var isFocused: Bool
    var placeholder: String = "Search..."

    @FocusState var __isFocused: Bool
    
    func changeFocused(_ isFocused: Bool) {
        DispatchQueue.main.async {
            self.isFocused = isFocused
        }
    }
    var body: some View {
            HStack(spacing: 2) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(OMSubtitle.secondaryColor)
                    .font(Font.system(size: OMSubtitle.size, weight: .semibold))
                OMTextField(text: text, placeholder: placeholder, size: OMTitle.size)
                    .focused($__isFocused)
                    .onChange(of: __isFocused, perform: changeFocused)
            }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(OMBackground.primaryColor)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}


struct ButtonView: View {
    let icon: String
    
    var size: CGFloat = OMButton.size
    var weight: Font.Weight = .semibold
    var hPadding: CGFloat = 8
    var vPadding: CGFloat = 8
    var tint: Color? = .blue
    var opacity: CGFloat = 0
    
    var disabled: Bool = false
    let action: () -> ()

    var body: some View {
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

struct MenuView: View {
    let icon: String
    
    var size: CGFloat = OMButton.size
    var weight: Font.Weight = .semibold
    var hPadding: CGFloat = 8
    var vPadding: CGFloat = 8
    var tint: Color? = .blue
    var opacity: CGFloat = 0
    
    let menu: UIMenu

    var body: some View {
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


struct CircleButtonView: View {
    let icon: String
    var size: CGFloat = OMButton.size
    var weight: Font.Weight = .heavy
    var padding: CGFloat = 16
    var foregroundStyle: Color = OMBackground.systemColor
    var tint: Color = .blue
    
    var _size: CGFloat {
        UIFont.systemFont(ofSize: size).lineHeight
    }
    let action: () -> ()


    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundStyle(foregroundStyle)
                .font(Font.system(size: _size, weight: weight))
                .frame(width: _size, height: _size)
                .padding(padding)
                .background {
                    Circle()
                        .fill(tint)
                        .shadow(color: tint.opacity(0.3),
                                radius: 5,
                                y: 3)
                }
        }
    }
}

