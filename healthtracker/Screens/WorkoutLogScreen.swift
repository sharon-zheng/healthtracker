//
//  WorkoutLogScreen.swift
//  healthtracker
//
//  Created by sharon on 4/25/23.
//

import SwiftUI

struct WorkoutLogScreen: View {
    @EnvironmentObject var healthData: HealthData
    @State private var selectedWorkoutData: WorkoutData?
    @Binding var selectedDate: Date
    let formatter = DateFormatter()
    
    var body: some View {
        ZStack {

            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .frame(width: 350.0, height: 150.0)
                        .overlay(
                            VStack {
                                Text(selectedDate, style: .date)
                                    .font(.custom("Arial Rounded MT Bold", size: 30))
                                    .foregroundColor(.green)
                                    .bold()
                                    .offset(y: 10)
                                Spacer()
                                HStack {
                
                                    VStack {
                                        Text("Total Minutes of Workout:")
                                            .font(.custom("Arial Rounded MT Bold", size: 16))
                                            .foregroundColor(.black)
                                            .offset(x: 0, y: 6)
                                        
                                        HStack {
                                            Text("\(HealthData.getDataForDate(date: selectedDate, dataList: healthData.workoutList))")
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
                                Spacer()
                            }
                        )
                }
                
                // Data Logs List View
                List {
                    Section(header: Spacer(minLength: 0)) {
                        ForEach(healthData.getWorkoutEntriesDate(date: selectedDate)) { data in
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
            
            
        }
    }
}

