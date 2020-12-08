//
//  AuthenticationVeiw.swift
//  ShopToday
//
//  Created by Waleerat Gottlieb on 2020-11-30.
//

import SwiftUI

struct AuthenticationVeiw: View {
    @State var isLogin: Bool = false
    
    var body: some View {
            ZStack {
                Color.init("myBackground")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    if isLogin == true {
                        Text("Go to dashboard")
                            .foregroundColor(.primary)
                            .padding()
                        
                        IconView(imageName: "square.and.arrow.up", backgroundColor: Color.blue) {
                            UserVM.logOutCurrentUser { (error) in
                                isLogin = false
                            }
                        } 
                    }
                }
                .padding()
                
                if !isLogin {
                    LoginView()
                }
                
            }
            .onAppear() {
                if UserVM.currentUser() != nil {
                    print("Login")
                    isLogin = true
                } else {
                    print(" Not Login")
                }
            }// End of ZStack
    }
}

struct AuthenticationVeiw_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationVeiw()
    }
}
 
