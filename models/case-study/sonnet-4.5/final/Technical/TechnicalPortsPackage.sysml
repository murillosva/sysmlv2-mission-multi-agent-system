package TechnicalPortsPackage {

	private import SI::*;
	private import ISQ::*;
	private import CoSMAPackage::*;

	// --- Flow Item Definitions ---
	item def RadarTrackData { doc /* Represents radar detection events, target tracks, position, heading, speed, and classification data from surveillance radar systems */ }
	item def VoiceCommData { doc /* Represents voice communication messages including heading information, vectoring commands, and procedural coordination */ }
	item def DatalinkData { doc /* Represents digital datalink messages including geographic coordinates (latitude/longitude), target cueing data, and status updates */ }
	item def SensorImagery { doc /* Represents electro-optical and infrared sensor imagery, laser rangefinder data, and visual tracking information */ }
	item def WeaponCommand { doc /* Represents weapon employment signals including fire authorization, laser designation signals, and engagement termination commands */ }
	item def FuelMaterial { doc /* Represents aviation fuel transferred during refueling operations */ }
	item def TargetPositionData { doc /* Represents UAS position, heading, speed, altitude, and threat classification information */ }
	item def EngagementStatusData { doc /* Represents interceptor position, engagement status, tracking state, and mission phase information */ }

	// --- Port Definitions ---
	port def VoiceCommPort {
		doc /* VHF voice communication port for receiving heading vectoring information and procedural coordination */
		in item headingInfo : VoiceCommData;
		out item statusReport : VoiceCommData;
	}
	port def DatalinkPort {
		doc /* Digital datalink port for receiving geographic coordinates and transmitting engagement status */
		in item coordinateData : DatalinkData;
		out item interceptorStatus : EngagementStatusData;
	}
	port def RadarSurveillancePort {
		doc /* Radar data port for transmitting and receiving radar track information and target detections */
		out item radarTracks : RadarTrackData;
		in item groundRadarData : RadarTrackData;
	}
	port def CommandControlPort {
		doc /* Command and control port for transmitting vectoring commands, engagement assignments, and receiving status reports */
		out item vectoringCommands : VoiceCommData;
		out item coordinateCues : DatalinkData;
		in item interceptorStatus : EngagementStatusData;
		in item radarDetections : RadarTrackData;
	}
	port def SensorDataPort {
		doc /* Electro-optical/infrared sensor port for imagery, tracking data, and laser designation */
		in item cuingCoordinates : DatalinkData;
		out item sensorImagery : SensorImagery;
		out item trackingData : SensorImagery;
		out item laserDesignation : WeaponCommand;
	}
	port def WeaponFiringPort {
		doc /* Weapon employment port for launching munitions and receiving guidance signals */
		in item laserGuidance : WeaponCommand;
		out item rocketLaunch : WeaponCommand;
	}
	port def RefuelingPort {
		doc /* Refueling interface port for fuel transfer operations */
		in item fuelSupply : FuelMaterial;
		out item refuelRequest : VoiceCommData;
	}
	port def ThreatEmissionPort {
		doc /* Threat entity port for emitting position and state data detectable by surveillance systems */
		out item positionData : TargetPositionData;
		in item incomingFire : WeaponCommand;
	}
	port def GroundRadarPort {
		doc /* Ground-based radar surveillance port for continuous airspace monitoring */
		out item surveillanceData : RadarTrackData;
	}

	// --- Interface Definitions ---
	interface def VoiceVectoringInterface {
		doc /* VHF voice communication interface for heading vectoring from E-99M to baseline A-29 */
		end controller : CommandControlPort;
		end interceptor : ~VoiceCommPort;
	}
	interface def DatalinkCueingInterface {
		doc /* Digital datalink interface for coordinate cueing from E-99M to modernized A-29N */
		end controller : CommandControlPort;
		end interceptor : ~DatalinkPort;
	}
	interface def RadarSurveillanceInterface {
		doc /* Radar data feed interface from ground network to airborne radar */
		end groundRadar : GroundRadarPort;
		end airborneRadar : ~RadarSurveillancePort;
	}
	interface def SensorCueingInterface {
		doc /* Interface for cueing EO/IR sensor to datalink coordinates */
		end datalinkReceiver : DatalinkPort;
		end sensor : ~SensorDataPort;
	}
	interface def LaserGuidanceInterface {
		doc /* Semi-active laser designation interface from EO/IR sensor to APKWS guidance kit */
		end designator : SensorDataPort;
		end guidedMunition : ~WeaponFiringPort;
	}
	interface def KineticEngagementInterface {
		doc /* Weapon-to-target interface for rocket fire against illicit UAS */
		end weapon : WeaponFiringPort;
		end target : ~ThreatEmissionPort;
	}
	interface def RadarDetectionInterface {
		doc /* Radar detection interface from airborne radar to threat entities */
		end radar : RadarSurveillancePort;
		end threat : ~ThreatEmissionPort;
	}
	interface def RefuelingInterface {
		doc /* Aircraft refueling interface at FARP points */
		end farpEquipment : RefuelingPort;
		end aircraft : ~RefuelingPort;
	}
}