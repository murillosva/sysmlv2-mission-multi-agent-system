package OperationsPackage {

	private import CoSMAPackage::*;
	action def DepartMainBase :> Operation {
		doc /* A-29 aircraft take off from SBPV (Porto Velho Air Base) and initiate transit flight at cruise speed toward designated FARP point */
	}
	action def TransitToFARP :> Operation {
		doc /* Aircraft conduct direct-route flight from SBPV to optimized FARP point; landing times and refueling operations at FARP disregarded in simulation */
	}
	action def RepositionToCAPPoint :> Operation {
		doc /* Aircraft depart FARP point and transit at cruise speed to assigned Combat Air Patrol (CAP) point within Area of Interest */
	}
	action def MaintainHoldingOrbit :> Operation {
		doc /* Aircraft arriving before T+153 min maintain holding orbit at CAP point until last aircraft (A-29-6) reaches its CAP point to synchronize mission start */
	}
	action def InitiateAirspacePolicing :> Operation {
		doc /* At T+153 min, all aircraft simultaneously commence Airspace Policing (PEA) posture; ALEVOO surveillance begins */
	}
	action def GenerateIllicitUASIncursion :> Operation {
		doc /* Illicit UAS (multi-rotor or fixed-wing) randomly generated via Monte Carlo simulation; entry point drawn from normal distribution over 23 sectors (28-50) of Amazon border polygon; heading perpendicular to border segment ± 45° variation */
	}
	action def CrossBorderIntoZIDA :> Operation {
		doc /* Illicit UAS crosses Brazilian border into continental ZIDA airspace; flight at sea level; velocity per UAS class (multi-rotor: max 29 m/s; fixed-wing: max 130 m/s) */
	}
	action def DetectUASByE99M :> Operation {
		doc /* E-99M AEW aircraft (PS-890 Erieye radar, S-band) detects illicit UAS through airborne radar; detection idealized (no failures) to isolate A-29 performance analysis */
	}
	action def NotifyInterceptorOfUASPresence :> Operation {
		doc /* E-99M notifies nearest A-29 aircraft on CAP of illicit UAS incursion; engagement exclusivity assigned (one UAS per A-29 at a time) */
	}
	action def VectorInterceptorViaVoice :> Operation {
		doc /* E-99M relays UAS heading information to baseline A-29 via VHF voice communication; update interval: random draw from uniform distribution [5, 60] seconds */
	}
	action def TransmitCoordinatesViaDatalink :> Operation {
		doc /* E-99M transmits geographic coordinates (latitude, longitude) to A-29N via dedicated digital datalink (R&S M3AR MR6000R/L, 30-400 MHz); update interval: random draw from uniform distribution [1, 10] seconds; coordinate transmission latency idealized as instantaneous */
	}
	action def ModifyHeadingTowardUAS :> Operation {
		doc /* A-29 aircraft modifies flight heading toward illicit UAS based on vectoring information received (voice heading for baseline; datalink coordinates for A-29N) */
	}
	action def PerformNakedEyeVisualSearch :> Operation {
		doc /* Baseline A-29 pilot conducts naked-eye visual search for UAS; maximum visual acquisition distance: [0, 7] nmi ≈ [0, 13] km; minimum acquisition and reaction time: 12.5 s; visual angle threshold ideally satisfied by E-99M heading; visible area modifier penalizes multi-rotor UAS (1 m) relative to fixed-wing (14 m) */
	}
	action def CueEOIRSensorToCoordinates :> Operation {
		doc /* A-29N pilot manually enters received coordinates into aircraft system; coordinate reception sensitivity: [1, 10] s (pilot manual entry time); EO/IR sensor (FLIR Star SAFIRE II) cued to search area */
	}
	action def AcquireUASWithEOIRSensor :> Operation {
		doc /* A-29N EO/IR sensor (360° azimuth, +30° to -120° elevation, 60°/s slew rate) scans for UAS; laser rangefinder max range: 20 km; accuracy: 5 m; tracking probability for multi-rotor penalized due to dimension (1 m) vs. sensor accuracy (5 m); fixed-wing tracking unpenalized */
	}
	action def MaintainVisualContactWithUAS :> Operation {
		doc /* Baseline A-29 maintains naked-eye visual contact with UAS; tracking probability decreases linearly with distance from 13 km to 0 km; multi-rotor modifier: 1/14 penalty; tracking verification interval: [5, 60] s per heading update */
	}
	action def MaintainEOIRTrackingLock :> Operation {
		doc /* A-29N maintains continuous EO/IR tracking lock on UAS; tracking probability for fixed-wing: negligible loss; multi-rotor: intermittent losses recovered by datalink coordinate updates; tracking verification interval: [1, 10] s per coordinate update */
	}
	action def EnterWeaponEmploymentEnvelope :> Operation {
		doc /* A-29 closes distance to UAS until within armament employment envelope; baseline: max 2 km (SBAT-70 unguided); A-29N: max 14 km (APKWS laser-guided) or min 2 km (with guidance) / 0.5 km (without guidance) */
	}
	action def DetermineFirePhilosophy :> Operation {
		doc /* Pilot randomly draws firing philosophy: long (max range), medium (midpoint), or short (min range); discrete uniform probability: 1/3 per philosophy */
	}
	action def ExecuteDeterrenceShot :> Operation {
		doc /* Baseline A-29 fires single SBAT-70 unguided rocket at drawn firing distance; hit probability: linear from 80% at 0.5 km to 0% at 2 km; dimensional penalty for multi-rotor: 0.5 */
	}
	action def LaserDesignateUAS :> Operation {
		doc /* A-29N EO/IR sensor performs laser designation of UAS for semi-active laser guidance */
	}
	action def ExecuteAPKWSLaunch :> Operation {
		doc /* A-29N fires single APKWS laser-guided rocket (15.8 kg) at drawn firing distance; hit probability: linear from 80% at 2 km to 0% at 14 km with guidance; dimensional penalty for multi-rotor: 0.5; platform speed at launch: 80-550 KCAS; launch altitude: -200 to 25,000 ft */
	}
	action def AssessNeutralization :> Operation {
		doc /* Stochastic determination of engagement outcome based on hit probability and dimensional penalty; if successful: UAS neutralized; if unsuccessful: engagement failure */
	}
	action def NeutralizeUAS :> Operation {
		doc /* Successful kinetic impact destroys illicit UAS before crossing 80 nmi ZIDA boundary; engagement terminates */
	}
	action def DetectUASEvasion :> Operation {
		doc /* UAS crosses 80 nmi ZIDA boundary into national territory without neutralization; mission failure for that engagement; engagement terminates */
	}
	action def ReturnToCAPPoint :> Operation {
		doc /* After neutralization or evasion, A-29 returns to CAP point to receive new UAS notification for next interception cycle */
	}
	action def ContinueInterceptionCycles :> Operation {
		doc /* A-29 repeats notification → interception → neutralization/evasion → CAP return cycle as long as flight endurance permits and illicit incursions continue */
	}
	action def DepartCAPForFARP :> Operation {
		doc /* A-29 reaches minimum fuel threshold for return leg; terminates PEA; departs CAP point for FARP refueling */
	}
	action def RefuelAtFARP :> Operation {
		doc /* Aircraft conducts refueling at FARP point (operation disregarded in simulation timing) */
	}
	action def RecoverToMainBase :> Operation {
		doc /* Aircraft transits from FARP point to SBPV at cruise speed; mission complete upon arrival */
	}
}
