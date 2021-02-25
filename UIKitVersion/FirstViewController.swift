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
	let segueNameForAddingNewGarment = "segueAddNewGarment"
	var model = LuluModel()

	// called once the UI is ready to use
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		model.delegate = self
		model.addSomeTestGarments()
	}

	// called when user changes the Sorting Segmented Control
	@IBAction func segmentedControlClicked(sender: UISegmentedControl)
	{
		if sender.selectedSegmentIndex == 0 {
			model.doSort(how:.name)
		}
		if sender.selectedSegmentIndex == 1 {
			model.doSort(how:.creationDate)
		}
	}
	
	// Called when the user clicks the "+" button in the navbar.
	@IBAction func plusButtonClicked(sender:Any)
	{
		self.performSegue(withIdentifier:segueNameForAddingNewGarment, sender:self)
	}

	// Called before doing a segue to another view controller.
	// This is our chance to pass data to the new view controller (such as the model or any data to display).
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if segue.identifier == segueNameForAddingNewGarment {
			if let vc = segue.destination as? AddNewGarmentViewController {
				vc.theModel = self.model	// pass the model class to the new VC so it can add new garments, etc
			}
		}
	}
	
	// MARK: - UITableView datasource and delegate functions
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

