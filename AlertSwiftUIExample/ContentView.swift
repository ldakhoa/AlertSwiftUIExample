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
                    title: "Title",
                    subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor."
                )
                .alertBannerType(.warning)
                .onTapAction {
                    isTapped.toggle()
                }
                .alert("Tapped", isPresented: $isTapped) {
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
