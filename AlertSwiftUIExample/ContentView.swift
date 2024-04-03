//
//  ContentView.swift
//  AlertSwiftUIExample
//
//  Created by Khoa Le on 2/4/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isTapped: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Alert OKDS Demo")
                AlertBannerView(
                    title: "Warning alert",
                    subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."
                )
                .alertBannerType(.warning)
                
                AlertBannerView(
                    title: "Info alert",
                    subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."
                )
                .alertBannerType(.info)
                .onTapAction {
                    isTapped.toggle()
                }
                .alert("Tapped", isPresented: $isTapped) {
                }
                
//                AlertBannerView(
//                    title: "Title",
//                    subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."
//                )
//                .alertBannerType(.info)
//                .closeButtonHidden()

            }
        }
    }
}

#Preview {
    ContentView()
}
