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

	@Published private(set) var arrGarments = [GarmentInfo]()
	var currentSortMethod:SortMethod = .unsorted

	
	/**
	 * Adds a garment to the array of garments, then performs a sort.
	 * @param name Name of the garment.
	 */
	func addGarment(name:String)
	{
		DispatchQueue.main.async {
			// this must be done on main thread because it publishes a change
			self.arrGarments.append(GarmentInfo(name:name, creationDate:Date.init()))
		}
	}
	
	/**
	 * Sorts arrGaments in place based on the method chosen (by name, or creation date).
	 * @param method Must be one of the SortMethod types
	 */
	func doSort(method: SortMethod)
	{
		arrGarments.sort { leftHandSide, rightHandSide in
			switch method {
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

		self.currentSortMethod = method
	}
}

