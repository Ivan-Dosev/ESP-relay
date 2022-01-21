//
//  TemperatureView.swift
//  Bert
//
//  Created by Dosi Dimitrov on 14.01.22.
//

import SwiftUI

struct TemperatureView: View {
    
    @Binding var temperature : String
    @Binding var humidity : String
    @Binding var isHighTemperature: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Temperature: ")
                    .frame(width: 200, height: 30, alignment: .trailing)
                Text(temperature)
                    .frame(width: 70, height: 30, alignment: .trailing)
                Text("°C")
                    .frame(width: 20, height: 30, alignment: .trailing)
            }
            .background(isHighTemperature ? .yellow : .clear)
            .frame(width: UIScreen.main.bounds.width , height: 70, alignment: .leading)
            HStack {
                Text("Humidity: ")
                    .frame(width: 200, height: 30, alignment: .trailing)
                Text( humidity  )
                    .frame(width: 70, height: 30, alignment: .trailing)
                Text("%")
                    .frame(width: 20, height: 30, alignment: .trailing)
            }
            .frame(width: UIScreen.main.bounds.width , height: 70, alignment: .leading)
        }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView(temperature: .constant("dd"), humidity: .constant("aa"), isHighTemperature: .constant(false))
    }
}
