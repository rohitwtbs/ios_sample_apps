//
//  ContentView.swift
//  Gallery_progress
//
//  Created by rohit kumar on 30/07/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    let imageUrls: [URL]

    @State private var progress: Double = 0.0

    var body: some View {
        VStack {
             ProgressBarView(progress: $progress)
                 .frame(height: 10)
                 .padding()

             // Iterate through your image URLs here and display them
             // For demonstration purposes, we're just simulating the iteration delay.
             ForEach(0..<imageUrls.count) { index in
                 Image(systemName: "photo")
                     .resizable()
                     .frame(width: 100, height: 100)
                     .onAppear {
                         // Simulate some delay to show the progress bar in action
                         DispatchQueue.main.asyncAfter(deadline: .now() + Double(index + 1) * 0.5) {
                             self.progress = Double(index + 1) / Double(imageUrls.count)
                         }
                     }
             }
         }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

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
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(imageUrls: <#[URL]#>).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}





struct ProgressBarView: View {
    @Binding var progress: Double

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)

                Rectangle().frame(width: min(CGFloat(self.progress) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color.green)
            }
        }
    }
}


