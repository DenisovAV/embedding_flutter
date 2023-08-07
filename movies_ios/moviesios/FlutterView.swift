//
//  FlutterView.swift
//  embedding_flutter_swiftui
//
//  Created by Aleksandr Denisov on 05.06.23.
//

import SwiftUI
import Flutter

struct FlutterView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = FlutterViewController
    
    let controller: FlutterViewController
    
    init(engine: FlutterEngine) {
        controller = FlutterViewController(
            engine: engine, nibName: nil, bundle: nil)
        controller.modalPresentationStyle = .overCurrentContext
        controller.isViewOpaque = false
    }
    
    func makeUIViewController(context: Context) -> FlutterViewController {
        return controller
    }
    
    func updateUIViewController(_ uiViewController: FlutterViewController, context: Context) {
    }
}

