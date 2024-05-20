//
//  RemoveBackgroundView.swift
//
//
//  Created by Omar Tharwat on 08/05/2024.
//

import UIKit
import AVFoundation

class RemoveBackgroundView: UIView {
    
    //MARK: - Outlets
    @IBOutlet weak var removeImageButton: UIButton!
    @IBOutlet weak var chooseThePicLabel: UILabel!{
        didSet{
            chooseThePicLabel.text = "Choose the picture".localized
        }
    }
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.text = "Remove Background".localized
        }
    }
    @IBOutlet weak var uploadImageLabel: UILabel!{
        didSet{
            uploadImageLabel.text = "Upload an image".localized
        }
    }
    @IBOutlet weak var backButton: UIButton!{
        didSet{
            if Locale.current.language.languageCode!.identifier == "en" {
                backButton.setImage( UIImage(systemName: "arrow.right"), for: .normal)
            }else if Locale.current.language.languageCode!.identifier == "ar" {
                backButton.setImage( UIImage(systemName: "arrow.lest"), for: .normal)
            }
        }
    }
    @IBOutlet weak var uploadPhotoLabel: UILabel!{
        didSet{
            uploadPhotoLabel.text = "Upload a photo, and we will remove the background for you.".localized
        }
    }
    @IBOutlet weak var mainImage: UIImageView!{
        didSet{
            mainImage.layer.cornerRadius = 25
        }
    }
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
                removeBackGroundButton.semanticContentAttribute = .forceLeftToRight
            }else if Locale.current.language.languageCode!.identifier == "ar" {
                removeBackGroundButton.semanticContentAttribute = .forceRightToLeft
            }
            
        }
    }
    @IBOutlet weak var viewImage: RectangularDashedView!{
        didSet{
            viewImage.layer.cornerRadius = 25
            viewImage.layer.borderWidth = 1
            viewImage.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1).cgColor
        }
    }
    
    
    var finalImage : UIImage? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        configuration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        configuration()
    }
    
    private func commonInit() {
        let bundle = Bundle.module
        let nib = UINib(nibName: "RemoveBackgroundView", bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            addSubview(view)
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            /Users/omartharwat/Desktop/Gyoom/CreateTranslationAi/Sources/CreateTranslationAi/Extension/DashedBorder.swift       }
    }
    
    //MARK: - Setup
    func configuration(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewImageTapped))
        uploadImageStackView.addGestureRecognizer(tapGesture)
        uploadImageStackView.isUserInteractionEnabled = true
        setUpButton()
        removeImageButton.isHidden = true
        viewImage.showDashBorder()
    }
    
    func setUpButton(){
        if finalImage == nil {
            removeBackGroundButton.isEnabled = false
            removeBackGroundButton.backgroundColor = UIColor(red: 0.166, green: 0.271, blue: 0.269, alpha: 1)
        }else {
            removeBackGroundButton.isEnabled = true
            removeBackGroundButton.backgroundColor = UIColor(red: 0.341, green: 0.584, blue: 0.58, alpha: 1)
        }
    }
    
    
    //MARK: - Actions
    @IBAction func removeImageClick(_ sender: Any) {
        finalImage = nil
        mainImage.image = nil
        removeImageButton.isHidden = true
        uploadImageStackView.isHidden = false
        removeBackGroundButton.isEnabled = false
        viewImage.showDashBorder()
        removeBackGroundButton.backgroundColor = UIColor(red: 0.166, green: 0.271, blue: 0.269, alpha: 1)
    }
    @IBAction func removeBackGroundClick(_ sender: Any) {
        if let parentVC = self.parentViewController {
            let vc = ImageResultVC()
            vc.modalPresentationStyle = .fullScreen
            vc.resultImage = finalImage
            parentVC.present(vc, animated: true)
        }
    }
    
    @objc func viewImageTapped() {
        openGallery()
    }
    
}
extension RemoveBackgroundView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        if let parentVC = self.parentViewController {
            parentVC.present(imagePicker, animated: true)
        } else {
            print("Parent view controller not found")
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the captured image
        if let editedImage = info[.editedImage] as? UIImage {
            finalImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            // If edited image is not available, fall back to original image
            finalImage = originalImage
        }
        mainImage.image = finalImage
        removeBackGroundButton.isEnabled = true
        removeBackGroundButton.backgroundColor = UIColor(red: 0.341, green: 0.584, blue: 0.58, alpha: 1)
        uploadImageStackView.isHidden = true
        removeImageButton.isHidden = false
        viewImage.hideDashBorder()
        picker.dismiss(animated: true)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the image picker if the user cancels
        picker.dismiss(animated: true, completion: nil)
    }
}
