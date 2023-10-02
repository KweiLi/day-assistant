//
//  KnowledgePanelView.swift
//  AppHome
//
//  Created by Kun Chen on 2023-06-27.
//

import SwiftUI

struct PanelView: View {
    
    @Binding var panel: KnowledgePanel
    
    var body: some View {
        ZStack {
            Image(panel.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(15)
                .opacity(0.7)
            
            Text(panel.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct PanelView_Previews: PreviewProvider {
    static var previews: some View {
        KnowledgeView()
    }
}
