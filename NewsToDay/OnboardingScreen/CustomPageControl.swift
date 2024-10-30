



import UIKit
import SnapKit

class CustomPageControl: UIView {

    var numberOfPages: Int = 3 {
        didSet { setupDots() }
    }
    
    var currentPage: Int = 0 {
        didSet { updateActiveDot() }
    }

    private var dotViews: [UIView] = []
    private let activeDotView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupActiveDot()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupActiveDot()
    }

    private func setupActiveDot() {
        activeDotView.backgroundColor = UIColor.app(.purplePrimary)
        activeDotView.layer.cornerRadius = 4
        addSubview(activeDotView)
    }

    private func setupDots() {
        dotViews.forEach { $0.removeFromSuperview() }
        dotViews.removeAll()

        for _ in 0..<numberOfPages {
            let dotView = UIView()
            dotView.backgroundColor = UIColor.app(.greyLighter)
            dotView.layer.cornerRadius = 4
            addSubview(dotView)
            dotViews.append(dotView)
        }
        layoutDots()
        updateActiveDot()
    }

    private func layoutDots() {
        let dotSize: CGFloat = 8
        let dotSpacing: CGFloat = 24
        for (index, dotView) in dotViews.enumerated() {
            dotView.frame = CGRect(x: CGFloat(index) * (dotSize + dotSpacing), y: 0, width: dotSize, height: dotSize)
        }
        activeDotView.frame = CGRect(x: 0, y: 0, width: dotSize * 2, height: dotSize)
    }

    private func updateActiveDot() {
        guard currentPage < dotViews.count else { return }
        
        for (index, dotView) in dotViews.enumerated() {
                    dotView.alpha = (index == currentPage ) ? 0 : 1
                }
        
            
        
        UIView.animate(withDuration: 0.3, animations: {
            let dotSize: CGFloat = 8
            let dotSpacing: CGFloat = 19
            let xOffset = CGFloat(self.currentPage) * (dotSize + dotSpacing)
            self.activeDotView.frame = CGRect(x: xOffset, y: 0, width: dotSize * 2.5, height: dotSize)
        })
        
    }
}

#Preview { OnboardingViewController() }
