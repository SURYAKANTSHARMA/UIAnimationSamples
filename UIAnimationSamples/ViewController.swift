
import UIKit

class ViewController: UIViewController {

  /// The currently selected curve to be used for all animations
  var selectedCurve: UIView.AnimationCurve = .easeInOut
  let colors: [UIColor] = [.white, .red, .green, .orange, .yellow, .lightGray, .darkGray]

  /// The ⬇️ button that rotates and moves around the screen
  @IBOutlet var movingButton: UIButton!

  /// The fake HUD view
  @IBOutlet var hud: FakeHUD?
  
  @IBAction func moveTo(button: UIButton) {
    // 1
    let destination = view.convert(button.center, from: button.superview)
    
    // 2
    movingButton.move(to: destination.applying(
      CGAffineTransform(translationX: 0.0, y: -70.0)),
                      duration: 1.0,
                      options: selectedCurve.animationOption)

  }
  
  @IBAction func rotate(button: UIButton) {
    button.rotate180(duration: 1.0, options: selectedCurve.animationOption)
  }
  
  @IBAction func zoomIn(button: UIButton) {
    // 1
    let pickerVC = AnimationCurvePickerViewController(style: .grouped)
    // 2
    pickerVC.delegate = self
    // 3
    pickerVC.view.bounds = CGRect(x: 0, y: 0, width: 280, height: 300)
    // 4
    pickerVC.view.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    
    // 5
    addChild(pickerVC)
    // 6
    view.addSubviewWithZoomInAnimation(pickerVC.view, duration: 1.0,
                                       options: selectedCurve.animationOption)
    // 7
    pickerVC.didMove(toParent: self)

  }
  
  @IBAction func showHUD() {
    // 1
    let nib = UINib.init(nibName: "FakeHUD", bundle: nil)
    nib.instantiate(withOwner: self, options: nil)
    
    if let hud = hud {
      // 2
      hud.center = view.center
      // 3
      view.addSubviewWithFadeAnimation(hud, duration: 1.0,
                                       options: selectedCurve.animationOption)
    }

  }
  
  @IBAction func dismissHUD() {
    hud?.removeWithSinkAnimation(steps: 75)

  }

  @IBAction func changeBackgroundColor() {
    view.changeColor(to: colors.randomElement()!, duration: 1.0,
                     options: selectedCurve.animationOption)

  }



}

// MARK: AnimationCurvePickerViewControllerDelegate
extension ViewController: AnimationCurvePickerViewControllerDelegate {
  
  func animationCurvePickerViewController(_ controller: AnimationCurvePickerViewController, didSelectCurve curve: UIView.AnimationCurve) {
    // 1
    selectedCurve = curve
    // 2
    controller.willMove(toParent: nil)
    // 3
    controller.view.removeWithZoomOutAnimation(duration: 1.0,
                                               options: selectedCurve.animationOption)
    // 4
    controller.removeFromParent()

  }
  
  
  
}
