//
//  ContentView.swift
//  ESP-relay
//
//  Created by Dosi Dimitrov on 18.01.22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseDatabaseSwift
import FirebaseDatabase

struct ContentView: View {
    @StateObject private var arda = MaraModel()
    var body: some View {
        
        VStack {
            List(arda.mara) { ar in
                Text("ar: \(ar.name)")
            }
            HStack{
                Button(action: {
                    arda.onButton()
                }) {
                    Text("ON")
                        .padding()
                }
                Button(action: {
                    arda.offButton()
                }) {
                    Text("OFF")
                        .padding()
                }
            }.padding()

            
            Text("temperature : \(arda.temperature)")
            Text("   humidity : \(arda.humidity)")
           
                .padding()
        }
      //  .onAppear(){
      //      arda.readData()
      //  }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Mara : Identifiable{
    var id   : String = UUID().uuidString
    var name : String
}
//make-it-so-77244-default-rtdb
class MaraModel : ObservableObject{
    
    @Published var mara = [Mara]()
    @Published var temperature: String = ""
    @Published var humidity : String = ""
    
    //( self.temperature as NSString).integerValue
    
    private var db = Firestore.firestore()
    private var  ref: DatabaseReference! = Database.database().reference()
    init(){
        readData()
        realTime()
    }
    //  "/DHT11/Temperature"
    //  "/DHT11/Humidity"
    
    func onButton() {
        self.ref.child("test").setValue(["relay-0": 1])
    }
    func offButton() {
        self.ref.child("test").setValue(["relay-0": 0])
    }

    func realTime(){

        self.ref.child("DHT11").child("Temperature").observe(.value) { snapshot in
            if let value = snapshot.value as? Int {
                print("DHT11/Temperature = \(value)")
                self.temperature = String(value)
              //  self.temperature = String(format: "%0.2f",value)
            }
        }
        self.ref.child("DHT11").child("Humidity").observe(.value) { snapshot in
            if let value = snapshot.value as? Int {
                print("DHT11/Humidity = \(value)")
                self.humidity =  String( value)
            }
        }

    }
    
    func readData() {
        db.collection("dossi").addSnapshotListener{ ( snap , err ) in
            guard let document = snap?.documents else {
                print("no document")
                return
            }
            self.mara =  document.map{ queryDoc -> Mara in
                let data = queryDoc.data()
                let name = data["name"] as? String ?? "....."
                let mara = Mara(name: name)
                return mara
            }
        }
    }
}
