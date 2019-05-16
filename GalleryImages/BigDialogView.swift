//
//  BigDialogView.swift
//  GalleryImages
//
//  Created by Nirav on 01/08/18.
//  Copyright © 2018 Elluminati. All rights reserved.
//

import Foundation
import UIKit

public class BigDialogView : UIView {
    
    static let  verificationDialog = "bigdialogviewui"
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var LblImageView: UIImageView!
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    public static func  showCustomConfirmationDialog
        (title:String,image:UIImage) ->
        BigDialogView
    {
        let view = UINib(nibName: verificationDialog, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BigDialogView
       
       
        let frame = (APPDELEGATE.window?.frame)!;
        view.frame = frame;
        view.lblTitle.text = title;
        view.LblImageView.image = image
        
//        view.btnLeft.setTitle(titleLeftButton.uppercased(), for: UIControlState.normal)
//        view.btnRight.setTitle(titleRightButton.uppercased(), for: UIControlState.normal)
        

        
        APPDELEGATE.window?.addSubview(view)
        APPDELEGATE.window?.bringSubview(toFront: view);
        return view;
    }
    
    @IBAction func tapGestureAction(_ sender: Any) {
        
        self.removeFromSuperview()
      
    }
    
    
    
}
extension UIView {
    
    /// Remove UIBlurEffect from UIView
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
}
