//
//  LoginView.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 22-07-22.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPass: String = ""
    
    @State var isEmailCorrect: Bool = false
    @State var isSignupComplete: Bool = false
    @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel()
    @State var errorMessage: String = ""
    @Namespace var animation
    
    var body: some View {
        
        VStack {
            
            VStack {
                VStack {
                    ZStack { //Logo
                        VStack {
                            Rectangle()
                        }
                        .frame(height: 220, alignment: .top)
                        .cornerRadius(35)
                        .foregroundColor(!self.loginViewModel.isSignupButtonSelected ? Color("pink") : Color("green"))
                            
                        
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 175, height: 110, alignment: .center)
                    } //End Logo
                    
                    
                    HStack(spacing: 2) { //Login and signup switch
                       
                        ZStack {
                            
                            HStack {
                                if !self.loginViewModel.isSignupButtonSelected {
                                    
                                    Color("pink")
                                        .frame(width: 120, height: 40)
                                        .cornerRadius(40)
                                        .matchedGeometryEffect(id: "selected", in: animation)
                                    
                                    Spacer()
                                } else {
                                    Spacer()
                                    
                                    Color("green")
                                        .frame(width: 120, height: 40)
                                        .cornerRadius(40)
                                        .matchedGeometryEffect(id: "selected", in: animation)
                                }
                            }
                            
                            
                            HStack(alignment: .center, spacing: 0) {
                                Text("Login")
                                    .foregroundColor(!self.loginViewModel.isSignupButtonSelected ? Color("buttonTextColor") : Color("switchBackgroundTextColor"))
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .padding(.horizontal, 15)
                                    .padding()
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.7, dampingFraction: 0.9, blendDuration: 10)) {
                                            self.loginViewModel.isSignupButtonSelected = false
                                        }
                                    }
                                    
                                
                                Text("Registrar")
                                    .foregroundColor(self.loginViewModel.isSignupButtonSelected ? Color("buttonTextColor") : Color("switchBackgroundTextColor"))
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .padding(.leading, 20)
                                    .padding()
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.7, dampingFraction: 1, blendDuration: 10)) {
                                            self.loginViewModel.isSignupButtonSelected = true
                                        }
                                    }
                                
                            }
                        }
                        .frame(width: 240, height: 40)
                        
                    } // End login and signup switch
                    .background(Color("switchBackground"))
                    .cornerRadius(30)
                    .padding(.top, 20)
                    
                    if !self.loginViewModel.isSignupButtonSelected {
                        Text("Inicia sesión con una cuenta ya creada")
                            .font(.system(size: 20, weight: .black, design: .rounded))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 242, maxHeight: 60, alignment: .center)
                            .offset(x: self.loginViewModel.isSignupButtonSelected ? -1800 : 0, y: 0)
                            .foregroundColor(Color("fontColor"))
                            .padding(.vertical, 10)
                            .matchedGeometryEffect(id: "title", in: animation)
                    } else {
                        Text("Registra una nueva cuenta")
                            .font(.system(size: 20, weight: .black, design: .rounded))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 242, maxHeight: 60, alignment: .center)
                            .offset(x: !self.loginViewModel.isSignupButtonSelected ? -1800 : 0, y: 0)
                            .foregroundColor(Color("fontColor"))
                            .padding(.vertical, 10)
                            .matchedGeometryEffect(id: "title", in: animation)
                    }
                    
                    
                    // MARK: - Text fields
                    VStack(spacing: 15) {
                        
                        HStack { //Email text field
                            VStack {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(Color("buttonTextColor"))
                                    .font(.system(size: 25))
                            }
                            .frame(width: 40, height: 40, alignment: .center)
                            .background(!self.loginViewModel.isSignupButtonSelected ? Color("pink") : Color("green"))
                            .cornerRadius(15)
                            
                            ZStack(alignment: .leading) {
                                if email.isEmpty {
                                    Text(verbatim: "Correo")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("fontColor"))
                                }
                                
                                TextField("", text: $email)
                                    .foregroundColor(Color("fontColor"))
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .keyboardType(.emailAddress)
                                    .ignoresSafeArea(.keyboard, edges: .bottom)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(Color("textField"))
                                .shadow(color: Color("shadow"), radius: 2, x: 0, y: 1)
                        )
                        
                        
                        HStack { //Password text field
                            VStack {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(Color("buttonTextColor"))
                                    .font(.system(size: 28))
                            }
                            .frame(width: 40, height: 40, alignment: .center)
                            .background(!self.loginViewModel.isSignupButtonSelected ? Color("pink") : Color("green"))
                            .cornerRadius(15)
                            
                            ZStack(alignment: .leading) {
                                if password.isEmpty {
                                    Text(verbatim: "Contraseña")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("fontColor"))
                                }
                                
                                SecureField("", text: $password)
                                    .foregroundColor(Color("fontColor"))
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .keyboardType(.emailAddress)
                                    .ignoresSafeArea(.keyboard, edges: .bottom)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(Color("textField"))
                                .shadow(color: Color("shadow"), radius: 2, x: 0, y: 1)
                        )
                        
                        if !self.loginViewModel.isSignupButtonSelected {
                            HStack { //Password text field
                                VStack {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(Color("buttonTextColor"))
                                        .font(.system(size: 28))
                                }
                                .frame(width: 40, height: 40, alignment: .center)
                                .background(!self.loginViewModel.isSignupButtonSelected ? Color("pink") : Color("green"))
                                .cornerRadius(15)

                                ZStack(alignment: .leading) {
                                    if password.isEmpty {
                                        Text(verbatim: "Confirmar Contraseña")
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(Color("fontColor"))
                                    }

                                    SecureField("", text: $password)
                                        .foregroundColor(Color("fontColor"))
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .keyboardType(.emailAddress)
                                        .ignoresSafeArea(.keyboard, edges: .bottom)
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .foregroundColor(Color("textField"))
                                    .shadow(color: Color("shadow"), radius: 2, x: 0, y: 1)
                            )
                            .matchedGeometryEffect(id: "confirmPass", in: animation)
                            .opacity(0)
                            .offset(x: 0, y: -40)
                        } else {
                            HStack { //Password text field
                                VStack {
                                    Image(systemName: "lock.fill")
                                        .foregroundColor(Color("buttonTextColor"))
                                        .font(.system(size: 28))
                                }
                                .frame(width: 40, height: 40, alignment: .center)
                                .background(!self.loginViewModel.isSignupButtonSelected ? Color("pink") : Color("green"))
                                .cornerRadius(15)
                                
                                ZStack(alignment: .leading) {
                                    if self.confirmPass.isEmpty {
                                        Text(verbatim: "Confirmar Contraseña")
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(Color("fontColor"))
                                    }
                                    
                                    SecureField("", text: self.$confirmPass)
                                        .foregroundColor(Color("fontColor"))
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .keyboardType(.emailAddress)
                                        .ignoresSafeArea(.keyboard, edges: .bottom)
                                }
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .foregroundColor(Color("textField"))
                                    .shadow(color: Color("shadow"), radius: 2, x: 0, y: 1)
                            )
                            .matchedGeometryEffect(id: "confirmPass", in: animation)
                            .opacity(1)
                        }
                        
                        
                        
                    }
                    .padding(.horizontal, 30)
                    
                    
                    
                    // MARK: - Bottom buttons
                    VStack {
                        
                        if !self.loginViewModel.isSignupButtonSelected {
                            
                            Button { //Login button
    //                            print(self.loginViewModel.validatePassword(password: self.password))
    //                            print(self.password)
                            } label: {
                                VStack {
                                    Text("Login")
                                        .foregroundColor(Color("buttonTextColor"))
                                        .font(.system(size: 30, weight: .bold, design: .rounded))
                                        .padding(.horizontal, 50)
                                }
                                .matchedGeometryEffect(id: "button", in: animation)
                                .padding(12)
                                .background(Color("pink"))
                                .cornerRadius(40)
                                .shadow(color: .gray, radius: 2, x: 0, y: 1)
                            }
                            
                            Button { //Fotgot your account button
                                //
                            } label: {
                                Text("¿Olvidaste tu cuenta?")
                                    .foregroundColor(Color("darkPink"))
                                    .underline()
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                            }
                            .padding()
                            .matchedGeometryEffect(id: "forgotPass", in: animation)
                            .opacity(1)
                        } else {
                            
                            Button { //Registrar button
                                self.loginViewModel.createNewUser(email: self.email, password: self.password, confirmPassword: self.confirmPass)
                            } label: {
                                VStack {
                                    Text("Registrar")
                                        .foregroundColor(Color("buttonTextColor"))
                                        .font(.system(size: 30, weight: .bold, design: .rounded))
                                        .padding(.horizontal, 50)
                                }
                                .padding(12)
                                .background(Color("green"))
                                .cornerRadius(40)
                                .shadow(color: .gray, radius: 2, x: 0, y: 1)
                            }
                            
                            Button { //Fotgot your account button
                                //
                            } label: {
                                Text("¿Olvidaste tu cuenta?")
                                    .foregroundColor(Color("green"))
                                    .underline()
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                            }
                            .padding()
                            .matchedGeometryEffect(id: "forgotPass", in: animation)
                            .opacity(0)
                            .offset(x: 0, y: -40)
                        }
                        

                    }
                    .padding(.top, 50)

                    
                    Spacer()
                }
                .ignoresSafeArea()
                .background(Color("background"))
                .task {
                    print("View: \(self.loginViewModel.itWasAccountCreated)")
                }
                
            }
            
            if self.loginViewModel.itWasAccountCreated {
                DashboardView()
            }

        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
        
        LoginView()
    }
}
