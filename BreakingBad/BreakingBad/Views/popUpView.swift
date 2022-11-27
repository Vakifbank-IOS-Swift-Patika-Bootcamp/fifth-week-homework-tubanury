//
//  popUpView.swift
//  BreakingBad
//
//  Created by Tuba N. Yıldız on 26.11.2022.
//

import UIKit

class popUpView: UIView {

    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var table: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func xibSetup(frame: CGRect){
        let view = loadXib()
        view.frame = frame
        addSubview(view)
    }

    func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "popUpView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view!
    }
}
