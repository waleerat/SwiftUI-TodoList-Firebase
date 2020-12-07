//
//  ContentView.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-04.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
            VStack {
                TabView {
                    todoListIndex()
                        .tabItem {
                            Image(systemName: "command")
                            Text("Todo")
                        }.tag(0)
                    
                    AuthenticationVeiw()
                        .tabItem {
                            Image(systemName: "command")
                            Text("Authentication")
                        }.tag(1)
                    Text("DownloadsView()")
                        .tabItem {
                            Image(systemName: "arrow.down.to.line.alt")
                            Text("Downloads")
                        }.tag(3)
                }
                //.accentColor(Color.init("myActiveObject"))
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
