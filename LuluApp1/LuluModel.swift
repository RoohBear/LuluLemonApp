//
//  LuluModel.swift
//  LuluApp1
//
//  Created by G Bear on 2021-02-23.
//

import Foundation


/**
 * Structure containing all the info about a single garment.
 */
struct GarmentInfo
{
	var name:String!
	var creationDate:Date!
	
	/**
	 * Returns the creation date as a string suitable for display in the UI.
	 * @return A string for displaying the creation date.
	 */
	func creationDateForUI() -> String
	{
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.timeStyle = .medium
		return formatter.string(from:self.creationDate)
	}
}

protocol LuluModelDelegate
{
	/**
	 * Called by LuluModel when the array of garments has been updated.
	 */
	func lulumodeldelegate_arrayUpdated()
}


/**
 * Class containing all the business logic and cross-platform code for the app.
 */
class LuluModel : ObservableObject
{
	enum SortMethod {
		case unsorted
		case name
		case creationDate
	}

	// Some read-only properties
	@Published private(set) var arrGarments = [GarmentInfo]()
	@Published private(set) var currentSortMethod:SortMethod = .unsorted
	var delegate:LuluModelDelegate!
	
	
	/**
	 * Adds a garment to the array of garments, then performs a sort using the current sort method (if any)
	 * @param name Name of the garment.
	 */
	func addGarment(name:String)
	{
		DispatchQueue.main.async {
			// this must be done on main thread because it publishes a change
			self.arrGarments.append(GarmentInfo(name:name, creationDate:Date.init()))
			self.doSort(how:self.currentSortMethod)
		}
	}
	
	/**
	 * Sorts arrGaments in place based on the method chosen (by name, or creation date).
	 * @param how Must be one of the SortMethod types
	 */
	func doSort(how: SortMethod)
	{
		arrGarments.sort { leftHandSide, rightHandSide in
			switch how {
				case .name:
					if leftHandSide.name < rightHandSide.name {
						return true
					}
					return false
				
				case .creationDate:
					if leftHandSide.creationDate < rightHandSide.creationDate {
						return true
					}
					return false

				default:
					return false;
			}
		}

		self.currentSortMethod = how
		self.updateDelegatesOfModelChange()
	}
	
	/**
	 * Adds some test garments to the array of garments using a timer, spaced 1 second apart.
	 * Does a sort by name at the end.
	 */
	func addSomeTestGarments()
	{
		// on ViewDidAppear, we add 4 things to the queue 1 second apart so they have obvious different creation times.
		DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + TimeInterval(1)) {
			self.addGarment(name: "T-Shirt")
		}
		DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + TimeInterval(2)) {
			self.addGarment(name: "Dress")
		}
		DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + TimeInterval(3)) {
			self.addGarment(name: "Shirt")
		}
		DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + TimeInterval(4)) {
			self.addGarment(name: "Pant")
		}
		

		// On a normal app, it would be good for the model to have a default sort method.
		// In this app, the default is ".unknown" but just for fun, let's set the sort method
		// automatically 5 seconds after startup to ".name" to demonstrate how the UI updates automatically.
		DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + TimeInterval(5)) {
			DispatchQueue.main.async {
				self.doSort(how:.name)
			}
		}
	}
	
	/**
	 * Private function that tells any delegates that the model has changed. They would want to refresh their UI.
	 * The UIKIt version needs this. The UIKIt version does not because it uses MVVM and observes changes to the model.
	 */
	private func updateDelegatesOfModelChange()
	{
		if let delegate = self.delegate {
			delegate.lulumodeldelegate_arrayUpdated()
		}
	}
}

