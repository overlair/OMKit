//
//  File.swift
//  
//
//  Created by John Knowles on 7/28/24.
//

import Foundation

extension Character {
    /// A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    /// Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    static var empty: String { "" }

    var isSingleEmoji: Bool { count == 1 && containsEmoji }

    var containsEmoji: Bool { contains { $0.isEmoji } }

    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }

    var emojiString: String { emojis.map { String($0) }.reduce("", +) }

    var emojis: [Character] { filter { $0.isEmoji } }

    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
}



extension String {
    func or(_ this: String) -> String {
        self.isEmpty ? this : self
    }
}


extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}

extension Character {
    
    var numeric: Int {
        Int(self.asciiValue ?? UInt8.max)
    }
    
    var lowercaseNumeric:  Int {
        switch self {
        case "a": return 0
        case "b": return 1
        case "c": return 2
        case "d": return 3
        case "e": return 4
        case "f": return 5
        case "g": return 6
        case "h": return 7
        case "i": return 8
        case "j": return 9
        case "k": return 10
        case "l": return 11
        case "m": return 12
        case "n": return 13
        case "o": return 14
        case "p": return 15
        case "q": return 16
        case "r": return 17
        case "s": return 18
        case "t": return 19
        case "u": return 20
        case "v": return 21
        case "w": return 22
        case "x": return 23
        case "y": return 24
        case "z": return 25
        default:  return 26
        }
    }
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

#if os(iOS)
import UIKit
extension String {
    
    /// Generates a `UIImage` instance from this string using a specified
    /// attributes and size.
    ///
    /// - Parameters:
    ///     - attributes: to draw this string with. Default is `nil`.
    ///     - size: of the image to return.
    /// - Returns: a `UIImage` instance from this string using a specified
    /// attributes and size, or `nil` if the operation fails.
    func image(withAttributes attributes: [NSAttributedString.Key: Any]? = nil,
               size: CGSize? = nil) -> UIImage? {
        let size = size ?? (self as NSString).size(withAttributes: attributes)
        return UIGraphicsImageRenderer(size: size).image { _ in
            (self as NSString).draw(in: CGRect(origin: .zero, size: size),
                                    withAttributes: attributes)
        }
    }
    
}
#endif


extension String.Encoding: CaseIterable {
    public static var allCases: [String.Encoding] {
        [
        .ascii,
        .nextstep,
        .japaneseEUC,
        .utf8,
        .isoLatin1,
        .symbol,
        .nonLossyASCII,
        .shiftJIS,
        .isoLatin2,
        .unicode,
        .windowsCP1251,
        .windowsCP1252,
        .windowsCP1253,
        .windowsCP1254,
        .windowsCP1250,
        .iso2022JP,
        .macOSRoman,
        .utf16,
        .utf16BigEndian,
        .utf16LittleEndian,
        .utf32,
        .utf32BigEndian,
        .utf32LittleEndian
        ]
    }
}




extension String {
    
    /**
     Cast String to NSString
     */
    @inlinable
    @inline(__always)
    var nsString: NSString {
        self as NSString
    }
    
    /**
     Return the NSRange representing the String
     */
    @inlinable
    @inline(__always)
    var fullNSRange: NSRange {
        nsString.fullNSRange
    }
    
}

extension String {
    /**
     Returns a run of length count of zero width spaces.
     */
    static func zeroWidthSpaces(count: Int) -> String {
        String(repeating: .zeroWidthSpace, count: count)
    }
}

extension NSString {
    
    /**
     Cast NSString to String
     */
    @inlinable
    @inline(__always)
    var string: String {
        self as String
    }
    
    
    /**
     Return the NSRange representing the NSString
     */
    @inlinable
    @inline(__always)
    var fullNSRange: NSRange {
        NSRange(location: 0, length: length)
    }
    
}

extension String {
    
    static var zeroWidthSpace: String {
        String("\u{200B}")
    }
}


public extension String {
    static let lorem = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Amet mattis vulputate enim nulla aliquet porttitor lacus luctus accumsan. At risus viverra adipiscing at. Fringilla est ullamcorper eget nulla. Odio aenean sed adipiscing diam donec adipiscing. Nunc consequat interdum varius sit amet mattis vulputate enim. Vestibulum lectus mauris ultrices eros in cursus. Arcu risus quis varius quam. Quis lectus nulla at volutpat diam ut venenatis tellus in. Convallis convallis tellus id interdum velit laoreet id.

        Sapien eget mi proin sed libero enim sed. Sit amet purus gravida quis blandit turpis. Commodo odio aenean sed adipiscing diam donec. Justo nec ultrices dui sapien eget mi proin. Sed odio morbi quis commodo odio aenean. Sed lectus vestibulum mattis ullamcorper velit sed. Non curabitur gravida arcu ac. Eu scelerisque felis imperdiet proin fermentum leo vel orci porta. Ac turpis egestas sed tempus. Consectetur adipiscing elit duis tristique sollicitudin. Consequat mauris nunc congue nisi vitae suscipit tellus mauris. Neque gravida in fermentum et sollicitudin ac orci. Volutpat sed cras ornare arcu dui vivamus arcu felis. Nisl rhoncus mattis rhoncus urna neque viverra. Habitant morbi tristique senectus et netus et malesuada. Porttitor leo a diam sollicitudin tempor id.

        Semper feugiat nibh sed pulvinar proin gravida hendrerit. Aenean euismod elementum nisi quis eleifend quam adipiscing vitae proin. Turpis tincidunt id aliquet risus feugiat in ante metus dictum. Porttitor lacus luctus accumsan tortor posuere. Risus feugiat in ante metus dictum. Tincidunt vitae semper quis lectus nulla at volutpat diam. Venenatis tellus in metus vulputate eu scelerisque felis imperdiet. Aliquet bibendum enim facilisis gravida neque. Aenean sed adipiscing diam donec. Urna porttitor rhoncus dolor purus. Bibendum arcu vitae elementum curabitur vitae nunc sed. Mattis ullamcorper velit sed ullamcorper. Bibendum neque egestas congue quisque egestas. Velit dignissim sodales ut eu sem integer vitae justo eget.

        Enim facilisis gravida neque convallis. Commodo ullamcorper a lacus vestibulum sed arcu. Aliquam nulla facilisi cras fermentum. Nunc pulvinar sapien et ligula ullamcorper malesuada proin. Adipiscing elit pellentesque habitant morbi. Pulvinar elementum integer enim neque volutpat ac. Sociis natoque penatibus et magnis. Mattis rhoncus urna neque viverra justo nec ultrices dui. Lacinia at quis risus sed vulputate odio ut enim blandit. Facilisi cras fermentum odio eu feugiat pretium nibh. Aenean pharetra magna ac placerat vestibulum lectus. Mauris a diam maecenas sed enim ut sem viverra aliquet. Ornare arcu odio ut sem nulla pharetra diam sit. Sollicitudin tempor id eu nisl nunc mi ipsum.

        Nec ullamcorper sit amet risus nullam eget felis eget. Facilisis sed odio morbi quis commodo odio aenean sed. Lectus sit amet est placerat in egestas erat imperdiet sed. Eget gravida cum sociis natoque penatibus et. Quis eleifend quam adipiscing vitae proin sagittis nisl. Sed euismod nisi porta lorem mollis aliquam ut porttitor. Urna cursus eget nunc scelerisque viverra. Orci ac auctor augue mauris augue neque gravida in. Amet nisl suscipit adipiscing bibendum est ultricies. At volutpat diam ut venenatis tellus. Nulla facilisi nullam vehicula ipsum a arcu cursus vitae. Orci nulla pellentesque dignissim enim sit amet venenatis urna cursus. Convallis tellus id interdum velit laoreet id. At varius vel pharetra vel turpis. Diam quam nulla porttitor massa id neque aliquam vestibulum. Sed blandit libero volutpat sed cras ornare arcu. Tincidunt id aliquet risus feugiat. Gravida rutrum quisque non tellus orci ac auctor augue. Amet nisl suscipit adipiscing bibendum. Lobortis feugiat vivamus at augue eget arcu dictum.
        """
    
    public static func random(minWords: Int = 1, maxWords: Int = 10) -> String {
        let numWords = Int.random(in: minWords...maxWords)
        let count = self.lorem.count
        var words: [String] = []
        for i in 0...numWords {
            let idx = Int.random(in: 0...self.lorem.count -  40)
            var size = Int.random(in: 0...20)
            let start: String.Index = .init(utf16Offset: idx, in: self.lorem)
            let end: String.Index = .init(utf16Offset: idx + size, in: self.lorem)
            let substring = lorem[start...end]
            
            words.append(String(substring))
        }
        
        return words.joined(separator: " ")
    }
}

extension String {
    var numberOfWords: Int {
        var count = 0
        let range = startIndex..<endIndex
        enumerateSubstrings(in: range, options: [.byWords, .substringNotRequired, .localized], { _, _, _, _ -> () in
            count += 1
        })
        return count
    }
}

public extension String.Element {

    /**
     Get the string element for a `\r` carriage return.
     */
    static var carriageReturn: String.Element { "\r" }

    /**
     Get the string element for a `\n` newline.
     */
    static var newLine: String.Element { "\n" }

    /**
     Get the string element for a `\t` tab.
     */
    static var tab: String.Element { "\t" }
}

public extension String {
    
    /**
     Get the string for a `\r` carriage return.
     */
    static let carriageReturn = String(.carriageReturn)

    /**
     Get the string for a `\n` newline.
     */
    static let newLine = String(.newLine)

    /**
     Get the string for a `\t` tab.
     */
    static let tab = String(.tab)
}
