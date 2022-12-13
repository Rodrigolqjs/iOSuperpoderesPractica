//
//  RegisterView.swift
//  KCHeroesMulti
//
//  Created by Rodrigo Latorre on 13/12/22.
//

import SwiftUI
import Combine

struct RegisterView: View {
    @EnvironmentObject private var rootViewModel: RootViewModel
    @StateObject private var registerViewModel = RegisterViewModel()
    
    @State private var data = RegisterModel()
    @State private var showAlert = false
    @State private var textError = ""
    
    var body: some View {
        VStack {
            Form {
                Section("Datos Personales") {
                    TextField("Nombre", text: $data.name)
                        .listRowBackground(Color.orange.opacity(0.5))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                    TextField("Apellido 1", text: $data.apell1)
                        .listRowBackground(Color.orange.opacity(0.5))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                    TextField("Apellido 2", text: $data.apell2)
                        .listRowBackground(Color.orange.opacity(0.5))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                    TextField("URL Foto", text: $data.photo)
                        .listRowBackground(Color.orange .opacity(0.5))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                } // Section 1
                Section("Datos Keepcoding") {
                    if let bootcampList = self.rootViewModel.bootcamps {
                        VStack {
                            Picker(selection: $data.bootcamp) {
                                ForEach(bootcampList) { bootcamp in
                                    Text(bootcamp.name)
                                        .foregroundColor(.orange)
                                }
                            } label: {
                                Text("Bootcamps")
                            } // Picker
                            .foregroundColor(.white)
                        }// VStack
                    } // If Let
                } // Section 2
                .listRowBackground(Color.orange.opacity(0.5))
                
                Section {
                    TextField("Email", text: $data.email)
                        .listRowBackground(Color.orange .opacity(0.5))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                    SecureField("Contraseña", text: $data.password)
                        .listRowBackground(Color.orange .opacity(0.5))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                    SecureField("Repetir Contraseña", text: $data.isValidPassword)
                        .listRowBackground(Color.orange .opacity(0.5))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                } // Section 3
                .listRowBackground(Color.orange.opacity(0.5))
                
                if (registerViewModel.status != .RegisterSuccess) {
                    Section("") {
                        Button {
                            if (!data.passwordValidation()) {
                                textError = "Las contraseñas no son iguales o el tamaño es menor de 6 caracteres"
                                showAlert.toggle()
                                return
                            }
                            
                            if (!data.emailValidation()){
                                textError = "Email incorrecto"
                                showAlert.toggle()
                            }
                            
                            if (data.validData()){
                                registerViewModel.register(data: data)
                            } else {
                                textError = "Rellene bien todos los datos"
                                showAlert.toggle()
                            }
                        } label: {
                            Text("Registrarse")
                        } // Button
                    }// Section 4
                } else {
                    Text("Registrado Correctamente")
                }// if - else
                Button {
                    rootViewModel.status = .none
                } label: {
                    Text("Volver al Login")
                }

            } // Form
        } // VStack Principal
        .alert(isPresented: $showAlert) {
            Alert(title: Text(""), message: Text(textError), dismissButton: .default(Text("OK")))
        }
        .onReceive(registerViewModel.$status) { _ in
            if (registerViewModel.status == .RegisterSuccess) {
                textError = "Registro correcto"
                showAlert.toggle()
                rootViewModel.status = .none
            } else if(registerViewModel.status == .RegisterError) {
                textError = "Error en registro"
                showAlert.toggle()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
