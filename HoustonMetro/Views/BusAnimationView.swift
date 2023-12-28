//
//  BusAnimationView.swift
//  HoustonMetro
//
//  Created by Tomas Sanni on 10/22/23.
//

import SwiftUI

struct BusAnimationView: View {
    @State private var startBusAnimation: Bool = false
    @EnvironmentObject var metroInfo: MetroInfoViewModel


    var body: some View {
        VStack {
            Image(systemName: "bus")
                .font(.largeTitle)
                .scaleEffect(startBusAnimation ? 2 : 1.5)
        }
        .onReceive(metroInfo.$dataExists) { _ in
            withAnimation(.linear(duration: 1).repeatCount(5, autoreverses: true)) {
                startBusAnimation.toggle()
            }
        }

    }
}

#Preview {
    BusAnimationView()
        .environmentObject(MetroInfoViewModel())
}
