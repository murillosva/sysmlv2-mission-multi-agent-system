package OperationsPackage {

	private import CoSMAPackage::*;
	action def ExecuteAircraftTakeoffSequenceFromSBPV :> Operation {
		doc /* Aircrew conduct pre-flight checks; initiate engine start procedures; request air traffic clearance from SBPV tower; taxi to active runway; execute takeoff roll and rotate to flight attitude; establish climb-out profile toward FARP routing. */
	}
	action def ConductDirectRouteTransitToFARP :> Operation {
		doc /* Aircraft maintain cruise flight at 280 KCAS (≈144 m/s) along Haversine shortest-path routing from SBPV to assigned FARP point; monitor fuel burn and reserve calculation; maintain VHF/UHF radio contact with CINDACTA IV and FARP ground personnel; establish navigation checkpoint tracking. */
	}
	action def ConductRefuelingAndRearmingOperationsAtFARP :> Operation {
		doc /* A-29 aircraft land at designated FARP point; FARP ground crew initiate fuel servicing (refueling with external tank configuration per aircraft endurance requirement); ordnance crew load unguided SBAT-70 rockets (baseline config) or integrate APKWS laser-guided kit (A-29N config) into weapon pylons; conduct post-service preflight inspections; crew conduct brief or rest as required. Note: This phase duration is disregarded in simulation modeling per §2.2.1. */
	}
	action def RepositionFromFARPToAssignedCAPPoint :> Operation {
		doc /* Aircraft depart FARP with full fuel load and ordnance; maintain cruise speed (280 KCAS) and direct routing to assigned CAP point within one of six Areas of Interest; establish climb-out profile to CAP point patrol altitude (sea-level flight assumed in simulation per §2.2.2); coordinate airspace entry with E-99M and CINDACTA IV; prepare to assume ALEVOO (airborne alert) posture upon arrival. */
	}
	action def MaintainHoldingOrbitAtCAPPoint :> Operation {
		doc /* A-29 aircraft enter racetrack holding pattern at designated CAP point altitude; monitor E-99M surveillance picture and CINDACTA IV communications for target notifications; maintain high readiness posture for rapid scramble to intercept illicit UAS; perform gentle orbit maneuvers to conserve fuel while remaining responsive; conduct heads-up systems checks and weapons readiness verification. Aircraft arriving before T+153 min milestone remain in orbit awaiting simultaneous PEA phase commencement. */
	}
	action def InitiateSimultaneousAirspacePolicing :> Operation {
		doc /* At T+153 min mission milestone, CINDACTA IV issues concurrent authorization to all six A-29 aircraft to transition from holding orbit to active Airspace Policing posture; E-99M radar and DECEA ground surveillance begin continuous scanning of six Areas of Interest for illicit UAS incursions; A-29 aircraft heighten situational awareness and prepare to execute intercept procedures upon first target notification. */
	}
	action def DetectIllicitUASIncursion :> Operation {
		doc /* E-99M airborne early warning radar or DECEA ground-based radar detects non-cooperative air target crossing Brazilian border within one of six Areas of Interest; radar track established with initial geographic position, heading, and velocity parameters; target classified as illicit UAS based on flight profile (low altitude, slow speed, small RCS). Stochastic target generation per Barros (2025) methodology yields entry coordinate from normal distribution across sectors 28–50 of border polygon; ... */
	}
	action def TransmitTargetNotificationToCAP :> Operation {
		doc /* Upon UAS detection by E-99M/DECEA, CINDACTA IV routes target data to A-29 assigned to geographic area containing incursion; transmission format differs by configuration: (1) Baseline A-29: vectoring heading (magnetic azimuth) relayed via VHF voice communication at intervals of [5, 60] seconds drawn from continuous uniform distribution; (2) A-29N: geographic target coordinate (latitude/longitude) relayed via datalink at intervals of [1, 10] seconds. Initial notification includes threat classif... */
	}
	action def AcceptTargetAssignmentAndInitiateInterceptionBaseline :> Operation {
		doc /* A-29 baseline pilot receives heading vector from E-99M via radio; acknowledges target assignment and engagement clearance (TDE authorization); modifies aircraft heading toward provided vector; initiates climb to optimal interception geometry; transitions from holding orbit to active pursuit of target. A-29 gains exclusive engagement responsibility within assigned Area of Interest; no other A-29 will be assigned targets within this area until interception concludes. */
	}
	action def AcceptTargetAssignmentAndInitiateInterceptionModernized :> Operation {
		doc /* A-29N pilot receives target coordinate (latitude/longitude) via datalink from E-99M; acknowledges target assignment and engagement clearance (TDE authorization); enters coordinate into navigation system (with manual entry reaction time hypothesis of [1, 10] seconds per pilot cognitive workload); aircraft autopilot (if equipped) or manual control adjusts heading toward target vicinity; initiates climb to optimal interception geometry; transitions from holding orbit to active pursuit. A-29N gai... */
	}
	action def NavigateToTargetVicinityUnderHeadingGuidanceBaseline :> Operation {
		doc /* A-29 baseline aircraft navigate toward UAS using series of heading updates provided by E-99M voice vectoring at [5, 60] second intervals; pilot manually adjust aircraft heading in response to each new heading instruction; aircraft climb to altitude above target (sea-level flight assumed in simulation); maintain cruise speed (280 KCAS) unless tactical geometry requires speed adjustment. Accumulated positional error accumulates with increasing heading update intervals; longer update intervals d... */
	}
	action def NavigateToTargetVicinityUnderDatalink :> Operation {
		doc /* A-29N aircraft navigate toward target using series of geographic coordinates provided via datalink at [1, 10] second intervals; autopilot (if equipped) or pilot manually updates routing waypoint with each new coordinate; aircraft climb to altitude above target (sea-level flight assumed); maintain cruise speed (280 KCAS) unless tactical geometry requires adjustment. Shorter update intervals ([1, 10] s vs. baseline [5, 60] s) reduce accumulated positional error; continuous coordinate refreshes ... */
	}
	action def EstablishVisualAcquisitionOfTargetBaseline :> Operation {
		doc /* A-29 baseline pilot searches forward quadrant for visual contact with UAS target; maximum visual acquisition distance is 13 km (from modeling hypothesis per Woo et al. 2020 and FAB specialist experience); pilot applies visual scan technique to locate small target against jungle background; target dimension visibility is penalized for multi-rotor UAS (1 m dimension): penalization factor = 1/14 (ratio of multi-rotor to fixed-wing dimension); fixed-wing UAS (14 m dimension) is visually acquired ... */
	}
	action def AcquireTargetViaEOIRSensor :> Operation {
		doc /* A-29N weapons systems officer activates onboard EO/IR sensor (FLIR Star SAFIRE II equivalent); sensor autonomously scans field-of-regard based on datalink-provided target coordinates; laser rangefinder establishes positive range measurement (maximum 20 km range, 5 m accuracy per Table 7); EO/IR sensor tracks target autonomously with 60°/s slew rate capability. Multi-rotor targets (1 m dimension) may experience intermittent tracking loss if target size is smaller than sensor accuracy (5 m), ca... */
	}
	action def DesignateTargetWithLaser :> Operation {
		doc /* A-29N weapons systems officer directs EO/IR sensor laser designator onto UAS target; laser spot established at target center-of-mass (for guidance kit seeker acquisition); maintain continuous laser illumination throughout weapon employment envelope ([2, 14] km range). Laser designation provides semi-active guidance signal for laser-guided APKWS rockets. Operator maintains uninterrupted visual/sensor contact with target throughout engagement; laser tracking accuracy is directly tied to laser r... */
	}
	action def TrackTargetDuringInterceptionBaseline :> Operation {
		doc /* A-29 baseline pilot maintains heading guidance from E-99M and visual search for target during approach phase; active tracking probability decays linearly with distance per Equation (12): P_track,B(d_k) = (1 − d_k/d_max) × M, where d_max = 13 km and M = visible area modifier (1.0 for fixed-wing, 1/14 for multi-rotor). Tracking probability = 0 if distance exceeds 13 km or if pilot loses visual contact. Update interval dependency: shorter E-99M heading update intervals ([5, 20] s representative)... */
	}
	action def TrackTargetDuringInterceptionModernized :> Operation {
		doc /* A-29N weapons systems officer maintains target lock via EO/IR sensor and laser rangefinder during approach phase; active tracking probability depends on ratio of UAS dimension to sensor accuracy per Equation (15): P_track,M(d_k) = min(1, c_UAS / a_EO/IR), valid for [14 < d_k ≤ 20] km. Fixed-wing targets (14 m) achieve tracking probability = 1.0 (continuous lock). Multi-rotor targets (1 m) achieve tracking probability = 1/5 ≈ 0.2 at long range; tracking loss probability increases if UAS maneuv... */
	}
	action def EstablishFiringGeometryAndWeaponsReady :> Operation {
		doc /* A-29 aircraft (baseline or modernized) maneuver to achieve optimal firing geometry: closing distance to target within maximum employment range of configured weapons (2 km baseline SBAT-70; 2–14 km A-29N APKWS); establish stable flight attitude suitable for rocket launch (wings level or slight bank); verify weapons system status and ordnance readiness (safety pins removed, fuzing verified, launch parameters entered into flight control system if equipped). Pilot/WSO confirm target is within eng... */
	}
	action def ExecuteWeaponsFireBaselineUnguidedSBAT70 :> Operation {
		doc /* A-29 baseline pilot selects firing distance philosophy (short = 0.5 km, medium = 1.25 km, long = 2.0 km) via discrete uniform probability draw (1/3 probability each); positions aircraft to achieve selected firing distance; acquires target visually via naked-eye scan or helmet-mounted sight (if equipped); announces 'RIFLE' (weapons away) and presses firing trigger; unguided SBAT-70 rocket launches from pod, ignites solid propellant motor, follows ballistic trajectory toward target. Rocket guid... */
	}
	action def ExecuteWeaponsFireModernizedLaserGuidedAPKWS :> Operation {
		doc /* A-29N weapons systems officer selects firing distance philosophy (short = 2 km, medium = 8 km, long = 14 km) via discrete uniform probability draw (1/3 probability each); positions aircraft to achieve selected firing distance within [2, 14] km APKWS employment envelope; maintains laser designation on target via EO/IR sensor laser illuminator; announces 'RIFLE' (weapons away) and presses firing trigger; APKWS laser-guided rocket launches from pod, ignites solid propellant motor, acquires laser... */
	}
	action def AssessWeaponsImpactAndTargetStatus :> Operation {
		doc /* A-29 aircraft (baseline or modernized) maintains visual/sensor observation of target impact area post-firing; assess whether UAS has been neutralized (destroyed, no longer transmitting, no longer maneuvering) or whether UAS has sustained damage but remains airborne and mobile. Determine engagement outcome: (1) Neutralization: UAS destroyed or incapacitated, no longer poses threat to continental ZIDA; (2) Evasion: UAS sustained flight after engagement attempt, continues penetrating toward inte... */
	}
	action def ReturnToCAPPointNeutralizationSuccess :> Operation {
		doc /* A-29 aircraft complete engagement against illicit UAS; assess neutralization successful; aircraft modify heading back toward assigned CAP point; reestablish holding orbit at CAP point altitude; replenish situational awareness from E-99M/DECEA surveillance picture; reset weapons system to ready state and prepare for next target notification. Time interval from engagement termination to CAP point recovery depends on range between engagement location and CAP point; assumes aircraft return at cru... */
	}
	action def DeclareTargetEvaluatedAndReturnToCAPPoint :> Operation {
		doc /* A-29 aircraft engaged illicit UAS; target sustained flight and crossed geographic boundary of assigned Area of Interest (either laterally into neighboring AoI or penetrated beyond 80 nmi continental ZIDA boundary); declare engagement as 'evasion' (mission failure for that specific target). Aircraft modify heading to return to assigned CAP point; reestablish holding orbit; reset weapons system; await next target notification. Evasion is recorded as metric failure for mission success calculatio... */
	}
	action def ContinuouslyMonitorFuelStateAndCalculateMinimumReserve :> Operation {
		doc /* Throughout Phase 6 (PEA) operational conduct, A-29 aircraft continuously monitor fuel quantity via fuel management system; pilot calculates available endurance remaining and determines 'bingo fuel' state (minimum fuel required to reach designated FARP point with safety reserve). Time-available-for-policing calculation (T_PEA, per Equation 8): T_PEA,k = (R − 2 × d_FARP,CAP / v), where R = 5.2 h maximum endurance, d_FARP,CAP = Haversine distance between FARP and CAP point, v = 144 m/s cruise sp... */
	}
	action def TransitionFromAirspacePoliceToRecoveryPhaseFuelConstraint :> Operation {
		doc /* A-29 aircraft fuel state reaches bingo threshold; pilot receives CINDACTA IV recovery directive or initiates self-directed recovery per fuel state; aircraft modify heading from CAP point toward assigned FARP point; disengage from active Airspace Policing posture; establish descent profile toward FARP landing pattern altitude. */
	}
	action def ConductDirectRouteTransitFromCAPPointToFARP :> Operation {
		doc /* A-29 aircraft depart CAP point vicinity; maintain direct routing to assigned FARP point using Haversine shortest-path navigation; maintain cruise speed (280 KCAS) or accelerate to fuel-efficient speed profile if fuel state warrants; monitor VHF/UHF communications with FARP ground personnel for recovery coordination; prepare aircraft and crew for landing. */
	}
	action def ConductLandingAndRecoveryAtFARP :> Operation {
		doc /* A-29 aircraft descend to FARP landing pattern altitude; coordinate with FARP air traffic control (if equipped) or ground personnel; request landing clearance; execute landing approach; touchdown and taxi to parking area; conduct post-flight debriefs and secure aircraft for next sortie cycle if required. */
	}
}
