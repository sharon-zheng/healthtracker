//
//  HealthData.swift
//  healthtracker
//
//  Created by sharon on 3/30/23.
//

import SwiftUI

struct HealthDataView: View {
    @EnvironmentObject var healthData: HealthData
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
                        .offset(x: -80, y: 70)
                    
                    HStack{
                        
                        NavigationLink(destination: SleepScreen().environmentObject(healthData),label: {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.indigo)
                                .frame(width: 170.0, height: 170.0)
                                .overlay(
                                    VStack {
                                        Text("Sleep")
                                            .font(.title).bold()
                                            .offset(x: -25, y: 0)
                                        Image(systemName: "bed.double")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                    }
                                )
                                        .foregroundColor(Color.white)
                                        .cornerRadius(20)
                                    
                        })
                        
                        NavigationLink(destination: WorkoutScreen(),label: {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.green)
                                .frame(width: 170.0, height: 170.0)
                                .overlay(
                                    VStack {
                                        Text("Workout")
                                            .font(.title).bold()
                                            .offset(x: -12, y: 0)
                                        Image(systemName: "figure.run")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                    }
                                )
                                        .foregroundColor(Color.white)
                                        .cornerRadius(20)
                                    
                        })
          
                    }.padding(.top, 150)
                    
                    HStack{
                        
                        NavigationLink(destination: WaterScreen(),label: {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.blue)
                                .frame(width: 170.0, height: 170.0)
                                .overlay(
                                    VStack {
                                        Text("Water")
                                            .font(.title).bold()
                                            .offset(x: -25, y: 0)
                                        Image(systemName: "takeoutbag.and.cup.and.straw")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                    }
                                )
                                        .foregroundColor(Color.white)
                                        .cornerRadius(20)
                                    
                        })
                        
                        NavigationLink(destination: MealScreen(),label: {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.orange)
                                .frame(width: 170.0, height: 170.0)
                                .overlay(
                                    VStack {
                                        Text("Meal")
                                            .font(.title).bold()
                                            .offset(x: -28, y: 0)
                                        Image(systemName: "fork.knife")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                    }
                                )
                                        .foregroundColor(Color.white)
                                        .cornerRadius(20)
                                    
                        })
          
                    }

               
                        
                }
                
            }
        }
                
    }
        
}

/*

struct HealthDataView_Previews: PreviewProvider {
    static var previews: some View {
        HealthDataView()
    }
}

*/
