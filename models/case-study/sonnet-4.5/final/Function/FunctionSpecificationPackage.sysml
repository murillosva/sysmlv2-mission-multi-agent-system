package FunctionSpecificationPackage {

	private import FunctionalRequirementsPackage::*;
	private import FunctionsPackage::*;
	private import CoSMAPackage::*;

	requirement cuasInterceptionFunctions {
		doc /* Functional requirements specification */
		subject performContinentalZIDAShield : PerformContinentalZIDAShield;
		requirement 'FR-001' : E99MAirborneRadarDetectionRequirement;
		requirement 'FR-002' : InterceptorAssignmentRequirement;
		requirement 'FR-003' : VectoringInformationTransmissionRequirement;
		requirement 'FR-004' : UASAcquisitionCapabilityRequirement;
		requirement 'FR-005' : ContinuousTrackingMaintenanceRequirement;
		requirement 'FR-006' : WeaponEmploymentEnvelopeEntryRequirement;
		requirement 'FR-007' : KineticNeutralizationExecutionRequirement;
		requirement 'FR-008' : EngagementOutcomeAssessmentRequirement;
		requirement 'FR-009' : CAPPointHoldingRequirement;
		requirement 'FR-010' : FARPRefuelingCapabilityRequirement;
		requirement 'FR-011' : FARPOptimizedPositioningRequirement;
		requirement 'FR-012' : MissionSynchronizationRequirement;
		requirement 'FR-013' : EngagementCycleRepetitionRequirement;
		requirement 'FR-014' : StochasticUASIncursionGenerationRequirement;
		requirement 'FR-015' : MissionEffectivenessReportingRequirement;
		satisfy 'FR-001' by performContinentalZIDAShield.provideAirborneControlAndEarlyWarning.detectIllicitUASWithAirborneRadar;
		satisfy 'FR-002' by performContinentalZIDAShield.provideAirborneControlAndEarlyWarning.assignInterceptorToUASTarget;
		satisfy 'FR-003' by performContinentalZIDAShield.provideAirborneControlAndEarlyWarning.transmitVectoringInformationViaVoice;
		satisfy 'FR-003' by performContinentalZIDAShield.provideAirborneControlAndEarlyWarning.transmitCueingCoordinatesViaDatalink;
		satisfy 'FR-004' by performContinentalZIDAShield.executeAirspacePolicing.acquireUASVisually;
		satisfy 'FR-004' by performContinentalZIDAShield.executeAirspacePolicing.acquireUASWithEOIRSensor;
		satisfy 'FR-005' by performContinentalZIDAShield.executeAirspacePolicing.maintainVisualTrackingOfUAS;
		satisfy 'FR-005' by performContinentalZIDAShield.executeAirspacePolicing.maintainEOIRTrackingLock;
		satisfy 'FR-006' by performContinentalZIDAShield.executeAirspacePolicing.enterWeaponEmploymentEnvelope;
		satisfy 'FR-007' by performContinentalZIDAShield.executeAirspacePolicing.executeSBAT70UnguiedRocket;
		satisfy 'FR-007' by performContinentalZIDAShield.executeAirspacePolicing.executeAPKWSLaserGuidedRocket;
		satisfy 'FR-008' by performContinentalZIDAShield.executeAirspacePolicing.assessEngagementOutcome;
		satisfy 'FR-009' by performContinentalZIDAShield.manageForwardOperations.maintainHoldingOrbitAtCAP;
		satisfy 'FR-010' by performContinentalZIDAShield.manageForwardOperations.refuelAtFARP;
		satisfy 'FR-011' by performContinentalZIDAShield.manageForwardOperations.transitFromMainBaseToFARP;
		satisfy 'FR-011' by performContinentalZIDAShield.manageForwardOperations.repositionFromFARPToCAP;
		satisfy 'FR-012' by performContinentalZIDAShield.executeAirspacePolicing.initiateAirspacePolicing;
		satisfy 'FR-013' by performContinentalZIDAShield.executeAirspacePolicing.continueInterceptionCycles;
		satisfy 'FR-013' by performContinentalZIDAShield.executeAirspacePolicing.returnToCAPAfterEngagement;
		satisfy 'FR-015' by performContinentalZIDAShield.executeAirspacePolicing.assessEngagementOutcome;
	}
}
