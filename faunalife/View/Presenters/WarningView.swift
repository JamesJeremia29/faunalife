//
//  WarningView.swift
//  faunalife
//
//  Created by James Jeremia on 25/05/23.
//

import SwiftUI

struct WarningView: View {
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [.red.opacity(0.5), .red.opacity(0.1), .clear, .clear, .clear, .clear, .clear, .clear, .red.opacity(0.1), .red.opacity(0.5)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            LinearGradient(
                gradient: Gradient(colors: [.red.opacity(0.5), .red.opacity(0.1), .clear, .clear, .clear, .clear, .clear, .clear, .red.opacity(0.1), .red.opacity(0.5)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("MOVE AWAY")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("warningLight"))
//                    .background(Color("warning"))
//                    .background(Color.red)
                    .cornerRadius(30)
                    .animation(.easeInOut)
                    .transition(.move(edge: .top))
                Spacer()
            }
        }
    }
}

struct WarningView_Previews: PreviewProvider {
    static var previews: some View {
        WarningView()
    }
}
