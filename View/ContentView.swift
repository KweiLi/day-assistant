//
//  ContentView.swift
//  day-assistant
//
//  Created by Kun Chen on 2023-09-28.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    @StateObject var weatherManager = WeatherManager()

    var body: some View {
        
        ZStack{
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            ScrollView{
                VStack(spacing: 30){
                    WeatherView()
                    
                    ToDoView()
                    
                    EventView()
                    
                }.padding()
            }.scrollIndicators(.never)
            .scrollDismissesKeyboard(.immediately)

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
