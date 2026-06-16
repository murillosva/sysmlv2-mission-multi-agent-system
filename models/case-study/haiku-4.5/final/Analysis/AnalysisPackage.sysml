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
		doc /* Percentage of illicit UAS incursions neutralized before crossing the 80-nautical-mile (80 nmi) boundary of continental ZIDA. Directly measures the effectiveness of each interceptor aircraft configuration in airspace policing and evaluates achievement of strategic objective (airspace sovereignty preservation). */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in neutralizedCount : ScalarValues::Integer;
		in totalIncursions : ScalarValues::Integer;
		out neutralizationRate : ScalarValues::Real = CalculationsPackage::calculateNeutralizationRate(neutralizedCount, totalIncursions);
		assert constraint {
			neutralizationRate >= 0.80
		}
	}

	analysis continentalZIDAShieldOperationNeutralizationRateAnalysis : NeutralizationRateAnalysis {
		doc /* Runs NeutralizationRate analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}

	analysis def EvasionReductionRateAnalysis {
		doc /* Relative reduction in illicit UAS evasion rate afforded by the modernized A-29N configuration compared to the baseline A-29. Measures the differential impact of new technological capability. */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in evasionRateBaseline : ScalarValues::Real;
		in evasionRateModernized : ScalarValues::Real;
		out evasionReductionRate : ScalarValues::Real = CalculationsPackage::calculateEvasionReductionRate(evasionRateBaseline, evasionRateModernized);
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
		doc /* Mean engagement completion time rate, relating the interval elapsed from initial illicit traffic notification to the A-29 until effective neutralization of the target. Incorporates maximum penalty for iterations where UAS evades beyond 80 nmi boundary. */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in totalEngagements : ScalarValues::Integer;
		in maxTimeAvailable :> ISQ::duration;
		in effectiveEngagementTimes :> ISQ::duration[*];
		out engagementTimeRate : ScalarValues::Real = CalculationsPackage::calculateEngagementTimeRate(totalEngagements, maxTimeAvailable, effectiveEngagementTimes);
		assert constraint {
			engagementTimeRate >= 0.0
		}
	}

	analysis continentalZIDAShieldOperationEngagementTimeRateAnalysis : EngagementTimeRateAnalysis {
		doc /* Runs EngagementTimeRate analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}

	analysis def TrackingRateAnalysis {
		doc /* Proportion of time during which the interceptor could maintain active tracking on the illicit UAS during pursuit, terminating when A-29 reaches maximum employment range of armament. Differs significantly between baseline (visual + heading updates) and A-29N (EO/IR sensor + datalink). */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in totalEngagements : ScalarValues::Integer;
		in trackingProportions : ScalarValues::Real[*];
		out trackingRate : ScalarValues::Real = CalculationsPackage::calculateTrackingRate(totalEngagements, trackingProportions);
		assert constraint {
			trackingRate >= 0.0 and trackingRate <= 1.0
		}
	}

	analysis continentalZIDAShieldOperationTrackingRateAnalysis : TrackingRateAnalysis {
		doc /* Runs TrackingRate analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}

	analysis def NeutralizationProbabilityAnalysis {
		doc /* Lethal outcome probability of Deterrence Shot (TDE) execution upon engagement initiation within armament employment envelope. Measures degree to which engagement results in actual destruction of UAS, considering firing distance and UAS dimensional differences. */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in totalEngagements : ScalarValues::Integer;
		in hitProbabilities : ScalarValues::Real[*];
		out neutralizationProbability : ScalarValues::Real = CalculationsPackage::calculateNeutralizationProbability(totalEngagements, hitProbabilities);
		assert constraint {
			neutralizationProbability >= 0.0 and neutralizationProbability <= 1.0
		}
	}

	analysis continentalZIDAShieldOperationNeutralizationProbabilityAnalysis : NeutralizationProbabilityAnalysis {
		doc /* Runs NeutralizationProbability analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}

	// --- Measures of Performance (MOP) — Analysis Definitions ---
	analysis def UpdateRateAnalysis {
		doc /* Interval between target position and heading indication updates relayed to the fighter aircraft, representing communication latency sensitivity and control loop update frequency. For baseline: heading vector via voice communication (VHF). For A-29N: geographic coordinate via datalink + pilot manual entry time. */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in updateIntervals :> ISQ::duration[*];
		out updateRate :> ISQ::duration = CalculationsPackage::calculateUpdateRate(updateIntervals);
		assert constraint {
			updateRate >= 1 [s] and updateRate <= 60 [s]
		}
	}

	analysis continentalZIDAShieldOperationUpdateRateAnalysis : UpdateRateAnalysis {
		doc /* Runs UpdateRate analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
}

	analysis def AcquisitionRangeAnalysis {
		doc /* Physical limit of acquisition and sensing capability for target detection and tracking. For baseline: physiological limits of human vision. For A-29N: technical performance limits of onboard EO/IR sensor. */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in maxAcquisitionDistance :> ISQ::length;
		out acquisitionRange :> ISQ::length = CalculationsPackage::calculateAcquisitionRange(maxAcquisitionDistance);
		assert constraint {
			acquisitionRange >= 13 [km] and acquisitionRange <= 20 [km]
		}
	}

	analysis continentalZIDAShieldOperationAcquisitionRangeAnalysis : AcquisitionRangeAnalysis {
		doc /* Runs AcquisitionRange analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}

	analysis def WeaponEnvelopeAnalysis {
		doc /* Ballistic envelope and armament precision per configuration, characterizing employment range and hit probability distribution. Baseline: unguided SBAT-70. A-29N: SBAT-70 + APKWS laser-guided kit. */
		subject missionSystem : ContinentalZIDAShieldOperation;
		in minRange :> ISQ::length;
		in maxRange :> ISQ::length;
		out weaponEnvelope :> ISQ::length = CalculationsPackage::calculateWeaponEnvelope(minRange, maxRange);
		assert constraint {
			weaponEnvelope >= 0.5 [km] and weaponEnvelope <= 14 [km]
		}
	}

	analysis continentalZIDAShieldOperationWeaponEnvelopeAnalysis : WeaponEnvelopeAnalysis {
		doc /* Runs WeaponEnvelope analysis on the ContinentalZIDAShieldOperation mission. */
		subject continentalZIDAShieldOperation : ContinentalZIDAShieldOperation;
	}

}
