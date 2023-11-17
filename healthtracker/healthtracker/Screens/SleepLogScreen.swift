//
//  SleepLogScreen.swift
//  healthtracker
//
//  Created by sharon on 4/25/23.
//

import SwiftUI

struct SleepLogScreen: View {
    @EnvironmentObject var healthData: HealthData
    @State private var selectedSleepData: SleepData?
    @Binding var selectedDate: Date
    let formatter = DateFormatter()
    
    var body: some View {
        ZStack {

            VStack {
//                Text("Sleep Logs")
//                    .font(.title)
//                    .padding()
                
                // This Date's Title View
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                        .frame(width: 350.0, height: 150.0)
                        .overlay(
                            VStack {
                                Text(selectedDate, style: .date)
                                    .font(.custom("Arial Rounded MT Bold", size: 30))
                                    .foregroundColor(.indigo)
                                    .bold()
                                    .offset(y: 10)
                                Spacer()
                                HStack {
                
                                    VStack {
                                        Text("Total Hours of Sleep:")
                                            .font(.custom("Arial Rounded MT Bold", size: 16))
                                            .foregroundColor(.black)
                                            .offset(x: 0, y: 6)
                                        
                                        HStack {
                                            Text("\(healthData.getSleepHours(date: selectedDate), specifier: "%.1f")")
                                                .font(.custom("Arial Rounded MT Bold", size: 25))
                                                .foregroundColor(.indigo)
                                                .offset(x: 0, y: 10)
                                            
                                            Text("hours")
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
                        ForEach(healthData.getSleepEntriesDate(date: selectedDate)) { data in
                            HStack {
                                Button(action: {
                                    selectedSleepData = data
                                }) {
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(.white)
                                            .frame(width: 370.0, height: 80.0)
                                            .overlay(
                                                VStack {
                                                    
                                                    HStack {
                                                        VStack {
                                                            Text("Start Time:")
                                                                .font(.custom("Arial Rounded MT Bold", size: 16))
                                                                .foregroundColor(.black)
                                                                .offset(x: -5, y: 0)
                                                            
                                                            HStack {
                                                                Text("\(data.startTime, formatter: timeFormatter)")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 22))
                                                                    .foregroundColor(.indigo)
                                                                    .offset(x: -8, y: 0)
                                                            }
                                                        }
                                                        VStack {
                                                            Text("End Time:")
                                                                .font(.custom("Arial Rounded MT Bold", size: 16))
                                                                .foregroundColor(.black)
                                                                .offset(x: -3, y: 0)
                                                            
                                                            HStack {
                                                                Text("\(data.endTime, formatter: timeFormatter)")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 22))
                                                                    .foregroundColor(.indigo)
                                                                    .offset(x: -3, y: 0)
                                                            }
                                                        }
                                                        VStack {
                                                            Text("Duration:")
                                                                .font(.custom("Arial Rounded MT Bold", size: 16))
                                                                .foregroundColor(.black)
                                                                .offset(x: 3, y: 1)
                                                            
                                                            HStack {
                                                                Text("\(data.duration, specifier: "%.1f")")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 22))
                                                                    .foregroundColor(.indigo)
                                                                    .offset(x: 3, y: 0)
                                                                
                                                                Text("hrs")
                                                                    .font(.custom("Arial Rounded MT Bold", size: 20))
                                                                    .foregroundColor(.black)
                                                                    .offset(x: 3, y: 0)
                                                                
                                                            }
                                                        }
                                                        
                                                        Image(systemName: "trash")
                                                            .foregroundColor(.red)
                                                            .offset(x: 12)
                                                            .onTapGesture {
                                                                if let index = healthData.sleepList.firstIndex(where: { $0.id == data.id }) {
                                                                    healthData.sleepList.remove(at: index)
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

//struct Previews_SleepLogScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        SleepLogScreen(selectedDate: )
//            .environmentObject(HealthData())
//    }
//}
