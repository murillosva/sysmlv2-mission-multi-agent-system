package FunctionSpecificationPackage {

	private import FunctionalRequirementsPackage::*;
	private import FunctionsPackage::*;

	requirement airspacePolicingFunctionSpecification {
		doc /* Functional requirements specification */
		subject conductContinentalZIDAShieldOperation : ConductContinentalZIDAShieldOperation;
		requirement 'FR-001' : AircraftTakeoffResponseTimeRequirement;
		requirement 'FR-002' : CruiseSpeedNormalizationRequirement;
		requirement 'FR-003' : BaselineVoiceCommunicationVectoringRequirement;
		requirement 'FR-004' : DataLinkCoordinateReceptionRequirement;
		requirement 'FR-005' : CoordinateReceptionSensitivityRequirement;
		requirement 'FR-006' : BaselineVisualAcquisitionDistanceRequirement;
		requirement 'FR-007' : BaselineAcquisitionReactionTimeRequirement;
		requirement 'FR-008' : BaselineMultirotorVisualPenaltyRequirement;
		requirement 'FR-009' : EORIRSensorRangeRequirement;
		requirement 'FR-010' : A29NMultirotorSensorTrackingPenaltyRequirement;
		requirement 'FR-011' : BaselineUnguideArmamentEnvelopeRequirement;
		requirement 'FR-012' : BaselineUnguideHitProbabilityRequirement;
		requirement 'FR-013' : ModernizedAPKWSArmamentEnvelopeRequirement;
		requirement 'FR-014' : ModernizedAPKWSHitProbabilityRequirement;
		requirement 'FR-015' : AirborneRadarContinuousAvailabilityRequirement;
		requirement 'FR-016' : FARPNetworkCoverageRequirement;
		requirement 'FR-017' : FARPFuelServicingCapacityRequirement;
		requirement 'FR-018' : FARPBaselineOrdnanceLoadingRequirement;
		requirement 'FR-019' : FARPModernizedOrdnanceLoadingRequirement;
		requirement 'FR-020' : ContinentalZIDACoverageSectoringRequirement;
		requirement 'FR-021' : SimultaneousAirspacePolicingAuthorizationRequirement;
		requirement 'FR-022' : UASThreatStochasticModelingRequirement;
		requirement 'FR-023' : EngagementOutcomeAssessmentRequirement;
		requirement 'FR-024' : FiringPhilosophyRandomSelectionRequirement;
		requirement 'FR-025' : LaserDesignationContinuityRequirement;
		satisfy 'FR-001' by conductContinentalZIDAShieldOperation.executeMissionLogisticsAndDeployment.departMainOperatingBase;
		satisfy 'FR-002' by conductContinentalZIDAShieldOperation.executeMissionLogisticsAndDeployment.conductDirectRouteTransitToFARP;
		satisfy 'FR-002' by conductContinentalZIDAShieldOperation.executeMissionLogisticsAndDeployment.repositionFromFARPToCAP;
		satisfy 'FR-002' by conductContinentalZIDAShieldOperation.executeMissionLogisticsAndDeployment.returnToFARPAndMainBase;
		satisfy 'FR-003' by conductContinentalZIDAShieldOperation.executeInterceptorCoordinationAndControl.provideRealTimeVectoringUpdates;
		satisfy 'FR-004' by conductContinentalZIDAShieldOperation.executeInterceptorCoordinationAndControl.acceptTargetCoordinatesAndInitiateSensorSearchModernized;
		satisfy 'FR-005' by conductContinentalZIDAShieldOperation.executeInterceptorCoordinationAndControl.acceptTargetCoordinatesAndInitiateSensorSearchModernized;
		satisfy 'FR-006' by conductContinentalZIDAShieldOperation.performUASInterceptionAndEngagement.achieveVisualContactAndTargetIdentificationBaseline;
		satisfy 'FR-007' by conductContinentalZIDAShieldOperation.performUASInterceptionAndEngagement.achieveVisualContactAndTargetIdentificationBaseline;
		satisfy 'FR-008' by conductContinentalZIDAShieldOperation.performUASInterceptionAndEngagement.achieveVisualContactAndTargetIdentificationBaseline;
		satisfy 'FR-009' by FLIRStarSAFIREIIEOIRSensorWithLaserRangefinderDesignator;
		satisfy 'FR-010' by conductContinentalZIDAShieldOperation.performUASInterceptionAndEngagement.achieveSensorLockAndPositiveIdentificationModernized;
		satisfy 'FR-011' by SBAT70UnguidedRocketPodBaseline;
		satisfy 'FR-012' by conductContinentalZIDAShieldOperation.performUASInterceptionAndEngagement.executeWeaponFiringDecisionAndShotDelivery;
		satisfy 'FR-013' by AdvancedPrecisionKillWeaponSystemAPKWSLaserGuidedKit;
		satisfy 'FR-013' by SBAT70RocketWithAPKWSIntegrationA29N;
		satisfy 'FR-014' by conductContinentalZIDAShieldOperation.performUASInterceptionAndEngagement.executeWeaponFiringDecisionAndShotDelivery;
		satisfy 'FR-015' by PS890ErieyeSBandAEWRadar;
		satisfy 'FR-016' by FARPNetworkInfrastructureFourSites;
		satisfy 'FR-017' by FuelServicingEquipmentFARP;
		satisfy 'FR-018' by OrdnanceLoadingEquipmentFARPBaseline;
		satisfy 'FR-019' by OrdnanceLoadingEquipmentFARPA29N;
		satisfy 'FR-020' by CINDACTAIVRegionalControlCenter;
		satisfy 'FR-021' by conductContinentalZIDAShieldOperation.executeInterceptorCoordinationAndControl.generateSimultaneousAirspacePolicingAuthorization;
		satisfy 'FR-023' by conductContinentalZIDAShieldOperation.performUASInterceptionAndEngagement.assessEngagementOutcome;
		satisfy 'FR-024' by conductContinentalZIDAShieldOperation.performUASInterceptionAndEngagement.executeWeaponFiringDecisionAndShotDelivery;
		satisfy 'FR-025' by conductContinentalZIDAShieldOperation.performUASInterceptionAndEngagement.executeControlledInterceptionApproach;
	}
}
