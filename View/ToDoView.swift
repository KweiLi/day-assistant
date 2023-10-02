import SwiftUI

struct ToDoItem: Identifiable {
    var id: String?
    var category: String
    var details: String
    var completed: Bool = false
}


struct ToDoView: View {
    @State private var showingAddTodoView = false

    @StateObject var toDoManager = ToDoManager()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing:10){
                Text("To do")
                    .bold()
                    .font(.headline)
            }
            
            VStack{
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(Array(toDoManager.toDoItems.enumerated()), id: \.element.id) { index, item in
                        HStack(spacing: 15) {
                            // Checkbox to mark as completed
                            Button(action: {
                                toDoManager.toDoItems[index].completed.toggle()
                                toDoManager.toggleCompletion(at: index)
                            }) {
                                Image(systemName: item.completed ? "checkmark.square" : "square")
                                    .font(.system(size: 25))
                                    .foregroundColor(item.completed ? .green : .gray)
                            }
                            .buttonStyle(PlainButtonStyle())

                            // Action item details
                            VStack(alignment: .leading, spacing: 5) {
                                Text(item.category)
                                    .font(.body)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(item.details)
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding()
                            .background(item.completed ? Color.purple.opacity(0.2) : Color.clear)
                            .cornerRadius(15)

                            // Delete button
                            Button(action: {
                                toDoManager.remove(at: index)
//                                toDoManager.toDoItems.remove(at: index)
                            }) {
                                Image(systemName: "delete.left.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(.gray)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .background(Color.white)
                .padding()
                
                HStack{
                    Spacer()
                    
                    Button(action: {
                        showingAddTodoView = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .padding()
                    }
                    
                    Spacer()
                }

            }
            .sheet(isPresented: $showingAddTodoView) {
                AddTodoView()
                    .environmentObject(toDoManager)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .padding(.bottom, 10)
        .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .background(.white)
        .cornerRadius(20)
    }
}

struct AddTodoView: View {
        
    @EnvironmentObject var toDoManager: ToDoManager
    @State private var selectedCategory = ""
    @State private var actionDetails = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedCategoryIndex: Int = 0

    let actionCategoryImageNames: [String: String] = [
        "Health & Fitness": "healthFitnessImage",
        "Work & Study": "workStudyImage",
        "Home & Chores": "homeChoresImage",
        "Shopping & Grocery": "shoppingImage"
    ]
    
    var body: some View {
        let categories = Array(actionCategoryImageNames.keys)

        NavigationView {
            VStack {
                TabView(selection: $selectedCategoryIndex) {
                    ForEach(0..<categories.count, id: \.self) { index in
                        let category = categories[index]
                        let imageName = actionCategoryImageNames[category] ?? ""
                        VStack {
                            Text(category)
                                .font(.title2)
                            
                            Image(imageName)
                                .resizable()
                                .scaledToFit()
                                .padding([.top, .bottom], 20)
                                .cornerRadius(40) // Rounded corners for the image background
                                .shadow(color: Color.purple.opacity(0.3), radius: 20, x:3, y:3)

                        }
                        .padding(10)
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .onChange(of: selectedCategoryIndex) { newValue in
                    selectedCategory = categories[newValue]
                }

                
                TextEditor(text: $actionDetails)
                    .font(.custom("Helvetica", size: 16))
                    .padding()
                    .frame(height: 100)
                    .foregroundColor(.gray)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary).opacity(0.5))
                    .padding()
            }
            .padding()
            .navigationTitle("Add To Do")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }, trailing: Button("Add") {
                let newItem = ToDoItem(category: categories[selectedCategoryIndex], details: actionDetails)
//                toDoManager.toDoItems.append(newItem)
                toDoManager.add(item: newItem)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
             ContentView().preferredColorScheme($0)
        }
    }
}
