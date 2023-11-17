//
//  MealScreen.swift
//  healthtracker
//
//  Created by sharon on 3/30/23.
//

import SwiftUI
import Charts

struct MealScreen: View {
    @EnvironmentObject var healthData: HealthData
    @State private var addItemPopup = false
    @State private var setDefaultPopup = false
    @State private var selectedMealData: DietData?
    @State private var mealGoalPopup = false
    @State private var goalValue = 2500
    
    var currentDate = Date()
    let formatter = DateFormatter()
    

    let sleepView: [SleepChart] = [
        //SleepChart(weekday: Date().dayBefore6, sleepTime: Int)
    ]
    
    var body: some View {

        ZStack {
            Color.gray
                .brightness(0.4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack {
                Text("Meal Tracker")
                    .font(.title)
                    .foregroundColor(.orange)
                    .bold()
                    .padding()
                Chart{
                    RuleMark(
                        y:.value("Goal",goalValue)
                    )
                    .lineStyle(StrokeStyle(lineWidth: 3))
                    .annotation(position: .top, alignment: .leading){
                        Text("Goal: \(goalValue,format:.number)")
                            .font(.body)
                            .foregroundStyle(.blue)
                    }
                    
                    ForEach((0...6).reversed(), id: \.self){ i in
                        ForEach( healthData.getDietEntriesDateDefault(date: Date().getDayBefore(num: i))){ j in
                            BarMark(
                                x:.value("Date",j.date.formatted(Date.FormatStyle().weekday(.abbreviated))),
                                y:.value("Duration", j.data)
                            )
                            .opacity(0.3)
                        }
                    }
                }
                .frame(width: 350.0, height: 250.0)
                .background(.white)
            
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .frame(width: 350.0, height: 120.0)
                        .overlay(
                            VStack {
                                HStack {
                                    Text("Today")
                                        .font(.title)
                                        .foregroundColor(.orange)
                                        .bold()
                                        .offset(x: -55, y: -5)
                                    
                                    Text(currentDate, style: .date)
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .bold()
                                        .offset(x: -55, y: -3)
                                }
                
                                HStack {
                
                                    VStack {
                                        Text("Total Calories of Today:")
                                            .font(.custom("Arial Rounded MT Bold", size: 16))
                                            .foregroundColor(.black)
                                            .offset(x: 0, y: 6)
                                        
                                        HStack {
                                            Text("\(healthData.getMealCalorie(date:currentDate))")
                                                .font(.custom("Arial Rounded MT Bold", size: 25))
                                                .foregroundColor(.orange)
                                                .offset(x: 0, y: 10)
                                            
                                            Text("calories")
                                                .font(.custom("Arial Rounded MT Bold", size: 20))
                                                .foregroundColor(.black)
                                                .offset(x: 0, y: 10)
                                        }
                                    }
                                }
                            }
                        )
                }
                    
                
                
                List {
                    Section(header: Spacer(minLength: 0)) {
                        ForEach(healthData.getDietEntriesDate(date: currentDate)) { data in
                            HStack {
                                Button(action: {
                                    selectedMealData = data
                                }) {
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(.white)
                                            .frame(width: 370.0, height: 80.0)
                                            .overlay(
                                                VStack {
                                                    VStack {
                                                        Text("Description:")
                                                            .font(.custom("Arial Rounded MT Bold", size: 16))
                                                            .foregroundColor(.black)
                                                            .offset(x: -3, y: 0)
                                                        
                                                        HStack {
                                                            Text("\(data.food)")
                                                                .font(.custom("Arial Rounded MT Bold", size: 22))
                                                                .foregroundColor(.orange)
                                                                .offset(x: -3, y: 0)
                                                        }
                                                    }
                                                    HStack {
                                                        VStack {
                                                            Text("Time:")
                                                                .font(.custom("Arial Rounded MT Bold", size: 16))
                                                                .foregroundColor(.black)
                                                                .offset(x: -5, y: 0)
                                                            
                                                            HStack {
                                                                Text("\(data.date, formatter: timeFormatter)")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 22))
                                                                    .foregroundColor(.orange)
                                                                    .offset(x: -8, y: 0)
                                                            }
                                                        }
                                                        VStack {
                                                            Text("Type:")
                                                                .font(.custom("Arial Rounded MT Bold", size: 16))
                                                                .foregroundColor(.black)
                                                                .offset(x: -3, y: 0)
                                                            
                                                            HStack {
                                                                Text("\(data.type.rawValue)")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 22))
                                                                    .foregroundColor(.orange)
                                                                    .offset(x: -3, y: 0)
                                                            }
                                                        }
                                                        VStack {
                                                            Text("Calories:")
                                                                .font(.custom("Arial Rounded MT Bold", size: 16))
                                                                .foregroundColor(.black)
                                                                .offset(x: 3, y: 1)
                                                            
                                                            HStack {
                                                                Text("\(data.data)")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 22))
                                                                    .foregroundColor(.orange)
                                                                    .offset(x: 3, y: 0)
                                                                
                                                               /* Text("hrs")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 20))
                                                                    .foregroundColor(.black)
                                                                    .offset(x: 3, y: 0)*/
                                                                
                                                            }
                                                        }
                                                        
                                                        
                                                        Image(systemName: "trash")
                                                            .foregroundColor(.red)
                                                            .offset(x: 12, y: 15)
                                                            .onTapGesture {
                                                                if let index = healthData.dietList.firstIndex(where: { $0.id == data.id }) {
                                                                    healthData.dietList.remove(at: index)
                                                                }
                                                            }
                                                        
                                                    }

                                                }
                                            )
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }

                }
            }
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        mealGoalPopup.toggle()
                    }) {
                        Image(systemName: "note.text")
                            .font(.system(size: 55))
                            .padding()
                            .foregroundColor(.green)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        addItemPopup.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 55))
                            .padding()
                            .foregroundColor(.yellow)
                    }
                }
            }
        }
        .sheet(isPresented: $addItemPopup) {
            MealDataEntryView { mealData in
                healthData.addDietList(newEntry: mealData)
                addItemPopup = false
            }.presentationDetents([.medium])
        }
        .fullScreenCover(item: $selectedMealData) { mealData in
            MealDataDetailView(mealData: mealData)
        }
        .sheet(isPresented: $mealGoalPopup) {
                MealGoalEntryView { goalValue in
                    self.goalValue = goalValue
                    mealGoalPopup = false
                }
                .presentationDetents([.medium])
            }
    }
    
}

struct MealGoalEntryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var goal: String = ""
    
    var onSubmit: (Int) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter calorie intake goal", text: $goal)
                    .keyboardType(.numberPad)
                    .padding()
                    //.border(.black)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            .navigationTitle("Set Intake Goal")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        if let goalInt = Int(goal) {
                            onSubmit(goalInt)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}



struct MealDataDetailView: View {
    var mealData: DietData
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Date: \(mealData.date, formatter: dateFormatter)")
                Text("Type: \(mealData.type.rawValue)")
                Text("Detail: \(mealData.food)")
                Text("Calorie: \(mealData.data)")
            }
            .padding()
            .navigationTitle("Meal Details")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct MealDataEntryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var date = Date()
    @State var selectedType: MealType = .snack
    @State var description: String = ""
    @State var calories: Int = 0
    
    var onSubmit: (DietData) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                
                Picker("Type", selection: $selectedType){
                    ForEach(MealType.allCases) { option in
                        Text((String(describing: option.rawValue)))
                    }
                }
                HStack(alignment: .center){
                    Text("Description: ")
                        .font(.callout)
                    TextField(
                        "",
                        text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack(alignment: .center){
                    Text("Calorie: ")
                        .font(.callout)
                    TextField(
                        "",
                        value: $calories, format: .number)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .navigationTitle("Add Meal Data")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        onSubmit(DietData(date: date,type: selectedType,food: description, data:calories))
                        dismiss()
                    }
                }
            }
        }
    }
    
    
}

struct MealChart: Identifiable{
    let weekday: Date
    let calorie: Int
    
    var id: Date { weekday }
}


struct MealScreen_Previews: PreviewProvider {
    static var previews: some View {
        MealScreen()
            .environmentObject(HealthData())
    }
}
