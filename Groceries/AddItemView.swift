//
//  AddItemView.swift
//  Groceries
//
//  Created by Kane Sweet on 12/28/23.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    @State private var inputName: String = ""

    var body: some View {
        HStack {
            TextField("Grocery Name", text: $inputName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Submit") {
                submitAction()
            }
            .padding()
        }
    }

    private func submitAction() {
        print("Submitted text: \(inputName)")
        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()
        newItem.name = inputName
        newItem.isWeekly = false

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        presentationMode.wrappedValue.dismiss()

    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
