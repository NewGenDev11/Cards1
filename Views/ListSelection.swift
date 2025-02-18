//
//  ListSelection.swift
//  Cards
//
//  Created by Curtis Fisher on 2/17/25.
//

import SwiftUI

enum ListState {
case list, carousel
}

struct ListSelection: View {
    @Binding var listState: ListState
    var body: some View {
        // 1
        // 2
        Picker(selection: $listState, label: Text("")) {
            Image(systemName: "square.grid.2x2.fill")
                .tag(ListState.list)
            Image(systemName: "rectangle.stack.fill")
                .tag(ListState.carousel)
        }
        // 3
        .pickerStyle(.segmented)
        .frame(width: 200)
    }
}

struct ListSelection_Previews: PreviewProvider {
    static var previews: some View {
    ListSelection(listState: .constant(.list))
    }
}
