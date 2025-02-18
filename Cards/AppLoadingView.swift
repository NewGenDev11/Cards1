//
//  AppLoadingView.swift
//  Cards
//
//  Created by Curtis Fisher on 2/16/25.
//

import SwiftUI

struct AppLoadingView: View {
    @State private var showSplash = true
    var body: some View {
        if showSplash {
            SplashScreen()
                .ignoresSafeArea()
                .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation{
                showSplash = false
                }
                }
                }
        } else {
            CardsListView()
                .transition(.scale(scale: 0, anchor: .top))
        }
    }
}

struct ApplLoadingView_Previews: PreviewProvider {
        static var previews: some View {
            AppLoadingView()
                .environmentObject(CardStore(defaultData: true))
        }
    }
