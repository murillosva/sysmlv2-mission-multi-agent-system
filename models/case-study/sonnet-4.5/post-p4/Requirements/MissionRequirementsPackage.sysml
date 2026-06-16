package MissionRequirementsPackage {

	private import SI::*;
	private import ISQ::*;
	private import ScalarValues::*;
	private import CoSMAPackage::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import ModelingMetadata::*;
	private import StakeholderNeedsPackage::*;
	private import CapabilitiesPackage::*;
	requirement def <'MR-001'> UASNeutralizationBeforeZIDABoundaryRequirement {
		doc /* The mission shall neutralize illicit UAS incursions before they cross the 80-nautical-mile boundary of continental ZIDA. */
		@Rationale {
			text = "Crossing the 80 nmi ZIDA boundary constitutes a failure in the strategic objective of sovereignty preservation and denial of illicit freedom of action, representing successful evasion of the mission's protective envelope.";
		}
		attribute actualNeutralizationDistance :> ISQ::length;
		attribute zidaBoundaryDistance :> ISQ::length = 80 [nmi];
		attribute uasSuccessfullyNeutralized : ScalarValues::Boolean;
		require constraint {
			uasSuccessfullyNeutralized and (actualNeutralizationDistance < zidaBoundaryDistance)
		}
		#refinement dependency 'MR-001' to CapabilitiesPackage::AirDefense;
		#refinement dependency 'MR-001' to CapabilitiesPackage::WeaponsEmployment;
	}
	requirement def <'MR-002'> UninterruptedAirspaceSurveillanceRequirement {
		doc /* The mission shall maintain uninterrupted and comprehensive surveillance of the airspace pertaining to continental ZIDA through capability to identify air traffic in the region. */
		@Rationale {
			text = "This requirement is driven by the operational need to detect and track illicit UAS continuously across the vast Amazon border area, enabling timely interception before territorial penetration exceeds the ZIDA boundary.";
		}
		attribute actualSurveillanceCoveragePercentage : ScalarValues::Real;
		attribute requiredSurveillanceCoveragePercentage : ScalarValues::Real = 100;
		attribute maxSurveillanceGapDuration :> ISQ::time;
		attribute allowedSurveillanceGapDuration :> ISQ::time = 0 [min];
		attribute airTrafficIdentificationCapable : ScalarValues::Boolean;
		require constraint {
			(actualSurveillanceCoveragePercentage >= requiredSurveillanceCoveragePercentage) and
			(maxSurveillanceGapDuration <= allowedSurveillanceGapDuration) and
			airTrafficIdentificationCapable
		}
		#refinement dependency 'MR-002' to CapabilitiesPackage::AirborneControlAndEarlyWarning;
		#refinement dependency 'MR-002' to CapabilitiesPackage::AirspaceSurveillanceAndControl;
	}
	requirement def <'MR-003'> ComprehensiveUASEngagementChainRequirement {
		doc /* The mission shall employ aerospace means to detect, identify, track, and neutralize non-cooperative UAS before they achieve sufficient penetration depth to fulfill their illicit purpose. */
		@Rationale {
			text = "This requirement reflects the desired tactical effect of the mission: preventing illicit UAS from conducting clandestine aerial surveying or providing logistical/surveillance support to drug trafficking by intercepting them within the ZIDA airspace.";
		}
		attribute uasDetectionCapable : ScalarValues::Boolean;
		attribute uasIdentificationCapable : ScalarValues::Boolean;
		attribute uasTrackingCapable : ScalarValues::Boolean;
		attribute uasNeutralizationCapable : ScalarValues::Boolean;
		attribute actualPenetrationDepth :> ISQ::length;
		attribute maxAllowablePenetrationDepth :> ISQ::length = 80 [nmi];
		require constraint {
			uasDetectionCapable and uasIdentificationCapable and 
			uasTrackingCapable and uasNeutralizationCapable and
			(actualPenetrationDepth < maxAllowablePenetrationDepth)
		}
		#refinement dependency 'MR-003' to CapabilitiesPackage::AirDefense;
		#refinement dependency 'MR-003' to CapabilitiesPackage::AirborneControlAndEarlyWarning;
		#refinement dependency 'MR-003' to CapabilitiesPackage::TargetTracking;
		#refinement dependency 'MR-003' to CapabilitiesPackage::WeaponsEmployment;
	}
	requirement def <'MR-004'> MaximizeTimeOnStationThroughFARPRequirement {
		doc /* The mission shall maximize time on station for interceptor aircraft through forward operations with Forward Arming and Refueling Points (FARPs). */
		@Rationale {
			text = "The vast Amazon border distances from main bases require forward logistics to ensure interceptors can maintain prolonged airspace policing at CAP points, directly enabling mission success.";
		}
		attribute actualTimeOnStation :> ISQ::time;
		attribute baselineTimeOnStationWithoutFARP :> ISQ::time = 2 [h]; // estimated
		attribute farpOperationalCapable : ScalarValues::Boolean;
		require constraint {
			farpOperationalCapable and (actualTimeOnStation > baselineTimeOnStationWithoutFARP)
		}
		#refinement dependency 'MR-004' to CapabilitiesPackage::ForwardOperations;
		#refinement dependency 'MR-004' to CapabilitiesPackage::CombatSustainment;
	}
	requirement def <'MR-005'> RealTimeVectoringSupportRequirement {
		doc /* The mission shall provide real-time vectoring support to interceptors through airborne control and early warning. */
		@Rationale {
			text = "This requirement exists to overcome the limitations of ground radar coverage and provide precise, real-time intelligence data to interceptor aircraft regarding low-altitude UAS traffic, enabling effective pursuit and engagement.";
		}
		attribute vectoringDataLatency :> ISQ::time;
		attribute maxVectoringDataLatency :> ISQ::time = 5 [s]; // estimated
		attribute airborneControlAvailable : ScalarValues::Boolean;
		attribute vectoringAccuracy :> ISQ::length;
		attribute maxVectoringError :> ISQ::length = 500 [m]; // estimated
		require constraint {
			airborneControlAvailable and
			(vectoringDataLatency <= maxVectoringDataLatency) and
			(vectoringAccuracy <= maxVectoringError)
		}
		#refinement dependency 'MR-005' to CapabilitiesPackage::AirborneControlAndEarlyWarning;
	}
	requirement def <'MR-006'> ImmediateKineticEngagementRequirement {
		doc /* The mission shall execute immediate kinetic engagement of illicit UAS upon detection without procedural escalation. */
		@Rationale {
			text = "This requirement is driven by the asymmetric threat posed by UAS supporting trafficking, necessitating direct application of Deterrence Shot (TDE) rather than the conventional escalated MPEA sequence, to ensure rapid neutralization.";
		}
		attribute timeFromDetectionToEngagement :> ISQ::time;
		attribute maxTimeFromDetectionToEngagement :> ISQ::time = 3 [min]; // estimated
		attribute proceduralEscalationRequired : ScalarValues::Boolean;
		attribute kineticEngagementCapable : ScalarValues::Boolean;
		require constraint {
			kineticEngagementCapable and
			(not proceduralEscalationRequired) and
			(timeFromDetectionToEngagement <= maxTimeFromDetectionToEngagement)
		}
		#refinement dependency 'MR-006' to CapabilitiesPackage::WeaponsEmployment;
	}
}
