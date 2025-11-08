//
//  AddName.swift
//  Remember Names
//
//  Created by Mohsin khan on 06/11/2025.
//

import PhotosUI
import SwiftUI
import SwiftData
import CoreLocation


struct AddName: View {
    @Environment(\.dismiss) var dismiss
    @State private var pickerItem : PhotosPickerItem?
    @State private var selectedPhoto : Image?
    @State private var UserName = ""
    @Environment(\.modelContext) var modelContext
    @State private var photoData : Data?
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        NavigationStack{
            List{
                TextField("Enter Name" , text: $UserName)
                VStack{
                    
                    PhotosPicker(selection: $pickerItem, matching: .images){
                        Label("select photo" , systemImage: "photo.fill")
                    }
                    selectedPhoto?
                        .resizable()
                        .scaledToFit()
                }
                
                .onChange(of: pickerItem){
                    Task{
                        if let data = try await pickerItem?.loadTransferable(type: Data.self){
                            photoData = data
                            if let uiImage = UIImage(data: data){
                                selectedPhoto = Image(uiImage: uiImage)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Name")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save"){
                        guard let photoData = photoData , !UserName.isEmpty else {return}
                        let location = locationFetcher.lastKnownLocation
                        let person = Person(
                            name: UserName,
                            photo: photoData,
                            latitude: location?.latitude,
                            longitude: location?.longitude
                        )

                        modelContext.insert(person)
                        dismiss()
                    }
                    .disabled(UserName.isEmpty || photoData == nil)
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            locationFetcher.start()
        }
    }
}

#Preview {
    AddName()
}
