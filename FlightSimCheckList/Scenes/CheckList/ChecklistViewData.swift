//
//  ChecklistData.swift
//  FlightSimCheckList
//
//  Created by Tabita Barbosa on 08/11/23.
//

import Foundation

// MARK: - Section Data Structure
//
public struct Item {
    var name: String
    var complement: String?
    var hasInput: Bool
}

public struct Section {
    var name: String
    var items: [Item]
    var collapsed: Bool
    
    public init(name: String, items: [Item], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

public var mockerDataAirbus: [Section] = [
    Section(name: "Cockpit Preparation", items: [
        Item(name: "Gear Pins & Covers", hasInput: false),
        Item(name: "Fuel Quantitty", complement: "kg/lbs", hasInput: true),
        Item(name: "Seat Belts On", hasInput: false),
        Item(name: "Adirs to NAV", hasInput: false),
        Item(name: "Baro Ref (both)", hasInput: true)
    ]),
    Section(name: "Before Start", items: [
        Item(name: "Parking Brake", hasInput: false),
        Item(name: "T.O Speed V1", complement: "knt", hasInput: true),
        Item(name: "T.O Speed VR", complement: "knt", hasInput: true),
        Item(name: "T.O Speed VR", complement: "knt", hasInput: true),
        Item(name: "Thrust", hasInput: true),
        Item(name: "Windows Closed", hasInput: false),
        Item(name: "Beacon Lights", hasInput: false),
    ]),
    Section(name: "After Start", items: [
        Item(name: "Anti Ice", hasInput: false),
        Item(name: "Ecam Status Page", hasInput: false),
        Item(name: "Pitch Trim", complement: "%", hasInput: true),
        Item(name: "Rudder Trim to zero", hasInput: false),
    ]),
    Section(name: "Taxi", items: [
        Item(name: "Flight Control Ok", hasInput: false),
        Item(name: "Flaps Setting", complement: "conf", hasInput: true),
        Item(name: "Radar On", hasInput: false),
        Item(name: "PWS Auto", hasInput: false),
        Item(name: "Eng Model Sel", hasInput: true),
        Item(name: "Auto Break Max", hasInput: false),
        Item(name: "Signs On", hasInput: false),
        Item(name: "Cabin Ready", hasInput: false),
        Item(name: "Flaps T.O", hasInput: false),
        Item(name: "T.O Config Norm", hasInput: false),
        Item(name: "Ecam Memo T.O no Blue", hasInput: false)
    ]),
    Section(name: "Lineup", items: [
        Item(name: "T.O Runway", complement: "conf", hasInput: true),
        Item(name: "TCAS", hasInput: true),
        Item(name: "Pack 1 & 2 On", hasInput: false),
    ]),
    Section(name: "Departure Change", items: [
        Item(name: "Runway", hasInput: true),
        Item(name: "SID", hasInput: true),
        Item(name: "Flaps Setting", hasInput: true),
        Item(name: "T.O Speeds", complement: "knt", hasInput: true),
        Item(name: "Thrust", hasInput: true),
        Item(name: "FCU Altitude", complement: "ft", hasInput: true),
    ]),
    Section(name: "Approach", items: [
        Item(name: "Baro Ref (both)", hasInput: true),
        Item(name: "Seat Belts On", hasInput: false),
        Item(name: "Minimums", complement: "ft", hasInput: true),
        Item(name: "Auto Brake", hasInput: true),
        Item(name: "Eng Mode Sel", hasInput: true),
    ]),
    Section(name: "Landing", items: [
        Item(name: "Go Around Alt Set", complement: "ft", hasInput: true),
        Item(name: "Cabin Crew Advised", hasInput: false),
        Item(name: "Landing Gear Down", hasInput: false),
        Item(name: "Signs On", hasInput: false),
        Item(name: "Cabin Ready", hasInput: false),
        Item(name: "Spoilers Armed", hasInput: false),
        Item(name: "Flaps Set", hasInput: false),
        Item(name: "Ecam Memo Landing no Blue", hasInput: false)
    ]),
    Section(name: "After Landing", items: [
        Item(name: "Radar Off", hasInput: false),
        Item(name: "PWS Off", hasInput: false)
    ]),
    Section(name: "Parking", items: [
        Item(name: "Park BRK or Chocks Set", hasInput: false),
        Item(name: "Engines Off", hasInput: false),
        Item(name: "Wing Lights Off", hasInput: false),
        Item(name: "Fuel Pumps Off", hasInput: false),
    ]),
    Section(name: "Securing the Aircraft", items: [
        Item(name: "Oxygen Off", hasInput: false),
        Item(name: "Emergency Exit Lights Off", hasInput: false),
        Item(name: "EFBs Off", hasInput: false),
        Item(name: "Batteries Off", hasInput: false),
    ])
]


public var mockedDataBoeing: [Section] = [
    Section(name: "Pre Flight", items: [
        Item(name: "Oxygen", hasInput: false),
        Item(name: "Instrument Transfer to Normal", hasInput: false),
        Item(name: "Display Switches to Auto", hasInput: false),
        Item(name: "Window Heat", hasInput: false),
        Item(name: "Pressurization Mode Selector to Auto", hasInput: false),
        Item(name: "Flight Instruments", hasInput: false),
        Item(name: "Parking Brake", hasInput: false),
        Item(name: "Engine Start Levers", hasInput: false),
    ]),
    Section(name: "Before Start", items: [
        Item(name: "Flight Deck Door Closed & Lock", hasInput: false),
        Item(name: "Fuel", complement: "kg/lbs", hasInput: true),
        Item(name: "Fuel Pumps On", hasInput: false),
        Item(name: "Passenger Signs", hasInput: false),
        Item(name: "Windows Locked", hasInput: false),
        Item(name: "MCP Set", hasInput: false),
        Item(name: "Takeoff Speeds Set", hasInput: false),
        Item(name: "CDU Preflight Completed", hasInput: false),
        Item(name: "Rudder Free", hasInput: false),
        Item(name: "Aileron Trim Zero", hasInput: false),
        Item(name: "Taxi & Takeoof Brifiend Completed", hasInput: false),
        Item(name: "Anti Collision Lights", hasInput: false),
    ]),
    Section(name: "Before Taxi", items: [
        Item(name: "Generators", hasInput: false),
        Item(name: "Probe Heat", complement: "kg/lbs", hasInput: true),
        Item(name: "Anti Ice", hasInput: true),
        Item(name: "Isolation Valves Auto", hasInput: false),
        Item(name: "Engine Start Switches Continuous", hasInput: false),
        Item(name: "Recall Checked", hasInput: false),
        Item(name: "Autobrake RTO", hasInput: false),
        Item(name: "CDEngine Start Levers IDLE Detent", hasInput: false),
        Item(name: "Flight Controls", hasInput: false),
        Item(name: "Ground Equipment Clear", hasInput: false)
    ]),
    Section(name: "Before Takeoff", items: [
        Item(name: "Flaps Green Lights", hasInput: true),
        Item(name: "Stabilizer Trim", complement: "units", hasInput: true)
    ]),
    Section(name: "After Takeoff", items: [
        Item(name: "Engine Bleeds", hasInput: false),
        Item(name: "Packs Auto", hasInput: false),
        Item(name: "Landing Gear Up & Off", hasInput: false),
        Item(name: "Flaps Up, No lights", hasInput: false)
    ]),
    Section(name: "Descent", items: [
        Item(name: "Pressurization Landing Altitude", complement: "ft", hasInput: true),
        Item(name: "Recall Checked", hasInput: false),
        Item(name: "Autobrake", hasInput: false),
        Item(name: "Landing Data VREF", hasInput: true),
        Item(name: "Landing Data Minimums", hasInput: true),
        Item(name: "Approach Briefing Completed", hasInput: false)
    ]),
    Section(name: "Approach", items: [
        Item(name: "Altimeters", complement: "set", hasInput: true)
    ]),
    Section(name: "Landing", items: [
        Item(name: "Engine Start Switches Continuos", hasInput: false),
        Item(name: "Speed Brake Armed", hasInput: false),
        Item(name: "Landing Gear Down", hasInput: false),
        Item(name: "Flaps Green Lights", hasInput: true),
    ]),
    Section(name: "Shutdown", items: [
        Item(name: "Fuel Pumps Off", hasInput: false),
        Item(name: "Probe Heat Off", hasInput: false),
        Item(name: "Hydraulic Panel Set", hasInput: false),
        Item(name: "Flaps Up", hasInput: false),
        Item(name: "Parking Brake", hasInput: true),
        Item(name: "Engine Start Levers CutOff", hasInput: false),
        Item(name: "Weather Radar Off", hasInput: false)
    ]),
    Section(name: "Securing Aircraft", items: [
        Item(name: "IRS's Off", hasInput: false),
        Item(name: "Emergent Exit Lights Off", hasInput: false),
        Item(name: "Window Heat Off", hasInput: false),
        Item(name: "Packs Off", hasInput: false),
    ])
]
