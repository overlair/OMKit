//
//  File.swift
//  
//
//  Created by John Knowles on 9/13/24.
//

import Foundation
import SwiftUI

public enum OMDefault {
    public static let darkPrimaryColor =  UIColor(red: 58 / 255, green: 59 / 255, blue: 60 / 255, alpha: 1)
    public static let lightPrimaryColor = UIColor(red: 250 / 255, green: 249 / 255, blue: 246 / 255, alpha: 1)
    public static let primaryColor = UIColor(dynamicProvider: { traits in
        traits.userInterfaceStyle == .light ? OMDefault.darkPrimaryColor : OMDefault.lightPrimaryColor
    })
    
    public static let darkSecondaryColor =  UIColor(red: 108 / 255, green: 109 / 255, blue: 110 / 255, alpha: 1)
    public static let lightSecondaryColor = UIColor(red: 160 / 255, green: 159 / 255, blue: 159 / 255, alpha: 1)
    public static let secondaryColor = UIColor(dynamicProvider: { traits in
        traits.userInterfaceStyle == .light ? OMDefault.lightSecondaryColor : OMDefault.darkSecondaryColor
    })
}

#Preview {
    VStack {
        Color(OMDefault.darkPrimaryColor)
        Color(OMDefault.darkSecondaryColor)
        Color(OMDefault.lightSecondaryColor)
        Color(OMDefault.lightPrimaryColor)
        Image(systemName: "gearshape.fill")
            .font(Font.system(size: 50))
            .foregroundStyle(Color(OMDefault.lightSecondaryColor))
    }
    .padding()
    .background(.white)
}
