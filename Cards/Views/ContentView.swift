//
//  ContentView.swift
//  Cards
//
//  Created by Curtis Fisher on 2/15/25.
//


import SwiftUI

@main
struct CardsApp: App {
  @StateObject var store = CardStore(defaultData: true)

  var body: some Scene {
    WindowGroup {
      CardsListView()
        .environmentObject(store)
    }
  }
}
