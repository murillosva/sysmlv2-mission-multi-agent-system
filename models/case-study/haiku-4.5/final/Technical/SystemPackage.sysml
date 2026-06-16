package SystemPackage {

	private import CoSMAPackage::*;
	private import LogicalComponentsPackage::*;
	private import TechnicalComponentsPackage::*;
	private import TechnicalPortsPackage::*;
	private import TechnicalIndividualsPackage::*;

	part def ContinentalZIDAShieldOperationSystem :> SystemOfSystems {
		doc /* System of Systems composed of five major logical component categories: (1) Blue Force Tactical Execution (LC-001: Interceptor Aircraft Element), (2) Blue Force Surveillance and Control (LC-002: Airborne Surveillance, LC-003: Ground Airspace Control Network), (3) Blue Force Sustainment (LC-004: Logistics and Forward Operations System), and (4) Red Force Threat (LC-005: Illicit UAS Threat Element). The SoS implements hierarchical command and control with integrated surveillance to detect, class... */
		part interceptorAircraftElement : InterceptorAircraftElement :> constituentSystems;
		part airborneSurveillanceAndControlElement : AirborneSurveillanceAndControlElement :> constituentSystems;
		part groundAirspaceControlNetwork : GroundAirspaceControlNetwork :> constituentSystems;
		part logisticsAndForwardOperationsSystem : LogisticsAndForwardOperationsSystem :> constituentSystems;
	}
}
