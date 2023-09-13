//
//  InputImageView.swift
//  admin
//
//  Created by imen cheref on 10/09/2023.
//

import UIKit

class InputImageView: UIView, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet var content: UIView!
    @IBOutlet weak var addPictureButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    var completion: ((UIImage?) -> ())?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("InputImageView", owner: self, options: nil)
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(content)
        
        self.image.layer.cornerRadius = 6
        
        self.addPictureButton.layer.cornerRadius = 6
        //self.addPictureButton.layer.borderColor =
        //self.addPictureButton.setTitleColor(Style.Color.primary, for: .normal)
        //self.addPictureButton.tintColor = Style.Color.primary
        self.addPictureButton.layer.borderWidth = 2
        
        self.deleteButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.deleteButton.layer.cornerRadius = 20
        self.deleteButton.isHidden = true
    }
    
    func configure(completion: ((UIImage?) -> ())?){
        self.completion = completion
    }
    
    @IBAction func onValidateButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Séléction d'image", message: "D'où provient votre image ?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Appareil photo", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Galerie", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Fermer", style: .cancel, handler: {(action: UIAlertAction) in
            if self.image.image == nil {
                //self.addPictureButton.setTitleColor(Style.Color.red, for: .normal)
               // self.addPictureButton.tintColor = Style.Color.red
                //self.addPictureButton.layer.borderColor = Style.Color.red.cgColor
                self.deleteButton.isHidden = true
            }
        }))
        if let popoverPresentationController = alert.popoverPresentationController {
              popoverPresentationController.sourceView = self.addPictureButton
              popoverPresentationController.sourceRect = self.addPictureButton.bounds
          }
        self.parentViewController?.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onDeleteButtonTapped(_ sender: Any) {
        self.image.image = nil
        //self.addPictureButton.setTitleColor(Style.Color.red, for: .normal)
        //self.addPictureButton.tintColor = Style.Color.red
        //self.addPictureButton.layer.borderColor = Style.Color.red.cgColor
        self.addPictureButton.setTitle("Ajouter une photo", for: .normal)
        self.addPictureButton.setImage(UIImage(named: "ico_camera"), for: .normal)
        self.addPictureButton.layer.borderWidth = 2
        self.deleteButton.isHidden = true
        self.completion?(nil)
    }
    
    //MARK: UIImagePickerViewDelegate.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) { [weak self] in
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                self?.deleteButton.isHidden = true
                return
            }
            self?.image.image = image
            self?.deleteButton.isHidden = false
            self?.addPictureButton.setTitle("", for: .normal)
            self?.addPictureButton.setImage(nil, for: .normal)
            self?.addPictureButton.layer.borderWidth = 0
            self?.completion?(self?.image.image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        if self.image.image == nil {
            //self.addPictureButton.setTitleColor(Style.Color.red, for: .normal)
            //self.addPictureButton.tintColor = Style.Color.red
           // self.addPictureButton.layer.borderColor = Style.Color.red.cgColor
            self.completion?(nil)
        }
    }

    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.parentViewController?.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    
    

}
