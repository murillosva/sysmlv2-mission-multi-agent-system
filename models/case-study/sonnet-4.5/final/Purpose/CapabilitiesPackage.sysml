package CapabilitiesPackage {

	private import CoSMAPackage::*;
	private import StakeholderNeedsPackage::*;
	private import ModelingMetadata::*;
	part def AirDefense :> Capability {
		doc /* Ensure UAS engagement within ZIDA airspace through kinetic interception */
		#refinement dependency AirDefense to StakeholderNeedsPackage::'SHN-001';
		#refinement dependency AirDefense to StakeholderNeedsPackage::'SHN-002';
		#refinement dependency AirDefense to StakeholderNeedsPackage::'SHN-006';
		#refinement dependency AirDefense to StakeholderNeedsPackage::'SHN-011';
	}
	part def AirborneControlAndEarlyWarning :> Capability {
		doc /* Provide interceptor vectoring and enhanced situational awareness through airborne radar and control */
		#refinement dependency AirborneControlAndEarlyWarning to StakeholderNeedsPackage::'SHN-001';
		#refinement dependency AirborneControlAndEarlyWarning to StakeholderNeedsPackage::'SHN-004';
		#refinement dependency AirborneControlAndEarlyWarning to StakeholderNeedsPackage::'SHN-006';
		#refinement dependency AirborneControlAndEarlyWarning to StakeholderNeedsPackage::'SHN-008';
		#refinement dependency AirborneControlAndEarlyWarning to StakeholderNeedsPackage::'SHN-009';
		#refinement dependency AirborneControlAndEarlyWarning to StakeholderNeedsPackage::'SHN-010';
		#refinement dependency AirborneControlAndEarlyWarning to StakeholderNeedsPackage::'SHN-011';
	}
	part def TargetTracking :> Capability {
		doc /* Maintain visual or sensor contact with UAS throughout interception geometry */
		#refinement dependency TargetTracking to StakeholderNeedsPackage::'SHN-001';
		#refinement dependency TargetTracking to StakeholderNeedsPackage::'SHN-006';
		#refinement dependency TargetTracking to StakeholderNeedsPackage::'SHN-011';
	}
	part def WeaponsEmployment :> Capability {
		doc /* Effectively neutralize UAS given interception geometry through appropriate armament */
		#refinement dependency WeaponsEmployment to StakeholderNeedsPackage::'SHN-001';
		#refinement dependency WeaponsEmployment to StakeholderNeedsPackage::'SHN-006';
		#refinement dependency WeaponsEmployment to StakeholderNeedsPackage::'SHN-011';
	}
	part def ForwardOperations :> Capability {
		doc /* Maximize time on station during mission sorties through Forward Arming and Refueling Points (FARPs) */
		#refinement dependency ForwardOperations to StakeholderNeedsPackage::'SHN-004';
		#refinement dependency ForwardOperations to StakeholderNeedsPackage::'SHN-008';
		#refinement dependency ForwardOperations to StakeholderNeedsPackage::'SHN-009';
		#refinement dependency ForwardOperations to StakeholderNeedsPackage::'SHN-010';
	}
	part def DedicatedDatalinkCommunication :> Capability {
		doc /* Receive target coordinates instantaneously for cueing purposes (A-29N specific) */
		#refinement dependency DedicatedDatalinkCommunication to StakeholderNeedsPackage::'SHN-011';
		#refinement dependency DedicatedDatalinkCommunication to StakeholderNeedsPackage::'SHN-012';
	}
	part def ElectroOpticalInfraredSensing :> Capability {
		doc /* Track and laser-designate targets through EO/IR sensor (A-29N specific) */
		#refinement dependency ElectroOpticalInfraredSensing to StakeholderNeedsPackage::'SHN-011';
		#refinement dependency ElectroOpticalInfraredSensing to StakeholderNeedsPackage::'SHN-012';
	}
	part def PrecisionGuidedMunitionsEmployment :> Capability {
		doc /* Neutralize designated UAS through laser-guided rockets (A-29N specific) */
		#refinement dependency PrecisionGuidedMunitionsEmployment to StakeholderNeedsPackage::'SHN-011';
		#refinement dependency PrecisionGuidedMunitionsEmployment to StakeholderNeedsPackage::'SHN-012';
	}
	part def AirspacePolicing :> Capability {
		doc /* Employ aerospace means to detect, identify, track, and neutralize illicit air traffic within airspace of interest during peacetime (Policiamento do Espaço Aéreo, PEA) */
		#refinement dependency AirspacePolicing to StakeholderNeedsPackage::'SHN-001';
		#refinement dependency AirspacePolicing to StakeholderNeedsPackage::'SHN-002';
		#refinement dependency AirspacePolicing to StakeholderNeedsPackage::'SHN-004';
		#refinement dependency AirspacePolicing to StakeholderNeedsPackage::'SHN-008';
		#refinement dependency AirspacePolicing to StakeholderNeedsPackage::'SHN-009';
		#refinement dependency AirspacePolicing to StakeholderNeedsPackage::'SHN-010';
	}
	part def AirspaceSurveillanceAndControl :> Capability {
		doc /* Employ surface-based Air Force means to detect, identify, track, and control aircraft within airspace of interest (Vigilância e Controle do Espaço Aéreo, VCEA) */
		#refinement dependency AirspaceSurveillanceAndControl to StakeholderNeedsPackage::'SHN-004';
		#refinement dependency AirspaceSurveillanceAndControl to StakeholderNeedsPackage::'SHN-008';
		#refinement dependency AirspaceSurveillanceAndControl to StakeholderNeedsPackage::'SHN-009';
		#refinement dependency AirspaceSurveillanceAndControl to StakeholderNeedsPackage::'SHN-010';
	}
	part def CombatSustainment :> Capability {
		doc /* Ensure means, infrastructure, services, and resources to sustain air operations and extend combat power (Sustentação ao Combate, SC) */
		#refinement dependency CombatSustainment to StakeholderNeedsPackage::'SHN-004';
		#refinement dependency CombatSustainment to StakeholderNeedsPackage::'SHN-008';
		#refinement dependency CombatSustainment to StakeholderNeedsPackage::'SHN-009';
		#refinement dependency CombatSustainment to StakeholderNeedsPackage::'SHN-010';
	}
}
