/*
 Animation 1
 Use of implicit animation. When opacity changes from 1 to 0,
 SwiftUI knows how to interpolate the values.
 The framework can display 0.9, 0.8, 0.7 and so on, until it is 0.0.
 */

import SwiftUI

struct OpacityAnimation: View {
    
    @State private var hidden = false
        
    var body: some View {
        Label("Play", systemImage: "play")
            .padding()
            .background(Color.orange)
            .opacity(hidden ? 0 : 1)
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/(duration: 1))
            .onTapGesture {
                playMusic()
            }
    }
    
    private func playMusic() {
        hidden = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OpacityAnimation()
    }
}
