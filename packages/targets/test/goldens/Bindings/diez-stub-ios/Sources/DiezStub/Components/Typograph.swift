import Foundation
import CoreGraphics

@objc(DEZTypograph)
public final class Typograph: NSObject, Decodable {
    @objc public internal(set) var font: Font
    @objc public internal(set) var fontSize: CGFloat
    @objc public internal(set) var color: Color
    @objc public internal(set) var iosTextStyle: String
    @objc public internal(set) var shouldScale: Bool

    init(
        font: Font,
        fontSize: CGFloat,
        color: Color,
        iosTextStyle: String,
        shouldScale: Bool
    ) {
        self.font = font
        self.fontSize = fontSize
        self.color = color
        self.iosTextStyle = iosTextStyle
        self.shouldScale = shouldScale
    }
}

extension Typograph: ReflectedCustomStringConvertible {
    public override var description: String {
        return reflectedDescription
    }
}
