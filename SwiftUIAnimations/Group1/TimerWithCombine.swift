//
//  ContentView.swift
//  CombineWIthTimer
//
//  Created by Sajan Shrestha on 1/5/21.
//

import SwiftUI
import Combine

struct TimerWithCombine: View {
    
    @ObservedObject var counter = Counter(from: 3, to: 1)
    @State private var newYear = false
    
    var body: some View {
        ZStack {
            Text("\(counter.currentCount)")
                .font(Font.custom("menlo", size: 150))
                .foregroundColor(colors[counter.currentCount % 5])
                .opacity(newYear ? 0 : 1)
                .animation(.spring())
                .onAppear { counter.count() { newYear = true } }
            
            HNYView()
                .opacity(newYear ? 1 : 0)
                .animation(.easeInOut)
            
            if newYear { LottieView(filename: "fireworks3") }
            
        }
    }
    
    // MARK:- CONSTANTS
    private let colors = [Color.pink, Color.yellow, Color.purple, Color.blue, Color.green]

}

class Counter: ObservableObject {
    
    @Published var currentCount = 0
    var destinationCount: Int
    var subscriber: AnyCancellable?
    
    init(from initialCount: Int, to destinationCount: Int) {
        self.currentCount = initialCount
        self.destinationCount = destinationCount
    }
    
    func count(completion: @escaping () -> Void) {
        
        let publisher = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
        
        subscriber = publisher.sink { _ in
            self.adjustCurrentCount(to: self.destinationCount, completion: completion)
        }
    }
    
    private func adjustCurrentCount(to endCount: Int, completion: @escaping () -> Void) {
        if currentCount > endCount {
            currentCount -= 1
        }
        else if currentCount < endCount {
            currentCount += 1
        }
        else {
            subscriber?.cancel()
            completion()
        }
    }
}


struct HNYView: View {
    var body: some View {
        HStack(spacing: 40) {
            StringyLetter(height: 300, letter: "H")
            StringyLetter(height: 320, letter: "N")
            StringyLetter(height: 290, letter: "Y")
        }
    }
}


struct StringyLetter: View {
    
    var height: CGFloat
    var letter: String
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 1, height: height)
            Text(letter)
                .font(.largeTitle)
                .offset(y: -24)
                .foregroundColor(Color.purple)
            Spacer()
        }
    }
}

struct StringyLetter_Previews: PreviewProvider {
    static var previews: some View {
        StringyLetter(height: 1.0, letter: "")
    }
}
