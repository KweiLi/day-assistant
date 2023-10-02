//
//  LoadingView.swift
//  day-assistant
//
//  Created by Kun Chen on 2023-09-28.
//

import SwiftUI

struct LoadingView: View {
    
    // MARK: - Body
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Preview
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
