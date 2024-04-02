//
//  AlertBannerView.swift
//  AlertSwiftUIExample
//
//  Created by Khoa Le on 2/4/24.
//

import SwiftUI

//public struct AlertBannerView: View {
//    public let leadingImageName: String
//    public let title: String
//    public let subTitle: String
//    public let rightImageName: String
//    
//    public var body: some View {        
//        HStack(alignment: .top, spacing: 8) {
//            Image(systemName: leadingImageName)
//                .font(.system(size: 14))
//            
//            VStack(alignment: .leading, spacing: 4) {
//                Text(title)
//                    .font(.system(size: 14, weight: .bold))
//                    
//                Text(subTitle)
//                    .font(.system(size: 12))
//                    .lineLimit(10)
//            }
//            Spacer()
//            
//            VStack {
//                Spacer()
//                Button {
//                    print("Did press")
//                } label: { 
//                    Image(systemName: rightImageName)
//                        .font(.system(size: 14))
//                }
//                .tint(.black)
//                Spacer()
//            }
//        }
//        .padding(.horizontal, 16)
//        .padding(.vertical, 12)
//        .background(Color.semanticNotice)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//    
////    public var body: some View {        
////        HStack(alignment: .top, spacing: 8) {
////            Image(systemName: "exclamationmark.circle")
////                .font(.system(size: 14))
////            
////            VStack(alignment: .leading, spacing: 4) {
////                Text("Title")
////                    .font(.system(size: 14, weight: .bold))
////                    
////                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.")
////                    .font(.system(size: 12))
////                    .lineLimit(10)
////            }
////            Spacer()
////            
////            VStack {
////                Spacer()
////                Button {
////                    print("Did press")
////                } label: { 
////                    Image(systemName: "chevron.right")
////                        .font(.system(size: 14))
////                }
////                .tint(.black)
////                Spacer()
////            }
////        }
////        .padding(.horizontal, 16)
////        .padding(.vertical, 12)
////        .background(Color.semanticNotice)
////        .frame(maxWidth: .infinity, maxHeight: .infinity)
////    }
//}

public struct AlertBannerView: View {
    // MARK: - Dependencies

    //    private let leadingImageName: String
    //    private let rightImageName: String
    private let title: String
    private let subTitle: String

    public init(title: String, subTitle: String) {
        self.title = title
        self.subTitle = subTitle
    }

    // MARK: - Environment

    @Environment(\.alertBannerType) private var type
    @Environment(\.closeButtonHidden) private var closeButtonHidden
    @Environment(\.actionHandler) private var actionHandler

    // MARK: - View

    public var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: leadingIconName)
                .font(.system(size: 14))
                .foregroundColor(contentForegroundColor)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(contentForegroundColor)

                Text(subTitle)
                    .font(.system(size: 12))
                    .foregroundColor(contentForegroundColor)
                    .lineLimit(10)
            }
            Spacer()

            trailingButton
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(backgroundColor)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var leadingIconName: String {
        switch type {
        case .info:
            return "info.circle"
        case .warning:
            return "exclamationmark.circle"
        }
    }

    @ViewBuilder
    private var backgroundColor: some View {
        switch type {
        case .info:
            Color.black
        case .warning:
            Color.semanticNotice
        }
    }

    private var contentForegroundColor: Color {
        switch type {
        case .info:
            return Color.white
        case .warning:
            return Color.black
        }
    }

    @ViewBuilder
    private var trailingButton: some View {
        VStack {
            if closeButtonHidden {
                Spacer()
            }

            Button {
                if let actionHandler {
                    actionHandler()
                }
            } label: {
                Image(systemName: trailingButtonImageName)
                    .font(.system(size: 14))
                    .foregroundColor(contentForegroundColor)
            }

            if closeButtonHidden {
                Spacer()
            }
        }
    }

    private var trailingButtonImageName: String {
        closeButtonHidden ? "chevron.right" : "xmark"
    }
}

#Preview {
    ScrollView {
        VStack {
            Text("Alert OKDS Demo")

            AlertBannerView(
                title: "Title",
                subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."
            )
            .closeButtonHidden(true)

            AlertBannerView(
                title: "Title",
                subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."
            )
            .alertBannerType(.warning)
        }
    }

}

// MARK: - AlertBannerViewHandler

private struct AlertBannerViewHandler: EnvironmentKey {
    static var defaultValue: (() -> Void)?
}

extension EnvironmentValues {
    var actionHandler: (() -> Void)? {
        get { self[AlertBannerViewHandler.self] }
        set { self[AlertBannerViewHandler.self] = newValue }
    }

}

extension View {
    public func onTapAction(_ actionHandler: @escaping () -> Void) -> some View {
        environment(\.actionHandler, actionHandler)
    }
}

// MARK: - AlertBannerStyle

public enum AlertBannerType {
    case warning
    case info
}

private struct AlertBannerStyleKey: EnvironmentKey {
    static var defaultValue: AlertBannerType = .info
}

extension EnvironmentValues {
    var alertBannerType: AlertBannerType {
        get { self[AlertBannerStyleKey.self] }
        set { self[AlertBannerStyleKey.self] = newValue }
    }
}

extension View {
    public func alertBannerType(_ type: AlertBannerType) -> some View {
        self.environment(\.alertBannerType, type)
    }
}

// MARK: - CloseButtonHidden

private struct AlertBannerViewCloseButtonHidden: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var closeButtonHidden: Bool {
        get { self[AlertBannerViewCloseButtonHidden.self] }
        set { self[AlertBannerViewCloseButtonHidden.self] = newValue }
    }
}

extension View {
    public func closeButtonHidden(_ hidesCloseButton: Bool = true) -> some View {
        environment(\.closeButtonHidden, hidesCloseButton)
    }
}

// MARK: - Custom Styling

struct AlertBannerConfiguration {
    var leadingImageName: String
    var title: String
    var subTitle: String
    var rightImageName: String
}

//protocol AlertBannerStyle {
//    associatedtype Body: View
//
//    typealias Configuration = AlertBannerConfiguration
//
//    func makeBody(configuration: Configuration) -> Body
//}


//struct DefaultAlertBannerStyle: AlertBannerStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        HStack {
//
//        }
//    }
//}
