//
//  LoginView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 30/11/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var rootViewModel: RootViewModel
    
    @State private var email = "rodrigo.latorre@outlook.com"
    @State private var clave = "rlq12345"
    @State private var animationAmounth = 1.0
    
    var body: some View {
        ZStack {
            Image(decorative: "backgroundLogin")
                .resizable()
                .opacity(1)
                .id(1)
            
            Image(decorative:"")
                .resizable()
                .background(.black)
                .opacity(0.3)
            
            VStack {
                Image(decorative: "title")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .opacity(0.8)
                    .padding(.top, 160)
                Spacer()
                VStack {
                    TextField("Email", text: $email)
                        .padding()
                        .background(.white)
                        .foregroundColor(.blue)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x:20, y:10)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .opacity(0.8)
                    
                    SecureField("Clave", text: $clave)
                        .padding()
                        .background(.white)
                        .foregroundColor(.blue)
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x:20, y:10)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .opacity(0.8)
                        .padding(.top, 16)
                    
                    Button {
                        rootViewModel.login(user: email, password: clave)
                    } label: {
                        Text("Entrar")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color(uiColor: UIColor(red: 221.0/255.0, green: 99.0/255.0, blue: 0.0, alpha: 1.0)))
                            .cornerRadius(20.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                            .id(3)
                    }
                    .id(2)
                    .padding(.top, 50)
                    .opacity(0.8)
                    .overlay(
                    Circle()
                        .stroke(.white)
                        .scaleEffect(animationAmounth)
                        .opacity(2 - animationAmounth)
                        .animation(.easeInOut(duration: 1).repeatCount(3), value: animationAmounth)
                        .padding(.top, 50)
                        .onAppear {
                            animationAmounth = 2
                        }
                    )
                }
                .padding([.leading, .trailing], 20)
                
                Spacer()
                HStack {
                    Text("No tienes una cuenta?")
                        .foregroundColor(.white)
                        .bold()
                    Button {
                        rootViewModel.status = .register
                    } label: {
                        Text("Registro")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 50)
            }
            
        }
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environment(\.locale, .init(identifier: "es"))
        LoginView()
            .environment(\.locale, .init(identifier: "en"))
    }
}

