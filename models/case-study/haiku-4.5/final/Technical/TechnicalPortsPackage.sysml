package TechnicalPortsPackage {

	private import SI::*;
	private import ISQ::*;
	private import CoSMAPackage::*;

	// --- Flow Item Definitions ---
	item def RadarTrackData { doc /* Radar track data including position, velocity, heading, and radar cross-section information */ }
	item def TargetCueingData { doc /* Target cueing and notification data with position, bearing, or coordinate information */ }
	item def VoiceCommData { doc /* Voice communication data representing analog audio signals and messages */ }
	item def DatalinkData { doc /* Digital datalink packet data for coordinate transmission and command reception */ }
	item def SensorImagery { doc /* Electro-optical/infrared sensor video and imagery data with tracking information */ }
	item def WeaponCommand { doc /* Weapon firing commands and status telemetry for rocket pods and guided systems */ }
	item def FuelFlowData { doc /* Fuel quantity, consumption, and refueling requirement data */ }
	item def NavigationData { doc /* Navigation waypoints, coordinates, headings, and routing instructions */ }
	item def CommandSignal { doc /* Discrete commands, authorization signals, and control instructions */ }
	item def LaserBeam { doc /* Coherent laser beam designator output for semi-active laser guidance */ }
	item def AmmunitionLoadData { doc /* Ammunition and ordnance load-out configuration data */ }

	// --- Port Definitions ---
	port def VoiceCommPort {
		doc /* Port for VHF voice-only radio communication between air and ground elements */
		inout item voiceSignal : VoiceCommData;
	}
	port def DatalinkPort {
		doc /* Port for digital V/UHF datalink communication supporting coordinate and command transmission */
		inout item datalinkPacket : DatalinkData;
	}
	port def TargetCueingPort {
		doc /* Port for reception and transmission of target position, bearing, and identification data */
		in item targetNotification : TargetCueingData;
		out item targetRequest : CommandSignal;
	}
	port def SensorDataPort {
		doc /* Port for EO/IR sensor imagery, video, and tracking data output */
		out item sensorImagery : SensorImagery;
		out item sensorTelemetry : NavigationData;
	}
	port def RadarDataPort {
		doc /* Port for transmission and reception of radar track data between radar and control center */
		inout item trackData : RadarTrackData;
	}
	port def WeaponFiringPort {
		doc /* Port for weapon firing commands and rocket pod/APKWS integration */
		in item firingCommand : WeaponCommand;
		out item weaponStatus : CommandSignal;
	}
	port def WeaponCueingPort {
		doc /* Port for laser designation and guidance cuing to guided munitions */
		out item laserDesignation : LaserBeam;
	}
	port def CommandPort {
		doc /* Port for transmission of airspace control commands and authorization signals */
		out item command : CommandSignal;
	}
	port def LogisticsPort {
		doc /* Port for fuel and ordnance load-out requests and logistics coordination at FARP */
		out item fuelRequest : FuelFlowData;
		out item ordnanceRequest : AmmunitionLoadData;
	}

	// --- Interface Definitions ---
	interface def VoiceCommInterface {
		doc /* Voice communication link between A-29 baseline and E-99M via VHF radio */
		end source : VoiceCommPort;
		end target : ~VoiceCommPort;
	}
	interface def TargetCueingInterface {
		doc /* Target notification and cueing interface between E-99M and interceptor aircraft (baseline voice, A-29N datalink) */
		end controller : TargetCueingPort;
		end interceptor : ~TargetCueingPort;
	}
	interface def DatalinkInterface {
		doc /* Digital datalink connection between E-99M and A-29N for coordinate transmission and command reception */
		end source : DatalinkPort;
		end target : ~DatalinkPort;
	}
	interface def SensorInterface {
		doc /* EO/IR sensor data output interface from FLIR Star SAFIRE II to A-29N fire control */
		end sensor : SensorDataPort;
		end fireControl : ~WeaponFiringPort;
	}
	interface def LaserGuidanceInterface {
		doc /* Laser designation link from FLIR Star SAFIRE II to APKWS seekers on guided rockets */
		end designator : WeaponCueingPort;
		end seeker : ~WeaponCueingPort;
	}
	interface def RadarInterface {
		doc /* Radar track data interface between PS-890 Erieye radar and CINDACTA IV control center */
		end radar : RadarDataPort;
		end controlCenter : ~RadarDataPort;
	}
	interface def AirspaceControlInterface {
		doc /* Airspace control command interface from CINDACTA IV to all A-29 interceptor aircraft */
		end controlCenter : CommandPort;
		end aircraft : ~CommandPort;
	}
	interface def LogisticsInterface {
		doc /* Logistics coordination interface between A-29 aircraft and FARP for fuel/ordnance services */
		end aircraft : LogisticsPort;
		end farp : ~LogisticsPort;
	}
}