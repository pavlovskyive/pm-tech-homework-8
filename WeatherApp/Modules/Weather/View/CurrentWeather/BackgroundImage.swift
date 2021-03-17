//
//  BackgroundImage.swift
//  WeatherApp
//
//  Created by Vsevolod Pavlovskyi on 17.03.2021.
//

import SwiftUI
import Combine

struct BackgroundImage: View {

    @State var offsetX = CGFloat.random(in: -200 ... 200)
    @State var offsetY = CGFloat.random(in: -100 ... 100)

    var timer: Publishers.Autoconnect<Timer.TimerPublisher>

    var image: Image?

    init(_ image: Image?) {
        self.image = image

        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    }

    var body: some View {
        if let image = image {
            GeometryReader { geometry in
                image
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .opacity(0.05)
                    .offset(x: offsetX, y: offsetY)
                    .onReceive(timer, perform: { _ in
                        withAnimation {
                            offsetX += 1
                        }

                        if offsetX >= geometry.frame(in: .local).maxX {
                            offsetX = -geometry.frame(in: .local).maxX
                            offsetY = CGFloat.random(in: -200 ... 200)
                        }
                    })
            }
        }
    }
}

struct BackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImage(Image(systemName: "sun.min.fill"))
            .background(Color.blue.edgesIgnoringSafeArea(.all))
    }
}
