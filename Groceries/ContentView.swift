//
//  ContentView.swift
//  Groceries
//
//  Created by Kane Sweet on 12/28/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var inputName: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Section {
                    HStack {
                        TextField("Grocery Name", text: $inputName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250)
                            //.padding()
                        Button("Add") {
                            addItem()
                        }
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(15)
                List {
                    ForEach(items) { item in
                        HStack {
                            Text(item.name!)
                            Spacer()
                            Text(item.timestamp!, formatter: itemFormatter).foregroundColor(Color.gray)
                            Button(
                                action: {
                                        toggleIsWeekly(item: item)
                                    }
                            ) {
                                Image(
                                    systemName: item.isWeekly ? "repeat.circle.fill" : "repeat.circle"
                                )
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }


                        }
                    }
                    .onDelete(perform: deleteItems)

                }
                .navigationTitle("Groceries")
                Section {
                    VStack {
                        Button(action: { wentShopping() } ) {
                            Text("Went Shopping!")
                                .font(.title2)
                        }
                        .frame(width: 250)
                    }

                }
                .padding()
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(15)


            }.background(.green)

        }.background(.gray)

    }

    private func toggleIsWeekly(item: Item) {
        item.isWeekly = !item.isWeekly

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.name = inputName
            newItem.timestamp = Date()
            newItem.isWeekly = false
            inputName = ""
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func wentShopping() {
        withAnimation {
            items.forEach { item in
                if (!item.isWeekly) {
                    viewContext.delete(item)
                } else {
                    item.timestamp = Date()
                }
            }

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
