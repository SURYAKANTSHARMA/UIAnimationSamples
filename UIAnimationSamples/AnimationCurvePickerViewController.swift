
import UIKit

protocol AnimationCurvePickerViewControllerDelegate: class {

  func animationCurvePickerViewController(_ controller: AnimationCurvePickerViewController, didSelectCurve curve: UIView.AnimationCurve)

}

class AnimationCurvePickerViewController: UITableViewController {

  static let cellID = "curveCellID"

  let curves: [UIView.AnimationCurve] = [
    .easeIn,
    .easeOut,
    .easeInOut,
    .linear
  ]

  weak var delegate: AnimationCurvePickerViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: AnimationCurvePickerViewController.cellID)
  }

}

// MARK: UITableViewDataSource
extension AnimationCurvePickerViewController {

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return curves.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: AnimationCurvePickerViewController.cellID, for: indexPath)
    cell.textLabel?.text = curves[indexPath.row].title
    return cell
  }

}

// MARK: UITableViewControllerDelegate
extension AnimationCurvePickerViewController {

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.animationCurvePickerViewController(self, didSelectCurve: curves[indexPath.row])
  }

}

// MARK: UIViewAnimationCurve Extensions
// MARK: - An extension that translates `UIView.AnimationCurve` into useful types
extension UIView.AnimationCurve {

  /// Produces a user-displayable title for the curve
  var title: String {
    switch self {
    case .easeIn: return "Ease In"
    case .easeOut: return "Ease Out"
    case .easeInOut: return "Ease In Out"
    case .linear: return "Linear"
    }
  }

  /// Converts this curve into it's corresponding UIView.AnimationOptions value for use in animations
  var animationOption: UIView.AnimationOptions {
    switch self {
    case .easeIn: return .curveEaseIn
    case .easeOut: return .curveEaseOut
    case .easeInOut: return .curveEaseInOut
    case .linear: return .curveLinear
    }
  }

}
