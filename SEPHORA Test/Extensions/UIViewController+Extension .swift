//
//  UIViewController+Extension .swift
//  SEPHORA Test
//
//  Created by Moussaab Djeradi on 3/3/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addView(_ view: UIView) {
        view.frame = self.view.bounds
        self.view.addSubview(view)
    }
    
    func remove(_ view: UIView) {
        view.removeFromSuperview()
    }
}
