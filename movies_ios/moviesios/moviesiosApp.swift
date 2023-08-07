//
//  moviesiosApp.swift
//  moviesios
//
//  Created by Aleksandr Denisov on 07.08.23.
//

import SwiftUI

import Flutter
import FlutterPluginRegistrant

class FlutterDependencies: ObservableObject {
 
    let engines = FlutterEngineGroup(name: "multiple-flutters", project: nil)
    let showMoviesScreenEngine: FlutterEngine
    let showMoviesDetailsEngine: FlutterEngine
    
  init(){
      showMoviesScreenEngine = engines.makeEngine(withEntrypoint: "showMoviesScreen", libraryURI: nil)
      showMoviesScreenEngine.run()
      showMoviesDetailsEngine = engines.makeEngine(withEntrypoint: "showMoviesDetails", libraryURI: nil)
      showMoviesDetailsEngine.run()
    // Runs the default Dart entrypoint with a default Flutter route.
    // Connects plugins with iOS platform code to this app.
      GeneratedPluginRegistrant.register(with: showMoviesScreenEngine)
      GeneratedPluginRegistrant.register(with: showMoviesDetailsEngine)
  }
}

@main
struct moviesiosApp: App {
    
    @StateObject var flutterDependencies = FlutterDependencies()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(flutterDependencies)
        }
    }
}
