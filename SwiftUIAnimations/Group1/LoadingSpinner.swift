//
//  LoadingSpinner.swift
//  SwiftUIAnimations
//
//  Created by Sajan Shrestha on 1/6/21.
//

import SwiftUI

struct LoadingSpinner: View {
    
    @State private var rotating = false
    
    var body: some View {
        Image(systemName: "arrow.triangle.2.circlepath.circle")
            .resizable()
            .frame(width: 100, height: 100)
            .rotationEffect(rotating ? .degrees(360) : .zero)
            .animation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false))
            .onAppear {
                rotating = true
            }
    }
}

struct LoadingSpinner_Previews: PreviewProvider {
    static var previews: some View {
        LoadingSpinner()
    }
}
