//
//  ContentView.swift
//  Remember Names
//
//  Created by Mohsin khan on 05/11/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: [SortDescriptor(\Person.name)]) var people: [Person]
    @Environment(\.modelContext) var modelContext
    @State private var isShowingAddView = false

    var body: some View {
        NavigationStack {
            VStack {
                if people.isEmpty {
                    ContentUnavailableView("No People Yet", systemImage: "person.3", description: Text("Tap + to add someone"))
                } else {
                    List{
                        ForEach(people, id: \.id) { person in
                            NavigationLink(destination: DetailView(person: person)){
                                HStack{
                                    Text(person.name)
                                    Spacer()
                                    if let uiImage = UIImage(data: person.photo){
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30 , height: 30)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deletePerson)
                    }
                }
            }
            .navigationTitle("Remember Names")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        isShowingAddView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
            .sheet(isPresented: $isShowingAddView) {
                AddName()
            }
        }
    }
    func deletePerson(at offsets: IndexSet) {
        for index in offsets {
            let person = people[index]
            modelContext.delete(person)
        }
    }

}

#Preview {
    ContentView()
}
