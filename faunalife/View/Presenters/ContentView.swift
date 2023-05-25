//
//  ContentView.swift
//  faunalife
//
//  Created by James Jeremia on 17/05/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    
    @State var isPlacementEnabled = false
    @State var selectedModel: String?
    @State var modelConfirmedForPlacement: String?
    @State var notification: Bool = false
    @State var info: Bool = false
    @State var resetAR: Bool = false
    
    var models: [String] = {
        let fileManager = FileManager.default
        
        guard let path = Bundle.main.resourcePath,
              let fileURLs = try? fileManager.contentsOfDirectory(at: URL(fileURLWithPath: path), includingPropertiesForKeys: nil) else {
            return []
        }
        
        var availableModels: [String] = []
        for fileURL in fileURLs {
            let fileName = fileURL.lastPathComponent
            if fileName.hasSuffix(".usdz") {
                let imageName = String(fileName).replacingOccurrences(of: ".usdz", with: "")
                availableModels.append(imageName)
            }
        }
        
        return availableModels
        
    }()

    var body: some View {
        ZStack(){
            ARViewContainer(notification: self.$notification, info: self.$info, resetAR: self.$resetAR, modelConfirmedForPlacement: self.$modelConfirmedForPlacement).edgesIgnoringSafeArea(.all)
            if notification == false{
                VStack(){
                    HStack{
                        Spacer()
                        Button {
                            self.resetAR = true
                        } label: {
                            Image(systemName: ("arrow.counterclockwise")).padding(.all)
                        }
                    }
                    Spacer()
                    if info == true {
                        InfoPageView()
                    }
                    Spacer()
                    if self.isPlacementEnabled{
                        PlacementButtonView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, modelConfirmedForPlacement: self.$modelConfirmedForPlacement)
                    } else {
                        ModelViewPicker(models: self.models, isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel)
                    }
                }
            } else{
                WarningView()
            }

        }.onTapGesture {
            self.info = false
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(notification: false)
    }
}
#endif
