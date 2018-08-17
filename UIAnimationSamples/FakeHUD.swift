
import UIKit

class FakeHUD: UIView {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    layer.masksToBounds = true
    layer.cornerRadius = 6.0
  }

}
