//
//  PlacementButtonView.swift
//  faunalife
//
//  Created by James Jeremia on 20/05/23.
//

import SwiftUI

struct PlacementButtonView: View {
    
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: String?
    @Binding var modelConfirmedForPlacement: String?
    
    var body: some View {
        HStack{
            Button {
                print("Debug: model placement canceled")
                self.resetPlacementParameters()
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(10)
            }
            
            Button {
                self.modelConfirmedForPlacement = self.selectedModel
                print(self.modelConfirmedForPlacement)
                print("Debug: model placement confirmed")
                self.resetPlacementParameters()
            } label: {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(10)
            }
        }
    }
    func resetPlacementParameters(){
        self.isPlacementEnabled = false
        self.selectedModel = nil
    }
    
//    struct PlacementButtonView_Previews: PreviewProvider {
//        static var previews: some View {
//            PlacementButtonView()
//        }
//    }
}
