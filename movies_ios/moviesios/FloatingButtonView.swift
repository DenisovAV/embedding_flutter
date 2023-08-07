//
//  FloatingButtonView.swift
//  moviesios
//
//  Created by Aleksandr Denisov on 07.08.23.
//

import SwiftUI

struct FloatingButton: View {
    let action: () -> Void
    let icon: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: action) {
                    Image(systemName: icon)
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                }
                .frame(width: 60, height: 60)
                .background(Color.red)
                .cornerRadius(30)
                .shadow(radius: 10)
                .offset(x: -25, y: 10)
            }
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(action: {
            // Perform some action here...
        }, icon: "plus")
    }
}
