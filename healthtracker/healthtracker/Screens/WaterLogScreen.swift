//
//  WaterLogScreen.swift
//  healthtracker
//
//  Created by sharon on 4/25/23.
//

import SwiftUI

struct WaterLogScreen: View {
    @EnvironmentObject var healthData: HealthData
    @State private var selectedWaterData: WaterData?
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
                                    .foregroundColor(.blue)
                                    .bold()
                                    .offset(y: 10)
                                Spacer()
                                
                                HStack {
                                    VStack {
                                        Text("Total Volume of Water:")
                                            .font(.custom("Arial Rounded MT Bold", size: 16))
                                            .foregroundColor(.black)
                                            .offset(x: 0, y: 6)

                                        HStack {
                                            Text("\(HealthData.getDataForDate(date: selectedDate, dataList: healthData.waterList))")
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
                                Spacer()
                            }
                        )
                }
                
                // Data Logs List View
                List {
                    Section(header: Spacer(minLength: 0)) {
                        ForEach(healthData.getWaterEntriesDate(date: selectedDate)) { data in
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
                                                            .offset(x: 30)
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
            
            
        }
    }
}

