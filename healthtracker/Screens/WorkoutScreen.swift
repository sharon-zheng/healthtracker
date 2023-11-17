//
//  WorkoutScreen.swift
//  healthtracker
//
//  Created by sharon on 3/30/23.
//

import SwiftUI
import Charts

struct WorkoutScreen: View {
    @EnvironmentObject var healthData: HealthData
    @State private var addItemPopup = false
    @State private var setDefaultPopup = false
    @State private var selectedWorkoutData: WorkoutData?
    @State private var workoutGoalPopup = false
    @State private var goalValue = 60
    
    var currentDate = Date()
    let formatter = DateFormatter()
    

    let workoutView: [WorkoutChart] = [
        //SleepChart(weekday: Date().dayBefore6, sleepTime: Int)
    ]
    
    var body: some View {

        ZStack {
            Color.gray
                .brightness(0.4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack {
                Text("Workout Tracker")
                    .font(.title)
                    .foregroundColor(.green)
                    .bold()
                
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
                        ForEach( healthData.getWorkoutEntriesDateDefault(date: Date().getDayBefore(num: i))){ j in
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
                        .frame(width: 350.0, height: 100.0)
                        .overlay(
                            VStack {
                                HStack {
                                    Text("Today")
                                        .font(.title)
                                        .foregroundColor(.green)
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
//                                        Text("Total Hours of Sleep:")
//                                            .font(.custom("Arial Rounded MT Bold", size: 16))
//                                            .foregroundColor(.black)
//                                            .offset(x: 0, y: 6)
//
                                        HStack {
                                            Text("\(HealthData.getDataForDate(date: currentDate, dataList: healthData.workoutList))")
                                                .font(.custom("Arial Rounded MT Bold", size: 25))
                                                .foregroundColor(.green)
                                                .offset(x: 0, y: 10)
                                            
                                            Text("minutes")
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
                        ForEach(healthData.getWorkoutEntriesDate(date: currentDate)) { data in
                            HStack {
                                Button(action: {
                                    selectedWorkoutData = data
                                }) {
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(.white)
                                            .frame(width: 370.0, height: 80.0)
                                            .overlay(
                                                VStack {
                                                    
                                                    HStack {

                                                        VStack {
                                                            Text("Type:")
                                                                .font(.custom("Arial Rounded MT Bold", size: 16))
                                                                .foregroundColor(.black)
                                                                .offset(x: -30, y: 0)
                                                            
                                                            HStack {
                                                                Text("\(data.type)")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 22))
                                                                    .foregroundColor(.green)
                                                                    .offset(x: -30, y: 0)
                                                            }
                                                        }
                                                        VStack {
                                                            Text("Duration:")
                                                                .font(.custom("Arial Rounded MT Bold", size: 16))
                                                                .foregroundColor(.black)
                                                                .offset(x: 3, y: 1)
                                                            
                                                            HStack {
                                                                Text("\(data.data)")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 22))
                                                                    .foregroundColor(.green)
                                                                    .offset(x: 3, y: 0)
                                                                
                                                                Text("minutes")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 20))
                                                                    .foregroundColor(.black)
                                                                    .offset(x: 3, y: 0)
                                                                
                                                            }
                                                        }
                                                        
                                                        Image(systemName: "trash")
                                                            .foregroundColor(.red)
                                                            .offset(x: 30)
                                                            .onTapGesture {
                                                                if let index = healthData.workoutList.firstIndex(where: { $0.id == data.id }) {
                                                                    healthData.workoutList.remove(at: index)
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
                        workoutGoalPopup.toggle()
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
            WorkoutDataEntryView { workoutData in
                healthData.addWorkoutData(newEntry: workoutData)
                addItemPopup = false
            }
            .presentationDetents([.medium])
        }
        .fullScreenCover(item: $selectedWorkoutData) { workoutData in
            WorkoutDataDetailView(workoutData: workoutData)
        }
        .sheet(isPresented: $workoutGoalPopup) {
                WorkoutGoalEntryView { goalValue in
                    self.goalValue = goalValue
                    workoutGoalPopup = false
                }
        .presentationDetents([.medium])
        }
    }
    
}

struct WorkoutGoalEntryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var goal: String = ""
    
    var onSubmit: (Int) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter workout goal (minutes)", text: $goal)
                    .keyboardType(.numberPad)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            .navigationTitle("Set Workout Goal")
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



struct WorkoutDataDetailView: View {
    var workoutData: WorkoutData
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Date: \(workoutData.date, formatter: dateFormatter)")
                Text("Duration: \(workoutData.data, specifier: "%.1f") minutes")
            }
            .padding()
            .navigationTitle("Sleep Details")
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

struct WorkoutDataEntryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var date = Date()
    @State private var workoutType = String()
    @State private var workoutTime = Int()
    
    var onSubmit: (WorkoutData) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                
                TextField("Enter workout type", text: $workoutType)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                VStack {
                    Text("Workout Duration: \(workoutTime) minutes")
                    Picker("", selection: $workoutTime) {
                        ForEach(1...1000, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
    
            }
            
            .navigationTitle("Add Workout Data")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        onSubmit(WorkoutData(date: date, type: workoutType, data: workoutTime))
                        dismiss()
                    }
                }
            }
        }
    }
    
    func calculateDuration(startTime: Date, endTime: Date) -> TimeInterval {
        var duration = endTime.timeIntervalSince(startTime) / 3600
        if duration < 0 {
            duration += 24
        }
        return duration
    }
    
}

struct WorkoutChart: Identifiable{
    let weekday: Date
    let workoutTime: Int
    
    var id: Date { weekday }
}


/*extension Date{
    static func from(year:Int, month:Int, day: Int)-> Date{
        let components = DateComponents(year:year, month:month, day:day)
       // let f = DateFormatter()
        return Calendar.current.date(from: components)!
        //return f.weekdaySymbols[Calendar.current.component(.weekday, from:Date()-1)]
    }
}*/



struct WorkoutScreen_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutScreen()
            .environmentObject(HealthData())
    }
}

