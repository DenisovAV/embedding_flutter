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
      let channel = FlutterMethodChannel(name: "OPEN",
                                         binaryMessenger: showMoviesScreenEngine.binaryMessenger)
      
      showMoviesDetailsEngine = engines.makeEngine(withEntrypoint: "showMoviesDetails", libraryURI: nil)
      showMoviesDetailsEngine.run()

      let eventChannel = FlutterEventChannel(name: "MOVIES", binaryMessenger: showMoviesDetailsEngine.binaryMessenger)
    // Runs the default Dart entrypoint with a default Flutter route.
    // Connects plugins with iOS platform code to this app.
      GeneratedPluginRegistrant.register(with: showMoviesScreenEngine)
      GeneratedPluginRegistrant.register(with: showMoviesDetailsEngine)
      
      let streamHandler = StreamHandler();
      
      eventChannel.setStreamHandler(streamHandler)

      channel.setMethodCallHandler({
        (call: FlutterMethodCall, result: FlutterResult) -> Void in
        guard call.method == "CALL" else {
          result(FlutterMethodNotImplemented)
          return
        }
        if let arguments = call.arguments as? [String: Any], let movie = arguments["NAME"] as? String{
            streamHandler.eventSink!(movie)
        }
        result("OK")
      })
  }
}

class StreamHandler:NSObject, FlutterStreamHandler {
    
  var eventSink: FlutterEventSink?
  
  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
      self.eventSink = events
    return nil
  }
  
  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    return nil
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
