//
//  ESP32View.swift
//  ESP-relay
//
//  Created by Dosi Dimitrov on 19.01.22.
//

import WebKit
import SwiftUI
import web3swift
import PromiseKit
import Combine
import CryptoKit

var contract:ProjectContract?
var web3:web3?
var network:Network = .rinkeby
var wallet:Wallet?
var password = "dakata_7b" // leave empty string for ganache

struct ESP32View: View {
    
    @State  var projectTitle = 76
  
    @StateObject private var vm = ESP32Model()
    
    
    var body: some View {
       
        
        ZStack {
            Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    Image("BCRL")
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height / 4)
                    VStack{
                        Form{
                            Section(header: Text("Thermometer")) {
                                VStack {

                                    TemperatureView(temperature: $vm.temperature, humidity: $vm.humidity, isHighTemperature: $vm.highTemperature )
   
                                }
                               
                               .onChange(of: vm.isOk) { bl in
                                   guard let my_block = bl else {return}
                                  
                                   if my_block{
                                       DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                           self.projectTitle = self.vm.blockArray
                                           createBlock()
                                          
                                       }
                                   }
                                 
                              
                               }
                            }
                            }

                        
                       Form{
                            
                            Section(header: Text("Machine Condition Monitoring")) {
                                HStack(){
                                    MarsView(onButton: $vm.relayN1)
                                        .transition(.move(edge: .trailing))
                              
                                    MarsView(onButton: $vm.relayN2)
                                        .transition(.move(edge: .trailing))
                             
                                    MarsView(onButton: $vm.relayN3)
                                        .transition(.move(edge: .trailing))
                           
                                    MarsView(onButton: $vm.relayN4)
                                        .transition(.move(edge: .trailing))
                                    Text("....")
                                          .padding()
                                          .foregroundColor(.clear)
                                }

                            }
                        }
                    }
                   
                 
                    

                    
                }
                .frame(width: geometry.size.width, height:geometry.size.height / 1.1)
                //.edgesIgnoringSafeArea(.bottom)
            }
        }
    }
    
    func createBlock(){
        wallet = getWallet(password: password, privateKey: "0b595c19b612180c8d0ebd015ed7c691e82dcfdeadf1733fa561ec2994a4be21", walletName:"GanacheWallet")
        // Create contract with wallet as the sender
        contract = ProjectContract(wallet: wallet!)
        // Call contract method
       createNewProject()
    }
    
    func createNewProject() {
        let parameters = [projectTitle] as [AnyObject]
        firstly {
            // Call contract method
            callContractMethod(method: .projectContract, parameters: parameters,password: "dakata_7b")
        }.done { response in
            self.getProjectTitle()
        }
    }

    func getProjectTitle() {
        let parameters = [] as [AnyObject]
        firstly {
            callContractMethod(method: .getProjectTitle, parameters: parameters,password: nil)
        }.done { response in
            // print out response
            print("getProjectTitle response \(response)")
        }
        self.vm.ReadBlockButton()
       
      
      
    }
}

struct ESP32View_Previews: PreviewProvider {
    static var previews: some View {
        ESP32View()
    }
}
