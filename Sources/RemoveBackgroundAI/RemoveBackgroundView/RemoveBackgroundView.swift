//
//  RemoveBackgroundView.swift
//  
//
//  Created by Omar Tharwat on 08/05/2024.
//

import UIKit

class RemoveBackgroundView: UIView {
    
    //MARK: - Outlets
    @IBOutlet weak var backButton: UIButton!{
        didSet{
            if Locale.current.language.languageCode!.identifier == "en" {
                backButton.setImage( UIImage(systemName: "arrow.right"), for: .normal)
            }else if Locale.current.language.languageCode!.identifier == "ar" {
                backButton.setImage( UIImage(systemName: "arrow.lest"), for: .normal)
            }
        }
    }
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var uploadImageStackView: UIStackView!
    @IBOutlet weak var removeBackGroundButton: UIButton!{
        didSet{
            removeBackGroundButton.layer.cornerRadius = 24
            removeBackGroundButton.configurationUpdateHandler = { button in
                var config = button.configuration
                config?.attributedTitle = AttributedString(NSLocalizedString("Remove Background".localized, comment: ""),
                                                           attributes: AttributeContainer([NSAttributedString.Key.foregroundColor: button.isEnabled ? UIColor.white : UIColor(red: 0.775, green: 0.775, blue: 0.775, alpha: 1)]))
                button.configuration = config
            }
            removeBackGroundButton.configuration?.imagePadding = 10
            if Locale.current.language.languageCode!.identifier == "en" {
                removeBackGroundButton.semanticContentAttribute = .forceRightToLeft
            }else if Locale.current.language.languageCode!.identifier == "ar" {
                removeBackGroundButton.semanticContentAttribute = .forceLeftToRight
            }
            
        }
    }
    @IBOutlet weak var viewImage: UIView!{
        didSet{
            viewImage.layer.cornerRadius = 25
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setUpButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setUpButton()
    }
    
    private func commonInit() {
        let bundle = Bundle.module
        let nib = UINib(nibName: "RemoveBackgroundView", bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            addSubview(view)
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    //MARK: - Setup
    func setUpButton(){
        removeBackGroundButton.isEnabled = false
    }
    
    //MARK: - Actions
    @IBAction func removeBackGroundClick(_ sender: Any) {
        
    }
    

}
