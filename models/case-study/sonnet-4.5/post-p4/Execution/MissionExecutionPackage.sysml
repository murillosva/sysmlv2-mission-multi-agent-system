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

	individual part def ContinentalZIDAShieldOperationIndividual :> ContinentalZIDAShieldOperation {
		attribute neutralizationRate : ScalarValues::Real;
		attribute evasionReductionRate : ScalarValues::Real;
	}

	individual part continentalZIDAShieldOperationIndividual : ContinentalZIDAShieldOperationIndividual {
		doc /* A timeline representing the key events of the Continental ZIDA Shield Operation (Operação Escudo ZIDA Continental) mission. */
		timeslice transitToFARPExecution {
			doc /* Timeslice covering the Transit to FARP phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.transitToFARP) }
			
			snapshot atDeparture {
				doc /* Interceptor departs main operating base for forward arming and refueling point. */
				attribute missionTime :> ISQ::time = 0 ['s'];
				attribute status : ScalarValues::String = "Departed main base";
				perform InterceptorAircraftPlatform::transitFromMainBaseToFARP;
			}
			
			snapshot atFARPApproach {
				doc /* Interceptor approaches FARP location. */
				attribute missionTime :> ISQ::time = 2400 ['s'];
				attribute altitude :> ISQ::length = 1500 [m];
				attribute speed :> ISQ::speed = 180 [kn];
			}
			
			snapshot atFARPArrival {
				doc /* Interceptor arrives at FARP and prepares for refueling operations. */
				attribute missionTime :> ISQ::time = 3000 ['s'];
				attribute status : ScalarValues::String = "FARP arrival complete";
			}
		}
		then timeslice farpToCAPRepositioningExecution {
			doc /* Timeslice covering the FARP to CAP Repositioning phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.farpToCAPRepositioning) }
			
			snapshot atFARPDeparture {
				doc /* Interceptor departs FARP and begins repositioning to CAP point. */
				attribute missionTime :> ISQ::time = 3600 ['s'];
				attribute status : ScalarValues::String = "Departing FARP for CAP";
				perform InterceptorAircraftPlatform::repositionFromFARPToCAP;
			}
			
			snapshot atCAPApproach {
				doc /* Interceptor approaches designated CAP holding orbit location. */
				attribute missionTime :> ISQ::time = 5400 ['s'];
				attribute altitude :> ISQ::length = 3000 [m];
				attribute speed :> ISQ::speed = 200 [kn];
			}
			
			snapshot atCAPArrival {
				doc /* Interceptor establishes position at CAP holding orbit point. */
				attribute missionTime :> ISQ::time = 6000 ['s'];
				attribute status : ScalarValues::String = "CAP position established";
			}
		}
		then timeslice capHoldingOrbitExecution {
			doc /* Timeslice covering the CAP Holding Orbit phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.capHoldingOrbit) }
			
			snapshot atHoldingOrbitStart {
				doc /* Interceptor begins maintaining holding orbit pattern at CAP station. */
				attribute missionTime :> ISQ::time = 6300 ['s'];
				attribute status : ScalarValues::String = "Holding orbit active";
				perform InterceptorAircraftPlatform::maintainHoldingOrbitAtCAP;
			}
			
			snapshot atMidHoldingOrbit {
				doc /* Interceptor continues holding orbit, awaiting tasking from AWACS. */
				attribute missionTime :> ISQ::time = 7200 ['s'];
				attribute altitude :> ISQ::length = 3000 [m];
				attribute speed :> ISQ::speed = 180 [kn];
			}
		}
		then timeslice airspacePolicingExecution {
			doc /* Timeslice covering the Airspace Policing (PEA) phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.airspacePolicing) }
			
			snapshot atPolicingInitiation {
				doc /* Airspace policing operation begins with AWACS detecting potential threat. */
				attribute missionTime :> ISQ::time = 7800 ['s'];
				attribute status : ScalarValues::String = "Policing operation initiated";
				perform InterceptorAircraftPlatform::initiateAirspacePolicing;
			}
			
			snapshot atUASIncursion {
				doc /* Illicit UAS crosses border into protected airspace zone (ZIDA). */
				attribute missionTime :> ISQ::time = 7920 ['s'];
				attribute status : ScalarValues::String = "UAS border crossing detected";
				perform IllicitUASThreatEntity::generateIllicitUASIncursion;
				perform IllicitUASThreatEntity::crossBorderIntoZIDA;
			}
			
			snapshot atRadarDetection {
				doc /* AWACS platform detects illicit UAS with airborne surveillance radar. */
				attribute missionTime :> ISQ::time = 7980 ['s'];
				attribute status : ScalarValues::String = "UAS detected by AWACS";
				perform AirborneControlAndEarlyWarningPlatform::detectIllicitUASWithAirborneRadar;
			}
			
			snapshot atInterceptorAssignment {
				doc /* AWACS assigns interceptor aircraft to engage detected UAS target. */
				attribute missionTime :> ISQ::time = 8040 ['s'];
				attribute status : ScalarValues::String = "Interceptor assigned to target";
				perform AirborneControlAndEarlyWarningPlatform::assignInterceptorToUASTarget;
				perform AirborneControlAndEarlyWarningPlatform::transmitVectoringInformationViaVoice;
			}
			
			snapshot atDatalinkCueing {
				doc /* AWACS transmits precise target coordinates via tactical datalink. */
				attribute missionTime :> ISQ::time = 8100 ['s'];
				attribute status : ScalarValues::String = "Target coordinates received";
				perform AirborneControlAndEarlyWarningPlatform::transmitCueingCoordinatesViaDatalink;
			}
			
			snapshot atHeadingModification {
				doc /* Interceptor modifies heading to intercept UAS target. */
				attribute missionTime :> ISQ::time = 8160 ['s'];
				attribute speed :> ISQ::speed = 220 [kn];
				attribute status : ScalarValues::String = "Heading modified toward UAS";
				perform InterceptorAircraftPlatform::modifyHeadingTowardUAS;
			}
			
			snapshot atVisualSearch {
				doc /* Crew initiates naked-eye visual search for UAS target. */
				attribute missionTime :> ISQ::time = 8280 ['s'];
				attribute altitude :> ISQ::length = 2500 [m];
				attribute status : ScalarValues::String = "Visual search initiated";
				perform InterceptorAircraftPlatform::acquireUASVisually;
			}
			
			snapshot atEOIRCueing {
				doc /* EOIR sensor cued to transmitted target coordinates for acquisition. */
				attribute missionTime :> ISQ::time = 8340 ['s'];
				attribute status : ScalarValues::String = "EOIR sensor cued to coordinates";
				perform InterceptorAircraftPlatform::cueEOIRSensorToCoordinates;
			}
			
			snapshot atEOIRAcquisition {
				doc /* EOIR sensor acquires UAS target and establishes tracking lock. */
				attribute missionTime :> ISQ::time = 8400 ['s'];
				attribute status : ScalarValues::String = "UAS acquired with EOIR";
				perform InterceptorAircraftPlatform::acquireUASWithEOIRSensor;
			}
			
			snapshot atVisualTracking {
				doc /* Crew maintains continuous visual contact with UAS target. */
				attribute missionTime :> ISQ::time = 8460 ['s'];
				attribute status : ScalarValues::String = "Visual tracking established";
				perform InterceptorAircraftPlatform::maintainVisualTrackingOfUAS;
			}
			
			snapshot atEOIRTracking {
				doc /* EOIR sensor maintains stable tracking lock on UAS target. */
				attribute missionTime :> ISQ::time = 8520 ['s'];
				attribute status : ScalarValues::String = "EOIR tracking lock maintained";
				perform InterceptorAircraftPlatform::maintainEOIRTrackingLock;
			}
			
			snapshot atWeaponEnvelopeEntry {
				doc /* Interceptor enters effective weapon employment envelope for engagement. */
				attribute missionTime :> ISQ::time = 8640 ['s'];
				attribute rangeToTarget :> ISQ::length = 2000 [m];
				attribute status : ScalarValues::String = "Weapon envelope entered";
				perform InterceptorAircraftPlatform::enterWeaponEmploymentEnvelope;
			}
			
			snapshot atFirePhilosophyDetermination {
				doc /* Crew determines appropriate firing philosophy based on tactical situation. */
				attribute missionTime :> ISQ::time = 8700 ['s'];
				attribute status : ScalarValues::String = "Fire philosophy determined";
				perform InterceptorAircraftPlatform::determineFiringPhilosophy;
			}
			
			snapshot atDeterrenceShot {
				doc /* Crew executes deterrence shot using unguided SBAT-70 rocket. */
				attribute missionTime :> ISQ::time = 8760 ['s'];
				attribute status : ScalarValues::String = "Deterrence shot executed";
				perform InterceptorAircraftPlatform::executeSBAT70UnguiedRocket;
			}
			
			snapshot atLaserDesignation {
				doc /* Crew designates UAS target with laser designator for precision engagement. */
				attribute missionTime :> ISQ::time = 8820 ['s'];
				attribute status : ScalarValues::String = "Target laser-designated";
				perform InterceptorAircraftPlatform::designateUASWithLaser;
			}
			
			snapshot atAPKWSLaunch {
				doc /* Crew launches APKWS laser-guided rocket at designated UAS target. */
				attribute missionTime :> ISQ::time = 8880 ['s'];
				attribute status : ScalarValues::String = "APKWS launched";
				perform InterceptorAircraftPlatform::executeAPKWSLaserGuidedRocket;
			}
			
			snapshot atEngagementAssessment {
				doc /* Crew assesses outcome of weapon engagement against UAS target. */
				attribute missionTime :> ISQ::time = 8940 ['s'];
				attribute status : ScalarValues::String = "Engagement outcome assessed";
				perform InterceptorAircraftPlatform::assessEngagementOutcome;
			}
			
			snapshot atNeutralization {
				doc /* UAS target successfully neutralized by precision-guided munition. */
				attribute missionTime :> ISQ::time = 9000 ['s'];
				attribute status : ScalarValues::String = "UAS neutralized";
				perform InterceptorAircraftPlatform::neutralizeUAS;
			}
			
			snapshot atEvasionDetection {
				doc /* Alternative scenario: UAS evasion detected if neutralization unsuccessful. */
				attribute missionTime :> ISQ::time = 9060 ['s'];
				attribute status : ScalarValues::String = "UAS evasion detected";
				perform InterceptorAircraftPlatform::detectUASEvasion;
			}
			
			snapshot atCAPReturn {
				doc /* Interceptor returns to CAP holding orbit after engagement completion. */
				attribute missionTime :> ISQ::time = 9300 ['s'];
				attribute status : ScalarValues::String = "Returning to CAP";
				perform InterceptorAircraftPlatform::returnToCAPAfterEngagement;
			}
			
			snapshot atInterceptionCyclesContinuation {
				doc /* Interceptor continues readiness for additional interception cycles. */
				attribute missionTime :> ISQ::time = 9600 ['s'];
				attribute status : ScalarValues::String = "Ready for next intercept";
				perform InterceptorAircraftPlatform::continueInterceptionCycles;
			}
		}
		then timeslice capToFARPReturnExecution {
			doc /* Timeslice covering the CAP to FARP Return phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.capToFARPReturn) }
			
			snapshot atCAPDeparture {
				doc /* Interceptor departs CAP station and begins transit to FARP for refueling. */
				attribute missionTime :> ISQ::time = 10800 ['s'];
				attribute status : ScalarValues::String = "Departing CAP for FARP";
				perform InterceptorAircraftPlatform::departCAPForFARP;
			}
			
			snapshot atFARPReturnApproach {
				doc /* Interceptor approaches FARP location for refueling operations. */
				attribute missionTime :> ISQ::time = 12600 ['s'];
				attribute altitude :> ISQ::length = 1500 [m];
				attribute speed :> ISQ::speed = 180 [kn];
			}
			
			snapshot atFARPRefueling {
				doc /* Interceptor conducts refueling operations at FARP before recovery. */
				attribute missionTime :> ISQ::time = 13200 ['s'];
				attribute status : ScalarValues::String = "Refueling at FARP";
				perform InterceptorAircraftPlatform::refuelAtFARP;
			}
		}
		then timeslice farpToBaseRecoveryExecution {
			doc /* Timeslice covering the FARP to Base Recovery phase. */
			assert constraint { isDuring(continentalZIDAShieldOperationPhases.farpToBaseRecovery) }
			
			snapshot atFARPDepartureForBase {
				doc /* Interceptor departs FARP and begins final transit to main operating base. */
				attribute missionTime :> ISQ::time = 14400 ['s'];
				attribute status : ScalarValues::String = "Departing FARP for main base";
				perform InterceptorAircraftPlatform::recoverToMainBase;
			}
			
			snapshot atBaseApproach {
				doc /* Interceptor approaches main operating base for mission recovery. */
				attribute missionTime :> ISQ::time = 16200 ['s'];
				attribute altitude :> ISQ::length = 1000 [m];
				attribute speed :> ISQ::speed = 160 [kn];
			}
			
			snapshot atMissionCompletion {
				doc /* Interceptor successfully recovers to main base, completing mission. */
				attribute missionTime :> ISQ::time = 16800 ['s'];
				attribute status : ScalarValues::String = "Mission complete";
			}
		}
	}
}
