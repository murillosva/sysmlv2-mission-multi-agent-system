package LogicalComponentsPackage {

	private import CoSMAPackage::*;
	private import FunctionsPackage::*;
	part def InterceptorAircraftElement :> LogicalComponent {
		doc /* Executes tactical interception, pursuit, and kinetic engagement of illicit UAS; operates from forward bases (FARPs) with full fuel and ordnance loads; maintains combat air patrol at designated areas of interest. Represents A-29 platform in both baseline and modernized (A-29N) configurations. */
		perform action departMainOperatingBase : DepartMainOperatingBase;
		perform action conductDirectRouteTransitToFARP : ConductDirectRouteTransitToFARP;
		perform action executeRefuelingAndRearmingAtFARP : ExecuteRefuelingAndRearmingAtFARP;
		perform action repositionFromFARPToCAP : RepositionFromFARPToCAP;
		perform action maintainHoldingOrbitAtCAP : MaintainHoldingOrbitAtCAP;
		perform action returnToFARPAndMainBase : ReturnToFARPAndMainBase;
		perform action acceptTargetAssignmentAndConfirmEngagementReadinessBaseline : AcceptTargetAssignmentAndConfirmEngagementReadinessBaseline;
		perform action acceptTargetCoordinatesAndInitiateSensorSearchModernized : AcceptTargetCoordinatesAndInitiateSensorSearchModernized;
		perform action executeHeadingBasedVisualPursuitBaseline : ExecuteHeadingBasedVisualPursuitBaseline;
		perform action executeDataLinkCueingAndEOIRSensorTrackingModernized : ExecuteDataLinkCueingAndEOIRSensorTrackingModernized;
		perform action achieveVisualContactAndTargetIdentificationBaseline : AchieveVisualContactAndTargetIdentificationBaseline;
		perform action achieveSensorLockAndPositiveIdentificationModernized : AchieveSensorLockAndPositiveIdentificationModernized;
		perform action executeControlledInterceptionApproach : ExecuteControlledInterceptionApproach;
		perform action executeWeaponFiringDecisionAndShotDelivery : ExecuteWeaponFiringDecisionAndShotDelivery;
		perform action assessEngagementOutcome : AssessEngagementOutcome;
		perform action returnToCAPPointAndAwaitNextAssignment : ReturnToCAPPointAndAwaitNextAssignment;
	}
	part def AirborneSurveillanceAndControlElement :> LogicalComponent {
		doc /* Provides airborne radar detection, real-time intelligence data, target cueing via vectoring (voice/datalink), and early warning of low-altitude UAS incursions; complements ground-based radars and fills coverage gaps. Represents E-99M platform serving as command and control node for interception coordination. */
		perform action conductAirborneRadarDetection : ConductAirborneRadarDetection;
		perform action generateSimultaneousAirspacePolicingAuthorization : GenerateSimultaneousAirspacePolicingAuthorization;
		perform action transmitTargetNotificationToInterceptor : TransmitTargetNotificationToInterceptor;
		perform action provideRealTimeVectoringUpdates : ProvideRealTimeVectoringUpdates;
	}
	part def GroundAirspaceControlNetwork :> LogicalComponent {
		doc /* Provides integrated ground-based radar surveillance, airspace surveillance and control (VCEA), command and control infrastructure, and UAS identification through continuous surveillance; central body for airspace management support. Represents DECEA and CINDACTA IV integrated system. */
		perform action conductGroundBasedRadarSurveillance : ConductGroundBasedRadarSurveillance;
		perform action classifyDetectedTargetAsIllicitUAS : ClassifyDetectedTargetAsIllicitUAS;
	}
	part def LogisticsAndForwardOperationsSystem :> LogicalComponent {
		doc /* Manages forward arming and refueling operations; positions interceptor aircraft at optimal combat air patrol points with full fuel and ordnance loads; sustains mission endurance through distributed refueling infrastructure. Represents FARP network, COMGAP, CELOG, and DIRMAB logistics entities. */
		perform action countSuccessfulNeutralizationsAndEvasions : CountSuccessfulNeutralizationsAndEvasions;
		perform action calculateMissionMeasureOfSuccessMOS1 : CalculateMissionMeasureOfSuccessMOS1;
	}
	part def IllicitUASThreatElement :> LogicalComponent {
		doc /* Represents non-cooperative unmanned aerial systems employed for clandestine aerial surveying and logistical support to narcotrafficking. Two archetypes: multi-rotor UAS (1 m × 1 m × 0.63 m, max speed 29 m/s, ceiling 6 km) and fixed-wing UAS (14 m wingspan, max speed 130 m/s, ceiling 18 km). Enters Brazilian airspace across continental ZIDA border with Peru and Colombia; attempts to penetrate 80 nmi boundary. Stochastically generated per Barros model with entry coordinates randomly distributed... */
	}
}
