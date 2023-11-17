//
//  HealthData.swift
//  healthtracker
//
//  Created by Anna Phung on 4/4/23.
//

import Foundation
import SwiftUI

enum HealthDataType{
    case sleep
    case workout
    case water
    case diet
}


enum ActivityLevel: String, CaseIterable, Identifiable{
    case sedentary = "Sedentary (little or no exercise)"
    case light = "Lightly Active (1-3 days/week)"
    case moderate = "Moderately Active (3-5 days/week)"
    case active = "Very Active (6-7 days/week)"
    case extra = "Extra Active (vigorous exercise daily)"
    
    var id: Self { self }
}

enum Gender: String,CaseIterable, Identifiable{
    case female = "Female"
    case male = "Male"
    case other = "Other"
    
    var id: Self { self }
    
}


enum MealType: String,CaseIterable, Identifiable{
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case brunch = "Brunch"
    case snack = "Snack"
    case fruit = "Fruit"
    
    var id: Self { self }
    
}

struct SleepData: Identifiable, CustomStringConvertible {
    var id = UUID()
    var date: Date
    var startTime: Date
    var endTime: Date
    var duration: TimeInterval {
        var timeInterval = endTime.timeIntervalSince(startTime) / 3600
        if (timeInterval < 0) {
            timeInterval += 24
        }
        return timeInterval
    }
    var description: String {
        return "{Date: \(dateFormatter.string(from: date)) Duration: \(duration)}"
    }
}

struct WorkoutData: Identifiable, CountableData {
    var id = UUID()
    var date: Date
    var type: String
    var data: Int
}

struct WaterData: Identifiable, CountableData {
    
    var id = UUID()
    var date: Date
    var data: Int
}

struct DietData: Identifiable, CountableData {
    var id = UUID()
    var date: Date
    var type: MealType
    var food: String
    var data: Int
}

protocol CountableData {
    var data: Int { get set }
    var date: Date { get set }
}


class HealthData: ObservableObject {
    @Published var sleepList: [SleepData] = []
    @Published var workoutList: [WorkoutData] = []
    @Published var waterList: [WaterData] = []
    @Published var dietList: [DietData] = []
    @Published var test: String = "hello"
    
    func addSleepData(newEntry: SleepData) {
        sleepList.append(newEntry)
    }
    
    func addWorkoutData(newEntry: WorkoutData) {
        workoutList.append(newEntry)
    }
    
    func addWaterList(newEntry: WaterData) {
        waterList.append(newEntry)
    }
    
    func addDietList(newEntry: DietData) {
        dietList.append(newEntry)
    }
    
    
    func getSleepHours(date: Date) -> TimeInterval {
        return sleepList.filter { sleepEntry in
            return Calendar.current.isDate(sleepEntry.date, inSameDayAs: date)
        }.reduce(TimeInterval(0),  {x,y in x + y.duration})
    }
    
    func getMealCalorie(date:Date) -> Int {
        var totalCalories = 0
        
        for dietData in dietList {
            if Calendar.current.isDate(dietData.date, equalTo: date, toGranularity: .day) {
                totalCalories += dietData.data
            }
        }
        return totalCalories
    }
    
    func getSleepEntriesDateDefault(date: Date) -> [SleepData] {
        let result = sleepList.filter { sleepEntry in
            return Calendar.current.isDate(sleepEntry.date, inSameDayAs: date)
        }
        if result.count == 0 {
            return [SleepData(date: date, startTime: Date.now, endTime: Date.now)]
        } else {
            return result
        }
    }
    
    func getSleepEntriesDate(date: Date) -> [SleepData] {
        return sleepList.filter { sleepEntry in
            return Calendar.current.isDate(sleepEntry.date, inSameDayAs: date)
        }
    }
    
    // Use get data for history view (put waterList, workoutList, or dietList for dataList)
    // Similar to the sleep function: getSleepHours
    static func getDataForDate(date: Date, dataList: [CountableData]) -> Int {
        return dataList.filter { entry in
            return Calendar.current.isDate(entry.date, inSameDayAs: date)
        }.reduce(0,  {x,y in x + y.data})
    }
    
    // Use to get data for graphs for water data
    // Similar to the sleep function: getSleepEntriesDateDefault
    func getWaterEntriesDateDefault(date: Date) -> [WaterData] {
        let result = waterList.filter { entry in
            return Calendar.current.isDate(entry.date, inSameDayAs: date)
        }
        if result.count == 0 {
            return [WaterData(date: date, data: 0)]
        } else {
            return result
        }
    }
    
    // Use to get data for graphs for workout data
    // Similar to the sleep function: getSleepEntriesDateDefault
    func getWorkoutEntriesDateDefault(date: Date) -> [WorkoutData] {
        let result = workoutList.filter { entry in
            return Calendar.current.isDate(entry.date, inSameDayAs: date)
        }
        if result.count == 0 {
            return [WorkoutData(date: date, type: "", data: 0)]
        } else {
            return result
        }
    }
    
    // Use to get data for graphs for diet data
    // Similar to the sleep function: getSleepEntriesDateDefault
    func getDietEntriesDateDefault(date: Date) -> [DietData] {
        let result = dietList.filter { entry in
            return Calendar.current.isDate(entry.date, inSameDayAs: date)
        }
        if result.count == 0 {
            return [DietData(date: date, type: MealType.snack, food: "", data: 0)]
        } else {
            return result
        }
    }
    
    // Use to get data for water entry logs
    // Similar to the sleep function: getSleepEntriesDate
    func getWaterEntriesDate(date: Date) -> [WaterData] {
        return waterList.filter { entry in
            return Calendar.current.isDate(entry.date, inSameDayAs: date)
        }
    }
    
    // Use to get data for workout entry logs
    // Similar to the sleep function: getSleepEntriesDate
    func getWorkoutEntriesDate(date: Date) -> [WorkoutData] {
        return workoutList.filter { entry in
            return Calendar.current.isDate(entry.date, inSameDayAs: date)
        }
    }
    
    // Use to get data for diet entry logs
    // Similar to the sleep function: getSleepEntriesDate
    func getDietEntriesDate(date: Date) -> [DietData] {
        return dietList.filter { entry in
            return Calendar.current.isDate(entry.date, inSameDayAs: date)
        }
    }
}


let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}()

extension Date {
    func getDayBefore(num: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -num, to: self)!
    }
}

