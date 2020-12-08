//
//  ButtonView.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-08.
//

import SwiftUI

struct ButtonView: View {
    var text: String
    var imageName: String
    var backgroundColor: Color = Color.white
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action , label: {
            HStack {
                Spacer()
                Image(systemName: imageName)
                    .font(.headline)
                Text(text)
                    .bold()
                    .font(.system(size: 16))
                Spacer()
               
            }
            .padding(.vertical, 6)
            .foregroundColor(backgroundColor == .white ? .blue : .white)
            .background(backgroundColor)
            .cornerRadius(3.0)
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
 
