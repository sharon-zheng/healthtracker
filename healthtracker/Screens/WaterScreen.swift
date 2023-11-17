//
//  WaterScreen.swift
//  healthtracker
//
//  Created by sharon on 3/30/23.
//

import SwiftUI
import Charts


struct WaterScreen: View {
    @EnvironmentObject var healthData: HealthData
    @State private var addItemPopup = false
    @State private var setDefaultPopup = false
    @State private var selectedWaterData: WaterData?
    @State private var waterGoalPopup = false
    @State private var goalValue = 64 // default goal value in ounces (8 glasses of 8 ounces)
    
    var currentDate = Date()
    let formatter = DateFormatter()
    
    var body: some View {
        
        ZStack {
            Color.gray
                .brightness(0.4)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack {
                Text("Water Tracker")
                    .font(.title)
                    .foregroundColor(.blue)
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
                        ForEach( healthData.getWaterEntriesDateDefault(date: Date().getDayBefore(num: i))){ j in
                            BarMark(
                                x:.value("Date",j.date.formatted(Date.FormatStyle().weekday(.abbreviated))),
                                y:.value("Volume", j.data)
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
                                        .foregroundColor(.blue)
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
                                        Text("Total Water Intake:")
                                            .font(.custom("Arial Rounded MT Bold", size: 16))
                                            .foregroundColor(.black)
                                            .offset(x: 0, y: 6)
                                        
                                        HStack {
                                            Text("\(HealthData.getDataForDate(date: currentDate, dataList: healthData.waterList))")
                                                .font(.custom("Arial Rounded MT Bold", size: 25))
                                                .foregroundColor(.blue)
                                                .offset(x: 0, y: 10)
                                            
                                            Text("oz")
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
                        ForEach(healthData.getWaterEntriesDate(date: currentDate)) { data in
                            HStack {
                                Button(action: {
                                    selectedWaterData = data
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(.white)
                                            .frame(width: 370.0, height: 80.0)
                                            .overlay(
                                                VStack {
                                                    
                                                    HStack {
                                                        VStack {
                                                            Text("Time:")
                                                                .font(.custom("Arial Rounded MT Bold", size: 16))
                                                                .foregroundColor(.black)
                                                                .offset(x: -5, y: 0)
                                                            
                                                            HStack {
                                                                Text("\(data.date, formatter: timeFormatter)")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 22))
                                                                    .foregroundColor(.blue)
                                                                    .offset(x: -8, y: 0)
                                                            }
                                                        }
                                                        VStack {
                                                            Text("Volume:")
                                                                .font(.custom("Arial Rounded MT Bold", size: 16))
                                                                .foregroundColor(.black)
                                                                .offset(x: 3, y: 1)
                                                            
                                                            HStack {
                                                                Text("\(data.data)")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 22))
                                                                    .foregroundColor(.blue)
                                                                    .offset(x: 3, y: 0)
                                                                
                                                                Text("oz")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 20))
                                                                    .foregroundColor(.black)
                                                                    .offset(x: 3, y: 0)
                                                            }
                                                        }
                                                        
                                                        Image(systemName: "trash")
                                                            .foregroundColor(.red)
                                                            .offset(x: 12)
                                                            .onTapGesture {
                                                                if let index = healthData.waterList.firstIndex(where: { $0.id == data.id }) {
                                                                    healthData.waterList.remove(at: index)
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
                        waterGoalPopup.toggle()
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
            WaterDataEntryView { waterData in
                healthData.addWaterList(newEntry: waterData)
                addItemPopup = false
            }
            .presentationDetents([.medium])
        }
        .fullScreenCover(item: $selectedWaterData) { waterData in
            WaterDataDetailView(waterData: waterData)
        }
        .sheet(isPresented: $waterGoalPopup) {
            WaterGoalEntryView { goalValue in
                self.goalValue = goalValue
                waterGoalPopup = false
            }
            .presentationDetents([.medium])
        }
    }
}

struct WaterGoalEntryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var goal: String = ""
    
    var onSubmit: (Int) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter water intake goal (oz)", text: $goal)
                    .keyboardType(.numberPad)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            .navigationTitle("Set Water Intake Goal")
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


struct WaterDataDetailView: View {
    var waterData: WaterData
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Date: \(waterData.date, formatter: dateFormatter)")
                Text("Volume: \(waterData.data) oz")
            }
            .padding()
            .navigationTitle("Water Intake Details")
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

struct WaterDataEntryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var date = Date()
    @State private var volume = ""
    
    var onSubmit: (WaterData) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Volume (oz)", text: $volume)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add Water Intake Data")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        if let volumeInt = Int(volume) {
                            onSubmit(WaterData(date: date, data: volumeInt))
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct WaterChart: Identifiable{
    let weekday: Date
    let volume: Double
    
    var id: Date { weekday }
}

struct WaterScreen_Previews: PreviewProvider {
    static var previews: some View {
        WaterScreen()
            .environmentObject(HealthData())
    }
}

