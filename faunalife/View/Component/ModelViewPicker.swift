//
//  ModelViewPicker.swift
//  faunalife
//
//  Created by James Jeremia on 20/05/23.
//

import SwiftUI

struct ModelViewPicker: View {
    
    var models: [String]
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: String?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 30){
                ForEach(0 ..< self.models.count){index in
                    Button {
                        print("Debug: selected model name: \(self.models[index])")
                        self.selectedModel = self.models[index]
                        self.isPlacementEnabled = true
                    } label: {
                        Image(uiImage: UIImage(named: self.models[index])!)
                            .resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fit)
                    }.buttonStyle(.plain)
                }
            }
        }.padding(.horizontal)
            .background(Color.black.opacity(0.5))
    }
}

