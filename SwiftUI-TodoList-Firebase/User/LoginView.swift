//
//  LoginView.swift
//  ShopToday
//
//  Created by Waleerat Gottlieb on 2020-11-30.
//

import SwiftUI 

struct LoginView: View {
 
    @State var IsPopupInfo: Bool = false
    @State private var IsPopSignupView = false
    @State var infoDescription: String = ""
    @State var isShowInfo: Bool = false
    
    @State var email = "waleerat.sang@gmail.com" // email for testing
    @State var password = ""
    
    
    var body: some View {
 
        return ZStack {
                // Main VStack
                ScrollView {
                    // Signup form
                    SigninForm(IsPopSignupView: $IsPopSignupView, infoDescription: $infoDescription, isShowInfo: $isShowInfo, email: $email, password: $password)
                }
                .foregroundColor(.primary)
                .padding()
                .padding(.bottom, 20)
                // Popup and show view selection
                if IsPopSignupView {
                    SignupView(IsPopSignupView: $IsPopSignupView)
                        .animation(.easeIn)
                }
                
                if (isShowInfo) {
                    ShowInfoView(infoDescription: $infoDescription, isShowInfo: $isShowInfo, IsPopSignupView: $IsPopSignupView)
                }
            }
            .foregroundColor(.primary)
        
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            LoginView()
         
        }
    }
}


struct SigninForm: View {
    @Binding var IsPopSignupView: Bool
    @Binding var infoDescription: String
    @Binding var isShowInfo: Bool
    
    @Binding var email: String
    @Binding var password: String
    
    var body: some View {
        VStack { 
            Text("Sign In")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.bottom, .top], 20)
            
            VStack(alignment: .leading) {
                
                Text("Email")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(Color.init(.label))
                    .opacity(0.75)
                
                TextField("Enter your email", text: $email)
                Divider()
                
                Text("Password")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundColor(Color.init(.label))
                    .opacity(0.75)
                
                SecureField("Enter your password", text: $password)
                Divider()
                
       
            }
            .padding(.bottom, 15)
            .animation(.easeOut(duration: 0.1))
            
            
            HStack {
                Spacer()
                Button(action: {
                    print(">>Forget Password Action")
                }, label: {
                    Text("Forgot Password?")
                        .foregroundColor(Color.black.opacity(0.5))
                })
            }//End of HStack
            
            //Sign in Button
            ButtonView(text: "Sign In",
                       backgroundColor: (email == "" || password == "") ? Color.gray : Color.blue,
                       frameWidth: screen.width - 120) {
                // signUpUser()
                loginUser()
            }
            .disabled(email == "" || password == "")
            
            Spacer()
            
            HStack(spacing: 8) {
                Text("Don't have an Account?")
                    .foregroundColor(Color.gray.opacity(0.8))
                    
                Button(action: {
                    self.IsPopSignupView.toggle()
                }, label: {
                    Text("Sign Up")
                })
                .foregroundColor(.blue)
            }
        } 
    }
    
    func loginUser(){
            
            UserVM.loginUserWith(email: email, password: password) { (error, isEmailVerified) in
                
                if error != nil {
                    self.isShowInfo = true
                    self.infoDescription = responseMessage(message: error!.localizedDescription)
                    return
                }else if isEmailVerified {
                    if !UserVM.currentUser()!.onBoarding {
                        self.isShowInfo = true
                        self.infoDescription = "Go to update profile form"
                    } else {
                        self.isShowInfo = true
                        self.infoDescription = "Success! go to the next process"
                    }
                    
                } else {
                    self.isShowInfo = true
                    self.infoDescription = "Please verify your Email"
                }
            }
        
    }
    
    
    func responseMessage(message: String) -> String{
        if (message == "There is no user record corresponding to this identifier. The user may have been deleted.") {
            return "Your email does not exist"
        }
        return message
    }
    
}
//self.isShowInfo = true
//self.infoDescription = "Go to Dashboard"
//print(infoDescription)
//print("Go to Dashboard")
