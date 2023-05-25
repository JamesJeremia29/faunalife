//
//  ARViewContainer.swift
//  faunalife
//
//  Created by James Jeremia on 18/05/23.
//

import Foundation
import ARKit
import RealityKit
import SwiftUI
import FocusEntity
import CoreHaptics

struct ARViewContainer: UIViewRepresentable {
    
    let impactFeedback = UINotificationFeedbackGenerator()
    
    @Binding var notification: Bool
    @Binding var info: Bool
    @Binding var resetAR: Bool
    
    @State var hapticEngine: CHHapticEngine?
    
    @Binding var modelConfirmedForPlacement: String?
    
    var hapticPlayer: CHHapticAdvancedPatternPlayer?
    
    func makeUIView(context: Context) -> ARView {
        
        
        let arView = FocusSquare(frame: .zero)
        
        arView.addCoaching()
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if resetAR == false{
            if let modelName = self.modelConfirmedForPlacement{
                
                print("Debug: Adding model to the scene \(modelName)")
                

                if modelName == "DinoAllosaurus"{
                    let dinoIdle = try! DinoAllosaurus.loadIdle()
                    _ = try! DinoAllosaurus.loadRoar()
                    uiView.scene.anchors.append(dinoIdle)

                    dinoIdle.actions.haptics.onAction = { entity in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            startHapticEngine()
                            self.notification = true
                            print(self.notification)
                        }
                        
                        
                        
                        dinoIdle.actions.unHaptic.onAction = { entity in
                            self.notification = false
                            print(self.notification)
                        }
                        
                    }
                    dinoIdle.actions.showInfo.onAction = { entity in
                        self.info = true
                        print(self.info)
                    }
                } else {
                    let textAnchor = try! Unavailable.loadInfo()
                    uiView.scene.anchors.append(textAnchor)
                }
            }
            
            
            DispatchQueue.main.async {
                self.modelConfirmedForPlacement = nil
            }
        } else {
            uiView.scene.anchors.remove(at: uiView.scene.anchors.count - 1)
            DispatchQueue.main.async {
                self.resetAR = false
            }
        }
    }
    func roarEffect(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator =  UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    func createHapticPattern() throws -> CHHapticPattern {
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 1.8)
        let pattern = try CHHapticPattern(events: [event], parameters: [])
        return pattern
    }
    func startHapticEngine() {
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
            
            let pattern = try createHapticPattern()
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                try? player?.stop(atTime: 0)
                try? self.hapticEngine?.stop()
            }
        } catch {
            print("Failed to start haptic engine: \(error)")
        }
    }
    
}


extension ARView: ARCoachingOverlayViewDelegate {
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = self.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        coachingOverlay.goal = .anyPlane
        self.addSubview(coachingOverlay)
    }
    
}

