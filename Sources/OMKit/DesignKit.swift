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
    public static let size = CGFloat(26)
    public static let radius = CGFloat(12)
}

public enum OMIcon {
    public static let hPadding = CGFloat(9.71)
}
