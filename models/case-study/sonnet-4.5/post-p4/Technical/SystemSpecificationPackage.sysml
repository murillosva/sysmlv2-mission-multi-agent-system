package SystemSpecificationPackage {

	private import TechnicalRequirementsPackage::*;
	private import SystemPackage::*;

	requirement a29SuperTucanoModernizationSystem {
		doc /* Technical requirements specification */
		subject continentalZIDAShieldSystem : ContinentalZIDAShieldSystem;
		requirement 'TR-001' : BaselineSBAT70UnguidedRocketRequirement;
		requirement 'TR-002' : ModernizedAPKWSLaserGuidedRocketRequirement;
		requirement 'TR-003' : BaselineVHFVoiceVectoringRequirement;
		requirement 'TR-004' : ModernizedDatalinkCueingRequirement;
		requirement 'TR-005' : BaselineNakedEyeVisualAcquisitionRequirement;
		requirement 'TR-006' : ModernizedEOIRSensorAcquisitionRequirement;
		requirement 'TR-007' : E99MPS890RadarDetectionRequirement;
		requirement 'TR-008' : SixCAPPointSpacingRequirement;
		requirement 'TR-009' : FourFARPOptimizedPositioningRequirement;
		requirement 'TR-010' : CruiseSpeedStandardizationRequirement;
		requirement 'TR-011' : MaximumEnduranceConstraintRequirement;
		requirement 'TR-012' : BaselineVisualAcquisitionDimensionalPenaltyRequirement;
		requirement 'TR-013' : ModernizedEOIRTrackingDimensionalPenaltyRequirement;
		requirement 'TR-014' : APKWSHitProbabilitySpecificationRequirement;
		requirement 'TR-015' : SBAT70UnguidedHitProbabilityRequirement;
		requirement 'TR-016' : MultiRotorEngagementDimensionalPenaltyRequirement;
		requirement 'TR-017' : E99MContinuousPresenceRequirement;
		requirement 'TR-018' : E99MRadarDetectionIdealizedRequirement;
		requirement 'TR-019' : UASEntryPointStochasticDistributionRequirement;
		requirement 'TR-020' : UASHeadingVariationRequirement;
		requirement 'TR-021' : UASClassEquiprobabilityRequirement;
		requirement 'TR-022' : FiringPhilosophyEquiprobabilityRequirement;
		requirement 'TR-023' : PEASimultaneousCommencementRequirement;
		requirement 'TR-024' : EngagementExclusivityRequirement;
		requirement 'TR-025' : EngagementTerminationAndCAPReturnRequirement;
		requirement 'TR-026' : DatalinkLatencyIdealizedRequirement;
		requirement 'TR-027' : RefuelingDurationDisregardedRequirement;
		requirement 'TR-028' : MultiRotorMaxSpeedRequirement;
		requirement 'TR-029' : FixedWingMaxSpeedRequirement;
		requirement 'TR-030' : ZIDABoundaryDistanceRequirement;
		satisfy 'TR-001' by continentalZIDAShieldSystem.interceptorAircraftPlatform;
		satisfy 'TR-002' by continentalZIDAShieldSystem.interceptorAircraftPlatform;
		satisfy 'TR-003' by continentalZIDAShieldSystem.interceptorAircraftPlatform;
		satisfy 'TR-004' by continentalZIDAShieldSystem.interceptorAircraftPlatform;
		satisfy 'TR-005' by continentalZIDAShieldSystem.interceptorAircraftPlatform;
		satisfy 'TR-006' by continentalZIDAShieldSystem.interceptorAircraftPlatform;
		satisfy 'TR-007' by continentalZIDAShieldSystem.airborneControlAndEarlyWarningPlatform;
		satisfy 'TR-008' by continentalZIDAShieldSystem.interceptorAircraftPlatform;
		satisfy 'TR-009' by continentalZIDAShieldSystem.combatLogisticsSustainmentSystem;
		satisfy 'TR-010' by continentalZIDAShieldSystem.interceptorAircraftPlatform;
		satisfy 'TR-011' by continentalZIDAShieldSystem.interceptorAircraftPlatform;
		satisfy 'TR-017' by continentalZIDAShieldSystem.airborneControlAndEarlyWarningPlatform;
		satisfy 'TR-020' by MultiRotorUASIllicit;
		satisfy 'TR-020' by FixedWingUASIllicit;
		satisfy 'TR-028' by MultiRotorUASIllicit;
		satisfy 'TR-029' by FixedWingUASIllicit;
	}
}
