//
//  ViewController.swift
//  UIKitVersion
//
//  Created by G Bear on 2021-02-24.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
	var model = LuluModel()

	override func viewDidLoad()
	{
		super.viewDidLoad()
	
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return model.arrGarments.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		var ret = tableView.dequeueReusableCell(withIdentifier:"cell")
		if ret == nil {
			ret = UITableViewCell.init(style:.default, reuseIdentifier:"cell")
		}
		
		return ret!
	}
	



}

