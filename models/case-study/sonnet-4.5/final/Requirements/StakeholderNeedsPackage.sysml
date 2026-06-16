package StakeholderNeedsPackage {

	private import ModelingMetadata::*;
	private import CoSMAPackage::*;
	requirement def <'SHN-001'> ZIDABoundaryProtection :> StakeholderNeed {
		doc /* The mission shall neutralize illicit UAS incursions before they cross the 80-nautical-mile boundary of continental ZIDA */
		@Rationale {
			text = "The 80-nautical-mile ZIDA boundary constitutes the legal threshold of national airspace sovereignty. UAS penetrating beyond this boundary achieve sufficient depth to fulfill illicit purposes, undermining territorial integrity and enabling transnational criminal networks to operate with impunity in Brazilian airspace.";
		}
	}
	requirement def <'SHN-002'> AirspaceSovereigntyPreservation :> StakeholderNeed {
		doc /* The mission shall preserve airspace sovereignty through identification, coercion, or detention of existing air traffic in Brazilian Airspace */
		@Rationale {
			text = "National sovereignty over the Amazon airspace is threatened by illicit aerial activities supporting transnational crime. The State must demonstrate effective control and authority over its airspace through continuous enforcement of air policing actions to deny freedom of action to hostile actors.";
		}
	}
	requirement def <'SHN-003'> RulesOfEngagementEstablishment :> StakeholderNeed {
		doc /* The mission shall establish rules of engagement and define postures prescribed for air defense alert */
		@Rationale {
			text = "Clear rules of engagement are essential to ensure legal compliance, operational effectiveness, and force protection during aerospace policing actions. They provide decision-making frameworks for interceptor crews facing non-cooperative UAS while maintaining adherence to international law and national sovereignty principles.";
		}
	}
	requirement def <'SHN-004'> ContinuousAirspaceSurveillance :> StakeholderNeed {
		doc /* The mission shall maintain uninterrupted and comprehensive surveillance of airspace pertaining to continental ZIDA */
		@Rationale {
			text = "The vast extent of the Amazon border combined with low population density and limited infrastructure creates surveillance gaps exploited by criminal networks. Continuous airspace monitoring is essential to detect illicit UAS incursions and enable timely interception before ZIDA boundary penetration.";
		}
	}
	requirement def <'SHN-005'> AirTrafficIdentificationCapability :> StakeholderNeed {
		doc /* The mission shall provide capability to identify air traffic in the region */
		@Rationale {
			text = "Identification of air traffic is foundational for distinguishing between authorized aviation and illicit UAS incursions. This capability enables correct classification of targets, appropriate application of rules of engagement, and prevention of engagement errors against legitimate aircraft.";
		}
	}
	requirement def <'SHN-006'> UASDetectionAndIdentification :> StakeholderNeed {
		doc /* The mission shall produce UAS identifications through continuous surveillance */
		@Rationale {
			text = "Small UAS signatures present detection and identification challenges distinct from conventional aircraft. Dedicated UAS identification capability is necessary to recognize and classify illicit drones against complex environmental backgrounds, enabling prompt engagement decisions.";
		}
	}
	requirement def <'SHN-007'> AlertAssetControl :> StakeholderNeed {
		doc /* The mission shall control alert assets during flight */
		@Rationale {
			text = "Effective mission execution requires real-time coordination and control of interceptor aircraft responding to UAS incursions. Flight control ensures aircraft operate within designated areas, maintain safe separation, and execute engagement sequences according to established tactical procedures.";
		}
	}
	requirement def <'SHN-008'> PermanentAirDefenseCoverage :> StakeholderNeed {
		doc /* The mission shall provide permanent air defense of areas of interest */
		@Rationale {
			text = "Illicit UAS operations occur unpredictably across vast border regions. Permanent air defense posture ensures continuous readiness to respond to incursions regardless of timing, denying adversaries the ability to exploit temporal gaps in coverage.";
		}
	}
	requirement def <'SHN-009'> LowAltitudeTrafficIntelligence :> StakeholderNeed {
		doc /* The mission shall provide precise, real-time intelligence data to interceptor fighter aircraft regarding traffic flying at low altitude */
		@Rationale {
			text = "Illicit UAS typically operate at low altitudes to evade detection by ground-based radars. Airborne early warning platforms compensate for terrain masking effects and provide interceptors with accurate target data necessary for successful engagement geometry in the Amazon environment.";
		}
	}
	requirement def <'SHN-010'> ExpandedCoverageSupport :> StakeholderNeed {
		doc /* The mission shall provide expanded coverage and control support through enhanced situational awareness */
		@Rationale {
			text = "The 300-km spacing between CAP points creates potential surveillance gaps. Airborne control extends effective radar coverage, enables mutual support between interceptor positions, and provides comprehensive situational awareness necessary for coordinated response to multiple simultaneous incursions.";
		}
	}
	requirement def <'SHN-011'> CUASCapabilityEnhancement :> StakeholderNeed {
		doc /* The mission shall enhance competence in intercepting and neutralizing illicit UAS through C-UAS capability */
		@Rationale {
			text = "Conventional aircraft systems were not designed to engage small, slow-moving UAS targets. Specialized C-UAS capabilities address the unique challenges of drone interception, including extended detection ranges, precise tracking, and appropriate weapons systems for effective neutralization.";
		}
	}
	requirement def <'SHN-012'> OperationalPerformanceElevation :> StakeholderNeed {
		doc /* The mission shall elevate operational performance and impact on mission success */
		@Rationale {
			text = "Mission success is measured by the percentage of UAS neutralized before ZIDA boundary penetration. Enhanced operational performance through modernized systems directly increases mission effectiveness and reduces the rate of illicit evasion, improving overall protection of national airspace.";
		}
	}
	requirement def <'SHN-013'> CombatLogisticsSustainment :> StakeholderNeed {
		doc /* The mission shall ensure logistical support of all aeronautical, ordnance, structural, and patrimonial materiel */
		@Rationale {
			text = "Sustained air operations across the vast Amazon region require continuous supply of fuel, munitions, spare parts, and maintenance support. Logistics sustainment is essential to maintain aircraft readiness rates and enable uninterrupted execution of airspace policing missions.";
		}
	}
	requirement def <'SHN-014'> EquipmentDistributionSupport :> StakeholderNeed {
		doc /* The mission shall distribute mission support equipment */
		@Rationale {
			text = "Forward operating locations (FARPs) and dispersed CAP points require timely distribution of specialized equipment to sustain operations. Efficient logistics distribution enables extended time-on-station and rapid reconstitution of combat capability after engagements.";
		}
	}
	requirement def <'SHN-015'> MaterielStandardizationAndSupport :> StakeholderNeed {
		doc /* The mission shall standardize, supervise, and support activities related to aeronautical and ordnance materiel */
		@Rationale {
			text = "Standardization of materiel ensures interoperability, maintainability, and operational effectiveness across multiple operating locations. Supervision and support activities guarantee that modernized C-UAS systems are properly integrated, maintained, and employed according to approved technical standards.";
		}
	}
}
