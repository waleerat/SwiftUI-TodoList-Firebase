//
//  ContentView.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                 
                NavigationLink(
                    destination: todoListIndex(),
                    label: {
                        Text("To do list")
                    })
                 
                Spacer()
            }
            .padding(.top, 50)
            .edgesIgnoringSafeArea(.all)
        }
        .animation(.easeInOut)
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
