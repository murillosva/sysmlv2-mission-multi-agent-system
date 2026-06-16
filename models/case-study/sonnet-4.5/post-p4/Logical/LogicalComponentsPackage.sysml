package LogicalComponentsPackage {

	private import CoSMAPackage::*;
	private import FunctionsPackage::*;
	part def InterceptorAircraftPlatform :> LogicalComponent {
		doc /* Air defense platform responsible for airspace policing, interception, and kinetic engagement of illicit UAS within assigned Areas of Interest; conducts forward operations through FARP logistics. Includes both baseline A-29 and modernized A-29N configurations. */
		perform action transitFromMainBaseToFARP : TransitFromMainBaseToFARP;
		perform action repositionFromFARPToCAP : RepositionFromFARPToCAP;
		perform action maintainHoldingOrbitAtCAP : MaintainHoldingOrbitAtCAP;
		perform action refuelAtFARP : RefuelAtFARP;
		perform action recoverToMainBase : RecoverToMainBase;
		perform action initiateAirspacePolicing : InitiateAirspacePolicing;
		perform action modifyHeadingTowardUAS : ModifyHeadingTowardUAS;
		perform action acquireUASVisually : AcquireUASVisually;
		perform action cueEOIRSensorToCoordinates : CueEOIRSensorToCoordinates;
		perform action acquireUASWithEOIRSensor : AcquireUASWithEOIRSensor;
		perform action maintainVisualTrackingOfUAS : MaintainVisualTrackingOfUAS;
		perform action maintainEOIRTrackingLock : MaintainEOIRTrackingLock;
		perform action enterWeaponEmploymentEnvelope : EnterWeaponEmploymentEnvelope;
		perform action determineFiringPhilosophy : DetermineFiringPhilosophy;
		perform action executeSBAT70UnguiedRocket : ExecuteSBAT70UnguiedRocket;
		perform action designateUASWithLaser : DesignateUASWithLaser;
		perform action executeAPKWSLaserGuidedRocket : ExecuteAPKWSLaserGuidedRocket;
		perform action assessEngagementOutcome : AssessEngagementOutcome;
		perform action neutralizeUAS : NeutralizeUAS;
		perform action detectUASEvasion : DetectUASEvasion;
		perform action returnToCAPAfterEngagement : ReturnToCAPAfterEngagement;
		perform action continueInterceptionCycles : ContinueInterceptionCycles;
		perform action departCAPForFARP : DepartCAPForFARP;
	}
	part def AirborneControlAndEarlyWarningPlatform :> LogicalComponent {
		doc /* Aerospace surveillance and control platform providing detection, tracking, and vectoring support to interceptor aircraft through radar surveillance and real-time coordination. E-99M aircraft equipped with PS-890 Erieye S-band radar. */
		perform action detectIllicitUASWithAirborneRadar : DetectIllicitUASWithAirborneRadar;
		perform action assignInterceptorToUASTarget : AssignInterceptorToUASTarget;
		perform action transmitVectoringInformationViaVoice : TransmitVectoringInformationViaVoice;
		perform action transmitCueingCoordinatesViaDatalink : TransmitCueingCoordinatesViaDatalink;
	}
	part def GroundSurveillanceAndControlNetwork :> LogicalComponent {
		doc /* Ground-based airspace surveillance and control infrastructure responsible for continuous monitoring of continental ZIDA and coordination of air defense assets. Operated by DECEA and CINDACTA IV regional center. */
	}
	part def IllicitUASThreatEntity :> LogicalComponent {
		doc /* Non-cooperative unmanned aerial platform conducting cross-border clandestine aerial surveying and logistical support to illicit activities; comprises multi-rotor and fixed-wing variants originating from Amazon border regions (Peru and Colombia). */
		perform action generateIllicitUASIncursion : GenerateIllicitUASIncursion;
		perform action crossBorderIntoZIDA : CrossBorderIntoZIDA;
	}
	part def CombatLogisticsSustainmentSystem :> LogicalComponent {
		doc /* Logistics infrastructure providing aeronautical, ordnance, structural, and patrimonial materiel support; enables forward arming and refueling operations at FARP points. Operated by COMGAP, CELOG, and DIRMAB. */
	}
	part def CommandAndControlAuthority :> LogicalComponent {
		doc /* Strategic-operational command body responsible for mission planning, rules of engagement definition, and tactical coordination of aerospace defense operations. Aerospace Operations Command (COMAE) serves as central body of SISDABRA. */
		perform action calculateNeutralizationRate : CalculateNeutralizationRate;
	}
}
