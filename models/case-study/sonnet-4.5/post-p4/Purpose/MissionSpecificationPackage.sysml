package MissionSpecificationPackage {

	private import MissionRequirementsPackage::*;
	private import MissionPackage::*;
	private import MissionPhasesPackage::*;

	requirement amazonBorderAirspacePolicing {
		doc /* Mission requirements specification for ContinentalZIDAShieldOperation */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
		requirement 'MR-001' : UASNeutralizationBeforeZIDABoundaryRequirement;
		requirement 'MR-002' : UninterruptedAirspaceSurveillanceRequirement;
		requirement 'MR-003' : ComprehensiveUASEngagementChainRequirement;
		requirement 'MR-004' : MaximizeTimeOnStationThroughFARPRequirement;
		requirement 'MR-005' : RealTimeVectoringSupportRequirement;
		requirement 'MR-006' : ImmediateKineticEngagementRequirement;
		satisfy 'MR-001' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.neutralizeUAS;
		satisfy 'MR-001' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.assessNeutralization;
		satisfy 'MR-002' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.detectUASByE99M;
		satisfy 'MR-002' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.initiateAirspacePolicing;
		satisfy 'MR-003' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.detectUASByE99M;
		satisfy 'MR-003' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.performNakedEyeVisualSearch;
		satisfy 'MR-003' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.acquireUASWithEOIRSensor;
		satisfy 'MR-003' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.maintainVisualContactWithUAS;
		satisfy 'MR-003' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.maintainEOIRTrackingLock;
		satisfy 'MR-003' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.executeDeterrenceShot;
		satisfy 'MR-003' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.executeAPKWSLaunch;
		satisfy 'MR-004' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.transitToFARP.transitToFARPOperations.transitToFARP;
		satisfy 'MR-004' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.capToFARPReturn.capToFARPReturnOperations.refuelAtFARP;
		satisfy 'MR-005' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.vectorInterceptorViaVoice;
		satisfy 'MR-005' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.transmitCoordinatesViaDatalink;
		satisfy 'MR-006' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.executeDeterrenceShot;
		satisfy 'MR-006' by continentalZIDAShieldOperation.continentalZIDAShieldOperationPhases.airspacePolicing.airspacePolicingOperations.executeAPKWSLaunch;
	}
}
