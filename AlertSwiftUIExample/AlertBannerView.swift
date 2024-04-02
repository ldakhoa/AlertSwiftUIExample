//
//  AlertBannerView.swift
//  AlertSwiftUIExample
//
//  Created by Khoa Le on 2/4/24.
//

import SwiftUI

public struct AlertBannerView: View {
    public let leadingImageName: String
    public let title: String
    public let subTitle: String
    public let rightImageName: String
    
    public var body: some View {        
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: leadingImageName)
                .font(.system(size: 14))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    
                Text(subTitle)
                    .font(.system(size: 12))
                    .lineLimit(10)
            }
            Spacer()
            
            VStack {
                Spacer()
                Button {
                    print("Did press")
                } label: { 
                    Image(systemName: rightImageName)
                        .font(.system(size: 14))
                }
                .tint(.black)
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.semanticNotice)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
//    public var body: some View {        
//        HStack(alignment: .top, spacing: 8) {
//            Image(systemName: "exclamationmark.circle")
//                .font(.system(size: 14))
//            
//            VStack(alignment: .leading, spacing: 4) {
//                Text("Title")
//                    .font(.system(size: 14, weight: .bold))
//                    
//                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.")
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
//                    Image(systemName: "chevron.right")
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
}

struct AlertBannerConfiguration {
    var leadingImageName: String
    var title: String
    var subTitle: String
    var rightImageName: String
}

protocol AlertBannerStyle {
    associatedtype Body: View
    
    typealias Configuration = AlertBannerConfiguration
    
    func makeBody(configuration: Configuration) -> Body
}

struct AlertBannerStyleKey: EnvironmentKey {
    static var defaultValue: any AlertBannerStyle = DefaultAlertBannerStyle()
}

extension EnvironmentValues {
    var alertBannerStyle: any AlertBannerStyle {
        get { self[AlertBannerStyleKey.self] }
        set { self[AlertBannerStyleKey.self] = newValue }
    }
}

extension View {
    func alertBannerStyle(_ style: some AlertBannerStyle) -> some View {
        self.environment(\.alertBannerStyle, style)
    }
}

struct DefaultAlertBannerStyle: AlertBannerStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            
        }
    }
}
