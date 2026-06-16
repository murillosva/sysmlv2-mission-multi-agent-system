package MissionPackage {

	private import CoSMAPackage::*;
	private import MissionPhasesPackage::*;
	private import CapabilitiesPackage::*;
	private import SystemPackage::*;
	private import FunctionsPackage::*;
	private import ContextPackage::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import SI::*;
	private import ISQ::*;

	part def ContinentalZIDAShieldOperation :> Mission {
		doc /* Hypothetical mission for counter-UAS airspace policing in the Brazilian Amazon border region, designed to detect, identify, track, and neutralize illicit unmanned aerial systems (UAS) employed for narcotrafficking support before they cross the 80-nautical-mile continental ZIDA (Zona de Interesse de Defesa Aérea) boundary. The mission integrates Forward Arming and Refueling Point (FARP) logistics, airborne early warning (E-99M CAV), and ground-based air defense control (DECEA, CINDACTA IV) to ... */

		part continentalZIDAShieldOperationSystem : ContinentalZIDAShieldOperationSystem :> system;
		part continentalZIDAShieldOperation : ContinentalZIDAShieldOperation :> context;

		perform action conductContinentalZIDAShieldOperation : ConductContinentalZIDAShieldOperation;
		requirement conductAerospaceControlOfContinentalZIDA : Goal {
			doc /* Achieve dominance of the airspace and space of interest (continental ZIDA) and deny such dominance to illicit operators, ensuring protection and freedom of action for friendly forces through integrated air defense operations. */
		} :> goals;
		requirement executeAirspacePolicing : Goal {
			doc /* Employ aerospace means to detect, identify, track, and neutralize illicit air traffic (specifically multi-rotor and fixed-wing UAS) within the designated Areas of Interest during the operational campaign, protecting the continental ZIDA boundary. */
		} :> goals;
		requirement provideAirborneControlAndEarlyWarningSupport : Goal {
			doc /* Employ E-99M airborne control and early warning aircraft to detect, identify, and provide early warning of UAS incursions, complementing ground-based DECEA systems by filling radar coverage gaps and enhancing low-altitude detection. */
		} :> goals;
		requirement maintainAirspaceSurveillanceAndControl : Goal {
			doc /* Employ ground and airborne Air Force means (DECEA radars and E-99M) to detect, identify, track, and control aircraft within the airspace of interest, preserving sovereignty and air traffic safety. */
		} :> goals;
		requirement sustainCombatOperationsAtExtendedRange : Goal {
			doc /* Provide Combat Sustainment through Forward Arming and Refueling Points (FARPs), logistical support infrastructure, and services to sustain air operations and extend the combat power of friendly forces in the remote Area of Operations, maximizing time on station and rapid response capability. */
		} :> goals;
		requirement assessModernizationImpactOnMissionEffectiveness : Goal {
			doc /* Investigate and measure the operational and tactical gains afforded by the integration of new counter-UAS (C-UAS) capabilities (datalink, EO/IR sensor, laser-guided rockets) into the A-29 Super Tucano platform compared to baseline configuration, informing capability development decisions. */
		} :> goals;
		part aerospaceControl : AerospaceControl :> requiredCapabilites;
		part combatSustainment : CombatSustainment :> requiredCapabilites;
		part airborneAlert : AirborneAlert :> requiredCapabilites;
		part airspacePolicing : AirspacePolicing :> requiredCapabilites;
		part airborneControlAndEarlyWarning : AirborneControlAndEarlyWarning :> requiredCapabilites;
		part airspaceSurveillanceAndControl : AirspaceSurveillanceAndControl :> requiredCapabilites;
		part counterUASEngagement : CounterUASEngagement :> requiredCapabilites;
		part multiRotorUASDetectionAndNeutralization : MultiRotorUASDetectionAndNeutralization :> requiredCapabilites;
		part fixedWingUASDetectionAndNeutralization : FixedWingUASDetectionAndNeutralization :> requiredCapabilites;
		part a29BaselineInterception : A29BaselineInterception :> requiredCapabilites;
		part a29NModernizedInterception : A29NModernizedInterception :> requiredCapabilites;
		connection : CapabilityToGoalDerivation {
			end capa :>> aerospaceControl;
			end goal :>> conductAerospaceControlOfContinentalZIDA;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> combatSustainment;
			end goal :>> sustainCombatOperationsAtExtendedRange;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> airborneAlert;
			end goal :>> executeAirspacePolicing;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> airspacePolicing;
			end goal :>> executeAirspacePolicing;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> airborneControlAndEarlyWarning;
			end goal1 :>> provideAirborneControlAndEarlyWarningSupport;
			end goal2 :>> maintainAirspaceSurveillanceAndControl;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> airspaceSurveillanceAndControl;
			end goal :>> maintainAirspaceSurveillanceAndControl;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> counterUASEngagement;
			end goal1 :>> executeAirspacePolicing;
			end goal2 :>> assessModernizationImpactOnMissionEffectiveness;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> multiRotorUASDetectionAndNeutralization;
			end goal1 :>> executeAirspacePolicing;
			end goal2 :>> assessModernizationImpactOnMissionEffectiveness;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> fixedWingUASDetectionAndNeutralization;
			end goal1 :>> executeAirspacePolicing;
			end goal2 :>> assessModernizationImpactOnMissionEffectiveness;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> a29BaselineInterception;
			end goal :>> executeAirspacePolicing;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> a29NModernizedInterception;
			end goal1 :>> executeAirspacePolicing;
			end goal2 :>> assessModernizationImpactOnMissionEffectiveness;
		} :> capabilityToGoals;

		exhibit state continentalZIDAShieldOperationPhases {

			state initial : Initial;
			state aircraftDepartureFromMainBase : AircraftDepartureFromMainBase;
			state transitToForwardArmingAndRefuelingPoint : TransitToForwardArmingAndRefuelingPoint;
			state refuelingAndRearmingAtFARP : RefuelingAndRearmingAtFARP;
			state repositioningFromFARPToCombatAirPatrolPoint : RepositioningFromFARPToCombatAirPatrolPoint;
			state holdingOrbitAtCAPPoint : HoldingOrbitAtCAPPoint;
			state airspacePolicing : AirspacePolicing;
			state returnTransitFromCAPPointToFARP : ReturnTransitFromCAPPointToFARP;
			state recoveryTransitFromFARPToMainBase : RecoveryTransitFromFARPToMainBase;
			state final : MissionComplete;

			transition first initial then aircraftDepartureFromMainBase;
			transition first aircraftDepartureFromMainBase accept AircraftDepartureFromMainBaseCompletedNotification then transitToForwardArmingAndRefuelingPoint {
				doc /* if "All A-29 aircraft have departed SBPV and are airborne en route to FARP" */
			}
			transition first transitToForwardArmingAndRefuelingPoint accept TransitToForwardArmingAndRefuelingPointCompletedNotification then refuelingAndRearmingAtFARP {
				doc /* if "Aircraft arrive at designated FARP point and begin descent to landing pattern" */
			}
			transition first refuelingAndRearmingAtFARP accept RefuelingAndRearmingAtFARPCompletedNotification then repositioningFromFARPToCombatAirPatrolPoint {
				doc /* if "Aircraft complete refueling, rearming, and preflight checks; crew signals readiness for departure" */
			}
			transition first repositioningFromFARPToCombatAirPatrolPoint accept RepositioningFromFARPToCombatAirPatrolPointCompletedNotification then holdingOrbitAtCAPPoint {
				doc /* if "Aircraft reach assigned CAP point and initiate holding orbit at designated altitude" */
			}
			transition first holdingOrbitAtCAPPoint accept HoldingOrbitAtCAPPointCompletedNotification then airspacePolicing {
				doc /* if "T+153 min milestone reached; last aircraft (A-29-6) arrives at CAP point; simultaneous commencement authorization for Phase 6 issued by CINDACTA IV" */
			}
			transition first airspacePolicing accept AirspacePolicingCompletedNotification then returnTransitFromCAPPointToFARP {
				doc /* if "Any of: (1) Aircraft fuel endurance exhausted below minimum reserve for recovery transit to FARP; (2) Aircraft achieves maximum PEA window per fuel calculation; (3) All detectable UAS incursions within AoI neutralized or evaded" */
			}
			transition first returnTransitFromCAPPointToFARP accept ReturnTransitFromCAPPointToFARPCompletedNotification then recoveryTransitFromFARPToMainBase {
				doc /* if "Aircraft land safely at designated FARP point; maintain minimum fuel reserve above bingo fuel threshold" */
			}
			transition first recoveryTransitFromFARPToMainBase accept RecoveryTransitFromFARPToMainBaseCompletedNotification then final {
				doc /* if "Aircraft land safely at SBPV; secure parking; crew debriefs complete; mission phase termination" */
			}
		} :>> phases;
	}
}
