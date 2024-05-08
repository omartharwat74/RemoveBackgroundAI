//
//  ImageResultVC.swift
//  
//
//  Created by Omar Tharwat on 08/05/2024.
//

import UIKit

class ImageResultVC: UIViewController {
    
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
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.text = "Remove Background".localized
        }
    }
    @IBOutlet weak var mainImage: UIImageView!{
        didSet{
            mainImage.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var saveAllButton: UIButton!{
        didSet{
            saveAllButton.layer.cornerRadius = 24
            saveAllButton.setTitle("Save all".localized, for: .normal)
        }
    }
    @IBOutlet weak var retryButton: UIButton!{
        didSet{
            retryButton.layer.cornerRadius = 24
            retryButton.setTitle("Retry the process".localized, for: .normal)
        }
    }
    
    var resultImage : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImage.image = resultImage
    }
    public init() {
        super.init(nibName: "ImageResultVC", bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func saveAllClick(_ sender: Any) {
    }
    
    @IBAction func retryClick(_ sender: Any) {
        dismiss(animated: true)
    }
    

}
