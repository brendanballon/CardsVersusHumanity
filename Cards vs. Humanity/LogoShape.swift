//
//  LogoShape.swift
//  Cards vs. Humanity
//
//  Created by Brendan Ballon on 4/30/23.
//

import SwiftUI

struct LogoShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.48809*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.58431*width, y: 0.01211*height), control1: CGPoint(x: 0.51671*width, y: 0.00362*height), control2: CGPoint(x: 0.55049*width, y: 0.00784*height))
        path.addCurve(to: CGPoint(x: 0.71636*width, y: 0.02872*height), control1: CGPoint(x: 0.62831*width, y: 0.01766*height), control2: CGPoint(x: 0.67236*width, y: 0.02317*height))
        path.addCurve(to: CGPoint(x: 0.84622*width, y: 0.04537*height), control1: CGPoint(x: 0.75964*width, y: 0.03422*height), control2: CGPoint(x: 0.80293*width, y: 0.03986*height))
        path.addCurve(to: CGPoint(x: 0.9424*width, y: 0.05716*height), control1: CGPoint(x: 0.87827*width, y: 0.04945*height), control2: CGPoint(x: 0.91027*width, y: 0.05404*height))
        path.addCurve(to: CGPoint(x: 0.99813*width, y: 0.12817*height), control1: CGPoint(x: 0.98147*width, y: 0.06092*height), control2: CGPoint(x: 1.00293*width, y: 0.08789*height))
        path.addCurve(to: CGPoint(x: 0.97396*width, y: 0.33518*height), control1: CGPoint(x: 0.98991*width, y: 0.19716*height), control2: CGPoint(x: 0.98218*width, y: 0.26619*height))
        path.addCurve(to: CGPoint(x: 0.94684*width, y: 0.55839*height), control1: CGPoint(x: 0.96507*width, y: 0.40959*height), control2: CGPoint(x: 0.95573*width, y: 0.48394*height))
        path.addCurve(to: CGPoint(x: 0.92489*width, y: 0.74688*height), control1: CGPoint(x: 0.93933*width, y: 0.62119*height), control2: CGPoint(x: 0.93227*width, y: 0.68404*height))
        path.addCurve(to: CGPoint(x: 0.91413*width, y: 0.83399*height), control1: CGPoint(x: 0.92147*width, y: 0.77592*height), control2: CGPoint(x: 0.91809*width, y: 0.805*height))
        path.addCurve(to: CGPoint(x: 0.85449*width, y: 0.88133*height), control1: CGPoint(x: 0.91009*width, y: 0.86358*height), control2: CGPoint(x: 0.88431*width, y: 0.8845*height))
        path.addCurve(to: CGPoint(x: 0.73089*width, y: 0.86615*height), control1: CGPoint(x: 0.8132*width, y: 0.87697*height), control2: CGPoint(x: 0.77204*width, y: 0.87133*height))
        path.addCurve(to: CGPoint(x: 0.67391*width, y: 0.85881*height), control1: CGPoint(x: 0.71187*width, y: 0.86376*height), control2: CGPoint(x: 0.69293*width, y: 0.86087*height))
        path.addCurve(to: CGPoint(x: 0.66062*width, y: 0.86161*height), control1: CGPoint(x: 0.6696*width, y: 0.85835*height), control2: CGPoint(x: 0.66484*width, y: 0.86*height))
        path.addCurve(to: CGPoint(x: 0.32044*width, y: 0.98959*height), control1: CGPoint(x: 0.54716*width, y: 0.90408*height), control2: CGPoint(x: 0.43347*width, y: 0.94596*height))
        path.addCurve(to: CGPoint(x: 0.23653*width, y: 0.94904*height), control1: CGPoint(x: 0.27667*width, y: 1.00651*height), control2: CGPoint(x: 0.24916*width, y: 0.98495*height))
        path.addCurve(to: CGPoint(x: 0.00542*width, y: 0.29321*height), control1: CGPoint(x: 0.15969*width, y: 0.73037*height), control2: CGPoint(x: 0.0824*width, y: 0.51183*height))
        path.addCurve(to: CGPoint(x: 0.04253*width, y: 0.21142*height), control1: CGPoint(x: -0.00831*width, y: 0.25422*height), control2: CGPoint(x: 0.00458*width, y: 0.22573*height))
        path.addCurve(to: CGPoint(x: 0.4108*width, y: 0.07317*height), control1: CGPoint(x: 0.1652*width, y: 0.16514*height), control2: CGPoint(x: 0.28796*width, y: 0.11904*height))
        path.addCurve(to: CGPoint(x: 0.42413*width, y: 0.05569*height), control1: CGPoint(x: 0.4196*width, y: 0.06986*height), control2: CGPoint(x: 0.42329*width, y: 0.06596*height))
        path.addCurve(to: CGPoint(x: 0.48809*width, y: 0), control1: CGPoint(x: 0.42716*width, y: 0.01931*height), control2: CGPoint(x: 0.44907*width, y: -0.00078*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.97404*width, y: 0.1261*height))
        path.addCurve(to: CGPoint(x: 0.94427*width, y: 0.08335*height), control1: CGPoint(x: 0.97551*width, y: 0.09729*height), control2: CGPoint(x: 0.96764*width, y: 0.08674*height))
        path.addCurve(to: CGPoint(x: 0.85564*width, y: 0.07188*height), control1: CGPoint(x: 0.9148*width, y: 0.07904*height), control2: CGPoint(x: 0.8852*width, y: 0.07564*height))
        path.addCurve(to: CGPoint(x: 0.72369*width, y: 0.05514*height), control1: CGPoint(x: 0.81164*width, y: 0.06628*height), control2: CGPoint(x: 0.76764*width, y: 0.06073*height))
        path.addCurve(to: CGPoint(x: 0.59382*width, y: 0.03862*height), control1: CGPoint(x: 0.6804*width, y: 0.04963*height), control2: CGPoint(x: 0.63711*width, y: 0.04413*height))
        path.addCurve(to: CGPoint(x: 0.484*width, y: 0.02477*height), control1: CGPoint(x: 0.55724*width, y: 0.03394*height), control2: CGPoint(x: 0.52067*width, y: 0.0289*height))
        path.addCurve(to: CGPoint(x: 0.44907*width, y: 0.05344*height), control1: CGPoint(x: 0.46498*width, y: 0.02261*height), control2: CGPoint(x: 0.45209*width, y: 0.03367*height))
        path.addCurve(to: CGPoint(x: 0.44444*width, y: 0.09156*height), control1: CGPoint(x: 0.44711*width, y: 0.06606*height), control2: CGPoint(x: 0.44596*width, y: 0.07885*height))
        path.addCurve(to: CGPoint(x: 0.42591*width, y: 0.24394*height), control1: CGPoint(x: 0.43827*width, y: 0.14234*height), control2: CGPoint(x: 0.43196*width, y: 0.19312*height))
        path.addCurve(to: CGPoint(x: 0.40604*width, y: 0.41385*height), control1: CGPoint(x: 0.41916*width, y: 0.30055*height), control2: CGPoint(x: 0.4128*width, y: 0.35725*height))
        path.addCurve(to: CGPoint(x: 0.38324*width, y: 0.60216*height), control1: CGPoint(x: 0.39858*width, y: 0.47665*height), control2: CGPoint(x: 0.3908*width, y: 0.5394*height))
        path.addCurve(to: CGPoint(x: 0.3648*width, y: 0.75784*height), control1: CGPoint(x: 0.37702*width, y: 0.65404*height), control2: CGPoint(x: 0.37116*width, y: 0.70601*height))
        path.addCurve(to: CGPoint(x: 0.39071*width, y: 0.79739*height), control1: CGPoint(x: 0.36222*width, y: 0.77885*height), control2: CGPoint(x: 0.37076*width, y: 0.79294*height))
        path.addCurve(to: CGPoint(x: 0.41702*width, y: 0.8011*height), control1: CGPoint(x: 0.39933*width, y: 0.79931*height), control2: CGPoint(x: 0.40822*width, y: 0.8*height))
        path.addCurve(to: CGPoint(x: 0.52996*width, y: 0.81546*height), control1: CGPoint(x: 0.45467*width, y: 0.80592*height), control2: CGPoint(x: 0.49231*width, y: 0.81069*height))
        path.addCurve(to: CGPoint(x: 0.64293*width, y: 0.82972*height), control1: CGPoint(x: 0.5676*width, y: 0.82023*height), control2: CGPoint(x: 0.60529*width, y: 0.82495*height))
        path.addCurve(to: CGPoint(x: 0.75591*width, y: 0.84408*height), control1: CGPoint(x: 0.68058*width, y: 0.8345*height), control2: CGPoint(x: 0.71822*width, y: 0.83936*height))
        path.addCurve(to: CGPoint(x: 0.85418*width, y: 0.85596*height), control1: CGPoint(x: 0.78867*width, y: 0.84821*height), control2: CGPoint(x: 0.82133*width, y: 0.85289*height))
        path.addCurve(to: CGPoint(x: 0.89098*width, y: 0.82372*height), control1: CGPoint(x: 0.87742*width, y: 0.85817*height), control2: CGPoint(x: 0.88849*width, y: 0.84734*height))
        path.addCurve(to: CGPoint(x: 0.89596*width, y: 0.78124*height), control1: CGPoint(x: 0.89249*width, y: 0.80954*height), control2: CGPoint(x: 0.89427*width, y: 0.79541*height))
        path.addCurve(to: CGPoint(x: 0.91222*width, y: 0.64624*height), control1: CGPoint(x: 0.90138*width, y: 0.73624*height), control2: CGPoint(x: 0.90684*width, y: 0.69124*height))
        path.addCurve(to: CGPoint(x: 0.928*width, y: 0.51229*height), control1: CGPoint(x: 0.91756*width, y: 0.60161*height), control2: CGPoint(x: 0.92271*width, y: 0.55693*height))
        path.addCurve(to: CGPoint(x: 0.94427*width, y: 0.37619*height), control1: CGPoint(x: 0.93338*width, y: 0.46693*height), control2: CGPoint(x: 0.93884*width, y: 0.42156*height))
        path.addCurve(to: CGPoint(x: 0.96031*width, y: 0.24229*height), control1: CGPoint(x: 0.9496*width, y: 0.33156*height), control2: CGPoint(x: 0.95498*width, y: 0.28693*height))
        path.addCurve(to: CGPoint(x: 0.97404*width, y: 0.1261*height), control1: CGPoint(x: 0.96507*width, y: 0.20193*height), control2: CGPoint(x: 0.96982*width, y: 0.16165*height))
        path.closeSubpath()
        return path
    }
}
