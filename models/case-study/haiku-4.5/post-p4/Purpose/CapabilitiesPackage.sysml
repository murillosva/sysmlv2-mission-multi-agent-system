package CapabilitiesPackage {

	private import CoSMAPackage::*;
	private import StakeholderNeedsPackage::*;
	private import ModelingMetadata::*;
	part def AerospaceControl :> Capability {
		doc /* Capability to dominate designated airspace of the continental ZIDA and deny such dominance to illicit operators, ensuring protection and freedom of action for friendly forces in peacetime, tension, and conflict. */
		#refinement dependency AerospaceControl to StakeholderNeedsPackage::'SHN-001';
		#refinement dependency AerospaceControl to StakeholderNeedsPackage::'SHN-003';
	}
	part def CombatSustainment :> Capability {
		doc /* Capability to ensure means, infrastructure, services, and human and material resources to sustain air operations in the remote Amazon Area of Operations, extending range, mobility, penetration, and rapid response of fighter aircraft through FARP optimization. */
		#refinement dependency CombatSustainment to StakeholderNeedsPackage::'SHN-004';
	}
	part def AirborneAlert :> Capability {
		doc /* Capability to employ aerospace means to protect designated Areas of Interest, using kinetic means to neutralize enemy aircraft and intruding UAS; continuous posture at CAP points with rapid response to notifications. */
		#refinement dependency AirborneAlert to StakeholderNeedsPackage::'SHN-001';
		#refinement dependency AirborneAlert to StakeholderNeedsPackage::'SHN-004';
	}
	part def AirspacePolicing :> Capability {
		doc /* Capability to detect, identify, track, and neutralize illicit air traffic (multi-rotor and fixed-wing UAS) within designated airspace during peacetime and operational campaigns, specifically protecting the 80-nautical-mile continental ZIDA boundary. */
		#refinement dependency AirspacePolicing to StakeholderNeedsPackage::'SHN-001';
		#refinement dependency AirspacePolicing to StakeholderNeedsPackage::'SHN-004';
	}
	part def AirborneControlAndEarlyWarning :> Capability {
		doc /* Capability to employ airborne radar and command/control means to monitor airspace, detect UAS incursions at low altitude, provide real-time intelligence data, and vector interceptor aircraft toward targets; fills radar coverage gaps in remote jungle environment. */
		#refinement dependency AirborneControlAndEarlyWarning to StakeholderNeedsPackage::'SHN-002';
		#refinement dependency AirborneControlAndEarlyWarning to StakeholderNeedsPackage::'SHN-003';
		#refinement dependency AirborneControlAndEarlyWarning to StakeholderNeedsPackage::'SHN-005';
	}
	part def AirspaceSurveillanceAndControl :> Capability {
		doc /* Capability to employ ground-based radar systems (DECEA) to detect, identify, track, and control aircraft within the continental ZIDA airspace, preserving sovereignty and air traffic safety through continuous surveillance. */
		#refinement dependency AirspaceSurveillanceAndControl to StakeholderNeedsPackage::'SHN-002';
		#refinement dependency AirspaceSurveillanceAndControl to StakeholderNeedsPackage::'SHN-003';
	}
	part def CounterUASEngagement :> Capability {
		doc /* Capability to acquire, track, designate, and engage low-signature UAS targets through integrated datalink cueing, EO/IR sensor targeting, and laser-guided precision weapons; modernized A-29N configuration integrates dedicated avionics for rapid target engagement. */
		#refinement dependency CounterUASEngagement to StakeholderNeedsPackage::'SHN-001';
		#refinement dependency CounterUASEngagement to StakeholderNeedsPackage::'SHN-004';
	}
	part def MultiRotorUASDetectionAndNeutralization :> Capability {
		doc /* Specialized capability to detect and neutralize multi-rotor UAS platforms (1 m dimension, small RCS, high maneuverability) employed for short-range surveillance and localized intelligence gathering in support of narcotrafficking operations. */
		#refinement dependency MultiRotorUASDetectionAndNeutralization to StakeholderNeedsPackage::'SHN-001';
		#refinement dependency MultiRotorUASDetectionAndNeutralization to StakeholderNeedsPackage::'SHN-004';
	}
	part def FixedWingUASDetectionAndNeutralization :> Capability {
		doc /* Specialized capability to detect and neutralize fixed-wing UAS platforms (14 m dimension, medium RCS, high endurance) employed for long-range narcotics transport and extended surveillance in support of illicit operations. */
		#refinement dependency FixedWingUASDetectionAndNeutralization to StakeholderNeedsPackage::'SHN-001';
		#refinement dependency FixedWingUASDetectionAndNeutralization to StakeholderNeedsPackage::'SHN-004';
	}
	part def A29BaselineInterception :> Capability {
		doc /* Capability of A-29 aircraft without C-UAS modernization to intercept and engage UAS using visual flight, heading-based vectoring via voice communication, unguided SBAT-70 rockets, and pilot naked-eye target acquisition (maximum 13 km range). */
		#refinement dependency A29BaselineInterception to StakeholderNeedsPackage::'SHN-001';
		#refinement dependency A29BaselineInterception to StakeholderNeedsPackage::'SHN-004';
	}
	part def A29NModernizedInterception :> Capability {
		doc /* Capability of modernized A-29N aircraft to intercept and engage UAS using datalink-based coordinate cueing, autonomous EO/IR sensor tracking (20 km range), and laser-guided APKWS rockets (14 km range, 80% hit probability at 2 km). */
		#refinement dependency A29NModernizedInterception to StakeholderNeedsPackage::'SHN-001';
		#refinement dependency A29NModernizedInterception to StakeholderNeedsPackage::'SHN-004';
	}
}
