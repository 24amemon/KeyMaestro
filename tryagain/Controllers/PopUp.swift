//
//  PopUp.swift
//  tryagain
//
//  Created by Aasiya Memon on 5/18/23.
//

import UIKit

class PopUp: UIView {

    @IBOutlet var closeButton: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        xibSetup(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
    
    func xibSetup(frame: CGRect){
        let view = loadXib()
        view.frame = frame
        addSubview(view)
        
    }
    
    func loadXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PopUp", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view!
    }

}
