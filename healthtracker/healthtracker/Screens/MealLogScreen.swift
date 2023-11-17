//
//  MealLogScreen.swift
//  healthtracker
//
//  Created by sharon on 4/25/23.
//

import SwiftUI

struct MealLogScreen: View {
    @EnvironmentObject var healthData: HealthData
    @State private var selectedDietData: DietData?
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
                                    .foregroundColor(.orange)
                                    .bold()
                                    .offset(y: 10)
                                Spacer()
                                HStack {
                
                                    VStack {
                                        Text("Total Amount of Calories")
                                            .font(.custom("Arial Rounded MT Bold", size: 16))
                                            .foregroundColor(.black)
                                            .offset(x: 0, y: 6)
                                        
                                        HStack {
                                            Text("\(HealthData.getDataForDate(date: selectedDate, dataList: healthData.dietList))")
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
                                Spacer()
                            }
                        )
                }
                
                // Data Logs List View
                List {
                    Section(header: Spacer(minLength: 0)) {
                        ForEach(healthData.getDietEntriesDate(date: selectedDate)) { data in
                            HStack {
                                Button(action: {
                                    selectedDietData = data
                                }) {
                                    ZStack {
                                        
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(.white)
                                            .frame(width: 370.0, height: 80.0)
                                            .overlay(
                                                VStack {
                                                    
                                                    HStack {

//                                                        VStack {
//                                                            Text("Type:")
//                                                                .font(.custom("Arial Rounded MT Bold", size: 16))
//                                                                .foregroundColor(.black)
//                                                                .offset(x: -30, y: 0)
//
//                                                            HStack {
//                                                                Text("\(data.volume)")
//                                                                    .font(.custom("Arial Rounded MT Bold", size: 22))
//                                                                    .foregroundColor(.orange)
//                                                                    .offset(x: -30, y: 0)
//                                                            }
//                                                        }
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
                                                                        
                                                                    }
                                                                }
                                                            }
                                                        }
                                                        
                                                        Image(systemName: "trash")
                                                            .foregroundColor(.red)
                                                            .offset(x: 30)
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
            
            
        }
    }
}

