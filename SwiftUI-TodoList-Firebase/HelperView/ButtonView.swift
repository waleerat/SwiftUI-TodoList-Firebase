//
//  ButtonView.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-08.
//

import SwiftUI

struct ButtonView: View {
    var text: String
    var imageName: String = ""
    var backgroundColor: Color = .blue
    var frameWidth: CGFloat = 100
    var action: () -> Void
    
    var body: some View {
        Button(action: action , label: {
            HStack {
                Spacer()
                if (imageName != "") {
                    Image(systemName: imageName)
                        .font(.headline)
                }
                Text(text)
                Spacer()
            }
            .padding()
            .foregroundColor(backgroundColor == .white ? .blue : .white)
            .background(backgroundColor)
            .clipShape(Capsule())
            .frame(width:frameWidth)
        })
        
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Some Button", imageName: "play.fill") {
            print("Tapped")
        }
    }
}
 
