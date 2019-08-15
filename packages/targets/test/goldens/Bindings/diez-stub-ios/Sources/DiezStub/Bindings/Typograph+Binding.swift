import UIKit

private var registeredFonts: Set<String> = []

private func registerFont(_ font: Font) {
    if font.file.src == "" || registeredFonts.contains(font.file.src) {
        return
    }

    registeredFonts.insert(font.file.src)

    guard
        let url = font.file.url,
        let data = try? Data(contentsOf: url) as CFData,
        let dataProvider = CGDataProvider(data: data),
        let cgFont = CGFont(dataProvider) else {
            return
    }

    CTFontManagerRegisterGraphicsFont(cgFont, nil)
}

extension Typograph {
    /**
     The `UIFont` of the `Typograph`.

     Iff `shouldScale` is `true`, the font will be scaled according to `UIFontMetric`s Dynamic Type scaling system with the `Typograph`s `iosTextStyle` value.

     This uses the `UIFont(name:size)` initializer and may return nil as a result.
     */
    @objc
    public var uiFont: UIFont? {
        return _uiFont(for: nil)
    }

    /**
     The `UIFont` of the `Typograph`.

     Iff `shouldScale` is `true`, the font will be scaled according to `UIFontMetric`s Dynamic Type scaling system with the `Typograph`s `iosTextStyle` value and the provided `UITraitCollection`.

     This uses the `UIFont(name:size)` initializer and may return nil as a result.
     */
    public func uiFont(for traitCollection: UITraitCollection) -> UIFont? {
        return _uiFont(for: traitCollection)
    }
    
    /**
     `NSAttributedString` attributes of the `Typograph`.
     */
    @objc
    public var attributedStringAttributes: [NSAttributedString.Key: Any] {
        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color.uiColor,
        ]
        
        if let font = uiFont {
            attributes[.font] = font
        }
        
        return attributes
    }
    
    /**
     Constructs an `NSAttributedString` decorating the provided `String`.
     */
    @objc
    public func attributedString(decorating string: String) -> NSAttributedString {
        return NSAttributedString(string: string, typograph: self)
    }

    /**
     The `UIFont.TextStyle` for the `Typograph`.
     */
    @objc
    public var uiFontTextStyle: UIFont.TextStyle {
        switch iosTextStyle {
        case "body": return .body
        case "callout": return .callout
        case "caption1": return .caption1
        case "caption2": return .caption2
        case "footnote": return .footnote
        case "headline": return .headline
        case "subheadline": return .subheadline
        case "largeTitle": return .largeTitle
        case "title1": return .title1
        case "title2": return .title2
        case "title3": return .title3
        default: return .body
        }
    }

    private func _uiFont(for traitCollection: UITraitCollection?) -> UIFont? {
        registerFont(font)

        guard let uiFont = UIFont(name: font.name, size: fontSize) else {
            return nil
        }

        guard shouldScale else {
            return uiFont

        }

        let metrics = UIFontMetrics(forTextStyle: uiFontTextStyle)

        guard let traitCollection = traitCollection else {
            return metrics.scaledFont(for: uiFont)
        }

        return metrics.scaledFont(for: uiFont, compatibleWith: traitCollection)
    }
}

extension NSAttributedString {
    /**
     Initializes an `NSAttributedString` with the provided string and `Typograph`.
     */
    @objc
    public convenience init(string: String, typograph: Typograph) {
        self.init(string: string, attributes: typograph.attributedStringAttributes)
    }
}

extension UILabel {
    /**
     Applies the provided `Typograph` to the receiver.
     */
    @objc(dez_applyTypograph:)
    public func apply(_ typograph: Typograph) {
        font = typograph.uiFont
        textColor = typograph.color.uiColor
        adjustsFontForContentSizeCategory = typograph.shouldScale
    }
}

extension UITextView {
    /**
     Applies the provided `Typograph` to the receiver.
     */
    @objc(dez_applyTypograph:)
    public func apply(_ typograph: Typograph) {
        font = typograph.uiFont
        textColor = typograph.color.uiColor
        adjustsFontForContentSizeCategory = typograph.shouldScale
    }
}

extension UITextField {
    /**
     Applies the provided `Typograph` to the receiver.
     */
    @objc(dez_applyTypograph:)
    public func apply(_ typograph: Typograph) {
        font = typograph.uiFont
        textColor = typograph.color.uiColor
        adjustsFontForContentSizeCategory = typograph.shouldScale
    }
}
