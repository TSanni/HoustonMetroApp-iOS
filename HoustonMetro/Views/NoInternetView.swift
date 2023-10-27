//
//  NoInternetView.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/22/23.
//

import SwiftUI

struct NoInternetView: View {
    @State private var startBlink: Bool = false
    var body: some View {
        VStack {
            Text("The app is not connected to the internet. To view metro details, check your internet connection, then try again.")
                .multilineTextAlignment(.center)
            Image(systemName: "wifi.exclamationmark")
                .font(.largeTitle)
                .opacity(startBlink ? 0 : 1)
                .scaleEffect(2)
                .padding()

        }
        .padding()
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5).repeatForever()) {
                startBlink = true
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(K.failColor)
    }
}

#Preview {
    NoInternetView()
}
