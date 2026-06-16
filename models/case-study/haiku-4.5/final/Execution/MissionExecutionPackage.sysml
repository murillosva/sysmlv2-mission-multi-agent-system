package MissionExecutionPackage {

	private import SI::*;
	private import ISQ::*;
	private import Time::*;
	private import ScalarValues::*;
	private import MissionPackage::*;
	private import FunctionsPackage::*;
	private import SystemPackage::*;
	private import LogicalComponentsPackage::*;
	private import ContextPackage::*;
	private import OccurrenceFunctions::*;
	private import TechnicalComponentsPackage::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import CoSMAPackage::*;

	individual part def ContinentalZIDAShieldOperationIndividual :> ContinentalZIDAShieldOperation {
		attribute neutralizationRate : ScalarValues::Real;
		attribute evasionReductionRate : ScalarValues::Real;
	}

	individual part continentalZIDAShieldOperationIndividual : ContinentalZIDAShieldOperationIndividual {
		doc /* A timeline representing the key events of the Continental ZIDA Shield Operation mission. */
		
		timeslice aircraftDepartureFromMainBaseExecution {
			doc /* Timeslice covering the Aircraft Departure from Main Base phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.aircraftDepartureFromMainBase) }
			
			snapshot atTakeoffInitiation {
				doc /* Aircraft begins takeoff sequence from main operating base. */
				attribute missionTime :> ISQ::time = 0 ['s'];
				attribute systemStatus : ScalarValues::String = "Takeoff sequence initiated";
			}
			
			snapshot atLiftOff {
				doc /* Aircraft achieves liftoff and transitions to climb phase. */
				attribute missionTime :> ISQ::time = 180 ['s'];
				attribute altitude :> ISQ::length = 500 [m];
				attribute speed :> ISQ::speed = 150 [kn];
				attribute systemStatus : ScalarValues::String = "Aircraft airborne, climbing to cruise altitude";
			}
		}
		
		then timeslice transitToForwardArmingAndRefuelingPointExecution {
			doc /* Timeslice covering the Transit to Forward Arming and Refueling Point (FARP) phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.transitToForwardArmingAndRefuelingPoint) }
			
			snapshot atCruiseAltitude {
				doc /* Aircraft reaches cruise altitude and maintains heading to FARP. */
				attribute missionTime :> ISQ::time = 900 ['s'];
				attribute altitude :> ISQ::length = 3000 [m];
				attribute speed :> ISQ::speed = 280 [kn];
				attribute systemStatus : ScalarValues::String = "En route to FARP, cruise flight";
			}
			
			snapshot atFARPApproach {
				doc /* Aircraft approaches FARP and begins descent. */
				attribute missionTime :> ISQ::time = 3600 ['s'];
				attribute altitude :> ISQ::length = 1500 [m];
				attribute speed :> ISQ::speed = 200 [kn];
				attribute systemStatus : ScalarValues::String = "Approaching FARP, initiating descent";
			}
		}
		
		then timeslice refuelingAndRearmingAtFARPExecution {
			doc /* Timeslice covering the Refueling and Rearming at FARP phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.refuelingAndRearmingAtFARP) }
			
			snapshot atFARPArrival {
				doc /* Aircraft lands at FARP, fuel and weapons status assessed. */
				attribute missionTime :> ISQ::time = 3900 ['s'];
				attribute altitude :> ISQ::length = 0 [m];
				attribute systemStatus : ScalarValues::String = "Landed at FARP, ground crew briefed";
			}
			
			snapshot atRefuelingComplete {
				doc /* Refueling and rearming operations completed at FARP. */
				attribute missionTime :> ISQ::time = 5400 ['s'];
				attribute fuelStatus : ScalarValues::String = "Tanks refilled";
				attribute weaponsStatus : ScalarValues::String = "Reloaded with SBAR or APKWS";
				attribute systemStatus : ScalarValues::String = "Refueling and rearming complete";
			}
		}
		
		then timeslice repositioningFromFARPToCombatAirPatrolPointExecution {
			doc /* Timeslice covering the Repositioning from FARP to Combat Air Patrol (CAP) Point phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.repositioningFromFARPToCombatAirPatrolPoint) }
			
			snapshot atFARPDeparture {
				doc /* Aircraft departs FARP and climbs to CAP altitude. */
				attribute missionTime :> ISQ::time = 5700 ['s'];
				attribute altitude :> ISQ::length = 500 [m];
				attribute speed :> ISQ::speed = 180 [kn];
				attribute systemStatus : ScalarValues::String = "Takeoff from FARP, repositioning to CAP";
			}
			
			snapshot atCAPPointArrival {
				doc /* Aircraft arrives at assigned CAP point and establishes holding pattern. */
				attribute missionTime :> ISQ::time = 7200 ['s'];
				attribute altitude :> ISQ::length = 4000 [m];
				attribute speed :> ISQ::speed = 250 [kn];
				attribute systemStatus : ScalarValues::String = "Arrived at CAP point, establishing orbit";
			}
		}
		
		then timeslice holdingOrbitAtCAPPointExecution {
			doc /* Timeslice covering the Holding Orbit at CAP Point (Pre-Policing Standby) phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.holdingOrbitAtCAPPoint) }
			
			snapshot atHoldingPatternStart {
				doc /* Aircraft enters holding pattern at CAP, sensors monitoring airspace. */
				attribute missionTime :> ISQ::time = 7200 ['s'];
				attribute altitude :> ISQ::length = 4000 [m];
				attribute speed :> ISQ::speed = 220 [kn];
				attribute systemStatus : ScalarValues::String = "In holding pattern, sensors active";
			}
			
			snapshot atHoldingPatternMidpoint {
				doc /* Aircraft maintains holding orbit, continuous surveillance ongoing. */
				attribute missionTime :> ISQ::time = 10800 ['s'];
				attribute altitude :> ISQ::length = 4000 [m];
				attribute speed :> ISQ::speed = 220 [kn];
				attribute systemStatus : ScalarValues::String = "Maintaining CAP orbit, standby for target assignment";
			}
		}
		
		then timeslice airspacePolicingExecution {
			doc /* Timeslice covering the Airspace Policing (PEA) — Active UAS Interception and Engagement phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.airspacePolicing) }
			
			snapshot atTargetDetection {
				doc /* Illicit UAS incursion detected by ground or airborne radar. */
				attribute missionTime :> ISQ::time = 14400 ['s'];
				attribute targetBearing : ScalarValues::Real = 045.0;
				attribute targetAltitude :> ISQ::length = 500 [m];
				attribute systemStatus : ScalarValues::String = "UAS target detected and classified";
			}
			
			snapshot atTargetAssignment {
				doc /* Target notification transmitted to interceptor aircraft, vector provided. */
				attribute missionTime :> ISQ::time = 14500 ['s'];
				attribute targetRange :> ISQ::length = 25 [km];
				attribute systemStatus : ScalarValues::String = "Target assigned, vector to intercept transmitted";
			}
			
			snapshot atInterceptionInitiation {
				doc /* Interceptor aircraft accepts target assignment and initiates pursuit. */
				attribute missionTime :> ISQ::time = 14700 ['s'];
				attribute altitude :> ISQ::length = 4000 [m];
				attribute speed :> ISQ::speed = 420 [kn];
				attribute systemStatus : ScalarValues::String = "Intercept initiated, heading to target";
			}
			
			snapshot atVisualAcquisition {
				doc /* Interceptor achieves visual contact with target UAS. */
				attribute missionTime :> ISQ::time = 15300 ['s'];
				attribute targetRange :> ISQ::length = 3 [km];
				attribute systemStatus : ScalarValues::String = "Visual contact established, target identified";
			}
			
			snapshot atFiringGeometry {
				doc /* Interceptor aircraft establishes firing geometry and weapon ready. */
				attribute missionTime :> ISQ::time = 15600 ['s'];
				attribute targetRange :> ISQ::length = 500 [m];
				attribute systemStatus : ScalarValues::String = "Firing geometry established, weapons ready";
			}
			
			snapshot atWeaponsfire {
				doc /* Weapons fire executed against target UAS. */
				attribute missionTime :> ISQ::time = 15700 ['s'];
				attribute weaponsDeployed : ScalarValues::String = "SBAR or APKWS";
				attribute systemStatus : ScalarValues::String = "Weapons fired, assessing impact";
			}
			
			snapshot atTargetNeutralization {
				doc /* Target neutralized, interceptor confirms neutralization success. */
				attribute missionTime :> ISQ::time = 15800 ['s'];
				attribute engagementOutcome : ScalarValues::String = "Neutralized";
				attribute systemStatus : ScalarValues::String = "Target eliminated, returning to CAP";
			}
		}
		
		then timeslice returnTransitFromCAPPointToFARPExecution {
			doc /* Timeslice covering the Return Transit from CAP Point to FARP phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.returnTransitFromCAPPointToFARP) }
			
			snapshot atCAP_to_FARP_Transit {
				doc /* Aircraft transits from CAP point back to FARP for refueling. */
				attribute missionTime :> ISQ::time = 18900 ['s'];
				attribute altitude :> ISQ::length = 3000 [m];
				attribute speed :> ISQ::speed = 280 [kn];
				attribute systemStatus : ScalarValues::String = "En route to FARP, post-engagement transit";
			}
			
			snapshot atFARP_Arrival_2 {
				doc /* Aircraft arrives at FARP for refueling and potential re-tasking. */
				attribute missionTime :> ISQ::time = 20700 ['s'];
				attribute altitude :> ISQ::length = 0 [m];
				attribute systemStatus : ScalarValues::String = "Returned to FARP, ground crew briefed on engagement";
			}
		}
		
		then timeslice recoveryTransitFromFARPToMainBaseExecution {
			doc /* Timeslice covering the Recovery Transit from FARP to Main Base (SBPV) phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.recoveryTransitFromFARPToMainBase) }
			
			snapshot atMainBase_Transit {
				doc /* Aircraft transits from FARP back to main operating base. */
				attribute missionTime :> ISQ::time = 21600 ['s'];
				attribute altitude :> ISQ::length = 3000 [m];
				attribute speed :> ISQ::speed = 280 [kn];
				attribute systemStatus : ScalarValues::String = "En route to main base";
			}
			
			snapshot atMainBase_Landing {
				doc /* Aircraft lands at main operating base and mission concluded. */
				attribute missionTime :> ISQ::time = 25200 ['s'];
				attribute altitude :> ISQ::length = 0 [m];
				attribute systemStatus : ScalarValues::String = "Landed at main base, mission complete";
			}
		}
	}
}