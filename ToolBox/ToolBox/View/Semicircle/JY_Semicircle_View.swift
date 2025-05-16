//
//  JY_Semicircle_View.swift
//  JY_Treasure_Box
//
//  Created by JYYQLin on 2025/5/6.
//

import UIKit

class JY_Semicircle_View: JY_View {
    private let yq_shape_layer = CAShapeLayer()
    private let yq_left_circle_layer = CAShapeLayer()
    private let yq_right_circle_layer = CAShapeLayer()
    
    private lazy var yq_bgColor: UIColor = UIColor.clear
    var yq_percentage: CGFloat = 100 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
}

extension JY_Semicircle_View {
    func yq_set(bgColor: UIColor) {
        yq_bgColor = bgColor
        setupLayers()
    }
}

extension JY_Semicircle_View {
    private func setupLayers() {
        yq_shape_layer.strokeColor = yq_bgColor.cgColor
        yq_shape_layer.fillColor = UIColor.clear.cgColor
        yq_shape_layer.lineWidth = 20.0
        layer.addSublayer(yq_shape_layer)
        
        yq_left_circle_layer.fillColor = yq_bgColor.cgColor
        layer.addSublayer(yq_left_circle_layer)
        
        yq_right_circle_layer.fillColor = yq_bgColor.cgColor
        layer.addSublayer(yq_right_circle_layer)
    }
}

extension JY_Semicircle_View {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.maxY - yq_shape_layer.lineWidth * 0.5)
        let radius = min(bounds.width, bounds.height) - yq_shape_layer.lineWidth
        let startAngle = -CGFloat.pi
        let endAngle = startAngle + CGFloat.pi * (yq_percentage / 100)
        let semicirclePath = UIBezierPath(arcCenter: center,
                                          radius: radius,
                                          startAngle: startAngle,
                                          endAngle: endAngle,
                                          clockwise: true)
        yq_shape_layer.path = semicirclePath.cgPath
        
        // 计算弧线端点位置
        let leftEndPoint = CGPoint(x: center.x - radius, y: center.y)
        let rightEndPoint = CGPoint(x: center.x + radius * cos(endAngle), y: center.y + radius * sin(endAngle))
        
        // 计算圆的半径（等于弧线宽度的一半）
        let circleRadius = yq_shape_layer.lineWidth / 2
        
        // 绘制左圆
        let leftCirclePath = UIBezierPath(arcCenter: leftEndPoint,
                                          radius: circleRadius,
                                          startAngle: 0,
                                          endAngle: 2 * CGFloat.pi,
                                          clockwise: true)
        yq_left_circle_layer.path = leftCirclePath.cgPath
        
        // 绘制右圆
        let rightCirclePath = UIBezierPath(arcCenter: rightEndPoint,
                                           radius: circleRadius,
                                           startAngle: 0,
                                           endAngle: 2 * CGFloat.pi,
                                           clockwise: true)
        yq_right_circle_layer.path = rightCirclePath.cgPath
    }
}
