import Foundation
import UIKit

struct Utils {
   static func createTwoCirclesImage(size: CGSize, firstCircleRadius: CGFloat, secondCircleRadius: CGFloat,
                                     ringWidth: CGFloat,
                                     openingRatio: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
       guard UIGraphicsGetCurrentContext() != nil else {
            return nil
        }
        
        let center = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
            let radius = min(size.width, size.height) / 2.0
            
            // Desenha o fundo
            let backgroundPath = UIBezierPath(arcCenter: center,
                                              radius: radius, startAngle: 0,
                                              endAngle: CGFloat.pi * 2, clockwise: true)
            UIColor.white.setFill()
            backgroundPath.fill()
            
            // Calcula os ângulos de início e término da abertura
            let openingAngle = CGFloat.pi * 2 * openingRatio
            let startAngle = (CGFloat.pi / 4.0) - (openingAngle / 2.0)
            let endAngle = startAngle + openingAngle
            
            // Desenha o anel externo
            let ringPath = UIBezierPath(arcCenter: center,
                                        radius: radius - ringWidth / 2.0,
                                        startAngle: startAngle,
                                        endAngle: endAngle, clockwise: true)
            UIColor.midnightBlue.setStroke()
            ringPath.lineWidth = ringWidth
            ringPath.lineCapStyle = .round
            ringPath.stroke()
        
        // Desenha o primeiro círculo
        let firstCirclePath = UIBezierPath(arcCenter: center,
                                           radius: firstCircleRadius,
                                           startAngle: 0,
                                           endAngle: CGFloat.pi * 2, clockwise: true)
        UIColor.cyan.setFill()
        firstCirclePath.fill()
        
        // Calcula a posição do segundo círculo (canto superior esquerdo do primeiro círculo)
        let xPosition = center.x - firstCircleRadius
        let yPosition = center.y - firstCircleRadius
        
        // Desenha o segundo círculo
        let secondCirclePath = UIBezierPath(arcCenter: CGPoint(x: xPosition - 1, y: yPosition - 1),
                                            radius: secondCircleRadius,
                                            startAngle: 0,
                                            endAngle: CGFloat.pi * 2, clockwise: true)
        UIColor.cyan.setFill()
        secondCirclePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
