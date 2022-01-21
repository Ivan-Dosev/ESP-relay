//
//  ESP32-Model.swift
//  ESP-relay
//
//  Created by Dosi Dimitrov on 19.01.22.
//
import SwiftUI
import FirebaseFirestore
import FirebaseDatabaseSwift
import FirebaseDatabase

//💸

class ESP32Model : ObservableObject{
    
    @Published var temperature: String = ""{
        didSet{
            if (temperature as NSString).integerValue > 25 {
                self.blockArray = (temperature as NSString).integerValue
                onButton()
                self.highTemperature = true
            }else{
                self.highTemperature = false
            }
        }
    }
    
    @Published var humidity   : String = ""
    @Published var blockArray : Int = 0
    @Published var relayN1    : Bool = true {
        didSet{
            if !relayN2 && !relayN1 && !relayN3 && !relayN4 {
                self.blockArray = Int.random(in: 1000..<1060)
                onButton()
            }
        }
    }
    
    @Published var relayN2    : Bool = true {
        didSet{
            if !relayN2 && !relayN1 && !relayN3 && !relayN4 {
                self.blockArray = Int.random(in: 1000..<1060)
                onButton()
            }
        }
    }
    @Published var relayN3    : Bool = true {
        didSet{
            if !relayN2 && !relayN1 && !relayN3 && !relayN4 {
                self.blockArray = Int.random(in: 1000..<1060)
                onButton()
            }
        }
    }
    @Published var relayN4    : Bool = true {
        didSet{
            if !relayN2 && !relayN1 && !relayN3 && !relayN4 {
                self.blockArray = Int.random(in: 1000..<1060)
                onButton()
            }
        }
    }
    @Published var isBlock    : Bool?
    @Published var isOk       : Bool?
    @Published var highTemperature: Bool = false

    private var  ref: DatabaseReference! = Database.database().reference()
    
    init(){
    
        readRelays()
  
    }
    //  "/DHT11/Temperature"
    //  "/DHT11/Humidity"
    
    func onButton() {
        
        self.ref.child("test").setValue(["relay-0": 1])
        self.isOk = true
       
        print("____>>>>_____")
    }
    func ReadBlockButton() {
        self.ref.child("test").setValue(["ReadBlock": 1])
        self.isOk = false
    }
    func ReadBlockButtonOff() {
        self.ref.child("test").setValue(["ReadBlock": 0])
        self.isBlock = false
    }
    func offButton() {
        self.ref.child("test").setValue(["relay-0": 0])
        self.isOk = false
    }

    func readRelays(){

        self.ref.child("DHT11").child("Temperature").observe(.value) { snapshot in
            if let value = snapshot.value as? Int {
             
                self.temperature = String(value)
            }
        }
        self.ref.child("DHT11").child("Humidity").observe(.value) { snapshot in
            if let value = snapshot.value as? Int {
           
                self.humidity =  String( value)
            }
        }

        
//relays
       
            self.ref.child("test").child("relay-1").observe(.value) { snapshot in
                if let value = snapshot.value as? Int {
                
                    self.relayN1 =  value == 1 ? true : false
                }
            }
            self.ref.child("test").child("relay-2").observe(.value) { snapshot in
                if let value = snapshot.value as? Int {
                   
                    self.relayN2 =   value == 1 ? true : false
                }
            }
            self.ref.child("test").child("relay-3").observe(.value) { snapshot in
                if let value = snapshot.value as? Int {
                  
                    self.relayN3 =   value == 1 ? true : false
                }
            }
            self.ref.child("test").child("relay-4").observe(.value) { snapshot in
                if let value = snapshot.value as? Int {
                
                    self.relayN4 =   value == 1 ? true : false
                }
            }

    }
}
