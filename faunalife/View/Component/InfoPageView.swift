//
//  InfoPageView.swift
//  faunalife
//
//  Created by James Jeremia on 25/05/23.
//

import SwiftUI
import SceneKit

struct InfoPageView: View {
    
    var body: some View {
        HStack{
            ZStack{
                Rectangle().fill(Color("bioBoard").opacity(0.6)).cornerRadius(10)
                VStack(alignment: .leading){
                    Text("Weight").foregroundColor(Color("bioText")).font(.system(size: 20))
                    Text("4 tons")                    .padding(.vertical).foregroundColor(Color("bioText"))
                        .frame(width: 180)
                        .background(Color("bioBoard").opacity(0.8))
                        .cornerRadius(5)
                    Text("Length").foregroundColor(Color("bioText")).font(.system(size: 20))
                    Text("8.5 m")                    .padding(.vertical).foregroundColor(Color("bioText"))
                        .frame(width: 180)
                        .background(Color("bioBoard").opacity(0.8))
                        .cornerRadius(5)
                    Text("Status").foregroundColor(Color("bioText")).font(.system(size: 20))
                    Text("Extinct")                    .padding(.vertical).foregroundColor(Color("bioRed"))
                        .frame(width: 180)
                        .background(Color("bioBoard").opacity(0.8))
                        .cornerRadius(5)
                }
            }.frame(width: 250, height: 320)
                .padding(.all)
        }
    }
}

struct InfoPageView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPageView()
    }
}
