
import UIKit

extension UIView {
  func move(to destination: CGPoint, duration: TimeInterval,
            options: UIView.AnimationOptions) {
    UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
      self.center = destination
    }, completion: nil)
  }
  
  func rotate180(duration: TimeInterval, options: UIView.AnimationOptions) {
    UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
      self.transform = self.transform.rotated(by: CGFloat.pi)
    }, completion: nil)
  }

  func addSubviewWithZoomInAnimation(_ view: UIView, duration: TimeInterval,
                                     options: UIView.AnimationOptions) {
    // 1
    view.transform = view.transform.scaledBy(x: 0.01, y: 0.01)
    
    // 2
    addSubview(view)
    
    UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
      // 3
      view.transform = CGAffineTransform.identity
    }, completion: nil)
  }

  
  func removeWithZoomOutAnimation(duration: TimeInterval,
                                  options: UIView.AnimationOptions) {
    UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
      // 1
      self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    }, completion: { _ in
      // 2
      self.removeFromSuperview()
    })
  }

  func addSubviewWithFadeAnimation(_ view: UIView, duration: TimeInterval, options: UIView.AnimationOptions) {
    // 1
    view.alpha = 0.0
    // 2
    addSubview(view)
    
    UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
      // 3
      view.alpha = 1.0
    }, completion: nil)
  }

  
  func removeWithSinkAnimation(steps: Int) {
    // 1
    guard 1..<100 ~= steps else {
      fatalError("Steps must be between 0 and 100.")
    }
    // 2
    tag = steps
    // 3
    _ = Timer.scheduledTimer(
      timeInterval: 0.05,
      target: self,
      selector: #selector(removeWithSinkAnimationRotateTimer),
      userInfo: nil,
      repeats: true)
  }
  
  @objc func removeWithSinkAnimationRotateTimer(timer: Timer) {
    // 1
    let newTransform = transform.scaledBy(x: 0.9, y: 0.9)
    // 2
    transform = newTransform.rotated(by: 0.314)
    // 3
    alpha *= 0.98
    // 4
    tag -= 1;
    // 5
    if tag <= 0 {
      timer.invalidate()
      removeFromSuperview()
    }
  }


  func changeColor(to color: UIColor, duration: TimeInterval,
                   options: UIView.AnimationOptions) {
    UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
      self.backgroundColor = color
    }, completion: nil)
  }

  
  
}

