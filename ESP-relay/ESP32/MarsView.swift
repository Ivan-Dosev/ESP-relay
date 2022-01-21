//
//  MarsView.swift
//  Bert
//
//  Created by Dosi Dimitrov on 15.01.22.
//

import SwiftUI

struct MarsView: View {
    
    @Binding var onButton : Bool
    var body: some View {
     //🔊🔇
     //💡⚠️
        ZStack {
            if onButton {
                Text("💡")
                    .font(.system(size: 60))
            }else{
                VStack {Text("⚠️")}
                .font(.system(size: 60))
                .transition(.move(edge: .bottom))
                .zIndex(1)
            }
        }
    }
}

struct MarsView_Previews: PreviewProvider {
    static var previews: some View {
        MarsView(onButton: .constant(false))
    }
}
struct CircleButton: ViewModifier {

    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)

                    Circle()
                        .foregroundColor(.white)
                        .blur(radius: 4.0)
                        .offset(x: -8.0, y: -8.0) })

          //  .foregroundColor(.gray)
            .foregroundColor(.gray)
            .clipShape(Circle())
            .shadow(color: Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255), radius: 5, x: 5.0  , y:  5.0)
            .shadow(color: Color.white, radius: 50, x: -50.0 , y: -50.0)

    }
}
