//
//  EventTableViewCell.swift
//  unipi-events
//
//  Created by Ildar Gubaydullin on 10/05/2018.
//  Copyright © 2018 Ildar Gubaydullin. All rights reserved.
//

import UIKit

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}

class EventTableViewCell: UITableViewCell {


    private let whiteRoundedCornerView = UIView()
    
    private let webView = UIWebView(frame: CGRect(x: 4, y: 4, width: 42, height: 42))
    
    let url: URLRequest = URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: "calend", ofType: "svg")! ))

    
    //MARK Params
    var caption: String = "" {
        didSet {
            if (caption != oldValue) {
                captionLabel.text = caption
            }
        }
    }

    var subCaption: String = "" {
        didSet {
            if (subCaption != oldValue) {
                subCaptionLabel.text = subCaption
            }
        }
    }

    var isFavorite: String = ""
    var isInternal: Bool = false
    var dateStart: String = ""
    var dateEnd: String = ""
    
    var captionLabel: UILabel!
    var subCaptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print("init")
        webView.loadRequest(url)
        webView.scrollView.isScrollEnabled = false
        webView.scalesPageToFit = true
        webView.contentMode = UIViewContentMode.scaleToFill
        //webView.
        
        setUp()
        
        let monthLayer = CATextLayer()
        monthLayer.frame = CGRect(x: 18, y: 5, width: 70, height: 50)
        monthLayer.string = "Май"
        monthLayer.fontSize = 16
        monthLayer.foregroundColor = UIColor.white.cgColor
        self.layer.addSublayer(monthLayer)
        monthLayer.zPosition = 20
        monthLayer.contentsScale = UIScreen.main.scale
        
        
        let dayLayer = CATextLayer()
        dayLayer.frame = CGRect(x: 28, y: 22, width: 70, height: 50)
        dayLayer.string = "24"
        dayLayer.fontSize = 28
        dayLayer.foregroundColor = UIColor.black.cgColor
        self.layer.addSublayer(dayLayer)
        dayLayer.zPosition = 21
        dayLayer.contentsScale = UIScreen.main.scale
        
        let weekdayLayer = CATextLayer()
        weekdayLayer.frame = CGRect(x: 20, y: 48, width: 70, height: 50)
        weekdayLayer.string = "Пятница"
        weekdayLayer.fontSize = 11
        weekdayLayer.foregroundColor = UIColor.black.cgColor
        self.layer.addSublayer(weekdayLayer)
        weekdayLayer.zPosition = 22
        weekdayLayer.contentsScale = UIScreen.main.scale
        
        let captionRect = CGRect(x: 90, y: 12, width: 400, height: 30)
        captionLabel = UILabel(frame: captionRect)
        captionLabel.text = "Название события"
        captionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        contentView.addSubview(captionLabel)

        let subCaptionRect = CGRect(x: 90, y: 36, width: 400, height: 30)
        subCaptionLabel = UILabel(frame: subCaptionRect)
        subCaptionLabel.text = "Организатор или место проведения"
        subCaptionLabel.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(subCaptionLabel)
    }
    
    private func setUp() {
        //setUpWhiteRoundedCornerView()
        
        self.firstShape()
    }
    
    private func setUpWhiteRoundedCornerView() {
        let child = whiteRoundedCornerView
        child.backgroundColor = UIColor.green
        
        let layer = child.layer
        layer.cornerRadius = 5.0
        layer.rasterizationScale = UIScreen.main.scale
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: -1, height: -1)
        layer.shadowOpacity = 0.5
        layer.shouldRasterize = true
        
        insertSubview(child, at: 0)
    }
    
    //MARK: Draw Svg Objects
    
    func firstShape() {
        
        //// Color Declarations
        let fillColor = UIColor(red: 0.878, green: 0.906, blue: 0.925, alpha: 1.000)
        let fillColor2 = UIColor(red: 0.867, green: 0.184, blue: 0.271, alpha: 1.000)
        let fillColor3 = UIColor(red: 0.953, green: 0.667, blue: 0.725, alpha: 1.000)
        
        //// Group 2
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 56, y: 49.93))
        bezierPath.addCurve(to: CGPoint(x: 49.77, y: 56.18), controlPoint1: CGPoint(x: 56, y: 53.44), controlPoint2: CGPoint(x: 53.27, y: 56.18))
        bezierPath.addLine(to: CGPoint(x: 6.23, y: 56.18))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 49.93), controlPoint1: CGPoint(x: 2.73, y: 56.18), controlPoint2: CGPoint(x: 0, y: 53.44))
        bezierPath.addLine(to: CGPoint(x: 0, y: 14.06))
        bezierPath.addCurve(to: CGPoint(x: 6.23, y: 7.81), controlPoint1: CGPoint(x: 0, y: 10.66), controlPoint2: CGPoint(x: 2.73, y: 7.81))
        bezierPath.addLine(to: CGPoint(x: 49.77, y: 7.81))
        bezierPath.addCurve(to: CGPoint(x: 56, y: 14.06), controlPoint1: CGPoint(x: 53.27, y: 7.81), controlPoint2: CGPoint(x: 56, y: 10.66))
        bezierPath.addLine(to: CGPoint(x: 56, y: 49.93))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 52.94, y: 0.02))
        bezier2Path.addLine(to: CGPoint(x: 47.8, y: 0.02))
        bezier2Path.addCurve(to: CGPoint(x: 48.23, y: 1.56), controlPoint1: CGPoint(x: 48.02, y: 0.46), controlPoint2: CGPoint(x: 48.23, y: 1.01))
        bezier2Path.addLine(to: CGPoint(x: 48.23, y: 1.56))
        bezier2Path.addCurve(to: CGPoint(x: 45.02, y: 4.46), controlPoint1: CGPoint(x: 48.15, y: 3.25), controlPoint2: CGPoint(x: 46.7, y: 4.55))
        bezier2Path.addCurve(to: CGPoint(x: 42.12, y: 1.23), controlPoint1: CGPoint(x: 43.33, y: 4.37), controlPoint2: CGPoint(x: 42.03, y: 2.93))
        bezier2Path.addCurve(to: CGPoint(x: 42.45, y: 0), controlPoint1: CGPoint(x: 42.14, y: 0.8), controlPoint2: CGPoint(x: 42.25, y: 0.38))
        bezier2Path.addLine(to: CGPoint(x: 13.56, y: 0.02))
        bezier2Path.addCurve(to: CGPoint(x: 14, y: 1.56), controlPoint1: CGPoint(x: 13.89, y: 0.46), controlPoint2: CGPoint(x: 14, y: 1.01))
        bezier2Path.addLine(to: CGPoint(x: 14, y: 1.56))
        bezier2Path.addCurve(to: CGPoint(x: 10.78, y: 4.46), controlPoint1: CGPoint(x: 13.91, y: 3.25), controlPoint2: CGPoint(x: 12.47, y: 4.55))
        bezier2Path.addCurve(to: CGPoint(x: 7.88, y: 1.23), controlPoint1: CGPoint(x: 9.09, y: 4.37), controlPoint2: CGPoint(x: 7.79, y: 2.93))
        bezier2Path.addCurve(to: CGPoint(x: 8.21, y: 0), controlPoint1: CGPoint(x: 7.91, y: 0.8), controlPoint2: CGPoint(x: 8.02, y: 0.38))
        bezier2Path.addLine(to: CGPoint(x: 3.06, y: 0.02))
        bezier2Path.addCurve(to: CGPoint(x: 0, y: 3.09), controlPoint1: CGPoint(x: 1.42, y: 0.02), controlPoint2: CGPoint(x: 0, y: 1.45))
        bezier2Path.addLine(to: CGPoint(x: 0, y: 20.31))
        bezier2Path.addLine(to: CGPoint(x: 56, y: 20.31))
        bezier2Path.addLine(to: CGPoint(x: 56, y: 3.09))
        bezier2Path.addCurve(to: CGPoint(x: 52.94, y: 0.02), controlPoint1: CGPoint(x: 56, y: 1.45), controlPoint2: CGPoint(x: 54.58, y: 0.02))
        bezier2Path.close()
        fillColor2.setFill()
        bezier2Path.fill()
        
        
        //// Group 3
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 50, y: 15.18, width: 3, height: 3))
        fillColor3.setFill()
        ovalPath.fill()
        
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalIn: CGRect(x: 50, y: 9.18, width: 3, height: 3))
        fillColor3.setFill()
        oval2Path.fill()
        
        
        //// Oval 3 Drawing
        let oval3Path = UIBezierPath(ovalIn: CGRect(x: 45, y: 15.18, width: 3, height: 3))
        fillColor3.setFill()
        oval3Path.fill()
        
        
        //// Oval 4 Drawing
        let oval4Path = UIBezierPath(ovalIn: CGRect(x: 45, y: 9.18, width: 3, height: 3))
        fillColor3.setFill()
        oval4Path.fill()
        
        
        //// Oval 5 Drawing
        let oval5Path = UIBezierPath(ovalIn: CGRect(x: 40, y: 15.18, width: 3, height: 3))
        fillColor3.setFill()
        oval5Path.fill()
        
        
        //// Oval 6 Drawing
        let oval6Path = UIBezierPath(ovalIn: CGRect(x: 40, y: 9.18, width: 3, height: 3))
        fillColor3.setFill()
        oval6Path.fill()

        
        let combinedPath: CGMutablePath = CGMutablePath.init()
        combinedPath.addPath(ovalPath.cgPath)
        combinedPath.addPath(oval2Path.cgPath)
        combinedPath.addPath(oval3Path.cgPath)
        combinedPath.addPath(oval4Path.cgPath)
        combinedPath.addPath(oval5Path.cgPath)
        combinedPath.addPath(oval6Path.cgPath)
        
        let startPosition = CGPoint(x: 15, y: 4)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.fillColor = fillColor.cgColor //UIColor.clear.cgColor
        shapeLayer.position = startPosition
        
        let shape2Layer = CAShapeLayer()
        shape2Layer.path = bezier2Path.cgPath
        shape2Layer.fillColor = fillColor2.cgColor //UIColor.clear.cgColor
        shape2Layer.position = startPosition
        
        let shape3Layer = CAShapeLayer()
        shape3Layer.path = combinedPath
        shape3Layer.fillColor = fillColor3.cgColor
        shape3Layer.position = startPosition
        
        self.layer.addSublayer(shapeLayer)
        self.layer.addSublayer(shape2Layer)
        self.layer.addSublayer(shape3Layer)
        
        shapeLayer.zPosition = 1
        shape2Layer.zPosition = 2
        shape3Layer.zPosition = 3
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //self.contentView.addSubview(webView)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        let bounds = self.bounds
//
//        var whiteRoundedCornerViewFrame = CGRect()
//        whiteRoundedCornerViewFrame.origin.x = 7
//        whiteRoundedCornerViewFrame.origin.y = 5
//        whiteRoundedCornerViewFrame.size.width = bounds.width - 7 - whiteRoundedCornerViewFrame.origin.x
//        whiteRoundedCornerViewFrame.size.height = bounds.height - 5 - whiteRoundedCornerViewFrame.origin.y
//        whiteRoundedCornerView.frame = whiteRoundedCornerViewFrame
//    }

}
