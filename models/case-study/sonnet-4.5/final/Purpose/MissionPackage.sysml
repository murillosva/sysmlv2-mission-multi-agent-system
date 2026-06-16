package MissionPackage {

	private import CoSMAPackage::*;
	private import MissionPhasesPackage::*;
	private import CapabilitiesPackage::*;
	private import SystemPackage::*;
	private import FunctionsPackage::*;
	private import ContextPackage::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import SI::*;
	private import ISQ::*;

	part def ContinentalZIDAShieldOperation :> Mission {
		doc /* Airspace policing mission to suppress entry of illicit UAS conducting clandestine aerial surveying and supporting drug trafficking along the Amazon border. The mission maintains continuous posture of aerospace control over portions of continental ZIDA through interceptor aircraft assisted by ground surveillance and airborne control and early warning, ensuring response capability and denial of access to incursions. The mission employs A-29 Super Tucano aircraft in baseline and modernized (A-29... */

		part continentalZIDAShieldSystem : ContinentalZIDAShieldSystem :> system;
		part continentalZIDAShieldOperationContext : ContinentalZIDAShieldOperationContext :> context;

		perform action performContinentalZIDAShield : PerformContinentalZIDAShield;
		requirement denyIllicitFreedomOfAction : Goal {
			doc /* Preserve sovereignty and deny freedom of action to UAS that use Brazilian airspace as means of achieving illicit effects */
		} :> goals;
		requirement maintainContinuousAerospaceControlPosture : Goal {
			doc /* Maintain continuous posture of aerospace control and airspace policing over portion of continental ZIDA through interceptor aircraft assisted by ground surveillance and airborne control and early warning */
		} :> goals;
		requirement achieveEffectiveUASNeutralization : Goal {
			doc /* Detect, identify, track, and neutralize non-cooperative UAS before they achieve sufficient penetration depth to fulfill their illicit purpose */
		} :> goals;
		requirement assessCUASModernizationImpact : Goal {
			doc /* Investigate impact of new C-UAS technologies and capabilities through modernization of A-29 avionic systems on mission effectiveness */
		} :> goals;
		part airDefense : AirDefense :> requiredCapabilites;
		part airborneControlAndEarlyWarning : AirborneControlAndEarlyWarning :> requiredCapabilites;
		part targetTracking : TargetTracking :> requiredCapabilites;
		part weaponsEmployment : WeaponsEmployment :> requiredCapabilites;
		part forwardOperations : ForwardOperations :> requiredCapabilites;
		part dedicatedDatalinkCommunication : DedicatedDatalinkCommunication :> requiredCapabilites;
		part electroOpticalInfraredSensing : ElectroOpticalInfraredSensing :> requiredCapabilites;
		part precisionGuidedMunitionsEmployment : PrecisionGuidedMunitionsEmployment :> requiredCapabilites;
		part airspacePolicing : AirspacePolicing :> requiredCapabilites;
		part airspaceSurveillanceAndControl : AirspaceSurveillanceAndControl :> requiredCapabilites;
		part combatSustainment : CombatSustainment :> requiredCapabilites;
		connection : CapabilityToGoalDerivation {
			end capa :>> airDefense;
			end goal1 :>> denyIllicitFreedomOfAction;
			end goal2 :>> achieveEffectiveUASNeutralization;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> airborneControlAndEarlyWarning;
			end goal1 :>> maintainContinuousAerospaceControlPosture;
			end goal2 :>> achieveEffectiveUASNeutralization;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> targetTracking;
			end goal :>> achieveEffectiveUASNeutralization;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> weaponsEmployment;
			end goal :>> achieveEffectiveUASNeutralization;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> forwardOperations;
			end goal :>> maintainContinuousAerospaceControlPosture;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> dedicatedDatalinkCommunication;
			end goal :>> assessCUASModernizationImpact;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> electroOpticalInfraredSensing;
			end goal :>> assessCUASModernizationImpact;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> precisionGuidedMunitionsEmployment;
			end goal :>> assessCUASModernizationImpact;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> airspacePolicing;
			end goal1 :>> denyIllicitFreedomOfAction;
			end goal2 :>> maintainContinuousAerospaceControlPosture;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> airspaceSurveillanceAndControl;
			end goal :>> maintainContinuousAerospaceControlPosture;
		} :> capabilityToGoals;
		connection : CapabilityToGoalDerivation {
			end capa :>> combatSustainment;
			end goal :>> maintainContinuousAerospaceControlPosture;
		} :> capabilityToGoals;

		exhibit state continentalZIDAShieldOperationPhases {

			state initial : Initial;
			state transitToFARP : TransitToFARP;
			state farpToCAPRepositioning : FARPToCAPRepositioning;
			state capHoldingOrbit : CAPHoldingOrbit;
			state airspacePolicing : AirspacePolicing;
			state capToFARPReturn : CAPToFARPReturn;
			state farpToBaseRecovery : FARPToBaseRecovery;
			state final : MissionComplete;

			transition first initial then transitToFARP;
			transition first transitToFARP accept TransitToFARPCompletedNotification then farpToCAPRepositioning {
				doc /* if "Arrival at designated FARP point" */
			}
			transition first farpToCAPRepositioning accept FARPToCAPRepositioningCompletedNotification then capHoldingOrbit {
				doc /* if "Arrival at assigned CAP point" */
			}
			transition first capHoldingOrbit accept CAPHoldingOrbitCompletedNotification then airspacePolicing {
				doc /* if "Last aircraft (A-29-6) reaches CAP point at T+153 min" */
			}
			transition first airspacePolicing accept AirspacePolicingCompletedNotification then capToFARPReturn {
				doc /* if "Minimum fuel threshold reached for return leg" */
			}
			transition first capToFARPReturn accept CAPToFARPReturnCompletedNotification then farpToBaseRecovery {
				doc /* if "Arrival at FARP point" */
			}
			transition first farpToBaseRecovery accept FARPToBaseRecoveryCompletedNotification then final {
				doc /* if "Arrival at SBPV" */
			}
		} :>> phases;
	}
}
