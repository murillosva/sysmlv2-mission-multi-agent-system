package AnalysisPackage {

	private import MissionPackage::*;
	private import CoSMAPackage::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import CalculationsPackage::*;
	private import ISQ::*;
	private import SI::*;
	private import ScalarValues::*;
	private import TechnicalComponentsPackage::*;
	private import MissionExecutionPackage::*;

	// --- Measures of Success (MOS) — Analysis Definitions ---
	analysis def NeutralizationRateAnalysis {
		doc /* Percentage of illicit UAS incursions neutralized before crossing the 80-nautical-mile boundary of the ZIDA; directly measures the effectiveness of each interceptor aircraft configuration in airspace policing and achieving the strategic objective of border protection */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in neutralizedCount : ScalarValues::Integer;
		in totalIncursions : ScalarValues::Integer;
		out neutralizationRate : ScalarValues::Real = calculateNeutralizationRate(neutralizedCount, totalIncursions);
		assert constraint {
			neutralizationRate >= 0.80
		}
	}

	analysis continentalZIDAShieldOperationNeutralizationRateAnalysis : NeutralizationRateAnalysis {
		doc /* Runs NeutralizationRate analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}

	analysis def EvasionReductionRateAnalysis {
		doc /* Illicit evasion reduction rate afforded by the modernized configuration compared to baseline; evidences the differential impact of the new technological C-UAS capability */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in baselineEvasionRate : ScalarValues::Real;
		in modernizedEvasionRate : ScalarValues::Real;
		out evasionReductionRate : ScalarValues::Real = calculateEvasionReductionRate(baselineEvasionRate, modernizedEvasionRate);
		assert constraint {
			evasionReductionRate > 0.0
		}
	}

	analysis continentalZIDAShieldOperationEvasionReductionRateAnalysis : EvasionReductionRateAnalysis {
		doc /* Runs EvasionReductionRate analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}

	// --- Measures of Effectiveness (MOE) — Analysis Definitions ---
	analysis def EngagementTimeRateAnalysis {
		doc /* Mean engagement completion time rate from initial illicit traffic notification to effective neutralization; incorporates maximum penalty in iterations where UAS evades beyond 80 nmi of ZIDA (considered maximum viable engagement time given aircraft endurance) */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in totalEngagements : ScalarValues::Integer;
		in meanTimeAvailable :> ISQ::duration;
		in sumEffectiveTimes :> ISQ::duration;
		out engagementTimeRate : ScalarValues::Real = calculateEngagementTimeRate(totalEngagements, meanTimeAvailable, sumEffectiveTimes);
		assert constraint {
			engagementTimeRate >= 0.0
		}
	}

	analysis continentalZIDAShieldOperationEngagementTimeRateAnalysis : EngagementTimeRateAnalysis {
		doc /* Runs EngagementTimeRate analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}

	analysis def TrackingRateAnalysis {
		doc /* Mean active tracking time rate during mission; evaluates proportion of time during which interceptor could maintain tracking on illicit UAS until reaching maximum employment range of armament; modeling diverges by configuration (baseline: visual flight + external vectoring; A-29N: avionic systems) */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in totalInterceptions : ScalarValues::Integer;
		in sumTrackingRates : ScalarValues::Real;
		out trackingRate : ScalarValues::Real = calculateTrackingRate(totalInterceptions, sumTrackingRates);
		assert constraint {
			trackingRate >= 0.0
		}
	}

	analysis continentalZIDAShieldOperationTrackingRateAnalysis : TrackingRateAnalysis {
		doc /* Runs TrackingRate analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}

	analysis def NeutralizationProbabilityAnalysis {
		doc /* Neutralization probability per approach; evaluates lethal outcome of Deterrence Shot (TDE) execution; quantifies success of MPEA considering dynamics of scenario interactions, assessing neutralization against evasions and resistances due to dimensional differences between multi-rotor and fixed-wing UAS */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in totalEngagements : ScalarValues::Integer;
		in sumHitProbabilities : ScalarValues::Real;
		out neutralizationProbability : ScalarValues::Real = calculateNeutralizationProbability(totalEngagements, sumHitProbabilities);
		assert constraint {
			neutralizationProbability >= 0.0
		}
	}

	analysis continentalZIDAShieldOperationNeutralizationProbabilityAnalysis : NeutralizationProbabilityAnalysis {
		doc /* Runs NeutralizationProbability analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}

	// --- Measures of Performance (MOP) — Analysis Definitions ---
	analysis def UpdateRateAnalysis {
		doc /* Update rate of heading and geographic coordinate transfer between E-99M and A-29; characterizes sensitivity differences in receiving illicit UAS location information; baseline: vectoring heading via voice; A-29N: coordinate reception sensitivity (time for pilot to manually enter and locate received coordinate in aircraft system) */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in minUpdateInterval :> ISQ::duration;
		in maxUpdateInterval :> ISQ::duration;
		out updateRate :> ISQ::duration = calculateUpdateRate(minUpdateInterval, maxUpdateInterval);
		assert constraint {
			updateRate >= 1.0 [s]
		}
	}

	analysis continentalZIDAShieldOperationUpdateRateAnalysis : UpdateRateAnalysis {
		doc /* Runs UpdateRate analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}

	analysis def AcquisitionRangeAnalysis {
		doc /* Physical limits of acquisition and sensing; baseline: physiological characteristics and restrictions of human vision; A-29N: technical performance limits of onboard EO/IR sensor; includes maximum acquisition distance, sensor accuracy, minimum acquisition/reaction time, and target dimension sensitivity */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in maxAcquisitionDistance :> ISQ::length;
		in sensorAccuracy :> ISQ::length;
		out acquisitionRange :> ISQ::length = calculateAcquisitionRange(maxAcquisitionDistance, sensorAccuracy);
		assert constraint {
			acquisitionRange >= 0.0 [km]
		}
	}

	analysis continentalZIDAShieldOperationAcquisitionRangeAnalysis : AcquisitionRangeAnalysis {
		doc /* Runs AcquisitionRange analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}

	analysis def WeaponEnvelopeAnalysis {
		doc /* Ballistic envelope and armament precision per configuration; baseline: unguided SBAT-70 rocket; A-29N: APKWS laser guidance kit with SBAT-70 rockets; includes max/min range, guidance type, hit probability, and dimensional penalty */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in maxRange :> ISQ::length;
		in minRange :> ISQ::length;
		out weaponEnvelope :> ISQ::length = calculateWeaponEnvelope(maxRange, minRange);
		assert constraint {
			weaponEnvelope >= 0.5 [km]
		}
	}

	analysis continentalZIDAShieldOperationWeaponEnvelopeAnalysis : WeaponEnvelopeAnalysis {
		doc /* Runs WeaponEnvelope analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}
}
