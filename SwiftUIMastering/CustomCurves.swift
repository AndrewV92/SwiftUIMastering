//
//  CustomCurves.swift
//  SwiftUIMastering
//
//  Created by Андрей Воробьев on 18.07.2022.
//

import SwiftUI

struct CustomCurves: View {
    var body: some View {
        WaterShape()
            .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]), startPoint: .leading, endPoint: .trailing))
            //.stroke(lineWidth: 5)
            //.frame(width: 200, height: 200)
            .ignoresSafeArea()
            
    }
}

struct CustomCurves_Previews: PreviewProvider {
    static var previews: some View {
        CustomCurves()
    }
}


struct ArcSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midY, y: rect.midY),
                        radius: rect.height / 2,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 40),
                        clockwise: true)
        }
    }
}

struct ShapeWithArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            //path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                        radius: rect.height / 2,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 180),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}

struct QuadSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY),
                              control: CGPoint(x: rect.maxX - 50, y: rect.minY - 100))
        }
    }
}

struct WaterShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY),
                              control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.40))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
                              control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.6))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}
