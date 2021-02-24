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
	var df = DateFormatter.init()

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
					}) {
						Image(systemName: "plus.circle").font(.largeTitle)
					}
				}.padding().border(Color.black, width: 2)
			}

			// The 2 buttons to choose a sort method
			HStack {
				Button(action: {
					print("Alpha button tapped")
					model.doSort(method:.name)
				}) {
					Text("Alpha")
				}.background(Color.black)
				Text(" ")
				Button(action: {
					print("Creation time button tapped")
					model.doSort(method:.creationDate)
				}) {
					Text("Creation Time")
				}
			}

			List(model.arrGarments, id: \.name) { garment in
				HStack
				{
					Text(garment.name)
					Spacer()
					Text(garment.creationDateForUI())
				}
			}
			Spacer()
		}.onAppear() {
			// add 4 things to the queue 1 second apart so they have obvious different creation times.
			DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + TimeInterval(1)) {
				model.addGarment(name: "T-Shirt")
			}
			DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + TimeInterval(2)) {
				model.addGarment(name: "Dress")
			}
			DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + TimeInterval(3)) {
				model.addGarment(name: "Shirt")
			}
			DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + TimeInterval(4)) {
				model.addGarment(name: "Pant")
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider
{
	static var previews: some View {
		ContentView(model:LuluModel())
    }
}
