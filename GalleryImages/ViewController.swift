//
//  ViewController.swift
//  GalleryImages
//
//  Created by Nirav on 26/07/18.
//  Copyright © 2018 Elluminati. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
   
    
    @IBOutlet weak var ListGridButton: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleLblView: UIView!
  
    @IBOutlet weak var collectionview: UICollectionView!
    
    var isList : Bool = true
    var arrImages = [UIImage]()
    var imagePicker = UIImagePickerController()

    var itemsPerRow : CGFloat = 1
      var sectionInsets = UIEdgeInsets(top: 15.0, left: 10.0, bottom: 30.0, right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        arrImages.insert(UIImage.init(named: "Photograph-Icon-PNG.png")!, at: 0)
      
      
        ListGridButton.addTarget(self, action: #selector(ListGridBtnAction(sender:)), for: .touchUpInside)
        ListGridButton.setImage(UIImage.init(named: "list-button.png"), for: .normal)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    @objc func ListGridBtnAction(sender:UIButton){
        if isList == true{
            isList = false
                ListGridButton.setImage(UIImage.init(named: "phone-keyboard-symbol-of-nine-squares (1).png"), for: .normal)
             itemsPerRow  = 2
            collectionview.reloadData()
          //   sectionInsets = UIEdgeInsets(top: 15.0, left: 10.0, bottom: 30.0, right: 10.0)
//
        }
        else {
            isList = true
            ListGridButton.setImage(UIImage.init(named: "list-button.png"), for: .normal)
            itemsPerRow = 1
            collectionview.reloadData()
            //sectionInsets = UIEdgeInsets(top: 15.0, left: 10.0, bottom: 30.0, right: 10.0)
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (arrImages.count)
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : addimageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addimage", for: indexPath) as! addimageCollectionViewCell
        cell.AddImageBtn.image = arrImages[indexPath.row]

        if indexPath.row == arrImages.count - 1 {
            cell.LikesButton.isHidden = true
            cell.titleLabel.isHidden = true
            cell.LikeCount.isHidden = true
            
        }else{
            cell.LikesButton.isHidden = false
            cell.titleLabel.isHidden = false
            cell.LikeCount.isHidden = false
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionview.cellForItem(at: indexPath) as? addimageCollectionViewCell {
            if cell.AddImageBtn.image == UIImage.init(named: "Photograph-Icon-PNG.png") {
                profileimageUpload()
            }
            else{
                UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
                    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
                    let blurEffectView = UIVisualEffectView(effect: blurEffect)
                    blurEffectView.frame = self.view.bounds
                    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                   self.view.addSubview(blurEffectView)
                     let dialogview : BigDialogView = BigDialogView.showCustomConfirmationDialog(title: "ravi lakhtariya", image: cell.AddImageBtn.image!)
                    // Do animation
                }, completion: nil)
               
            }
        }
        
    
        
    }
    func profileimageUpload(){
        
        imagePicker.allowsEditing = true
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let cells = addimageCollectionViewCell()
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
      
            arrImages.insert(pickedImage, at: arrImages.index(before: arrImages.endIndex))

            
        }else if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
  
             arrImages.insert(pickedImage, at: arrImages.index(before: arrImages.endIndex))
        }else{
            
        }
        self.collectionview.reloadData()
        dismiss(animated: true, completion: nil)
        
    }

}
//MARK: EXTENSIONS

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

extension UICollectionView {
    func indexPathForView(view: AnyObject) -> IndexPath? {
        let originInCollectioView = self.convert(CGPoint.zero, from: (view as! UIView))
        return self.indexPathForItem(at: originInCollectioView) as IndexPath?
    }
}
