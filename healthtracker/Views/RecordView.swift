//
//  RecordView.swift
//  healthtracker
//
//  Created by sharon on 3/30/23.
//

import SwiftUI

struct RecordView: View {
    @EnvironmentObject var viewModel: HealthData
    @State var isShowing = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.gray
                    .brightness(0.4)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                ScrollView{
                    Text("Health Data")
                        .font(.largeTitle)
                        .foregroundColor(Color.black)
                        .offset(x: -90, y: 0)
                    
                    VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.white)
                                .frame(width: 370.0, height: 150.0)
                                .overlay(
                                    Text("Sleep")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .offset(x: -140, y: -45)
                                )
                            Spacer()
                            VStack{
                                NavigationLink(destination: SleepScreen(),label: {
                                    Text("Start")
                                        .frame(width: 260.0, height: 40.0)
                                        .background(Color.indigo)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(10)
                                    
                                })
                                
                            }
                            .offset(y:35)
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.white)
                                .frame(width: 370.0, height: 150.0)
                                .overlay(
                                    Text("Workout")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .offset(x: -140, y: -45)
                                )
                            Spacer()
                            VStack{
                                NavigationLink(destination: WorkoutScreen(),label: {
                                    Text("Start")
                                        .frame(width: 260.0, height: 40.0)
                                        .background(Color.green)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(10)
                                })
                                
                            }
                            .offset(y:35)
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.white)
                                .frame(width: 370.0, height: 150.0)
                                .overlay(
                                    Text("Water")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .offset(x: -140, y: -45)
                                )
                            Spacer()
                            VStack{
                                NavigationLink(destination: WaterScreen(),label: {
                                    Text("Start")
                                        .frame(width: 260.0, height: 40.0)
                                        .background(Color.blue)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(10)
                                })
                                
                            }
                            .offset(y:35)
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.white)
                                .frame(width: 370.0, height: 150.0)
                                .overlay(
                                    Text("Meal")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .offset(x: -140, y: -45)
                                )
                            Spacer()
                            VStack{
                                NavigationLink(destination: MealScreen(),label: {
                                    Text("Start")
                                        .frame(width: 260.0, height: 40.0)
                                        .background(Color.orange)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(10)
                                })
                                
                            }
                            .offset(y:35)
                        }
                        
                    }
                }
                
            }
        }
                
    }
        
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
