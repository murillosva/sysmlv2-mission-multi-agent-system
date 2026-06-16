package FunctionsPackage {

	private import MissionPhasesPackage::*;
	private import CoSMAPackage::*;
	private import ScalarValues::*;
	private import ModelingMetadata::*;
	private import MissionRequirementsPackage::*;

	// --- Domain Item Definitions ---
	item def AircraftStatus { doc /* Represents the operational state of an interceptor aircraft, including position, altitude, fuel quantity, ordnance configuration, and readiness posture. */ }
	item def TargetTrack { doc /* Represents a detected and classified air target, including geographic position, heading, velocity, altitude, radar cross-section, and threat archetype. */ }
	item def TargetCueing { doc /* Represents targeting information transmitted to interceptor aircraft, including heading vector or geographic coordinates with transmission interval and datalink status. */ }
	item def InterceptionGeometry { doc /* Represents the spatial relationship between interceptor aircraft and target during pursuit, including distance, relative bearing, relative velocity, and weapon employment envelope status. */ }
	item def EngagementOutcome { doc /* Represents the result of a weapons engagement attempt, including neutralization status, evasion determination, tracking loss indication, and timestamp. */ }
	item def MissionMetrics { doc /* Represents aggregated mission performance data, including neutralization counts, evasion counts, and quantified measures of success and effectiveness. */ }
	item def SurveillanceAuthorization { doc /* Represents command authorization signals from CINDACTA IV to transition interceptor aircraft from holding posture to active airspace policing. */ }
	item def LogisticsConfiguration { doc /* Represents aircraft deployment parameters, including FARP assignment, CAP point coordinates, fuel load, ordnance type, and cruise profile. */ }

	// ===================================================================
	//  Level 4: Leaf-Level Function Definitions
	//  NOTE: These functions refine the abstract Operations from OperationsPackage.
	// ===================================================================
	action def DepartMainOperatingBase :> Function {
		in takeoffAuthorization : SurveillanceAuthorization;
		out aircraftDeparted : AircraftStatus;
		doc /* Execute aircraft engine start, pre-flight checks, air traffic clearance, runway taxi, takeoff roll, and climb-out profile from SBPV toward designated FARP point. */
		#refinement dependency DepartMainOperatingBase to OperationsPackage::ExecuteAircraftTakeoffSequenceFromSBPV;
	}
	action def ConductDirectRouteTransitToFARP :> Function {
		in aircraftDepartureCruiseConfiguration : AircraftStatus;
		in farpAssignment : LogisticsConfiguration;
		out aircraftArrivalAtFARP : AircraftStatus;
		doc /* Maintain cruise flight at 280 KCAS along shortest-path routing from SBPV to assigned FARP point; monitor fuel burn, maintain radio contact, establish navigation checkpoints. */
		#refinement dependency ConductDirectRouteTransitToFARP to OperationsPackage::ConductDirectRouteTransitToFARP;
	}
	action def ExecuteRefuelingAndRearmingAtFARP :> Function {
		in aircraftFARPArrival : AircraftStatus;
		out aircraftFueled : AircraftStatus;
		doc /* Conduct fuel servicing with external tank configuration; load ordnance (SBAT-70 unguided or APKWS laser-guided kit per configuration); perform post-service preflight inspections. */
		#refinement dependency ExecuteRefuelingAndRearmingAtFARP to OperationsPackage::ConductRefuelingAndRearmingOperationsAtFARP;
	}
	action def RepositionFromFARPToCAP :> Function {
		in aircraftReadyFuelOrdnance : AircraftStatus;
		in capPointCoordinates : LogisticsConfiguration;
		out aircraftArrivalAtCAP : AircraftStatus;
		doc /* Depart FARP with full fuel and ordnance; maintain cruise speed and direct routing to assigned CAP point; establish climb-out profile to patrol altitude; coordinate airspace entry with E-99M and CINDACTA IV. */
		#refinement dependency RepositionFromFARPToCAP to OperationsPackage::RepositionFromFARPToAssignedCAPPoint;
	}
	action def MaintainHoldingOrbitAtCAP :> Function {
		in aircraftCAPPosition : AircraftStatus;
		out aircraftHoldingReadiness : AircraftStatus;
		doc /* Hold racetrack pattern at CAP point; monitor surveillance picture and communications for target notifications; maintain high readiness (ALEVOO posture); perform fuel conservation maneuvers; await simultaneous Airspace Policing authorization. */
		#refinement dependency MaintainHoldingOrbitAtCAP to OperationsPackage::MaintainHoldingOrbitAtCAPPoint;
	}
	action def ReturnToFARPAndMainBase :> Function {
		in aircraftEnduranceExhausted : AircraftStatus;
		out aircraftRecovered : AircraftStatus;
		doc /* Depart CAP point when fuel endurance exhausted; navigate return route to FARP point; land safely with minimum fuel reserve; proceed to SBPV and conduct recovery procedures. */
		#refinement dependency ReturnToFARPAndMainBase to OperationsPackage::ConductDirectRouteTransitFromCAPPointToFARP;
		#refinement dependency ReturnToFARPAndMainBase to OperationsPackage::ConductLandingAndRecoveryAtFARP;
	}
	action def ConductGroundBasedRadarSurveillance :> Function {
		in surveillanceAuthorization : SurveillanceAuthorization;
		out groundRadarTrack : TargetTrack;
		doc /* Operate DECEA ground radar systems to continuously scan Areas of Interest within continental ZIDA; detect non-cooperative air targets crossing border; establish radar tracks with geographic position, heading, and velocity parameters. */
		#refinement dependency ConductGroundBasedRadarSurveillance to OperationsPackage::DetectIllicitUASIncursion;
	}
	action def ConductAirborneRadarDetection :> Function {
		in airborneRadarAuthorization : SurveillanceAuthorization;
		out airborneRadarTrack : TargetTrack;
		doc /* Operate E-99M Erieye S-band AEW radar to detect low-altitude UAS incursions; fill radar coverage gaps from ground systems; establish robust radar track with stochastic entry coordinates and headings; provide continuous surveillance picture. */
		#refinement dependency ConductAirborneRadarDetection to OperationsPackage::DetectIllicitUASIncursion;
	}
	action def ClassifyDetectedTargetAsIllicitUAS :> Function {
		in rawRadarTrack : TargetTrack;
		out classifiedUASTrack : TargetTrack;
		doc /* Process radar track data to confirm non-cooperative status; determine UAS archetype (multi-rotor vs. fixed-wing) based on kinematic profile (speed, altitude, RCS); establish threat classification for tactical action. */
		#refinement dependency ClassifyDetectedTargetAsIllicitUAS to OperationsPackage::DetectIllicitUASIncursion;
	}
	action def GenerateSimultaneousAirspacePolicingAuthorization :> Function {
		in missionTimerThreshold : SurveillanceAuthorization;
		out policingAuthorizationBroadcast : SurveillanceAuthorization;
		doc /* At T+153 min mission milestone, CINDACTA IV issues concurrent authorization to all six A-29 aircraft to transition from holding orbit to active Airspace Policing posture; E-99M radar and DECEA begin continuous scanning of six Areas of Interest. */
		#refinement dependency GenerateSimultaneousAirspacePolicingAuthorization to OperationsPackage::InitiateSimultaneousAirspacePolicing;
	}
	action def TransmitTargetNotificationToInterceptor :> Function {
		in classifiedUASTarget : TargetTrack;
		out targetNotificationMessage : TargetCueing;
		doc /* Upon UAS detection by E-99M/DECEA, CINDACTA IV routes target cueing data to A-29 assigned to geographic area containing incursion; transmission differs by configuration: baseline receives heading vector via VHF voice [5, 60] s interval; A-29N receives geographic coordinate via datalink [1, 10] s interval. */
		#refinement dependency TransmitTargetNotificationToInterceptor to OperationsPackage::TransmitTargetNotificationToCAP;
	}
	action def AcceptTargetAssignmentAndConfirmEngagementReadinessBaseline :> Function {
		in headingVectorCueing : TargetCueing;
		out aircraftHeadingModified : AircraftStatus;
		doc /* A-29 baseline pilot receives heading vector from E-99M via radio; acknowledges target assignment and engagement clearance (TDE authorization); modifies aircraft heading toward provided vector; initiates climb to patrol altitude for visual search. */
		#refinement dependency AcceptTargetAssignmentAndConfirmEngagementReadinessBaseline to OperationsPackage::AcceptTargetAssignmentAndInitiateInterceptionBaseline;
	}
	action def AcceptTargetCoordinatesAndInitiateSensorSearchModernized :> Function {
		in coordinateCueingDatalink : TargetCueing;
		out sensorSearchInitiated : AircraftStatus;
		doc /* A-29N pilot receives geographic target coordinate via datalink from E-99M; acknowledges engagement clearance; enters coordinate into aircraft navigation system (1–10 s reception sensitivity); initiates EO/IR sensor autonomous scan toward coordinate. */
		#refinement dependency AcceptTargetCoordinatesAndInitiateSensorSearchModernized to OperationsPackage::AcceptTargetAssignmentAndInitiateInterceptionModernized;
	}
	action def ProvideRealTimeVectoringUpdates :> Function {
		in updatedTargetPosition : TargetTrack;
		out vectoringUpdateTransmission : TargetCueing;
		doc /* E-99M/CINDACTA IV provides continuous target position updates to interceptor aircraft at scheduled intervals (baseline: [5, 60] s heading updates via voice; A-29N: [1, 10] s coordinate updates via datalink) to correct cumulative trajectory error. */
		#refinement dependency ProvideRealTimeVectoringUpdates to OperationsPackage::TransmitTargetNotificationToCAP;
	}
	action def ExecuteHeadingBasedVisualPursuitBaseline :> Function {
		in headingVector : TargetCueing;
		in aircraftStateBaseline : AircraftStatus;
		out visualAcquisitionAttempt : InterceptionGeometry;
		doc /* A-29 baseline pilot modifies aircraft heading toward E-99M-provided vector; climbs toward UAS altitude; maintains heading correction based on periodic vectoring updates ([5, 60] s intervals); searches for visual target within 13 km maximum acquisition distance; applies size-based contrast penalty for multi-rotor UAS (1/14 of fixed-wing size). */
		#refinement dependency ExecuteHeadingBasedVisualPursuitBaseline to OperationsPackage::NavigateToTargetVicinityUnderHeadingGuidanceBaseline;
	}
	action def ExecuteDataLinkCueingAndEOIRSensorTrackingModernized :> Function {
		in targetCoordinate : TargetCueing;
		in aircraftStateModernized : AircraftStatus;
		out sensorTrackConfirmed : InterceptionGeometry;
		doc /* A-29N pilot receives target coordinate via datalink; autonomously initiates EO/IR sensor scan; acquires UAS within sensor range (20 km max); maintains continuous laser rangefinder tracking with accuracy 5 m; adapts tracking to target maneuvers; supports tracking probability (fixed-wing: negligible loss; multi-rotor: intermittent losses due to dimension). */
		#refinement dependency ExecuteDataLinkCueingAndEOIRSensorTrackingModernized to OperationsPackage::NavigateToTargetVicinityUnderDatalink;
	}
	action def AchieveVisualContactAndTargetIdentificationBaseline :> Function {
		in visualSearchGeometry : InterceptionGeometry;
		out visualTargetLock : InterceptionGeometry;
		doc /* A-29 baseline pilot visually acquires UAS within 13 km range; identifies UAS type (multi-rotor vs. fixed-wing) through visual signature; performs minimum 12.5 s identification and reaction time; maintains visual contact during pursuit; aborts pursuit if visual contact lost. */
		#refinement dependency AchieveVisualContactAndTargetIdentificationBaseline to OperationsPackage::EstablishVisualAcquisitionOfTargetBaseline;
	}
	action def AchieveSensorLockAndPositiveIdentificationModernized :> Function {
		in sensorTrackGeometry : InterceptionGeometry;
		out sensorLockConfirmed : InterceptionGeometry;
		doc /* A-29N pilot confirms EO/IR sensor lock on UAS target; validates laser rangefinder return signal; identifies UAS archetype through sensor analysis (fixed-wing: robust tracking; multi-rotor: prone to intermittent lock loss); maintains lock during approach to engagement range. */
		#refinement dependency AchieveSensorLockAndPositiveIdentificationModernized to OperationsPackage::AcquireTargetViaEOIRSensor;
	}
	action def ExecuteControlledInterceptionApproach :> Function {
		in targetLockStatus : InterceptionGeometry;
		out weaponEnvelopeAchieved : InterceptionGeometry;
		doc /* A-29 aircraft (both configurations) modify heading and altitude to close distance to UAS while maintaining engagement geometry; avoid excessive closure rates to prevent overshoot; maneuver to position within weapon employment envelope (baseline: 0.5–2 km; A-29N: 2–14 km). */
		#refinement dependency ExecuteControlledInterceptionApproach to OperationsPackage::DesignateTargetWithLaser;
		#refinement dependency ExecuteControlledInterceptionApproach to OperationsPackage::TrackTargetDuringInterceptionBaseline;
	}
	action def ExecuteWeaponFiringDecisionAndShotDelivery :> Function {
		in engagementClearanceAndGeometry : InterceptionGeometry;
		out ordnanceReleased : EngagementOutcome;
		doc /* A-29 pilot executes TDE authorization; randomly selects firing philosophy (short/medium/long range) with equal probability (1/3 each); releases ordnance (unguided SBAT-70 or APKWS laser-guided rocket) at selected distance; maintain laser designation for A-29N guidance until impact. */
		#refinement dependency ExecuteWeaponFiringDecisionAndShotDelivery to OperationsPackage::ExecuteWeaponsFireBaselineUnguidedSBAT70;
		#refinement dependency ExecuteWeaponFiringDecisionAndShotDelivery to OperationsPackage::ExecuteWeaponsFireModernizedLaserGuidedAPKWS;
	}
	action def AssessEngagementOutcome :> Function {
		in postEngagementStatus : EngagementOutcome;
		out engagementResultClassification : EngagementOutcome;
		doc /* Evaluate UAS status post-engagement: (1) Neutralized — UAS destroyed or incapacitated; return to CAP point for next assignment. (2) Evaded — UAS crosses 80 nmi ZIDA boundary before engagement; classify as mission failure; return to CAP point. (3) Lost Track — Tracking lost before weapon employment; abort pursuit; return to CAP point. */
		#refinement dependency AssessEngagementOutcome to OperationsPackage::AssessWeaponsImpactAndTargetStatus;
		#refinement dependency AssessEngagementOutcome to OperationsPackage::ReturnToCAPPointNeutralizationSuccess;
		#refinement dependency AssessEngagementOutcome to OperationsPackage::DeclareTargetEvaluatedAndReturnToCAPPoint;
	}
	action def ReturnToCAPPointAndAwaitNextAssignment :> Function {
		in engagementTerminationSignal : EngagementOutcome;
		out aircraftRTBCAP : AircraftStatus;
		doc /* Upon interception termination (neutralization, evasion, or tracking loss), A-29 aircraft navigate back to assigned CAP point; maintain holding orbit; monitor E-99M/CINDACTA IV for next target notification; continue until fuel endurance reached (minimum reserve for recovery transit). */
		#refinement dependency ReturnToCAPPointAndAwaitNextAssignment to OperationsPackage::ReturnToCAPPointNeutralizationSuccess;
		#refinement dependency ReturnToCAPPointAndAwaitNextAssignment to OperationsPackage::DeclareTargetEvaluatedAndReturnToCAPPoint;
		#refinement dependency ReturnToCAPPointAndAwaitNextAssignment to OperationsPackage::ContinuouslyMonitorFuelStateAndCalculateMinimumReserve;
		#refinement dependency ReturnToCAPPointAndAwaitNextAssignment to OperationsPackage::TransitionFromAirspacePoliceToRecoveryPhaseFuelConstraint;
	}
	action def CountSuccessfulNeutralizationsAndEvasions :> Function {
		in allEngagementResults : EngagementOutcome;
		out neutralizationAndEvasionCounts : MissionMetrics;
		doc /* Aggregate engagement outcomes across all interceptor aircraft and UAS incursions during entire mission activation; tabulate number of UAS neutralized before 80 nmi boundary vs. number that successfully evaded. */
	}
	action def CalculateMissionMeasureOfSuccessMOS1 :> Function {
		in neutralizationCounts : MissionMetrics;
		out neutralizationRateMetric : MissionMetrics;
		doc /* Compute neutralization rate as proportion of neutralized UAS to total incursions; evaluate strategic objective achievement (target: >80% neutralization rate). */
	}
	action def CalculateEvasionReductionRateMOS2 :> Function {
		in baselineAndModernizedEvasionCounts : MissionMetrics;
		out evasionReductionRateMetric : MissionMetrics;
		doc /* Compare baseline vs. A-29N evasion rates; compute relative improvement afforded by modernized configuration (target: >0% reduction). */
	}
	action def EvaluateEngagementTimeEffectivenessMOE1 :> Function {
		in timestampedEngagementEvents : EngagementOutcome;
		out engagementTimeEffectivenessMetric : MissionMetrics;
		doc /* Measure mean interval from UAS notification to neutralization or evasion outcome; apply penalty factor for evasion events; assess temporal efficiency of each configuration. */
	}
	action def EvaluateActiveTrackingCapabilityMOE2 :> Function {
		in trackingDurationAndDropouts : InterceptionGeometry;
		out trackingReliabilityMetric : MissionMetrics;
		doc /* Measure proportion of interception time during which interceptor maintained continuous target tracking; assess baseline (visual + vectoring) vs. A-29N (EO/IR + datalink) tracking reliability. */
	}
	action def EvaluateNeutralizationProbabilityPerEngagementMOE3 :> Function {
		in weaponPerformanceData : EngagementOutcome;
		out neutralizationProbabilityMetric : MissionMetrics;
		doc /* Calculate cumulative hit probability across all engagements based on weapon employment range, UAS dimension, and armament precision characteristics; assess baseline vs. A-29N lethality. */
	}

	// ===================================================================
	//  Level 1-3: Orchestrating Functions (compose Leaf-Level Functions)
	// ===================================================================
	action def ConductContinentalZIDAShieldOperation :> Function {
		in missionActivationAuthorization : SurveillanceAuthorization;
		out missionOutcomeReport : MissionMetrics;
		doc /* Execute end-to-end airspace policing and counter-UAS operations to protect the Brazilian Amazon border region (continental ZIDA) through integrated surveillance, interception, and neutralization of illicit unmanned aerial systems. */
		action executeMissionLogisticsAndDeployment : ExecuteMissionLogisticsAndDeployment;
		action conductAirspaceSurveillanceAndDetection : ConductAirspaceSurveillanceAndDetection;
		action executeInterceptorCoordinationAndControl : ExecuteInterceptorCoordinationAndControl;
		action performUASInterceptionAndEngagement : PerformUASInterceptionAndEngagement;
		action assessMissionOutcomeAndEffectiveness : AssessMissionOutcomeAndEffectiveness;
	}
	action def ExecuteMissionLogisticsAndDeployment :> Function {
		in missionActivationSignal : SurveillanceAuthorization;
		out aircraftDeploymentComplete : AircraftStatus;
		doc /* Manage aircraft transportation, refueling, rearming, and forward basing operations to position interceptor aircraft at optimal combat air patrol points with full fuel and ordnance loads. */
		action departMainOperatingBase : DepartMainOperatingBase;
		action conductDirectRouteTransitToFARP : ConductDirectRouteTransitToFARP;
		action executeRefuelingAndRearmingAtFARP : ExecuteRefuelingAndRearmingAtFARP;
		action repositionFromFARPToCAP : RepositionFromFARPToCAP;
		action maintainHoldingOrbitAtCAP : MaintainHoldingOrbitAtCAP;
		action returnToFARPAndMainBase : ReturnToFARPAndMainBase;
	}
	action def ConductAirspaceSurveillanceAndDetection :> Function {
		in surveillanceActivationAuthorization : SurveillanceAuthorization;
		out detectedTargetTrack : TargetTrack;
		doc /* Employ ground and airborne radar systems to continuously detect, classify, and track illicit UAS incursions across the continental ZIDA, establishing radar tracks and target coordinates. */
		action conductGroundBasedRadarSurveillance : ConductGroundBasedRadarSurveillance;
		action conductAirborneRadarDetection : ConductAirborneRadarDetection;
		action classifyDetectedTargetAsIllicitUAS : ClassifyDetectedTargetAsIllicitUAS;
	}
	action def ExecuteInterceptorCoordinationAndControl :> Function {
		in targetTrackFromSurveillance : TargetTrack;
		out targetCueingToInterceptor : TargetCueing;
		doc /* Provide command and control direction, target cueing, and tactical vectoring to interceptor aircraft from surveillance and airborne early warning platforms, enabling rapid threat response. */
		action generateSimultaneousAirspacePolicingAuthorization : GenerateSimultaneousAirspacePolicingAuthorization;
		action transmitTargetNotificationToInterceptor : TransmitTargetNotificationToInterceptor;
		action acceptTargetAssignmentAndConfirmEngagementReadinessBaseline : AcceptTargetAssignmentAndConfirmEngagementReadinessBaseline;
		action acceptTargetCoordinatesAndInitiateSensorSearchModernized : AcceptTargetCoordinatesAndInitiateSensorSearchModernized;
		action provideRealTimeVectoringUpdates : ProvideRealTimeVectoringUpdates;
	}
	action def PerformUASInterceptionAndEngagement :> Function {
		in targetCueingInput : TargetCueing;
		in aircraftState : AircraftStatus;
		out engagementResult : EngagementOutcome;
		doc /* Conduct tactical pursuit, tracking, identification, and kinetic engagement of detected illicit UAS to achieve neutralization before airspace boundary penetration. */
		action executeHeadingBasedVisualPursuitBaseline : ExecuteHeadingBasedVisualPursuitBaseline;
		action executeDataLinkCueingAndEOIRSensorTrackingModernized : ExecuteDataLinkCueingAndEOIRSensorTrackingModernized;
		action achieveVisualContactAndTargetIdentificationBaseline : AchieveVisualContactAndTargetIdentificationBaseline;
		action achieveSensorLockAndPositiveIdentificationModernized : AchieveSensorLockAndPositiveIdentificationModernized;
		action executeControlledInterceptionApproach : ExecuteControlledInterceptionApproach;
		action executeWeaponFiringDecisionAndShotDelivery : ExecuteWeaponFiringDecisionAndShotDelivery;
		action assessEngagementOutcome : AssessEngagementOutcome;
		action returnToCAPPointAndAwaitNextAssignment : ReturnToCAPPointAndAwaitNextAssignment;
	}
	action def AssessMissionOutcomeAndEffectiveness :> Function {
		in allEngagementOutcomes : EngagementOutcome;
		out missionPerformanceMetrics : MissionMetrics;
		doc /* Measure and evaluate the success of neutralization actions, evasion outcomes, and overall mission impact on airspace sovereignty preservation. */
		action countSuccessfulNeutralizationsAndEvasions : CountSuccessfulNeutralizationsAndEvasions;
		action calculateMissionMeasureOfSuccessMOS1 : CalculateMissionMeasureOfSuccessMOS1;
		action calculateEvasionReductionRateMOS2 : CalculateEvasionReductionRateMOS2;
		action evaluateEngagementTimeEffectivenessMOE1 : EvaluateEngagementTimeEffectivenessMOE1;
		action evaluateActiveTrackingCapabilityMOE2 : EvaluateActiveTrackingCapabilityMOE2;
		action evaluateNeutralizationProbabilityPerEngagementMOE3 : EvaluateNeutralizationProbabilityPerEngagementMOE3;
	}
}
