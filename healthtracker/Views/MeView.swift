//
//  MeView.swift
//  healthtracker
//
//  Created by sharon on 3/30/23.
//

import SwiftUI
import UserNotifications

struct MeView: View {
    var body: some View {
        
        NavigationStack{
            List{
                
                Section("Heath Tools"){
                    NavigationLink(destination: BMICalculatorView()){
                        Label("BMI Calculator",systemImage: "number.square.fill")
                            .foregroundColor(.pink)
                    }
                    NavigationLink(destination: SuggestGoalView()){
                        Label("Suggest Goals",systemImage: "lightbulb")
                            .foregroundColor(.yellow)
                    }
                }
                Section("Reminders"){
                   
                    NavigationLink(destination: SleepRemainder()){
                        Label("Sleep",systemImage: "bed.double")
                            .foregroundColor(.indigo)
                    }
                    NavigationLink(destination: WaterRemainder()){
                        Label("Water",systemImage: "takeoutbag.and.cup.and.straw")
                            .foregroundColor(.blue)
                    }
                    NavigationLink(destination: WorkoutRemainder()){
                        Label("Workout",systemImage: "figure.run")
                            .foregroundColor(.green)
                    }
                    NavigationLink(destination: MealRemainder()){
                        Label("Meal",systemImage: "fork.knife")
                            .foregroundColor(.orange)
                    }
                  
                    /*
                    ForEach(trackTypes,id: \.name){ trackType in
                        NavigationLink(SleepRemainder(),value:trackType){
                            Label(trackType.name,systemImage: trackType.imageName)
                                .foregroundColor(trackType.color)
                        }
                        
                    }*/
                }
            }
            
            /*Form{
                Section(header:Text("display")){
                    Toggle(isOn: .constant(true),
                           label: {
                        Text("Dark Mode")
                        
                    })
                }
            }*/
            .navigationTitle("My Settings")
            
        }
        .onAppear{
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
    }
}

import SwiftUI

struct BMICalculatorView: View {
    @State private var weight = ""
    @State private var height = ""

    var body: some View {
        Form {
            Section(header: Text("Enter your weight (kg)")) {
                TextField("Weight", text: $weight)
                    .keyboardType(.decimalPad)
            }

            Section(header: Text("Enter your height (cm)")) {
                TextField("Height", text: $height)
                    .keyboardType(.decimalPad)
            }

            Section(header: Text("Your BMI")) {
                Text("\(calculateBMI())")
            }
            
            Section(header: Text("BMI Category")) {
                Text("\(bmiCategory())")
            }
        }
        .navigationTitle("BMI Calculator")
    }

    func calculateBMI() -> Double {
        guard let weight = Double(weight), let height = Double(height), height != 0 else {
            return 0
        }

        let heightInMeters = height / 100
        let bmi = weight / (heightInMeters * heightInMeters)
        return bmi
    }

    func bmiCategory() -> String {
        let bmi = calculateBMI()
        if bmi < 0 {
            return "Invalid Input"
        } else if bmi < 18.5 {
            return "Underweight"
        } else if bmi < 24.9 {
            return "Normal weight"
        } else if bmi < 29.9 {
            return "Overweight"
        } else {
            return "Obesity"
        }
    }
}

struct SuggestGoalView: View {
    @State private var age = ""
    @State private var weight = ""
    @State private var height = ""
    @State private var gender: Gender = .female
    @State private var activityLevel: ActivityLevel = .sedentary

    var body: some View {
        Form {
            Section(header: Text("Enter your age (years)")) {
                TextField("Age", text: $age)
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("Select your gender")) {
                Picker("Gender", selection: $gender){
                    ForEach(Gender.allCases) { option in
                        Text((String(describing: option.rawValue)))
                    }
                }
            }

            Section(header: Text("Enter your weight (kg)")) {
                TextField("Weight", text: $weight)
                    .keyboardType(.decimalPad)
            }

            Section(header: Text("Enter your height (cm)")) {
                TextField("Height", text: $height)
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("How active are you?")) {
                Picker("Level", selection: $activityLevel){
                    ForEach(ActivityLevel.allCases) { option in
                        Text((String(describing: option.rawValue)))
                    }
                }
            }
            
            Section(header: Text("Your Recommended Amount of Sleep")) {
                Text(calculateSleep())
            }.foregroundColor(Color.indigo)
            
            Section(header: Text("Your Recommended Physical Activity Per Day (minutes)")) {
                Text(String(format: "%.0f", calculateExercise()))            }.foregroundColor(Color.green)
            
            Section(header: Text("Your Daily Calorie Need")) {
                Text(String(format: "%.0f", calculateCalories()))
            }.foregroundColor(Color.orange)
            
            Section(header: Text("Your Daily Water Need (ounces)")) {
                Text(String(format: "%.0f", calculateWater()))
            }.foregroundColor(Color.blue)
            
            /*
            Section(header: Text("BMI Category")) {
                Text("\(bmiCategory())")
            }*/
        }
        .navigationTitle("Suggest Goals")
    }

    func calculateCalories() -> Double {
        guard let weight = Double(weight), let height = Double(height),
              let age = Double(age), height != 0 else {
            return 0
        }
        
        var activityFactor = 1.2
        if activityLevel == .light {
            activityFactor = 1.375
        } else if activityLevel == .moderate {
            activityFactor = 1.55
        } else if activityLevel == .active {
            activityFactor = 1.725
        } else if activityLevel == .extra {
            activityFactor = 1.9
        }

        if gender == .female {
            return round((655 + (9.6 * weight) + (1.8 * height) - (4.7 * age)) * activityFactor)
        } else {
            return round((66 + (13.7 * weight) + (5 * height) - (6.8 * age)) * activityFactor)
        }
    }
    
    func calculateSleep() -> String {
        guard let age = Double(age) else {
            return "N/A"
        }
        
        if age < 1 {
            return "12-16 hours"
        } else if age < 3 {
            return "11-14 hours"
        } else if age < 6 {
            return "10-13 hours"
        } else if age < 13 {
            return "9-12 hours"
        } else if age < 18 {
            return "8-10 hours"
        } else {
            return "7 or more hours"
        }
    }
    
    func calculateExercise() -> Double {
        guard let age = Double(age) else {
            return 0
        }
        if age < 17 {
            return 60
        } else if age < 65{
            return 150
        } else {
            return 150
        }
    }
    
    func calculateWater() -> Double {
        guard let weight = Double(weight) else {
            return 0
        }
        
        return weight/2 + (calculateExercise()/30 * 12)
    }

    /*
    func bmiCategory() -> String {
        let bmi = calculateBMI()
        if bmi < 0 {
            return "Invalid Input"
        } else if bmi < 18.5 {
            return "Underweight"
        } else if bmi < 24.9 {
            return "Normal weight"
        } else if bmi < 29.9 {
            return "Overweight"
        } else {
            return "Obesity"
        }
    }*/
}


struct SleepRemainder: View{
    @State private var showCalendar = false
    @State private var terminate = false
    @State private var isRepeat = false
    @State var selectedTime = Date()
    @State var option = ["everyday", "every 6 hours", "every 12 hours"]
    @State var selectedRepeat = "everyday"
    
    var body: some View{
        
        VStack{
            List{
                Section{
                    Toggle("Active", isOn:$showCalendar)
                    if(showCalendar) {
                        
                        DatePicker("Select Time to Sleep", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        Button("Enable Notification"){
                            NotificationManager.instance.requestAuthorization()
                            
                        }.offset(x:170)
                        
                        
                    }
                   /* Toggle("Stop when reach the goal",isOn:$terminate)*/
                }
                Section{
                    Toggle("Repeat Everyday", isOn: $isRepeat)
                    if (isRepeat){
                       /* Picker("Remainder repeat in every: ",selection: $selectedRepeat){
                            ForEach(option, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)*/
                    }
                    
                }
                
                
                let SleepComponents = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
                
                Button(action: {
                    let SleepContent = UNMutableNotificationContent()
                    SleepContent.title = "It's time to go to sleep."
                    SleepContent.subtitle = "Don't stay up late. It's important to get enought sleep."
                    SleepContent.sound = .default
                    SleepContent.badge = 1
                    
                    NotificationManager.instance.scheduleNotification(content:SleepContent, components: SleepComponents,SelectedRepeat: isRepeat)
                    
                    
                }, label: {
                    Text("Save".uppercased())
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal,20)
                        .frame(width:300,height:50)
                        .offset(x:0,y:0)
                        .background(
                            Color.blue
                                .cornerRadius(10))
                    
                })
                
            }
            
            
        }
        .navigationTitle("Reminder")
        
    }
}
struct WaterRemainder: View{
    @State private var showCalendar = false
    @State private var terminate = false
    @State private var isRepeat = false
    @State var selectedTime = Date()
    @State var option = ["everyday", "every 6 hours", "every 12 hours"]
    @State var selectedRepeat = "everyday"
    
    var body: some View{
        
        VStack{
            List{
                Section{
                    Toggle("Active", isOn:$showCalendar)
                    if(showCalendar) {
                        
                        DatePicker("Select time to remind you", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        Button("Enable Notification"){
                            NotificationManager.instance.requestAuthorization()
                            
                        }.offset(x:170)
                        
                        
                    }
                   /* Toggle("Stop when reach the goal",isOn:$terminate)*/
                }
                Section{
                    Toggle("Repeat Everyday", isOn: $isRepeat)
                    if (isRepeat){
                       /* Picker("Remainder repeat in every: ",selection: $selectedRepeat){
                            ForEach(option, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)*/
                    }
                    
                }
                
                
                let WaterComponents = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
                
                Button(action: {
                    let WaterContent = UNMutableNotificationContent()
                    WaterContent.title = "Hey! Just Checking"
                    WaterContent.subtitle = "Make sure you have enought water today."
                    WaterContent.sound = .default
                    WaterContent.badge = 1
                    NotificationManager.instance.scheduleNotification(content: WaterContent, components: WaterComponents,SelectedRepeat: isRepeat)}, label: {
                    Text("Save".uppercased())
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal,20)
                        .frame(width:300,height:50)
                        .offset(x:0,y:0)
                        .background(
                            Color.blue
                                .cornerRadius(10))
                    
                })
            }
        }
        .navigationTitle("Reminder")
        
    }
}

struct WorkoutRemainder: View{
    @State private var showCalendar = false
    @State private var terminate = false
    @State private var isRepeat = false
    @State var selectedTime = Date()
    @State var option = ["everyday", "every 6 hours", "every 12 hours"]
    @State var selectedRepeat = "everyday"
    
    var body: some View{
        
        VStack{
            List{
                Section{
                    Toggle("Active", isOn:$showCalendar)
                    if(showCalendar) {
                        
                        DatePicker("Select time to remind you", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        Button("Enable Notification"){
                            NotificationManager.instance.requestAuthorization()
                            
                        }.offset(x:170)
                        
                        
                    }
                   /* Toggle("Stop when reach the goal",isOn:$terminate)*/
                }
                Section{
                    Toggle("Repeat Everyday", isOn: $isRepeat)
                    if (isRepeat){
                       /* Picker("Remainder repeat in every: ",selection: $selectedRepeat){
                            ForEach(option, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)*/
                    }
                    
                }
                
                
                let WorkoutComponents = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
                
                Button(action: {
                    let WorkoutContent = UNMutableNotificationContent()
                    WorkoutContent.title = "Don't be lazy!"
                    WorkoutContent.subtitle = "It's time to reach your goal"
                    WorkoutContent.sound = .default
                    WorkoutContent.badge = 1
                    NotificationManager.instance.scheduleNotification(content: WorkoutContent, components: WorkoutComponents,SelectedRepeat: isRepeat)}, label: {
                    Text("Save".uppercased())
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal,20)
                        .frame(width:300,height:50)
                        .offset(x:0,y:0)
                        .background(
                            Color.blue
                                .cornerRadius(10))
                    
                })
            }
        }
        .navigationTitle("Reminder")
        
    }
}

struct MealRemainder: View{
    @State private var showCalendar = false
    @State private var terminate = false
    @State private var isRepeat = false
    @State var selectedTime = Date()
    @State var option = ["everyday", "every 6 hours", "every 12 hours"]
    @State var selectedRepeat = "everyday"
    
    var body: some View{
        VStack{
            List{
                Section{
                    Toggle("Active", isOn:$showCalendar)
                    if(showCalendar) {
                        
                        DatePicker("Select time to remind you", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        Button("Enable Notification"){
                            NotificationManager.instance.requestAuthorization()
                            
                        }.offset(x:170)
                        
                        
                    }
                   /* Toggle("Stop when reach the goal",isOn:$terminate)*/
                }
                Section{
                    Toggle("Repeat Everyday", isOn: $isRepeat)
                    if (isRepeat){
                        /*Picker("Remainder repeat in every: ",selection: $selectedRepeat){
                            ForEach(option, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel) */
                    }
                    
                }
                
                
                let MealComponents = Calendar.current.dateComponents([.hour, .minute], from: selectedTime)
                
                Button(action: {
                    let MealContent = UNMutableNotificationContent()
                    MealContent.title = "Don't skip a meal!"
                    MealContent.subtitle = "It's important to get enough nutrition everyday."
                    MealContent.sound = .default
                    MealContent.badge = 1
                    NotificationManager.instance.scheduleNotification(content: MealContent, components: MealComponents,SelectedRepeat: isRepeat)}, label: {
                    Text("Save".uppercased())
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal,20)
                        .frame(width:300,height:50)
                        .offset(x:0,y:0)
                        .background(
                            Color.blue
                                .cornerRadius(10))
                    
                })
            }
        }
        .navigationTitle("Reminder")
        
    }
}


class NotificationManager{
    static let instance = NotificationManager()
    
    func requestAuthorization(){
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options){ (success, error) in
            if let error = error{
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    
    func scheduleNotification(content:UNMutableNotificationContent,components:DateComponents, SelectedRepeat:Bool){
        
      
        let trigger =
        UNCalendarNotificationTrigger(dateMatching:components, repeats: SelectedRepeat)
        
        let Request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(Request)
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
