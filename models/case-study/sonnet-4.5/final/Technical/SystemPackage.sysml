package SystemPackage {

	private import CoSMAPackage::*;
	private import LogicalComponentsPackage::*;
	private import TechnicalComponentsPackage::*;
	private import TechnicalPortsPackage::*;
	private import TechnicalIndividualsPackage::*;

	part def ContinentalZIDAShieldSystem :> SystemOfSystems {
		doc /* Collaborative System of Systems (SoS) comprising six A-29 Super Tucano interceptor aircraft (baseline or modernized A-29N configuration), E-99M airborne control and early warning platform, DECEA ground surveillance and control network, COMGAP combat logistics sustainment infrastructure, and COMAE command and control authority. Mission objective: deny illicit freedom of action by detecting, tracking, and neutralizing UAS incursions within continental ZIDA before penetration reaches 80 nautical... */
		part interceptorAircraftPlatform : InterceptorAircraftPlatform :> constituentSystems;
		part airborneControlAndEarlyWarningPlatform : AirborneControlAndEarlyWarningPlatform :> constituentSystems;
		part groundSurveillanceAndControlNetwork : GroundSurveillanceAndControlNetwork :> constituentSystems;
		part combatLogisticsSustainmentSystem : CombatLogisticsSustainmentSystem :> constituentSystems;
		part commandAndControlAuthority : CommandAndControlAuthority :> constituentSystems;
	}
}
