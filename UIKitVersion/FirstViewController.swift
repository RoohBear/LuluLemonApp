//
//  ViewController.swift
//  UIKitVersion
//
//  Created by G Bear on 2021-02-24.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LuluModelDelegate
{
	@IBOutlet var theTable:UITableView!
	@IBOutlet var theSegmentedControl:UISegmentedControl!
	var model = LuluModel()

	override func viewDidLoad()
	{
		super.viewDidLoad()

		model.delegate = self
		model.addSomeTestGarments()
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
		ret?.textLabel?.text = self.model.arrGarments[indexPath.row].name
		
		return ret!
	}

	// MARK: - LuluModelDelegate functions
	
	// called by the model when the model changes and the UI should refresh
	func lulumodeldelegate_arrayUpdated()
	{
		self.theTable.reloadData()
	}
	
}

