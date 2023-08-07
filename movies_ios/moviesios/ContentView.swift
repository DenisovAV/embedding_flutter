//
//  ContentView.swift
//  moviesios
//
//  Created by Aleksandr Denisov on 07.08.23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var flutterDependencies: FlutterDependencies
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    FlutterView(engine: flutterDependencies.showMoviesScreenEngine)
                    Image("apple")
                        .padding(50)
                    Text("This is an example of simple SwiftUI application, created specifically for my talk")
                        .multilineTextAlignment(.center)
                        .bold()
                    FlutterView(engine: flutterDependencies.showMoviesDetailsEngine)
                }
                .padding()
                FloatingButton(action: {
                    // Perform some action here...
                }, icon: "globe")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

