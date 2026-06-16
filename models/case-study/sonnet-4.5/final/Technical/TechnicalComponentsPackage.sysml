package TechnicalComponentsPackage {

	private import CoSMAPackage::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import ShapeItems::*;
	private import SI::*;
	private import ISQ::*;
	private import LogicalComponentsPackage::*;
	private import TechnicalPortsPackage::*;
	part def EmbraerEMB314SuperTucanoAirframeBaseline :> System {
		doc /* Multi-mission turboprop airframe for baseline A-29 configuration; operates from unpaved runways; equipped with embedded wing-mounted .50 caliber machine guns; supports unguided SBAT-70 rocket employment; VHF voice communication for E-99M vectoring */
		attribute maxOperatingSpeedKCAS :> ISQ::speed = 320 [kn];
		attribute maxOperatingSpeed :> ISQ::speed = 165 [m/s];
		attribute cruiseSpeedKCAS :> ISQ::speed = 280 [kn];
		attribute cruiseSpeed :> ISQ::speed = 144 [m/s];
		attribute stallSpeedKCAS :> ISQ::speed = 80 [kn];
		attribute stallSpeed :> ISQ::speed = 41 [m/s];
		attribute maxRangeWith3ExternalTanksNmi :> ISQ::length = 1550 [nmi];
		attribute maxRangeWith3ExternalTanks :> ISQ::length = 2871 [km];
		attribute enduranceWith2ExternalTanksAndEOIR :> ISQ::time = 5.2 [h];
		attribute takeoffDistanceToClear50ft :> ISQ::length = 900 [m];
		attribute landingDistanceToClear50ft :> ISQ::length = 860 [m];
		attribute rateOfClimbAtSeaLevelFtMin :> ISQ::speed = 16.5 [m/s]; // converted from 3240 ft/min
		attribute rateOfClimbAtSeaLevel :> ISQ::speed = 16.5 [m/s];
		attribute serviceCeilingFt :> ISQ::length = 10668 [m]; // converted from 35000 ft
		attribute serviceCeiling :> ISQ::length = 10668 [m];
		port refuelingRequestPort : RefuelingPort;
	}
	part def FiftyCaliberMachineGunsWingEmbedded :> System {
		doc /* Organic .50 caliber machine gun armament embedded in aircraft wings; baseline defensive armament */
	}
	part def SBAT70UnguidedRocketLauncherPod :> System {
		doc /* Air-to-Ground Ballistic System 70 mm unguided rocket pod; chemical propulsion with solid propellant double-base; maximum employment range 2 km; firing distance determined by pilot philosophy (long: 2 km, medium: 1.25 km, short: 0.5 km); baseline kinetic engagement capability */
		attribute diameter :> ISQ::length = 0.07 [m];
		attribute maxEmploymentRange :> ISQ::length = 2 [km];
		attribute firingDistanceLongPhilosophy :> ISQ::length = 2 [km];
		attribute firingDistanceMediumPhilosophy :> ISQ::length = 1.25 [km];
		attribute firingDistanceShortPhilosophy :> ISQ::length = 0.5 [km];
		attribute propulsionType : ScalarValues::String = "solid propellant, double-base";
		port kineticEngagementPort : WeaponFiringPort;
	}
	part def VHFVoiceCommunicationRadio :> System {
		doc /* VHF voice communication radio for receiving heading information from E-99M; baseline vectoring interface; update interval random uniform distribution [5, 60] seconds */
		attribute updateIntervalMin :> ISQ::time = 5 [s];
		attribute updateIntervalMax :> ISQ::time = 60 [s];
		attribute dataType : ScalarValues::String = "heading information (azimuth, voice)";
		port vhfVoiceCommReceiverPort : VoiceCommPort;
	}
	part def PilotVisualAcquisitionSystemNakedEye :> SimpleThing {
		doc /* Human visual acquisition system for UAS detection and tracking; maximum visual acquisition distance [0, 7] nmi ≈ [0, 13] km; minimum acquisition and reaction time 12.5 s; visual acuity threshold 1.0 arcminute; visible area modifier: fixed-wing (14 m) no penalty, multi-rotor (1 m) penalty proportional to size (1/14) */
		attribute maxVisualAcquisitionDistanceMinNmi :> ISQ::length = 0 [nmi];
		attribute maxVisualAcquisitionDistanceMaxNmi :> ISQ::length = 7 [nmi];
		attribute maxVisualAcquisitionDistanceMin :> ISQ::length = 0 [km];
		attribute maxVisualAcquisitionDistanceMax :> ISQ::length = 13 [km];
		attribute minAcquisitionAndReactionTime :> ISQ::time = 12.5 [s];
		attribute visualAcuityThreshold :> ISQ::planeAngle = 1.0 ['arcmin'];
		attribute visibleAreaModifierFixedWing : ScalarValues::Real = 1.0;
		attribute visibleAreaModifierMultiRotor : ScalarValues::Real = 0.071;
	}
	part def EmbraerEMB314SuperTucanoAirframeModernized :> System {
		doc /* Modernized A-29N airframe with identical baseline airframe specifications; integrated with C-UAS avionic systems including digital datalink, EO/IR sensor, and APKWS laser-guided rocket capability */
		attribute maxOperatingSpeedKCAS :> ISQ::speed = 320 [kn];
		attribute maxOperatingSpeed :> ISQ::speed = 165 [m/s];
		attribute cruiseSpeedKCAS :> ISQ::speed = 280 [kn];
		attribute cruiseSpeed :> ISQ::speed = 144 [m/s];
		attribute stallSpeedKCAS :> ISQ::speed = 80 [kn];
		attribute stallSpeed :> ISQ::speed = 41 [m/s];
		attribute maxRangeWith3ExternalTanksNmi :> ISQ::length = 1550 [nmi];
		attribute maxRangeWith3ExternalTanks :> ISQ::length = 2871 [km];
		attribute enduranceWith2ExternalTanksAndEOIR :> ISQ::time = 5.2 [h];
		attribute takeoffDistanceToClear50ft :> ISQ::length = 900 [m];
		attribute landingDistanceToClear50ft :> ISQ::length = 860 [m];
		attribute rateOfClimbAtSeaLevelFtMin :> ISQ::speed = 16.5 [m/s]; // converted from 3240 ft/min
		attribute rateOfClimbAtSeaLevel :> ISQ::speed = 16.5 [m/s];
		attribute serviceCeilingFt :> ISQ::length = 10668 [m]; // converted from 35000 ft
		attribute serviceCeiling :> ISQ::length = 10668 [m];
	}
	part def RohdeAndSchwarzM3ARMR6000RLDigitalDatalink :> System {
		doc /* R&S M3AR MR6000R/L digital datalink for modernized A-29N; frequency range 30 MHz to 400 MHz (V/UHF); control interfaces MIL-STD-1553B and RS-485; data and voice network R&S SECOS (TDMA, up to 128 participants); data capability up to 16 kbit/s; receives geographic coordinates (latitude, longitude) from E-99M; update interval random uniform [1, 10] s; coordinate transmission latency idealized as instantaneous; coordinate reception sensitivity [1, 10] s */
		attribute frequencyRangeMin :> ISQ::frequency = 30000000.0 [Hz]; // converted from 30 MHz
		attribute frequencyRangeMax :> ISQ::frequency = 400000000.0 [Hz]; // converted from 400 MHz
		attribute controlInterfaces : ScalarValues::String = "MIL-STD-1553B, RS-485";
		attribute networkProtocol : ScalarValues::String = "R&S SECOS (TDMA)";
		attribute maxParticipants : ScalarValues::Integer = 128;
		attribute dataCapability : ScalarValues::Real = 16.0; // kbit/s, dimensionless representation
		attribute updateIntervalMin :> ISQ::time = 1 [s];
		attribute updateIntervalMax :> ISQ::time = 10 [s];
		attribute coordinateTransmissionLatency :> ISQ::time = 0 [s];
		attribute coordinateReceptionSensitivityMin :> ISQ::time = 1 [s];
		attribute coordinateReceptionSensitivityMax :> ISQ::time = 10 [s];
		port datalinkReceiverPort : DatalinkPort;
	}
	part def FLIRStarSAFIREIIEOIRSensor :> System {
		doc /* FLIR Star SAFIRE II electro-optical/infrared sensor for modernized A-29N; laser rangefinder max range 20 km; range accuracy 5 m; azimuth coverage 360° continuous; elevation coverage +30° to -120°; slew rate 60°/s; control interfaces SCU/serial digital/MIL-STD-1553B/ARINC; max operating speed 405 KCAS ≈ 208 m/s; used for search, positive identification, continuous tracking, and laser designation; tracking probability: fixed-wing (14 m) negligible loss, multi-rotor (1 m) intermittent losses (pe... */
		attribute laserRangefinderMaxRange :> ISQ::length = 20 [km];
		attribute rangeAccuracy :> ISQ::length = 5 [m];
		attribute azimuthCoverage :> ISQ::planeAngle = 360 ['°'];
		attribute azimuthContinuous : ScalarValues::Boolean = true;
		attribute elevationCoverageMin :> ISQ::planeAngle = -120 ['°'];
		attribute elevationCoverageMax :> ISQ::planeAngle = 30 ['°'];
		attribute slewRate : ScalarValues::Real = 60 ['°'/s]; // degrees per second
		attribute controlInterfaces : ScalarValues::String = "SCU, serial digital, MIL-STD-1553B, ARINC";
		attribute maxOperatingSpeedKCAS :> ISQ::speed = 405 [kn];
		attribute maxOperatingSpeed :> ISQ::speed = 208 [m/s];
		attribute trackingProbabilityFixedWing : ScalarValues::Real = 1.0;
		attribute trackingProbabilityMultiRotor : ScalarValues::Real = 0.2;
		port laserDesignationSignalPort : SensorDataPort;
	}
	part def APKWSLaserGuidanceKitWithSBAT70Rocket :> System {
		doc /* Advanced Precision Kill Weapon System (APKWS) laser guidance kit integrated with SBAT-70 rocket for modernized A-29N; semi-active laser guidance; minimum range 2 km (with guidance); maximum range 14 km (with guidance); hit probability 80% within 2 m of laser spot center at minimum range (2 km), decreasing linearly to 0% at 14 km; platform speed at launch 80 to 550 KCAS ≈ 41 to 283 m/s; launch altitude -200 to 25,000 ft ≈ -61 to 7620 m; weight 15.8 kg; firing distance determined by philosophy ... */
		attribute guidanceType : ScalarValues::String = "semi-active laser";
		attribute minRangeWithGuidance :> ISQ::length = 2 [km];
		attribute maxRangeWithGuidance :> ISQ::length = 14 [km];
		attribute hitProbabilityAtMinRange : ScalarValues::Real = 80.0; // percent
		attribute hitProbabilityAtMaxRange : ScalarValues::Real = 0.0; // percent
		attribute platformSpeedAtLaunchMinKCAS :> ISQ::speed = 80 [kn];
		attribute platformSpeedAtLaunchMaxKCAS :> ISQ::speed = 550 [kn];
		attribute platformSpeedAtLaunchMin :> ISQ::speed = 41 [m/s];
		attribute platformSpeedAtLaunchMax :> ISQ::speed = 283 [m/s];
		attribute launchAltitudeMinFt :> ISQ::length = -61 [m]; // converted from -200 ft
		attribute launchAltitudeMaxFt :> ISQ::length = 7620 [m]; // converted from 25000 ft
		attribute launchAltitudeMin :> ISQ::length = -61 [m];
		attribute launchAltitudeMax :> ISQ::length = 7620 [m];
		attribute weight :> ISQ::mass = 15.8 [kg];
		attribute firingDistanceLongPhilosophy :> ISQ::length = 14 [km];
		attribute firingDistanceMediumPhilosophy :> ISQ::length = 8 [km];
		attribute firingDistanceShortPhilosophy :> ISQ::length = 2 [km];
		attribute dimensionalPenaltyFixedWing : ScalarValues::Real = 1.0;
		attribute dimensionalPenaltyMultiRotor : ScalarValues::Real = 0.5;
		port kineticEngagementGuidedPort : WeaponFiringPort;
	}
	part def FiftyCaliberMachineGunsWingEmbeddedModernized :> System {
		doc /* Organic .50 caliber machine gun armament embedded in aircraft wings for modernized A-29N; identical to baseline TC-002 */
	}
	part def EmbraerEMB145AEWCAirframe :> System {
		doc /* Embraer EMB-145 Airborne Early Warning and Control (AEW&C) airframe platform for E-99M; cruise speed 450 KCAS ≈ 232 m/s; ceiling 37,000 ft ≈ 11,278 m; rate of climb at sea level 2,560 ft/min ≈ 13.0 m/s; range 1,330 nmi ≈ 2463 km; endurance 8 h */
		attribute cruiseSpeedKCAS :> ISQ::speed = 450 [kn];
		attribute cruiseSpeed :> ISQ::speed = 232 [m/s];
		attribute ceilingFt :> ISQ::length = 11278 [m]; // converted from 37000 ft
		attribute ceiling :> ISQ::length = 11278 [m];
		attribute rateOfClimbAtSeaLevelFtMin :> ISQ::speed = 13.0 [m/s]; // converted from 2560 ft/min
		attribute rateOfClimbAtSeaLevel :> ISQ::speed = 13.0 [m/s];
		attribute rangeNmi :> ISQ::length = 1330 [nmi];
		attribute range :> ISQ::length = 2463 [km];
		attribute endurance :> ISQ::time = 8 [h];
	}
	part def PS890ErieyeSBandAirborneRadar :> System {
		doc /* PS-890 Erieye S-band airborne radar for E-99M; S-band operation; reported ranges: hundreds of km; detection idealized with no failures for case study to isolate A-29 performance analysis; provides detection, tracking, and early warning of UAS incursions; continuous presence and full coverage in scenario border area */
		attribute band : ScalarValues::String = "S-band";
		attribute reportedRanges : ScalarValues::String = "hundreds of km";
		attribute detectionReliability : ScalarValues::String = "idealized (no failures)";
		attribute coveragePresence : ScalarValues::String = "continuous";
		port groundRadarDataFeedPort : RadarSurveillancePort;
	}
	part def CommandAndControlConsoleE99M :> System {
		doc /* Command and control console aboard E-99M; provides vectoring information to A-29: heading via VHF voice (baseline) at [5, 60] s intervals, geographic coordinates via datalink (A-29N) at [1, 10] s intervals; assigns engagement exclusivity (one UAS per A-29 at a time); notifies nearest A-29 on CAP of illicit UAS incursion */
		attribute vectoringHeadingUpdateIntervalMin :> ISQ::time = 5 [s];
		attribute vectoringHeadingUpdateIntervalMax :> ISQ::time = 60 [s];
		attribute vectoringCoordinateUpdateIntervalMin :> ISQ::time = 1 [s];
		attribute vectoringCoordinateUpdateIntervalMax :> ISQ::time = 10 [s];
		attribute engagementExclusivity : ScalarValues::String = "one UAS per A-29 at a time";
		port vectoringCommandOutputPort : CommandControlPort;
	}
	part def GroundRadarNetworkDECEACINDACTAIV :> System {
		doc /* Ground radar network operated by DECEA/CINDACTA IV; provides ground radar surveillance data to E-99M; responsible for continuous monitoring of continental ZIDA; air defense services; air traffic control */
		port surveillanceDataOutputPort : GroundRadarPort;
	}
	part def FARPPointSBCZ :> System {
		doc /* Forward Arming and Refueling Point at SBCZ; latitude 7°35'59.86"S; longitude 72°46'23.12"W; runway length 2400 m; surface: asphalt */
		attribute latitude : ScalarValues::String = "7°35'59.86\"S";
		attribute longitude : ScalarValues::String = "72°46'23.12\"W";
		attribute runwayLength :> ISQ::length = 2400 [m];
		attribute runwaySurface : ScalarValues::String = "Asphalt";
	}
	part def FARPPointSWKU :> System {
		doc /* Forward Arming and Refueling Point at SWKU; latitude 1°7'11.98"N; longitude 66°50'29.59"W; runway length 1200 m; surface: asphalt */
		attribute latitude : ScalarValues::String = "1°7'11.98\"N";
		attribute longitude : ScalarValues::String = "66°50'29.59\"W";
		attribute runwayLength :> ISQ::length = 1200 [m];
		attribute runwaySurface : ScalarValues::String = "Asphalt";
	}
	part def FARPPointSDCG :> System {
		doc /* Forward Arming and Refueling Point at SDCG; latitude 3°28'9.00"S; longitude 68°55'16.00"W; runway length 1200 m; surface: concrete */
		attribute latitude : ScalarValues::String = "3°28'9.00\"S";
		attribute longitude : ScalarValues::String = "68°55'16.00\"W";
		attribute runwayLength :> ISQ::length = 1200 [m];
		attribute runwaySurface : ScalarValues::String = "Concrete";
	}
	part def FARPPointSBRB :> System {
		doc /* Forward Arming and Refueling Point at SBRB; latitude 9°52'12.82"S; longitude 67°53'44.23"W; runway length 2158 m; surface: asphalt */
		attribute latitude : ScalarValues::String = "9°52'12.82\"S";
		attribute longitude : ScalarValues::String = "67°53'44.23\"W";
		attribute runwayLength :> ISQ::length = 2158 [m];
		attribute runwaySurface : ScalarValues::String = "Asphalt";
	}
	part def FARPRefuelingEquipment :> System {
		doc /* Refueling equipment at FARP points; enables refueling operations to restore aircraft endurance for return leg; refueling duration disregarded in simulation simplification */
		attribute refuelingDuration : ScalarValues::String = "disregarded";
		port refuelingConfirmationPort : RefuelingPort;
	}
	part def GovernadorJorgeTeixeiraDeOliveiraAerodromeSBPV :> System {
		doc /* Main operating base at Porto Velho, Rondônia (RO); latitude 8°42'59.61"S; longitude 63°54'7.46"W; home base for 2°/3° GAV (Second Third Aviation Group) */
		attribute latitude : ScalarValues::String = "8°42'59.61\"S";
		attribute longitude : ScalarValues::String = "63°54'7.46\"W";
		attribute location : ScalarValues::String = "Porto Velho, Rondônia (RO)";
	}
	part def MultiRotorUASIllicit :> System {
		doc /* Multi-rotor illicit unmanned aerial system; type: multi-rotor; max dimensions 1 m × 1 m × 0.63 m (width × height × depth); fuselage material: carbon fiber; max endurance: 3 h; max payload capacity: 8 kg; ceiling: 6 km; max speed: 29 m/s; propulsion system: propeller; operating frequencies: 900 MHz to 5.8 GHz; navigation: indoor and outdoor; heat signature: small; Radar Cross Section (RCS): small */
		attribute type : ScalarValues::String = "multi-rotor";
		attribute maxDimensionWidth :> ISQ::length = 1 [m];
		attribute maxDimensionHeight :> ISQ::length = 1 [m];
		attribute maxDimensionDepth :> ISQ::length = 0.63 [m];
		attribute fuselageMaterial : ScalarValues::String = "carbon fiber";
		attribute maxEndurance :> ISQ::time = 3 [h];
		attribute maxPayloadCapacity :> ISQ::mass = 8 [kg];
		attribute ceiling :> ISQ::length = 6 [km];
		attribute maxSpeed :> ISQ::speed = 29 [m/s];
		attribute propulsionSystem : ScalarValues::String = "propeller";
		attribute operatingFrequenciesMin :> ISQ::frequency = 900000000.0 [Hz]; // converted from 900 MHz
		attribute operatingFrequenciesMax :> ISQ::frequency = 5800000000.0 [Hz]; // converted from 5800 MHz
		attribute navigation : ScalarValues::String = "indoor and outdoor";
		attribute heatSignature : ScalarValues::String = "small";
		attribute radarCrossSection : ScalarValues::String = "small";
		port threatPositionDataPort : ThreatEmissionPort;
	}
	part def FixedWingUASIllicit :> System {
		doc /* Fixed-wing illicit unmanned aerial system; type: fixed-wing; max dimensions 14 m × 1.7 m × 4 m (width × height × depth); fuselage material: carbon fiber; max endurance: 42 h; max payload capacity: 100 kg; ceiling: 18 km; max speed: 130 m/s; propulsion system: propeller; operating frequencies: 900 MHz to 5.8 GHz; navigation: indoor and outdoor; heat signature: very small; Radar Cross Section (RCS): small to medium */
		attribute type : ScalarValues::String = "fixed-wing";
		attribute maxDimensionWidth :> ISQ::length = 14 [m];
		attribute maxDimensionHeight :> ISQ::length = 1.7 [m];
		attribute maxDimensionDepth :> ISQ::length = 4 [m];
		attribute fuselageMaterial : ScalarValues::String = "carbon fiber";
		attribute maxEndurance :> ISQ::time = 42 [h];
		attribute maxPayloadCapacity :> ISQ::mass = 100 [kg];
		attribute ceiling :> ISQ::length = 18 [km];
		attribute maxSpeed :> ISQ::speed = 130 [m/s];
		attribute propulsionSystem : ScalarValues::String = "propeller";
		attribute operatingFrequenciesMin :> ISQ::frequency = 900000000.0 [Hz]; // converted from 900 MHz
		attribute operatingFrequenciesMax :> ISQ::frequency = 5800000000.0 [Hz]; // converted from 5800 MHz
		attribute navigation : ScalarValues::String = "indoor and outdoor";
		attribute heatSignature : ScalarValues::String = "very small";
		attribute radarCrossSection : ScalarValues::String = "small to medium";
		port threatPositionDataFixedWingPort : ThreatEmissionPort;
	}
}
