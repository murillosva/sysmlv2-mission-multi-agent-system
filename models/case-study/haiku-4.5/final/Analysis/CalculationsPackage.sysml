package CalculationsPackage {

	private import ISQ::*;
	private import SI::*;
	private import ScalarValues::*;
	private import CoSMAPackage::*;
	private import ScalarFunctions::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import TechnicalComponentsPackage::*;
	private import NumericalFunctions::*;
	private import CollectionFunctions::*;
	private import ControlFunctions::*;
	private import Parts::*;

	// --- Calculation Definitions for Measures of Success ---
	calc def calculateNeutralizationRate {
		doc /* Calculates Percentage of illicit UAS incursions neutralized before crossing the 80-nautical-mile (80 nmi) boundary of continental ZIDA. Directly measures the effectiveness of each interceptor aircraft configuration in airspace policing and evaluates achievement of strategic objective (airspace sovereignty preservation). */
		in Nn : ScalarValues::Integer;
		in Nt : ScalarValues::Integer;
		return neutralizationRate : ScalarValues::Real = Nn / Nt;
	}
	calc def calculateEvasionReductionRate {
		doc /* Calculates Relative reduction in illicit UAS evasion rate afforded by the modernized A-29N configuration compared to the baseline A-29. Measures the differential impact of new technological capability. */
		in rB : ScalarValues::Real;
		in rM : ScalarValues::Real;
		in MOS1_B : ScalarValues::Real;
		in MOS1_M : ScalarValues::Real;
		return evasionReductionRate : ScalarValues::Real = (rB - rM) / rM;
	}

	// --- Calculation Definitions for Measures of Effectiveness ---
	calc def calculateEngagementTimeRate {
		doc /* Calculates Mean engagement completion time rate, relating the interval elapsed from initial illicit traffic notification to the A-29 until effective neutralization of the target. Incorporates maximum penalty for iterations where UAS evades beyond 80 nmi boundary. */
		in N : ScalarValues::Integer;
		in Tmax :> ISQ::duration;
		in sumTef :> ISQ::duration;
		in E : ScalarValues::Integer;
		return engagementTimeRate : ScalarValues::Real = 1.0 - (sumTef / (N * Tmax));
	}
	calc def calculateTrackingRate {
		doc /* Calculates Proportion of time during which the interceptor could maintain active tracking on the illicit UAS during pursuit, terminating when A-29 reaches maximum employment range of armament. Differs significantly between baseline (visual + heading updates) and A-29N (EO/IR sensor + datalink). */
		in N : ScalarValues::Integer;
		in sumMOE2 : ScalarValues::Real;
		return trackingRate : ScalarValues::Real = sumMOE2 / N;
	}
	calc def calculateNeutralizationProbability {
		doc /* Calculates Lethal outcome probability of Deterrence Shot (TDE) execution upon engagement initiation within armament employment envelope. Measures degree to which engagement results in actual destruction of UAS, considering firing distance and UAS dimensional differences. */
		in N : ScalarValues::Integer;
		in sumPhit : ScalarValues::Real;
		return neutralizationProbability : ScalarValues::Real = sumPhit / N;
	}

	// --- Calculation Definitions for Measures of Performance ---
	calc def calculateUpdateRate {
		doc /* Calculates Interval between target position and heading indication updates relayed to the fighter aircraft, representing communication latency sensitivity and control loop update frequency. For baseline: heading vector via voice communication (VHF). For A-29N: geographic coordinate via datalink + pilot manual entry time. */
		in updateInterval :> ISQ::duration;
		return updateRate :> ISQ::frequency = 1.0 / updateInterval;
	}
	calc def calculateAcquisitionRange {
		doc /* Calculates Physical limit of acquisition and sensing capability for target detection and tracking. For baseline: physiological limits of human vision. For A-29N: technical performance limits of onboard EO/IR sensor. */
		in maxSensorRange :> ISQ::length;
		return acquisitionRange :> ISQ::length = maxSensorRange;
	}
	calc def calculateWeaponEnvelope {
		doc /* Calculates Ballistic envelope and armament precision per configuration, characterizing employment range and hit probability distribution. Baseline: unguided SBAT-70. A-29N: SBAT-70 + APKWS laser-guided kit. */
		in minEmploymentRange :> ISQ::length;
		in maxEmploymentRange :> ISQ::length;
		return weaponEnvelopeSpan :> ISQ::length = maxEmploymentRange - minEmploymentRange;
	}
}
