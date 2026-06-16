package MissionPhasesPackage {

	private import CoSMAPackage::*;
	private import OperationsPackage::*;

	// --- Item Definitions (Completion Notifications) ---
	item def AircraftDepartureFromMainBaseCompletedNotification;
	item def TransitToForwardArmingAndRefuelingPointCompletedNotification;
	item def RefuelingAndRearmingAtFARPCompletedNotification;
	item def RepositioningFromFARPToCombatAirPatrolPointCompletedNotification;
	item def HoldingOrbitAtCAPPointCompletedNotification;
	item def AirspacePolicingCompletedNotification;
	item def ReturnTransitFromCAPPointToFARPCompletedNotification;
	item def RecoveryTransitFromFARPToMainBaseCompletedNotification;

	// --- State Definitions ---
	state def AircraftDepartureFromMainBase :> Phase {
		do action aircraftDepartureFromMainBaseOperations {
			first start;
			then action executeAircraftTakeoffSequenceFromSBPV : ExecuteAircraftTakeoffSequenceFromSBPV;
			then done;
		}
	}
	state def TransitToForwardArmingAndRefuelingPoint :> Phase {
		do action transitToForwardArmingAndRefuelingPointOperations {
			first start;
			then action conductDirectRouteTransitToFARP : ConductDirectRouteTransitToFARP;
			then done;
		}
	}
	state def RefuelingAndRearmingAtFARP :> Phase {
		do action refuelingAndRearmingAtFARPOperations {
			first start;
			then action conductRefuelingAndRearmingOperationsAtFARP : ConductRefuelingAndRearmingOperationsAtFARP;
			then done;
		}
	}
	state def RepositioningFromFARPToCombatAirPatrolPoint :> Phase {
		do action repositioningFromFARPToCombatAirPatrolPointOperations {
			first start;
			then action repositionFromFARPToAssignedCAPPoint : RepositionFromFARPToAssignedCAPPoint;
			then done;
		}
	}
	state def HoldingOrbitAtCAPPoint :> Phase {
		do action holdingOrbitAtCAPPointOperations {
			first start;
			then action maintainHoldingOrbitAtCAPPoint : MaintainHoldingOrbitAtCAPPoint;
			then done;
		}
	}
	state def AirspacePolicing :> Phase {
		do action airspacePolicingOperations {
			first start;
			then action initiateSimultaneousAirspacePolicing : InitiateSimultaneousAirspacePolicing;
			then action detectIllicitUASIncursion : DetectIllicitUASIncursion;
			then action transmitTargetNotificationToCAP : TransmitTargetNotificationToCAP;
			then action acceptTargetAssignmentAndInitiateInterceptionBaseline : AcceptTargetAssignmentAndInitiateInterceptionBaseline;
			then action acceptTargetAssignmentAndInitiateInterceptionModernized : AcceptTargetAssignmentAndInitiateInterceptionModernized;
			then action navigateToTargetVicinityUnderHeadingGuidanceBaseline : NavigateToTargetVicinityUnderHeadingGuidanceBaseline;
			then action navigateToTargetVicinityUnderDatalink : NavigateToTargetVicinityUnderDatalink;
			then action establishVisualAcquisitionOfTargetBaseline : EstablishVisualAcquisitionOfTargetBaseline;
			then action acquireTargetViaEOIRSensor : AcquireTargetViaEOIRSensor;
			then action designateTargetWithLaser : DesignateTargetWithLaser;
			then action trackTargetDuringInterceptionBaseline : TrackTargetDuringInterceptionBaseline;
			then action trackTargetDuringInterceptionModernized : TrackTargetDuringInterceptionModernized;
			then action establishFiringGeometryAndWeaponsReady : EstablishFiringGeometryAndWeaponsReady;
			then action executeWeaponsFireBaselineUnguidedSBAT70 : ExecuteWeaponsFireBaselineUnguidedSBAT70;
			then action executeWeaponsFireModernizedLaserGuidedAPKWS : ExecuteWeaponsFireModernizedLaserGuidedAPKWS;
			then action assessWeaponsImpactAndTargetStatus : AssessWeaponsImpactAndTargetStatus;
			then action returnToCAPPointNeutralizationSuccess : ReturnToCAPPointNeutralizationSuccess;
			then action declareTargetEvaluatedAndReturnToCAPPoint : DeclareTargetEvaluatedAndReturnToCAPPoint;
			then action continuouslyMonitorFuelStateAndCalculateMinimumReserve : ContinuouslyMonitorFuelStateAndCalculateMinimumReserve;
			then action transitionFromAirspacePoliceToRecoveryPhaseFuelConstraint : TransitionFromAirspacePoliceToRecoveryPhaseFuelConstraint;
			then done;
		}
	}
	state def ReturnTransitFromCAPPointToFARP :> Phase {
		do action returnTransitFromCAPPointToFARPOperations {
			first start;
			then action conductDirectRouteTransitFromCAPPointToFARP : ConductDirectRouteTransitFromCAPPointToFARP;
			then done;
		}
	}
	state def RecoveryTransitFromFARPToMainBase :> Phase {
		do action recoveryTransitFromFARPToMainBaseOperations {
			first start;
			then action conductLandingAndRecoveryAtFARP : ConductLandingAndRecoveryAtFARP;
			then done;
		}
	}

	// Special states
	state def Initial;
	state def MissionComplete;
}
