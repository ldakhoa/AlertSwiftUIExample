//
//  Colors.swift
//  AlertSwiftUIExample
//
//  Created by Khoa Le on 2/4/24.
//

import SwiftUI
import UIKit

/// A platform-agnostic representation of a 32-bit RGBA color value.
public struct ColorValue: Equatable {

    public static let clear: ColorValue = .init(r: 0.0, g: 0.0, b: 0.0, a: 0.0)

    /// Creates a color value instance with the specified three-channel, 8-bit-per-channel color value, usually in hex.
    ///
    /// For example: `0xFF0000` represents red, `0x00FF00` green, and `0x0000FF` blue.
    /// There is no way to specify an alpha channel via this initializer. For that, use `init(r:g:b:a)` instead.
    ///
    /// - Parameter hexValue: The color value to store, in 24-bit (three-channel, 8-bit) RGB.
    ///
    /// - Returns: A color object that stores the provided color information.
    public init(_ hexValue: UInt32) {
        self.hexValue = hexValue << 8 | 0xFF
    }

    /// Creates a color value instance with the specified channel values.
    ///
    /// Parameters work just like `UIColor`, `NSColor`, or `SwiftUI.Color`, and should all be in the range of `0.0 ≤ value ≤ 1.0`.
    /// Any channel that is above 1.0 will be clipped down to 1.0; results are undefined for negative inputs.
    ///
    /// - Parameter r: The red channel.
    /// - Parameter g: The green channel.
    /// - Parameter b: The blue channel.
    /// - Parameter a: The alpha channel.
    ///
    /// - Returns: A color object that stores the provided color information.
    public init(
        r: CGFloat,
        g: CGFloat,
        b: CGFloat,
        a: CGFloat
    ) {
        hexValue = (min(UInt32(r * 255.0), 0xFF) << 24) |
                   (min(UInt32(g * 255.0), 0xFF) << 16) |
                   (min(UInt32(b * 255.0), 0xFF) << 8) |
                   (min(UInt32(a * 255.0), 0xFF))
    }

    var r: CGFloat { CGFloat((hexValue & 0xFF000000) >> 24) / 255.0 }
    var g: CGFloat { CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0 }
    var b: CGFloat { CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0 }
    var a: CGFloat { CGFloat(hexValue & 0x000000FF) / 255.0 }

    // Value is stored in RGBA format.
    let hexValue: UInt32
}

extension UIColor {

    /// Creates a UIColor from a `ColorValue` instance.
    ///
    /// - Parameter colorValue: Color value to use to initialize this color.
    public convenience init(colorValue: ColorValue) {
        self.init(
            red: colorValue.r,
            green: colorValue.g,
            blue: colorValue.b,
            alpha: colorValue.a)
    }

    public convenience init(light: UIColor, dark: UIColor) {
        self.init { traits -> UIColor in
            if traits.userInterfaceStyle == .light {
                return light
            } else {
                return dark
            }
        }
    }

    private var colorValue: ColorValue? {
        var redValue: CGFloat = 1.0
        var greenValue: CGFloat = 1.0
        var blueValue: CGFloat = 1.0
        var alphaValue: CGFloat = 1.0
        if self.getRed(&redValue, green: &greenValue, blue: &blueValue, alpha: &alphaValue) {
            let colorValue = ColorValue(r: redValue, g: greenValue, b: blueValue, a: alphaValue)
            return colorValue
        } else {
            return nil
        }
    }

    public var hexString: String {
        let cgColorInRGB = cgColor.converted(to: CGColorSpace(name: CGColorSpace.sRGB)!, intent: .defaultIntent, options: nil)!
        let colorRef = cgColorInRGB.components
        let r = colorRef?[0] ?? 0
        let g = colorRef?[1] ?? 0
        let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0
        let a = cgColor.alpha

        var color = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )

        if a < 1 {
            color += String(format: "%02lX", lroundf(Float(a * 255)))
        }

        return color
    }
}

extension Color {
    /// Creates a Color from a `ColorValue` instance.
    ///
    /// - Parameter colorValue: Color value to use to initialize this color.
    init(colorValue: ColorValue) {
        self.init(UIColor(colorValue: colorValue))
    }
    
    static let semanticNotice = Color(colorValue: ColorValue(0xFFB117))
}
