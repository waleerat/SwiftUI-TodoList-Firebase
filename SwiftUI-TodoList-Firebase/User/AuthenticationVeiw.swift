//
//  AuthenticationVeiw.swift
//  ShopToday
//
//  Created by Waleerat Gottlieb on 2020-11-30.
//

import SwiftUI

struct AuthenticationVeiw: View {
    let screen = UIScreen.main.bounds
    
    var body: some View {
            ZStack {
                Color.init("myBackground")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    if UserVM.currentUser() != nil {
                        Text("Go to dashboard")
                            .foregroundColor(.primary)
                            .padding()
                            
                    } else {
                        LoginView()
                    }
                }
                .padding()
            } // End of ZStack
    }
}

struct AuthenticationVeiw_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationVeiw()
    }
}
 
