package SystemSpecificationPackage {

	private import TechnicalRequirementsPackage::*;
	private import SystemPackage::*;
	private import CoSMAPackage::*;

	requirement a29E99MCINDACTAIntegratedSystem {
		doc /* Technical requirements specification */
		subject continentalZIDAShieldOperationSystem : ContinentalZIDAShieldOperationSystem;
		requirement 'TR-001' : A29EnduranceSpecificationRequirement;
		requirement 'TR-002' : A29CruiseSpeedSpecificationRequirement;
		requirement 'TR-003' : BaselineVectoringUpdateIntervalSpecificationRequirement;
		requirement 'TR-004' : A29NDataLinkUpdateIntervalSpecificationRequirement;
		requirement 'TR-005' : A29NCoordinateReceptionSensitivitySpecificationRequirement;
		requirement 'TR-006' : BaselineVisualAcquisitionRangeSpecificationRequirement;
		requirement 'TR-007' : BaselineAcquisitionReactionTimeSpecificationRequirement;
		requirement 'TR-008' : BaselineMultirotorVisualPenaltySpecificationRequirement;
		requirement 'TR-009' : EORIRSensorSpecificationRequirement;
		requirement 'TR-010' : A29NMultirotorSensorTrackingPenaltySpecificationRequirement;
		requirement 'TR-011' : BaselineUnguideArmamentSpecificationRequirement;
		requirement 'TR-012' : BaselineUnguideHitProbabilitySpecificationRequirement;
		requirement 'TR-013' : ModernizedAPKWSArmamentSpecificationRequirement;
		requirement 'TR-014' : ModernizedAPKWSHitProbabilitySpecificationRequirement;
		requirement 'TR-015' : AirborneRadarDetectionRangeSpecificationRequirement;
		requirement 'TR-016' : FARPNetworkTransitDistanceSpecificationRequirement;
		requirement 'TR-017' : FARPFuelServicingConfigurationSpecificationRequirement;
		requirement 'TR-018' : FARPBaselineOrdnanceLoadSpecificationRequirement;
		requirement 'TR-019' : FARPModernizedOrdnanceLoadSpecificationRequirement;
		requirement 'TR-020' : ContinentalZIDACoverageSectorSpecificationRequirement;
		requirement 'TR-021' : SimultaneousAuthorizationMilestoneSpecificationRequirement;
		requirement 'TR-022' : UASThreatGenerationMethodologySpecificationRequirement;
		requirement 'TR-023' : BaselineVHFRadioSystemSpecificationRequirement;
		requirement 'TR-024' : A29NPilotVisualSystemSpecificationRequirement;
		requirement 'TR-025' : RohdeSchwartzDataLinkSpecificationRequirement;
		requirement 'TR-026' : FLIRSAFIREIISensorSpecificationRequirement;
		requirement 'TR-027' : APKWSLaserGuidedKitSpecificationRequirement;
		requirement 'TR-028' : E99MAirframePerformanceSpecificationRequirement;
		requirement 'TR-029' : MultirotorUASThreatModelSpecificationRequirement;
		requirement 'TR-030' : FixedwingUASThreatModelSpecificationRequirement;
		satisfy 'TR-001' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-002' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-003' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-004' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-005' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-006' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-007' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-008' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-009' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-010' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-011' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-013' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-015' by continentalZIDAShieldOperationSystem.airborneSurveillanceAndControlElement;
		satisfy 'TR-016' by continentalZIDAShieldOperationSystem.logisticsAndForwardOperationsSystem;
		satisfy 'TR-017' by continentalZIDAShieldOperationSystem.logisticsAndForwardOperationsSystem;
		satisfy 'TR-018' by continentalZIDAShieldOperationSystem.logisticsAndForwardOperationsSystem;
		satisfy 'TR-019' by continentalZIDAShieldOperationSystem.logisticsAndForwardOperationsSystem;
		satisfy 'TR-020' by continentalZIDAShieldOperationSystem.groundAirspaceControlNetwork;
		satisfy 'TR-021' by continentalZIDAShieldOperationSystem.groundAirspaceControlNetwork;
		satisfy 'TR-023' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-024' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-025' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-026' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-027' by continentalZIDAShieldOperationSystem.interceptorAircraftElement;
		satisfy 'TR-028' by continentalZIDAShieldOperationSystem.airborneSurveillanceAndControlElement;
		satisfy 'TR-029' by MultiRotorUASIllicitArchetype;
		satisfy 'TR-030' by FixedWingUASIllicitArchetype;
	}
}
