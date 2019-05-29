extension Typograph {
    /**
     The `UIFont` of the `Typograph`.

     - Note: If the font fails to load this will fallback to the `UIFont.systemFont(ofSize:)`.
     */
    @objc public var font: UIFont {
        guard let font = UIFont(name: fontName, size: fontSize) else {
            // TODO: Should this instead return nil? Update doc comment if this changes.
            return UIFont.systemFont(ofSize: fontSize)
        }

        return font
    }
}

public extension UILabel {
    @objc(dez_applyTypograph:)
    func apply(_ typograph: Typograph) {
        font = typograph.font
        textColor = typograph.color.color
    }
}

public extension UITextView {
    @objc(dez_applyTypograph:)
    func apply(_ typograph: Typograph) {
        font = typograph.font
        textColor = typograph.color.color
    }
}

public extension UITextField {
    @objc(dez_applyTypograph:)
    func apply(_ typograph: Typograph) {
        font = typograph.font
        textColor = typograph.color.color
    }
}