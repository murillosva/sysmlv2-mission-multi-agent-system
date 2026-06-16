package StakeholderNeedsPackage {

	private import ModelingMetadata::*;
	private import CoSMAPackage::*;
	requirement def <'SHN-001'> AirspaceSovereigntyPreservation :> StakeholderNeed {
		doc /* The mission shall neutralize illicit UAS incursions before crossing the 80-nautical-mile boundary of continental ZIDA to preserve national airspace sovereignty and deny freedom of action to criminal networks. */
		@Rationale {
			text = "Brazil's constitutional mandate to protect national territory and defend airspace sovereignty requires that illicit aerial incursions be stopped before penetrating the national interior. Criminal networks exploiting UAS for narcotrafficking logistics represent an asymmetric threat to state control over the Amazon region.";
		}
	}
	requirement def <'SHN-002'> ComprehensiveAirspaceSurveillance :> StakeholderNeed {
		doc /* The mission shall maintain uninterrupted and comprehensive surveillance of the airspace pertaining to the continental ZIDA, including the capability to identify air traffic in the region through integrated ground and airborne systems. */
		@Rationale {
			text = "Effective air defense requires persistent surveillance across a vast jungle region where radar coverage is incomplete and atmospheric conditions degrade detection. Integrated ground and airborne systems are necessary to achieve continuous situational awareness and early warning of incursions.";
		}
	}
	requirement def <'SHN-003'> ContinuousAirDefensePosture :> StakeholderNeed {
		doc /* The mission shall maintain permanent air defense posture of areas of interest with the capability to control alert assets during flight and execute rapid response to detected incursions. */
		@Rationale {
			text = "Remote Amazon territory precludes centralized defense; distributed CAP points enable rapid response geometry to intercept incursions. Continuous control and rapid execution are operationally necessary to prevent UAS penetration across the 80-nautical-mile boundary.";
		}
	}
	requirement def <'SHN-004'> EnhancedInterceptionCapability :> StakeholderNeed {
		doc /* The mission shall enhance the 2°/3° GAV's competence in intercepting and neutralizing illicit UAS through integration of counter-UAS (C-UAS) capability on modernized A-29 aircraft, thereby elevating operational performance. */
		@Rationale {
			text = "Baseline air defense tactics (visual acquisition, voice-guided heading vectors, unguided rockets) are insufficient against small, maneuverable multi-rotor threats and extended-range fixed-wing platforms. Modernized C-UAS avionics (datalink, EO/IR sensor, laser-guided weapons) directly address interception gaps and increase kill probability.";
		}
	}
	requirement def <'SHN-005'> TargetVectoringAndSituationalAwareness :> StakeholderNeed {
		doc /* The mission shall provide the 2°/3° GAV with expanded coverage and control support through enhanced situational awareness and precise target vectoring of A-29 aircraft during interception operations. */
		@Rationale {
			text = "Expanded geographic separation among distributed CAP points necessitates better coordination and targeting support from airborne control platforms. Enhanced vectoring reduces time-to-intercept and improves engagement geometry by leveraging E-99M's superior sensor range and vantage point.";
		}
	}
}
