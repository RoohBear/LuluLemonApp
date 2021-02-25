//
//  ContentView.swift
//  LuluApp1
//
//  Created by G Bear on 2021-02-23.
//

import SwiftUI

struct ContentView: View
{
	@ObservedObject var model:LuluModel
	@State private var showAddGarmentView = false
	@State private var newGarmentName = ""

	var body: some View
	{
		VStack {
			// The "List" and "+" button
			ZStack {
				HStack {
					Text("List")
				}
				HStack{
					Spacer()
					Button(action: {
						print("Add button was tapped")
						newGarmentName = ""
						self.showAddGarmentView = true
					}) {
						Image(systemName: "plus.circle").font(.largeTitle)
					}.popover(isPresented: $showAddGarmentView, content: {
						// Title string and Save button at the top
						ZStack {
							HStack {
								Text("Add")
							}
							HStack {
								Spacer()
								Button(action: {
									print("Save button was tapped")
									self.model.addGarment(name: newGarmentName)
									self.showAddGarmentView = false
								}) {
									Text("Save")
								}
							}
						}.padding().border(Color.black, width: 2)

						// Label and text field go here
						VStack {
							HStack {
								Text("Garment Name:")
								Spacer()
							}
							HStack {
								TextField("Enter garment name", text:$newGarmentName, onEditingChanged: { began in
									print("Hello from onediting changed")
								})
								Spacer()
							}
						}
						
						// push everything up and leave space at the bottom
						Spacer()
					})
				}.padding().border(Color.black, width: 2)
			}

			// The 2 buttons to choose a sort method
			HStack {
				Button(action: {
					print("Alpha button tapped")
					model.doSort(how:.name)
				}) {
					Text("Alpha")
				}.background(model.currentSortMethod == .name ? Color.black : Color.clear)

				Text(" ")

				Button(action: {
					print("Creation time button tapped")
					model.doSort(how:.creationDate)
				}) {
					Text("Creation Time")
				}.background(model.currentSortMethod == .creationDate ? Color.black : Color.clear)
			}

			// The table of garments (each row showing the garment name and creation date)
			List(model.arrGarments, id: \.name) { garment in
				HStack
				{
					Text(garment.name)
					Spacer()
					Text(garment.creationDateForUI())
				}.frame(width:350, height:50)
			}

			// The spacer pushes everything up to leave space at the bottom
			Spacer()
		}.onAppear() {
			model.addSomeTestGarments()
		}
	}
}

struct ContentView_Previews: PreviewProvider
{
	static var previews: some View {
		ContentView(model:LuluModel())
    }
}
