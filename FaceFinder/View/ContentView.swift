//
//  ContentView.swift
//  FaceFinder
//
//  Created by 이정훈 on 5/25/24.
//

import SwiftUI

struct ContentView: View {
    @State private var image: UIImage?
    @State private var isShowingPhotoLibrary: Bool = false
    
    private var flag: Bool = false
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Spacer()
            
            Button(action: {
                isShowingPhotoLibrary.toggle()
            }, label: {
                Text("사진 선택")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(.blue)
                    .cornerRadius(10)
            })
        }
        .padding()
        .sheet(isPresented: $isShowingPhotoLibrary) {
            ImagePicker(image: $image)
        }
    }
}


#Preview {
    ContentView()
}
