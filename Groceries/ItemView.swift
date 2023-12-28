//
//  ItemView.swift
//  Groceries
//
//  Created by Kane Sweet on 12/28/23.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    var body: some View {
        Text(item.name ?? "Item")
    }
}


//struct ItemView_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//        ItemView(item:Item())
//    }
//}
