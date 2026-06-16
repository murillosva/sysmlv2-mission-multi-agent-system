package FunctionsPackage {

	private import MissionPhasesPackage::*;
	private import CoSMAPackage::*;
	private import ScalarValues::*;
	private import ModelingMetadata::*;
	private import MissionRequirementsPackage::*;

	// --- Domain Item Definitions ---
	item def MissionDirective { doc /* Command or authorization to initiate or modify mission operations, including activation orders and boundary definitions. */ }
	item def AircraftStatus { doc /* Represents the complete state of an aircraft, including position, heading, fuel level, sensor configuration, and weapon readiness. */ }
	item def TargetTrack { doc /* Continuous surveillance data for a detected target, including position, velocity, heading, and classification. */ }
	item def VectoringCommand { doc /* Instructions to guide an interceptor toward a target, transmitted via voice or datalink, containing heading or geographic coordinates. */ }
	item def SensorData { doc /* Information acquired by aircraft sensors (radar, EO/IR, visual), including detection events, tracking status, and target acquisition. */ }
	item def WeaponCommand { doc /* Authorization and parameters for weapon employment, including firing philosophy, engagement range, and guidance settings. */ }
	item def EngagementOutcome { doc /* Result of a weapon engagement, including hit/miss determination, neutralization confirmation, or evasion detection. */ }
	item def PerformanceMetric { doc /* Quantitative assessment of mission effectiveness, including neutralization rates, engagement times, tracking performance, and probability metrics. */ }
	item def GeographicReference { doc /* Spatial information defining operational areas, including CAP points, FARP locations, border sectors, and ZIDA boundaries. */ }
	item def ThreatEvent { doc /* Notification of an illicit incursion, including UAS class (multi-rotor or fixed-wing), entry point, heading, and velocity. */ }

	// ===================================================================
	//  Level 4: Leaf-Level Function Definitions
	//  NOTE: These functions refine the abstract Operations from OperationsPackage.
	// ===================================================================
	action def TransitFromMainBaseToFARP :> Function {
		in takeoffClearance : MissionDirective;
		in farpCoordinates : GeographicReference;
		in fuelLoad : AircraftStatus;
		out arrivalAtFARP : AircraftStatus;
		doc /* Navigate A-29 aircraft from Porto Velho Air Base (SBPV) to designated FARP point at cruise speed */
		#refinement dependency TransitFromMainBaseToFARP to OperationsPackage::DepartMainBase;
		#refinement dependency TransitFromMainBaseToFARP to OperationsPackage::TransitToFARP;
	}
	action def RepositionFromFARPToCAP :> Function {
		in departureClearance : MissionDirective;
		in capPointCoordinates : GeographicReference;
		out arrivalAtCAP : AircraftStatus;
		doc /* Navigate A-29 aircraft from FARP point to assigned CAP point at cruise speed */
		#refinement dependency RepositionFromFARPToCAP to OperationsPackage::RepositionToCAPPoint;
	}
	action def MaintainHoldingOrbitAtCAP :> Function {
		in capPointCoordinates : GeographicReference;
		in currentTime : MissionDirective;
		in synchronizationMilestone : MissionDirective;
		out aircraftOnStation : AircraftStatus;
		doc /* Execute holding pattern at CAP point until mission synchronization milestone (T+153 min) */
		#refinement dependency MaintainHoldingOrbitAtCAP to OperationsPackage::MaintainHoldingOrbit;
	}
	action def RefuelAtFARP :> Function {
		in arrivalAtFARP : AircraftStatus;
		in fuelRequirements : AircraftStatus;
		out refueledAircraft : AircraftStatus;
		doc /* Conduct refueling operations at FARP point to restore aircraft endurance for return leg */
		#refinement dependency RefuelAtFARP to OperationsPackage::RefuelAtFARP;
	}
	action def RecoverToMainBase :> Function {
		in departureClearance : MissionDirective;
		in baseCoordinates : GeographicReference;
		out arrivalAtBase : AircraftStatus;
		doc /* Navigate A-29 aircraft from FARP point to Porto Velho Air Base (SBPV) at cruise speed */
		#refinement dependency RecoverToMainBase to OperationsPackage::RecoverToMainBase;
	}
	action def DetectIllicitUASWithAirborneRadar :> Function {
		in uasPresenceInCoverage : ThreatEvent;
		in radarScanCycles : SensorData;
		out uasDetectionEvents : SensorData;
		out targetTracks : TargetTrack;
		doc /* Employ E-99M PS-890 Erieye S-band radar to detect illicit UAS incursions crossing Brazilian border into ZIDA airspace */
		#refinement dependency DetectIllicitUASWithAirborneRadar to OperationsPackage::DetectUASByE99M;
	}
	action def AssignInterceptorToUASTarget :> Function {
		in uasDetectionEvent : SensorData;
		in interceptorPositions : AircraftStatus;
		out targetNotification : VectoringCommand;
		doc /* Notify nearest A-29 on CAP of illicit UAS incursion and assign engagement exclusivity */
		#refinement dependency AssignInterceptorToUASTarget to OperationsPackage::NotifyInterceptorOfUASPresence;
	}
	action def TransmitVectoringInformationViaVoice :> Function {
		in uasTrackUpdates : TargetTrack;
		in a29Position : AircraftStatus;
		out uasHeadingInformation : VectoringCommand;
		doc /* Relay UAS heading information to baseline A-29 via VHF voice communication at update intervals [5, 60] seconds */
		#refinement dependency TransmitVectoringInformationViaVoice to OperationsPackage::VectorInterceptorViaVoice;
	}
	action def TransmitCueingCoordinatesViaDatalink :> Function {
		in uasTrackUpdates : TargetTrack;
		in a29nPosition : AircraftStatus;
		out geographicCoordinates : VectoringCommand;
		doc /* Transmit geographic coordinates (latitude, longitude) to A-29N via digital datalink at update intervals [1, 10] seconds */
		#refinement dependency TransmitCueingCoordinatesViaDatalink to OperationsPackage::TransmitCoordinatesViaDatalink;
	}
	action def InitiateAirspacePolicing :> Function {
		in synchronizationMilestone : MissionDirective;
		in aircraftOnStationStatus : AircraftStatus;
		out peaPostureActive : MissionDirective;
		doc /* Activate ALEVOO posture at T+153 min when all aircraft on station; commence surveillance for illicit UAS incursions */
		#refinement dependency InitiateAirspacePolicing to OperationsPackage::InitiateAirspacePolicing;
	}
	action def ModifyHeadingTowardUAS :> Function {
		in vectoringInformation : VectoringCommand;
		in currentHeading : AircraftStatus;
		out updatedHeading : AircraftStatus;
		doc /* Adjust A-29 flight heading based on vectoring information (voice heading for baseline; datalink coordinates for A-29N) to close distance toward illicit UAS */
		#refinement dependency ModifyHeadingTowardUAS to OperationsPackage::ModifyHeadingTowardUAS;
	}
	action def AcquireUASVisually :> Function {
		in uasPosition : TargetTrack;
		in aircraftHeading : AircraftStatus;
		out visualAcquisitionEvent : SensorData;
		doc /* Conduct naked-eye visual search by baseline A-29 pilot to acquire UAS within [0, 13] km range; subject to 12.5 s minimum acquisition and reaction time; penalized for multi-rotor dimension (1/14 modifier) */
		#refinement dependency AcquireUASVisually to OperationsPackage::PerformNakedEyeVisualSearch;
	}
	action def CueEOIRSensorToCoordinates :> Function {
		in coordinatesFromDatalink : VectoringCommand;
		in pilotInput : MissionDirective;
		out sensorCuedToSearchArea : SensorData;
		doc /* Manually enter received coordinates into A-29N system; cue EO/IR sensor to search area; coordinate reception sensitivity [1, 10] s */
		#refinement dependency CueEOIRSensorToCoordinates to OperationsPackage::CueEOIRSensorToCoordinates;
	}
	action def AcquireUASWithEOIRSensor :> Function {
		in cuedSearchArea : SensorData;
		in uasPosition : TargetTrack;
		out sensorAcquisitionEvent : SensorData;
		out rangefinderLock : SensorData;
		doc /* Scan for UAS using A-29N EO/IR sensor (FLIR Star SAFIRE II): 360° azimuth, +30° to -120° elevation, 60°/s slew rate; laser rangefinder max 20 km, accuracy 5 m; tracking probability penalized for multi-rotor (1 m dimension vs. 5 m accuracy) */
		#refinement dependency AcquireUASWithEOIRSensor to OperationsPackage::AcquireUASWithEOIRSensor;
	}
	action def MaintainVisualTrackingOfUAS :> Function {
		in visualAcquisition : SensorData;
		in headingUpdates : VectoringCommand;
		in distanceToUAS : TargetTrack;
		out visualTrackingStatus : SensorData;
		doc /* Maintain naked-eye visual contact with UAS by baseline A-29; tracking probability decreases linearly from 13 km to 0 km; multi-rotor penalty: 1/14; tracking verification interval: [5, 60] s per heading update */
		#refinement dependency MaintainVisualTrackingOfUAS to OperationsPackage::MaintainVisualContactWithUAS;
	}
	action def MaintainEOIRTrackingLock :> Function {
		in sensorAcquisition : SensorData;
		in coordinateUpdates : VectoringCommand;
		in distanceToUAS : TargetTrack;
		out eoirTrackingStatus : SensorData;
		doc /* Maintain continuous EO/IR tracking lock on UAS by A-29N; fixed-wing: negligible tracking loss; multi-rotor: intermittent losses recovered by datalink coordinate updates; tracking verification interval: [1, 10] s per coordinate update */
		#refinement dependency MaintainEOIRTrackingLock to OperationsPackage::MaintainEOIRTrackingLock;
	}
	action def EnterWeaponEmploymentEnvelope :> Function {
		in uasPosition : TargetTrack;
		in aircraftPosition : AircraftStatus;
		out withinWeaponRange : AircraftStatus;
		doc /* Close distance to UAS until within armament employment envelope: baseline: max 2 km (SBAT-70 unguided); A-29N: max 14 km (APKWS laser-guided) or min 2 km */
		#refinement dependency EnterWeaponEmploymentEnvelope to OperationsPackage::EnterWeaponEmploymentEnvelope;
	}
	action def DetermineFiringPhilosophy :> Function {
		in weaponEnvelope : AircraftStatus;
		out selectedFiringDistance : WeaponCommand;
		doc /* Randomly draw firing philosophy via discrete uniform distribution (1/3 probability each): long (max range), medium (midpoint), or short (min range) */
		#refinement dependency DetermineFiringPhilosophy to OperationsPackage::DetermineFirePhilosophy;
	}
	action def ExecuteSBAT70UnguiedRocket :> Function {
		in firingDistance : WeaponCommand;
		in uasPosition : TargetTrack;
		out rocketLaunched : WeaponCommand;
		out impactOutcome : EngagementOutcome;
		doc /* Fire single SBAT-70 unguided rocket by baseline A-29 at drawn firing distance; hit probability: linear from 80% at 0.5 km to 0% at 2 km; dimensional penalty for multi-rotor: 0.5 */
		#refinement dependency ExecuteSBAT70UnguiedRocket to OperationsPackage::ExecuteDeterrenceShot;
	}
	action def DesignateUASWithLaser :> Function {
		in eoirTrackingLock : SensorData;
		out laserDesignationActive : SensorData;
		doc /* Perform laser designation of UAS by A-29N EO/IR sensor for semi-active laser guidance of APKWS rocket */
		#refinement dependency DesignateUASWithLaser to OperationsPackage::LaserDesignateUAS;
	}
	action def ExecuteAPKWSLaserGuidedRocket :> Function {
		in firingDistance : WeaponCommand;
		in laserDesignationActive : SensorData;
		in uasPosition : TargetTrack;
		out rocketLaunched : WeaponCommand;
		out guidanceTracking : SensorData;
		out impactOutcome : EngagementOutcome;
		doc /* Fire single APKWS laser-guided rocket by A-29N at drawn firing distance (15.8 kg); hit probability: linear from 80% at 2 km to 0% at 14 km with guidance; dimensional penalty for multi-rotor: 0.5; platform speed: 80-550 KCAS; launch altitude: -200 to 25,000 ft */
		#refinement dependency ExecuteAPKWSLaserGuidedRocket to OperationsPackage::ExecuteAPKWSLaunch;
	}
	action def AssessEngagementOutcome :> Function {
		in rocketImpact : EngagementOutcome;
		in hitProbability : WeaponCommand;
		in dimensionalPenalty : WeaponCommand;
		out engagementOutcome : EngagementOutcome;
		doc /* Stochastically determine engagement outcome based on hit probability and dimensional penalty; outcomes: UAS neutralized (success) or engagement failure */
		#refinement dependency AssessEngagementOutcome to OperationsPackage::AssessNeutralization;
	}
	action def NeutralizeUAS :> Function {
		in successfulImpact : EngagementOutcome;
		out uasNeutralized : EngagementOutcome;
		out engagementTerminated : MissionDirective;
		doc /* Kinetically destroy illicit UAS before it crosses 80 nmi ZIDA boundary; terminate engagement */
		#refinement dependency NeutralizeUAS to OperationsPackage::NeutralizeUAS;
	}
	action def DetectUASEvasion :> Function {
		in uasPosition : TargetTrack;
		in zidaBoundary : GeographicReference;
		in engagementOutcome : EngagementOutcome;
		out uasEvaded : EngagementOutcome;
		out missionFailureEvent : EngagementOutcome;
		out engagementTerminated : MissionDirective;
		doc /* Identify UAS crossing 80 nmi ZIDA boundary into national territory without neutralization; classify as mission failure for that engagement; terminate engagement */
		#refinement dependency DetectUASEvasion to OperationsPackage::DetectUASEvasion;
	}
	action def ReturnToCAPAfterEngagement :> Function {
		in engagementTermination : MissionDirective;
		in capPointCoordinates : GeographicReference;
		out aircraftAtCAP : AircraftStatus;
		doc /* Navigate A-29 back to CAP point after neutralization or evasion to receive new UAS notification for next interception cycle */
		#refinement dependency ReturnToCAPAfterEngagement to OperationsPackage::ReturnToCAPPoint;
	}
	action def ContinueInterceptionCycles :> Function {
		in fuelStatus : AircraftStatus;
		in illicitIncursions : ThreatEvent;
		in capPosition : GeographicReference;
		out interceptionCyclesExecuted : EngagementOutcome;
		doc /* Repeat notification → interception → neutralization/evasion → CAP return cycle as long as flight endurance permits and illicit incursions continue */
		#refinement dependency ContinueInterceptionCycles to OperationsPackage::ContinueInterceptionCycles;
	}
	action def DepartCAPForFARP :> Function {
		in minimumFuelThreshold : AircraftStatus;
		in farpCoordinates : GeographicReference;
		out aircraftEnRouteToFARP : AircraftStatus;
		doc /* Reach minimum fuel threshold for return leg; terminate PEA posture; depart CAP point for FARP refueling */
		#refinement dependency DepartCAPForFARP to OperationsPackage::DepartCAPForFARP;
	}
	action def GenerateIllicitUASIncursion :> Function {
		in missionEpoch : MissionDirective;
		in borderPolygonSectors : GeographicReference;
		out uasIncursionEvent : ThreatEvent;
		out entryCoordinates : GeographicReference;
		out heading : TargetTrack;
		out uasClass : ThreatEvent;
		doc /* Randomly generate illicit UAS (multi-rotor or fixed-wing) via Monte Carlo simulation; entry point drawn from normal distribution over 23 sectors (28-50) of Amazon border polygon; heading perpendicular to border segment ± 45° variation */
		#refinement dependency GenerateIllicitUASIncursion to OperationsPackage::GenerateIllicitUASIncursion;
	}
	action def CrossBorderIntoZIDA :> Function {
		in entryPoint : GeographicReference;
		in heading : TargetTrack;
		in velocity : ThreatEvent;
		out uasPositionInZIDA : TargetTrack;
		out borderCrossedEvent : ThreatEvent;
		doc /* Illicit UAS crosses Brazilian border into continental ZIDA airspace; flight at sea level; velocity per UAS class (multi-rotor: max 29 m/s; fixed-wing: max 130 m/s) */
		#refinement dependency CrossBorderIntoZIDA to OperationsPackage::CrossBorderIntoZIDA;
	}
	action def CalculateNeutralizationRate :> Function {
		in numberOfUASNeutralized : EngagementOutcome;
		in totalIncursions : ThreatEvent;
		out neutralizationRate : PerformanceMetric;
		doc /* Compute percentage of illicit UAS incursions neutralized before crossing 80 nmi ZIDA boundary per configuration (baseline vs. A-29N) */
	}
	action def CalculateEvasionReductionRate :> Function {
		in baselineEvasionRate : PerformanceMetric;
		in a29nEvasionRate : PerformanceMetric;
		out evasionReductionRate : PerformanceMetric;
		doc /* Compute illicit evasion reduction rate afforded by modernized configuration compared to baseline */
	}
	action def CalculateMeanEngagementCompletionTime :> Function {
		in engagementTimes : PerformanceMetric;
		in neutralizationTimes : PerformanceMetric;
		in evasionTimes : PerformanceMetric;
		in evasionPenaltyFactor : PerformanceMetric;
		out engagementTimeRate : PerformanceMetric;
		doc /* Compute mean engagement completion time rate from notification to neutralization; apply maximum penalty for evasions */
	}
	action def CalculateActiveTrackingTimeRate :> Function {
		in trackingStatusPerTimeStep : SensorData;
		in headingUpdateIntervals : VectoringCommand;
		in trackingProbabilities : SensorData;
		out trackingRate : PerformanceMetric;
		doc /* Compute proportion of time interceptor maintained tracking on UAS until weapon employment range; baseline: visual tracking; A-29N: EO/IR sensor tracking */
	}
	action def CalculateNeutralizationProbabilityPerApproach :> Function {
		in firingDistance : WeaponCommand;
		in firingPhilosophy : WeaponCommand;
		in hitProbability : WeaponCommand;
		in dimensionalPenalty : WeaponCommand;
		out neutralizationProbability : PerformanceMetric;
		doc /* Compute lethal outcome probability of Deterrence Shot execution based on firing distance, firing philosophy, and dimensional penalty */
	}

	// ===================================================================
	//  Level 1-3: Orchestrating Functions (compose Leaf-Level Functions)
	// ===================================================================
	action def PerformContinentalZIDAShield :> Function {
		in missionActivation : MissionDirective;
		in zidaBoundary : GeographicReference;
		in threatIntelligence : ThreatEvent;
		out missionCompletionStatus : PerformanceMetric;
		out neutralizationOutcomes : EngagementOutcome;
		out assessmentReports : PerformanceMetric;
		doc /* Execute comprehensive airspace policing mission to detect, track, and neutralize illicit UAS incursions within continental ZIDA through integrated air defense, airborne control, and forward operations */
		action manageForwardOperations : ManageForwardOperations;
		action provideAirborneControlAndEarlyWarning : ProvideAirborneControlAndEarlyWarning;
		action executeAirspacePolicing : ExecuteAirspacePolicing;
		action assessAndReportMissionEffectiveness : AssessAndReportMissionEffectiveness;
	}
	action def ManageForwardOperations :> Function {
		in missionActivation : MissionDirective;
		in farpLocations : GeographicReference;
		in aircraftEndurance : AircraftStatus;
		out aircraftAtCAP : AircraftStatus;
		out refuelingStatus : AircraftStatus;
		doc /* Orchestrate logistics and positioning of interceptor assets through FARP infrastructure to maximize time on station in Areas of Interest */
		action transitFromMainBaseToFARP : TransitFromMainBaseToFARP;
		action repositionFromFARPToCAP : RepositionFromFARPToCAP;
		action maintainHoldingOrbitAtCAP : MaintainHoldingOrbitAtCAP;
		action refuelAtFARP : RefuelAtFARP;
		action recoverToMainBase : RecoverToMainBase;
	}
	action def ProvideAirborneControlAndEarlyWarning :> Function {
		in illicitUASPresence : ThreatEvent;
		in groundRadarData : TargetTrack;
		in interceptorPositions : AircraftStatus;
		out targetTracks : TargetTrack;
		out vectoringCommands : VectoringCommand;
		out cueingData : VectoringCommand;
		doc /* Detect, track, and provide vectoring support to interceptors through airborne radar surveillance and real-time coordination */
		action detectIllicitUASWithAirborneRadar : DetectIllicitUASWithAirborneRadar;
		action assignInterceptorToUASTarget : AssignInterceptorToUASTarget;
		action transmitVectoringInformationViaVoice : TransmitVectoringInformationViaVoice;
		action transmitCueingCoordinatesViaDatalink : TransmitCueingCoordinatesViaDatalink;
	}
	action def ExecuteAirspacePolicing :> Function {
		in targetNotifications : VectoringCommand;
		in aircraftFuelStatus : AircraftStatus;
		in zidaBoundary : GeographicReference;
		out neutralizedUAS : EngagementOutcome;
		out evasionReports : EngagementOutcome;
		out engagementOutcomes : EngagementOutcome;
		doc /* Conduct continuous surveillance at CAP points and perform intercept-engagement cycles against illicit UAS to neutralize threats within ZIDA boundary */
		action initiateAirspacePolicing : InitiateAirspacePolicing;
		action modifyHeadingTowardUAS : ModifyHeadingTowardUAS;
		action acquireUASVisually : AcquireUASVisually;
		action cueEOIRSensorToCoordinates : CueEOIRSensorToCoordinates;
		action acquireUASWithEOIRSensor : AcquireUASWithEOIRSensor;
		action maintainVisualTrackingOfUAS : MaintainVisualTrackingOfUAS;
		action maintainEOIRTrackingLock : MaintainEOIRTrackingLock;
		action enterWeaponEmploymentEnvelope : EnterWeaponEmploymentEnvelope;
		action determineFiringPhilosophy : DetermineFiringPhilosophy;
		action executeSBAT70UnguiedRocket : ExecuteSBAT70UnguiedRocket;
		action designateUASWithLaser : DesignateUASWithLaser;
		action executeAPKWSLaserGuidedRocket : ExecuteAPKWSLaserGuidedRocket;
		action assessEngagementOutcome : AssessEngagementOutcome;
		action neutralizeUAS : NeutralizeUAS;
		action detectUASEvasion : DetectUASEvasion;
		action returnToCAPAfterEngagement : ReturnToCAPAfterEngagement;
		action continueInterceptionCycles : ContinueInterceptionCycles;
		action departCAPForFARP : DepartCAPForFARP;
	}
	action def AssessAndReportMissionEffectiveness :> Function {
		in engagementOutcomes : EngagementOutcome;
		in neutralizationData : EngagementOutcome;
		in evasionEvents : EngagementOutcome;
		out missionSuccessMetrics : PerformanceMetric;
		out effectivenessReports : PerformanceMetric;
		out capabilityRecommendations : PerformanceMetric;
		doc /* Evaluate mission outcomes, measure protection effectiveness, and generate assessment reports for decision-makers */
		action calculateNeutralizationRate : CalculateNeutralizationRate;
		action calculateEvasionReductionRate : CalculateEvasionReductionRate;
		action calculateMeanEngagementCompletionTime : CalculateMeanEngagementCompletionTime;
		action calculateActiveTrackingTimeRate : CalculateActiveTrackingTimeRate;
		action calculateNeutralizationProbabilityPerApproach : CalculateNeutralizationProbabilityPerApproach;
	}
}
