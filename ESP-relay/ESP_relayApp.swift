//
//  ESP_relayApp.swift
//  ESP-relay
//
//  Created by Dosi Dimitrov on 18.01.22.
//

import SwiftUI
import Firebase

@main
struct ESP_relayApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            //ContentView()
            ESP32View()
         
        }
    }
}
