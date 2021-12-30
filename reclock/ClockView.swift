//
//  ClockView.swift
//  reclock
//
//  Created by Mohammad Nauman on 30/12/2021.
//

import ScreenSaver

class ClockView: ScreenSaverView {
    private var timePosition: CGPoint = .zero
    private let timeRadius: CGFloat = 300
    private let fontSize: CGFloat = 100
    
    private let changeTime: NSInteger = 10
    private var timer: NSInteger = 0
    private let maxTimer: NSInteger = 300

    private let fontName = "Quicksand"
    // private let fontName = "American Typewriter"
    // private let fontName = "Marker Felt"
    
    private func getTimeString() -> String {

        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)

        let hour = components.hour
        let minute = components.minute
        let second = components.second
    
        let s_hour = String(format: "%02d", hour!)
        let s_minute = String(format: "%02d", minute!)
        let s_second = String(format: "%02d", second!)
    
        let today_string = s_hour  + " : " + s_minute + " : " + s_second

        return today_string
    }
    
    private func getRandomRect() -> NSRect {
        
        if (timer == 0 || timer == changeTime * 30) {
            let rX = CGFloat.random(in: 0.2...0.6)
            let rY = CGFloat.random(in: 0.2...0.6)
            
            timePosition.x = (bounds.size.width * rX)
            timePosition.y = (bounds.size.height * rY)
            
            timer = 1
        } else {
            timer += 1
        }
        
        let randomRect = NSRect(x: timePosition.x,
                                y: timePosition.y,
                                width: timeRadius * 2,
                                height: fontSize + 20)
        
        return randomRect
    }

    private func drawTime() {
        var timeRect: NSRect
        timeRect = getRandomRect()
        
        // draw the actual time now
        let font = NSFont(name:  fontName, size: fontSize)
        
        
        let timeText: String = getTimeString()
        let string = NSAttributedString(string: timeText, attributes: [
            .foregroundColor: NSColor.gray,
            .font: font
        ])
        
        string.draw(in: timeRect)
        
        // NSColor.white.setFill()
        // time.fill()
    }
    private func drawBackground(_ color: NSColor) {
        let background = NSBezierPath(rect: bounds)
        color.setFill()
        background.fill()
    }
    
    // MARK: - Initialization
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
    }

    @available(*, unavailable)
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func draw(_ rect: NSRect) {
        // Draw a single frame in this function
        drawBackground(.black)
        drawTime()
    }

    override func animateOneFrame() {
        super.animateOneFrame()

        // Update the "state" of the screensaver in this function
        
        setNeedsDisplay(bounds)
    }

}
