//
//  IconView.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-08.
//

import SwiftUI

struct IconView: View {
    var imageName: String
    var backgroundColor: Color = Color.blue
    var frameSize: CGFloat = 35
    var action: () -> Void
    
    var body: some View {
        Button(action: action , label: {
            Image(systemName: imageName)
                .resizable()
                .frame(width: frameSize, height: frameSize)
                .foregroundColor(backgroundColor)
                .imageScale(.large)
        })
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(imageName: "plus.circle.fill") {
            print("Tapped")
        }
    }
}
