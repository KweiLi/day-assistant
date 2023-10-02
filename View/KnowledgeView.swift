//
//  KnowledgeView.swift
//  AppHome
//
//  Created by Kun Chen on 2023-06-26.
//

import SwiftUI

struct KnowledgePanel: Identifiable {
    let name: String
    let image: String
    var id: String { name }
}

struct KnowledgeView: View {
    
    private var twoColumnGrid = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State var knowledgePanels: [KnowledgePanel] = [
        KnowledgePanel(name: "Stories", image: "reading"),
        KnowledgePanel(name: "Meditation", image: "meditation"),
        KnowledgePanel(name: "Nature", image: "environment"),
        KnowledgePanel(name: "Support", image: "networking"),
    ]
    
    var body: some View {
        LazyVGrid(columns: twoColumnGrid) {
            ForEach($knowledgePanels) { $panel in
                PanelView(panel: $panel)
            }
        }

    }
}

struct KnowledgeView_Previews: PreviewProvider {
    static var previews: some View {
        KnowledgeView()
    }
}
