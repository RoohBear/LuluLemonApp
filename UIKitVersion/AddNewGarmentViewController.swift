//
//  AddNewGarmentViewController.swift
//  UIKitVersion
//
//  Created by G Bear on 2021-02-24.
//

import Foundation
import UIKit

class AddNewGarmentViewController : UIViewController
{
	@IBOutlet var textfieldName:UITextField!
	var theModel:LuluModel!
		
	// Called when the user clicks the "Save" button. Here, we tell the model class to add the garment and dismiss ourselves.
	// The main view controller should notice the change and do a refresh.
	@IBAction func buttonSaveClicked(sender:Any)
	{
		if let safeModel = theModel {
			if let safeText = textfieldName.text {
				safeModel.addGarment(name:safeText)
				
				self.navigationController?.popViewController(animated:true)
			}
		}
	}
}

