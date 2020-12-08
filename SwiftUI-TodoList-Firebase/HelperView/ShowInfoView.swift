//
//  ShowInfoView.swift
//  SwiftUI-TodoList-Firebase
//
//  Created by Waleerat Gottlieb on 2020-12-06.
//

import SwiftUI

struct ShowInfoView: View {
    @Binding var infoDescription: String
    @Binding var isShowInfo: Bool
    @Binding var IsPopSignupView: Bool
    
    var body: some View {
        ZStack {
            Group {
                Color.white.opacity(0.6)
                    VStack {
                        Text("\(infoDescription)")
                            .font(.title3)
                        
                        ButtonView(text: "Close",backgroundColor: .orange, frameWidth: screen.width - 120) {
                            // signUpUser()
                            isShowInfo.toggle()
                        }
                         
                    }
                    .frame(width: screen.width * 0.9, height: screen.height * 0.3)
                        .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                
            }
            
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isShowInfo.toggle()
                self.IsPopSignupView = false
            }
        } 
         
    }
}


struct ShowInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ShowInfoView(infoDescription: .constant(""), isShowInfo:  .constant(false), IsPopSignupView: .constant(false))
    }
}
