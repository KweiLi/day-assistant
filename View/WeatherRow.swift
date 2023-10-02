//
//  WeatherRow.swift
//  day-assistant
//
//  Created by Kun Chen on 2023-09-28.
//

import SwiftUI

struct WeatherRow: View {
    // MARK: - Properties
    var logo: String
    var name: String
    var value: String
    var size: CGFloat
    var color: Color = Color(hue: 1.0, saturation: 0.0, brightness: 0.808)
    
    // MARK: - Body
    var body: some View {
        HStack {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: size, height: size)
                .padding()
                .background(color)
                .cornerRadius(50)
            
            VStack {
                Text(name)
                    .font(.caption)
                
                Text(value)
                    .bold()
                    .font(.title3)
            } // VStack
        } // HStack
    }
}

// MARK: - Preview
struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(logo: "thermometer", name: "Feels like", value: "8", size: 20)
    }
}
