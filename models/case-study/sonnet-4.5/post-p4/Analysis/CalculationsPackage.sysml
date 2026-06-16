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
		doc /* Calculates Percentage of illicit UAS incursions neutralized before crossing the 80-nautical-mile boundary of the ZIDA; directly measures the effectiveness of each interceptor aircraft configuration in airspace policing and achieving the strategic objective of border protection */
		in Nn : ScalarValues::Integer;
		in Nt : ScalarValues::Integer;
		in Config : ScalarValues::String;
		return NeutralizationRate : ScalarValues::Real = Nn / Nt;
	}
	calc def calculateEvasionReductionRate {
		doc /* Calculates Illicit evasion reduction rate afforded by the modernized configuration compared to baseline; evidences the differential impact of the new technological C-UAS capability */
		in rB : ScalarValues::Real;
		in rM : ScalarValues::Real;
		return EvasionReductionRate : ScalarValues::Real = (rB - rM) / rM;
	}

	// --- Calculation Definitions for Measures of Effectiveness ---
	calc def calculateEngagementTimeRate {
		doc /* Calculates Mean engagement completion time rate from initial illicit traffic notification to effective neutralization; incorporates maximum penalty in iterations where UAS evades beyond 80 nmi of ZIDA (considered maximum viable engagement time given aircraft endurance) */
		in N : ScalarValues::Integer;
		in Tmax :> ISQ::duration;
		in totalTefSum :> ISQ::duration;
		in E : ScalarValues::Integer;
		in K : ScalarValues::Integer;
		in R :> ISQ::duration;
		in dFARP_k_CAP_k :> ISQ::length;
		in v :> ISQ::speed;
		in Config : ScalarValues::String;
		return EngagementTimeRate : ScalarValues::Real = 1 - totalTefSum / (N * Tmax);
	}
	calc def calculateTrackingRate {
		doc /* Calculates Mean active tracking time rate during mission; evaluates proportion of time during which interceptor could maintain tracking on illicit UAS until reaching maximum employment range of armament; modeling diverges by configuration (baseline: visual flight + external vectoring; A-29N: avionic systems) */
		in N : ScalarValues::Integer;
		in totalMOE2Sum : ScalarValues::Real;
		in n : ScalarValues::Integer;
		in dk :> ISQ::length;
		in Ptrack_dk : ScalarValues::Real;
		in dmax :> ISQ::length;
		in M : ScalarValues::Real;
		in cUAS :> ISQ::length;
		in cA :> ISQ::length;
		in aEO_IR :> ISQ::length;
		in X :> ISQ::duration;
		in Y :> ISQ::duration;
		return TrackingRate : ScalarValues::Real = totalMOE2Sum / N;
	}
	calc def calculateNeutralizationProbability {
		doc /* Calculates Neutralization probability per approach; evaluates lethal outcome of Deterrence Shot (TDE) execution; quantifies success of MPEA considering dynamics of scenario interactions, assessing neutralization against evasions and resistances due to dimensional differences between multi-rotor and fixed-wing UAS */
		in N : ScalarValues::Integer;
		in totalPhitSum : ScalarValues::Real;
		in ds_i :> ISQ::length;
		in Phit_s : ScalarValues::Real;
		in s :> ISQ::length;
		in dmax :> ISQ::length;
		in dmin :> ISQ::length;
		in M : ScalarValues::Real;
		in cUAS :> ISQ::length;
		in aAPKWS :> ISQ::length;
		in k : ScalarValues::Integer;
		in j : ScalarValues::Integer;
		return NeutralizationProbability : ScalarValues::Real = totalPhitSum / N;
	}

	// --- Calculation Definitions for Measures of Performance ---
	calc def calculateUpdateRate {
		doc /* Calculates Update rate of heading and geographic coordinate transfer between E-99M and A-29; characterizes sensitivity differences in receiving illicit UAS location information; baseline: vectoring heading via voice; A-29N: coordinate reception sensitivity (time for pilot to manually enter and locate received coordinate in aircraft system) */
		in minUpdateInterval :> ISQ::duration;
		in maxUpdateInterval :> ISQ::duration;
		in config : ScalarValues::String;
		return updateRate :> ISQ::duration = (minUpdateInterval + maxUpdateInterval) / 2;
	}
	calc def calculateAcquisitionRange {
		doc /* Calculates Physical limits of acquisition and sensing; baseline: physiological characteristics and restrictions of human vision; A-29N: technical performance limits of onboard EO/IR sensor; includes maximum acquisition distance, sensor accuracy, minimum acquisition/reaction time, and target dimension sensitivity */
		in maxAcquisitionDistance :> ISQ::length;
		in sensorAccuracy :> ISQ::length;
		in minAcquisitionTime :> ISQ::duration;
		in targetDimension :> ISQ::length;
		in referenceDimension :> ISQ::length;
		in config : ScalarValues::String;
		return acquisitionRange :> ISQ::length = maxAcquisitionDistance;
	}
	calc def calculateWeaponEnvelope {
		doc /* Calculates Ballistic envelope and armament precision per configuration; baseline: unguided SBAT-70 rocket; A-29N: APKWS laser guidance kit with SBAT-70 rockets; includes max/min range, guidance type, hit probability, and dimensional penalty */
		in maxRange :> ISQ::length;
		in minRange :> ISQ::length;
		in guidanceType : ScalarValues::String;
		in baseHitProbability : ScalarValues::Real;
		in dimensionalPenalty : ScalarValues::Real;
		in config : ScalarValues::String;
		return weaponEnvelope :> ISQ::length = maxRange - minRange;
	}
}
