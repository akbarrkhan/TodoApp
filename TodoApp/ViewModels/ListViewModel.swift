//
//  ListViewModel.swift
//  TodoApp
//
//  Created by Mac on 24/02/2023.
//

import Foundation

class ListViewModel: ObservableObject {
    
    //    Any change will effect didSet Here
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init(){
        getItems()
    }
    
    func getItems(){
        //        let newItems =  [
        //            ItemModel(title: "This is the first Model", isCompleted: false),
        //            ItemModel(title: "This is the second Model", isCompleted: true),
        //            ItemModel(title: "This is the third Model", isCompleted: false),
        //            ItemModel(title: "This is the fourth Model", isCompleted: true),
        //            ItemModel(title: "This is the fifth Model", isCompleted: false)
        //        ]
        //        items.append(contentsOf: newItems)
        
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems  = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
        
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
        
    }
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func addItem(title: String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel){
        
        if let index = items.firstIndex(where: { $0.id == item.id }){
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems()  {
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
        
    }
    
}
