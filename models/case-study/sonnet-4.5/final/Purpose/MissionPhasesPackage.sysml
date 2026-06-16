package MissionPhasesPackage {

	private import CoSMAPackage::*;
	private import OperationsPackage::*;

	// --- Item Definitions (Completion Notifications) ---
	item def TransitToFARPCompletedNotification;
	item def FARPToCAPRepositioningCompletedNotification;
	item def CAPHoldingOrbitCompletedNotification;
	item def AirspacePolicingCompletedNotification;
	item def CAPToFARPReturnCompletedNotification;
	item def FARPToBaseRecoveryCompletedNotification;

	// --- State Definitions ---
	state def TransitToFARP :> Phase {
		do action transitToFARPOperations {
			first start;
			then action departMainBase : DepartMainBase;
			then action transitToFARP : TransitToFARP;
			then done;
		}
	}
	state def FARPToCAPRepositioning :> Phase {
		do action farpToCAPRepositioningOperations {
			first start;
			then action repositionToCAPPoint : RepositionToCAPPoint;
			then done;
		}
	}
	state def CAPHoldingOrbit :> Phase {
		do action capHoldingOrbitOperations {
			first start;
			then action maintainHoldingOrbit : MaintainHoldingOrbit;
			then done;
		}
	}
	state def AirspacePolicing :> Phase {
		do action airspacePolicingOperations {
			first start;
			then action initiateAirspacePolicing : InitiateAirspacePolicing;
			then action generateIllicitUASIncursion : GenerateIllicitUASIncursion;
			then action crossBorderIntoZIDA : CrossBorderIntoZIDA;
			then action detectUASByE99M : DetectUASByE99M;
			then action notifyInterceptorOfUASPresence : NotifyInterceptorOfUASPresence;
			then action vectorInterceptorViaVoice : VectorInterceptorViaVoice;
			then action transmitCoordinatesViaDatalink : TransmitCoordinatesViaDatalink;
			then action modifyHeadingTowardUAS : ModifyHeadingTowardUAS;
			then action performNakedEyeVisualSearch : PerformNakedEyeVisualSearch;
			then action cueEOIRSensorToCoordinates : CueEOIRSensorToCoordinates;
			then action acquireUASWithEOIRSensor : AcquireUASWithEOIRSensor;
			then action maintainVisualContactWithUAS : MaintainVisualContactWithUAS;
			then action maintainEOIRTrackingLock : MaintainEOIRTrackingLock;
			then action enterWeaponEmploymentEnvelope : EnterWeaponEmploymentEnvelope;
			then action determineFirePhilosophy : DetermineFirePhilosophy;
			then action executeDeterrenceShot : ExecuteDeterrenceShot;
			then action laserDesignateUAS : LaserDesignateUAS;
			then action executeAPKWSLaunch : ExecuteAPKWSLaunch;
			then action assessNeutralization : AssessNeutralization;
			then action neutralizeUAS : NeutralizeUAS;
			then action detectUASEvasion : DetectUASEvasion;
			then action returnToCAPPoint : ReturnToCAPPoint;
			then action continueInterceptionCycles : ContinueInterceptionCycles;
			then done;
		}
	}
	state def CAPToFARPReturn :> Phase {
		do action capToFARPReturnOperations {
			first start;
			then action departCAPForFARP : DepartCAPForFARP;
			then action refuelAtFARP : RefuelAtFARP;
			then done;
		}
	}
	state def FARPToBaseRecovery :> Phase {
		do action farpToBaseRecoveryOperations {
			first start;
			then action recoverToMainBase : RecoverToMainBase;
			then done;
		}
	}

	// Special states
	state def Initial;
	state def MissionComplete;
}
