package TechnicalComponentsPackage {

	private import CoSMAPackage::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import ShapeItems::*;
	private import SI::*;
	private import ISQ::*;
	private import LogicalComponentsPackage::*;
	private import TechnicalPortsPackage::*;

	part def A29SuperTucanoAirframeBaseline :> System {
		doc /* Multi-mission turboprop, unpaved runway capable, 6 aircraft instances (A-29-1 to A-29-6) */
		attribute aircraftType : ScalarValues::String = "Multi-mission turboprop";
		attribute runwayCapability : ScalarValues::String = "Unpaved runway capable";
		attribute numberOfInstances : ScalarValues::Integer = 6;
		port farpRefuelingRequestPort : LogisticsPort;
	}

	part def PrattWhitneyPT6A62TurbopropEngine :> System {
		doc /* Single turboprop engine for A-29 Super Tucano */
		attribute engineType : ScalarValues::String = "Single turboprop";
		attribute shaftHorsepower :> ISQ::power = 1417 [kW]; // converted from 1900 SHP
		attribute cruisePowerSpeed :> ISQ::speed = 162 [m/s]; // converted from 315 KCAS
	}

	part def IntegratedFuelSystemBaseline :> System {
		doc /* 3 external fuel tanks with refueling capability at FARP */
		attribute externalFuelTanks : ScalarValues::Integer = 3;
		attribute maximumEndurance :> ISQ::time = 5.2 [h];
		attribute refuelingLocation : ScalarValues::String = "FARP";
	}

	part def VHFRadioCommunicationSuite :> System {
		doc /* VHF voice-only communication system for baseline A-29 */
		attribute communicationType : ScalarValues::String = "VHF voice-only";
		attribute vectoringUpdateIntervalMin :> ISQ::time = 5 [s];
		attribute vectoringUpdateIntervalMax :> ISQ::time = 60 [s];
		port vhfVoiceTxRxPort : VoiceCommPort;
	}

	part def PilotVisualAcquisitionSystemNakedEye :> System {
		doc /* Human vision capability for target acquisition */
		attribute maximumAcquisitionDistance :> ISQ::length = 13 [km];
		attribute visualAcuity :> ISQ::planeAngle = 1.0 ['arcmin'];
		attribute acquisitionReactionTime :> ISQ::time = 12.5 [s];
		attribute smallTargetContrastPenalty : ScalarValues::Real = 0.071; // 1/14 as ratio
		port headingVectorReceptionPort : TargetCueingPort;
	}

	part def SBAT70UnguidedRocketPodBaseline :> System {
		doc /* Air-to-ground ballistic system, 70 mm diameter, solid propellant, unguided */
		attribute caliber :> ISQ::length = 70 [mm];
		attribute propellantType : ScalarValues::String = "Solid propellant";
		attribute guidanceType : ScalarValues::String = "Unguided ballistic";
		attribute maximumRange :> ISQ::length = 2 [km];
		attribute minimumRange :> ISQ::length = 0.5 [km];
		attribute hitProbabilityAtMinRange : ScalarValues::Real = 0.80;
	}

	part def WingMounted50CaliberMachineGuns :> System {
		doc /* Organic armament for suppressive fire; not primary C-UAS weapon in this scenario */
		attribute caliber :> ISQ::length = 12.7 [mm]; // converted from 0.50 inches
		attribute purpose : ScalarValues::String = "Suppressive fire; not primary C-UAS weapon";
	}

	part def A29SuperTucanoAirframeModernizedA29N :> System {
		doc /* Same airframe as baseline; equipped with C-UAS avionics, datalink, EO/IR sensor, and laser-guided armament integration */
		attribute aircraftType : ScalarValues::String = "Multi-mission turboprop (A-29N variant)";
		attribute cuasAvionics : ScalarValues::String = "Equipped";
		attribute numberOfInstances : ScalarValues::Integer = 6;
		attribute datalinkIntegration : ScalarValues::String = "Rohde & Schwarz SECOS compatible";
		port farpRefuelingRequestModernizedPort : LogisticsPort;
	}

	part def IntegratedFuelSystemA29N :> System {
		doc /* Same as baseline: 3 external fuel tanks with endurance of 5.2 hours */
		attribute externalFuelTanks : ScalarValues::Integer = 3;
		attribute maximumEndurance :> ISQ::time = 5.2 [h];
	}

	part def RohdeSchwarzRSM3ARDatalinkSuiteMR6000RL :> System {
		doc /* Digital datalink for coordinate reception and command transmission */
		attribute frequencyRangeMin :> ISQ::frequency = 30.0E6 [Hz]; // 30E6 Hz
		attribute frequencyRangeMax :> ISQ::frequency = 400.0E6 [Hz]; // 400E6 Hz
		attribute frequencyBand : ScalarValues::String = "V/UHF";
		attribute controlInterfaceStandards : ScalarValues::String = "MIL-STD-1553B / RS-485";
		attribute dataCapability :> ISQ::frequency = 16000 [Hz]; // converted from 16 kbit/s
		attribute networkType : ScalarValues::String = "SECOS voice/data with TDMA";
		attribute tdmaParticipants : ScalarValues::Integer = 128;
		attribute coordinateReceptionUpdateIntervalMin :> ISQ::time = 1 [s];
		attribute coordinateReceptionUpdateIntervalMax :> ISQ::time = 10 [s];
		attribute pilotManualEntryTimeMin :> ISQ::time = 1 [s];
		attribute pilotManualEntryTimeMax :> ISQ::time = 10 [s];
		port datalinkTxRxPort : DatalinkPort;
	}

	part def FLIRStarSAFIREIIEOIRSensorWithLaserRangefinderDesignator :> System {
		doc /* Electro-optical/infrared sensor with integrated laser rangefinder and designator capability */
		attribute sensorType : ScalarValues::String = "Electro-optical/infrared (EO/IR)";
		attribute laserRangefinderMaximumRange :> ISQ::length = 20 [km];
		attribute rangeAccuracy :> ISQ::length = 5 [m];
		attribute azimuthCoverage :> ISQ::planeAngle = 360 ['°'];
		attribute azimuthCoverageMode : ScalarValues::String = "Continuous";
		attribute elevationCoverageMin :> ISQ::planeAngle = -120 ['°'];
		attribute elevationCoverageMax :> ISQ::planeAngle = 30 ['°'];
		attribute slewRate : ScalarValues::Real = 60 [rad/s]; // converted from 60 deg/s
		attribute controlInterface : ScalarValues::String = "SCU/serial digital/MIL-STD-1553B/ARINC";
		attribute maximumOperationalSpeed :> ISQ::speed = 209 [m/s]; // converted from 405 KCAS
		port coordinateReceptionPort : TargetCueingPort;
		port eoirSensorOutputPort : SensorDataPort;
		port laserDesignatorTxPort : WeaponCueingPort;
	}

	part def AdvancedPrecisionKillWeaponSystemAPKWSLaserGuidedKit :> System {
		doc /* Laser guidance kit for SBAT-70 rockets with semi-active laser guidance */
		attribute guidanceType : ScalarValues::String = "Semi-active laser";
		attribute minimumRange :> ISQ::length = 2 [km];
		attribute maximumRange :> ISQ::length = 14 [km];
		attribute hitProbabilityAtMinimumRange : ScalarValues::Real = 0.80;
		attribute platformSpeedCapabilityMin :> ISQ::speed = 41 [m/s]; // converted from 80 KCAS
		attribute platformSpeedCapabilityMax :> ISQ::speed = 283 [m/s]; // converted from 550 KCAS
		attribute launchAltitudeRangeMin :> ISQ::length = -61 [m]; // converted from -200 feet
		attribute launchAltitudeRangeMax :> ISQ::length = 7620 [m]; // converted from 25,000 feet
		attribute weightPerKit :> ISQ::mass = 15.8 [kg];
		port rocketPodInterfacePort : WeaponFiringPort;
	}

	part def SBAT70RocketWithAPKWSIntegrationA29N :> System {
		doc /* SBAT-70 unguided rocket adapted with APKWS laser guidance kit for A-29N */
		attribute baseMunition : ScalarValues::String = "SBAT-70 unguided rocket";
		attribute guidanceKitIntegration : ScalarValues::String = "APKWS laser-guided kit";
		attribute maximumRangeGuided :> ISQ::length = 14 [km];
		attribute maximumRangeUnguided :> ISQ::length = 0.5 [km];
		attribute hitProbabilityAtMinRangeGuided : ScalarValues::Real = 0.80;
		attribute multiRotorDimensionalPenalty : ScalarValues::Real = 0.5;
	}

	part def EMB145AEWCAirframeE99M :> System {
		doc /* Airborne control and early warning platform for Continental ZIDA Shield operation */
		attribute platformType : ScalarValues::String = "Airborne Early Warning & Control (AEW&C)";
		attribute cruiseSpeed :> ISQ::speed = 232 [m/s]; // converted from 450 KCAS
		attribute serviceCeiling :> ISQ::length = 11278 [m]; // converted from 37,000 feet
		attribute rateOfClimbSeaLevel :> ISQ::speed = 13.0 [m/s]; // converted from 2,560 feet/minute
		attribute range :> ISQ::length = 2463 [km]; // converted from 1,330 nautical miles
		attribute maximumEndurance :> ISQ::time = 8 [h];
	}

	part def PS890ErieyeSBandAEWRadar :> System {
		doc /* Primary sensor for E-99M; S-band operation with continuous surveillance capability */
		attribute sensorType : ScalarValues::String = "S-band AEW radar";
		attribute frequencyBand : ScalarValues::String = "S-band";
		attribute reportedDetectionRange : ScalarValues::String = "Hundreds of kilometers";
		attribute availabilityAssumption : ScalarValues::String = "Continuous presence assumption for scenario coverage (idealized in simulation)";
		port radarTrackUplinkPort : RadarDataPort;
	}

	part def E99MCommandControlC2Infrastructure :> System {
		doc /* Operates as extension of DECEA/CINDACTA IV ground control for vectoring functions */
		attribute c2FunctionType : ScalarValues::String = "Airborne command and control";
		attribute groundLink : ScalarValues::String = "DECEA/CINDACTA IV extension";
		attribute vectoringModeBaseline : ScalarValues::String = "Heading-based via voice";
		attribute vectoringModeA29N : ScalarValues::String = "Geographic coordinates via datalink";
		attribute operationalAssumption : ScalarValues::String = "Ideal scenario (no CAV failures, no CAV operational gaps)";
	}

	part def E99MVectoringCommunicationsBaselineConfiguration :> System {
		doc /* Voice communication link from E-99M to A-29 baseline with heading vector updates */
		attribute communicationType : ScalarValues::String = "Voice radio link";
		attribute communicationMedium : ScalarValues::String = "VHF";
		attribute updateIntervalMin :> ISQ::time = 5 [s];
		attribute updateIntervalMax :> ISQ::time = 60 [s];
		attribute dataContent : ScalarValues::String = "Azimuth bearing to detected UAS";
		port targetNotificationVoicePort : TargetCueingPort;
	}

	part def E99MDatalinkCommunicationsA29NConfiguration :> System {
		doc /* Digital datalink from E-99M to A-29N with geographic coordinate updates */
		attribute communicationType : ScalarValues::String = "Digital datalink";
		attribute datalinkStandard : ScalarValues::String = "Rohde & Schwarz SECOS compatible";
		attribute updateIntervalMin :> ISQ::time = 1 [s];
		attribute updateIntervalMax :> ISQ::time = 10 [s];
		attribute dataContent : ScalarValues::String = "Latitude/longitude of detected UAS";
		port targetNotificationDatalinkPort : TargetCueingPort;
	}

	part def DECEAGroundRadarNetwork :> System {
		doc /* Ground-based radar systems providing continuous surveillance of continental ZIDA */
		attribute systemType : ScalarValues::String = "Ground-based radar network";
		attribute coverage : ScalarValues::String = "Continental ZIDA";
		attribute function : ScalarValues::String = "UAS detection and track data provision";
		attribute surveillanceType : ScalarValues::String = "Continuous";
	}

	part def CINDACTAIVRegionalControlCenter :> System {
		doc /* Fourth Integrated Air Defense and Air Traffic Control Center for Northern region; produces UAS identifications and controls alert assets */
		attribute systemType : ScalarValues::String = "Integrated Air Defense and Air Traffic Control Center";
		attribute centerDesignation : ScalarValues::String = "CINDACTA IV";
		attribute regionalCoverage : ScalarValues::String = "Northern region";
		attribute primaryFunctions : ScalarValues::String = "Airspace control, management, and air defense services";
		attribute targetProduction : ScalarValues::String = "UAS identifications via continuous surveillance";
		attribute alertAssetControl : ScalarValues::String = "Controls alert assets during flight";
		attribute airDefensePosture : ScalarValues::String = "Permanent";
		port radarTrackDownlinkPort : RadarDataPort;
	}

	part def CINDACTAIVToE99MInterface :> System {
		doc /* Supplies airspace surveillance data, radar track coordinates, and detected UAS position/velocity to E-99M for relay to interceptors */
		attribute interfaceType : ScalarValues::String = "Data link interface";
		attribute dataSupplied : ScalarValues::String = "Airspace surveillance data, radar track coordinates, UAS position/velocity";
		attribute direction : ScalarValues::String = "CINDACTA IV to E-99M";
	}

	part def CINDACTAIVTargetNotificationProtocol :> System {
		doc /* Issues simultaneous authorization to commence Airspace Policing and coordinates target notifications */
		attribute protocolType : ScalarValues::String = "Command and authorization protocol";
		attribute authorizationTiming : ScalarValues::String = "T+153 min (simultaneous to all six A-29)";
		attribute triggerEvent : ScalarValues::String = "Arrival of last aircraft at CAP point";
		attribute function : ScalarValues::String = "Commence Airspace Policing (PEA) phase";
		port airspaceClearancePort : CommandPort;
		port recoveryVectorPort : TargetCueingPort;
	}

	part def FARPNetworkInfrastructureFourSites :> System {
		doc /* Four strategically positioned aerodromes for aircraft refueling and rearming */
		attribute numberOfFARPs : ScalarValues::Integer = 4;
		attribute optimizationMethod : ScalarValues::String = "Combinatorial optimization (Szvaticsek et al., 2025)";
		attribute farp1Designation : ScalarValues::String = "SBRB";
		attribute farp1Coordinates : ScalarValues::String = "9°52'12.82\"S, 67°53'44.23\"O";
		attribute farp1RunwayLength :> ISQ::length = 2158 [m];
		attribute farp2Designation : ScalarValues::String = "SBCZ";
		attribute farp2Coordinates : ScalarValues::String = "7°35'59.86\"S, 72°46'23.12\"O";
		attribute farp2RunwayLength :> ISQ::length = 2400 [m];
		attribute farp3Designation : ScalarValues::String = "SDCG";
		attribute farp3Coordinates : ScalarValues::String = "3°28'9.00\"S, 68°55'16.00\"O";
		attribute farp3RunwayLength :> ISQ::length = 1200 [m];
		attribute farp4Designation : ScalarValues::String = "SWKU";
		attribute farp4Coordinates : ScalarValues::String = "1°7'11.98\"N, 66°50'29.59\"O";
		attribute farp4RunwayLength :> ISQ::length = 1200 [m];
	}

	part def FuelServicingEquipmentFARP :> System {
		doc /* Equipment for refueling A-29 aircraft at forward locations */
		attribute equipmentType : ScalarValues::String = "Fuel servicing equipment";
		attribute fuelTankConfiguration : ScalarValues::String = "External tank refueling";
		attribute tankFillCount : ScalarValues::Integer = 2;
		attribute enduranceTarget :> ISQ::time = 5.2 [h];
	}

	part def OrdnanceLoadingEquipmentFARPBaseline :> System {
		doc /* Equipment for loading SBAT-70 unguided rockets at FARP */
		attribute equipmentType : ScalarValues::String = "Ordnance loading system";
		attribute munitionType : ScalarValues::String = "SBAT-70 unguided rocket";
		attribute loadConfiguration : ScalarValues::String = "Rocket pod loading";
		attribute function : ScalarValues::String = "Ordnance load-out per sortie";
	}

	part def OrdnanceLoadingEquipmentFARPA29N :> System {
		doc /* Equipment for loading SBAT-70 + APKWS laser-guided kit at FARP */
		attribute equipmentType : ScalarValues::String = "Integrated ordnance loading system";
		attribute munitionType : ScalarValues::String = "SBAT-70 + APKWS laser-guided kit";
		attribute loadConfiguration : ScalarValues::String = "Rocket pod with APKWS integration";
		attribute setupFunction : ScalarValues::String = "Integrated guidance subsystem setup";
		attribute loadCycle : ScalarValues::String = "Ordnance load-out per sortie";
	}

	part def MultiRotorUASIllicitArchetype :> System {
		doc /* Threat entity representing typical multi-rotor UAS used for narcotrafficking support operations */
		attribute fuselageMaterial : ScalarValues::String = "Carbon fiber";
		attribute maximumDimensionsLength :> ISQ::length = 1 [m];
		attribute maximumDimensionsWidth :> ISQ::length = 1 [m];
		attribute maximumDimensionsHeight :> ISQ::length = 0.63 [m];
		attribute maximumEndurance :> ISQ::time = 3 [h];
		attribute maximumPayload :> ISQ::mass = 8 [kg];
		attribute serviceCeiling :> ISQ::length = 6 [km];
		attribute maximumSpeed :> ISQ::speed = 29 [m/s];
		attribute propulsionType : ScalarValues::String = "Propeller-driven";
		attribute operatingFrequencyMin :> ISQ::frequency = 900000000 [Hz]; // 900 MHz
		attribute operatingFrequencyMax :> ISQ::frequency = 5.80E+09 [Hz]; // 5.8 GHz
		attribute thermalSignature : ScalarValues::String = "Small heat signature";
		attribute radarCrossSection : ScalarValues::String = "Small RCS";
		attribute primaryEmployment : ScalarValues::String = "Aerial surveying and small-payload logistical support to narcotrafficking";
	}

	part def FixedWingUASIllicitArchetype :> System {
		doc /* Threat entity representing larger fixed-wing UAS used for narcotrafficking long-range cargo operations */
		attribute fuselageMaterial : ScalarValues::String = "Carbon fiber";
		attribute maximumDimensionsLength :> ISQ::length = 14 [m];
		attribute maximumDimensionsWidth :> ISQ::length = 1.7 [m];
		attribute maximumDimensionsHeight :> ISQ::length = 4 [m];
		attribute maximumEndurance :> ISQ::time = 42 [h];
		attribute maximumPayload :> ISQ::mass = 100 [kg];
		attribute serviceCeiling :> ISQ::length = 18 [km];
		attribute maximumSpeed :> ISQ::speed = 130 [m/s];
		attribute propulsionType : ScalarValues::String = "Propeller-driven";
		attribute operatingFrequencyMin :> ISQ::frequency = 900000000 [Hz]; // 900 MHz
		attribute operatingFrequencyMax :> ISQ::frequency = 5.80E+09 [Hz]; // 5.8 GHz
		attribute thermalSignature : ScalarValues::String = "Very small heat signature";
		attribute radarCrossSection : ScalarValues::String = "Small-to-medium RCS";
		attribute primaryEmployment : ScalarValues::String = "Longer-range operations and cargo transport";
	}

}
