package MissionRequirementsPackage {

	private import SI::*;
	private import ISQ::*;
	private import ScalarValues::*;
	private import CoSMAPackage::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import ModelingMetadata::*;
	private import StakeholderNeedsPackage::*;
	private import CapabilitiesPackage::*;

	requirement def <'MR-001'> UASNeutralizationBoundaryRequirement {
		doc /* The mission shall neutralize illicit UAS incursions before they cross the 80-nautical-mile boundary of continental ZIDA. */
		@Rationale {
			text = "This geographic threshold defines airspace sovereignty; UAS penetrating beyond it achieve their illicit objectives (surveillance, logistical support to narcotrafficking), representing mission failure.";
		}
		attribute actualUASPenetrationDistance :> ISQ::length;
		attribute maxAllowedPenetrationDistance :> ISQ::length = 80 [nmi];
		require constraint {
			actualUASPenetrationDistance <= maxAllowedPenetrationDistance
		}
		#refinement dependency 'MR-001' to CapabilitiesPackage::AirspacePolicing;
		#refinement dependency 'MR-001' to CapabilitiesPackage::MultiRotorUASDetectionAndNeutralization;
		#refinement dependency 'MR-001' to CapabilitiesPackage::FixedWingUASDetectionAndNeutralization;
	}

	requirement def <'MR-002'> UninterruptedAirspaceSurveillanceRequirement {
		doc /* The mission shall maintain uninterrupted and comprehensive surveillance of the airspace pertaining to continental ZIDA through integrated ground and airborne systems. */
		@Rationale {
			text = "Continuous surveillance is prerequisite for target detection and early warning; gaps in coverage enable UAS evasion. Integrated ground (DECEA) + air (E-99M) systems achieve redundancy and low-altitude coverage.";
		}
		attribute actualSurveillanceCoveragePercentage : ScalarValues::Real;
		attribute minSurveillanceCoveragePercentage : ScalarValues::Real = 100;
		attribute maxAllowedCoverageGapDuration :> ISQ::time;
		attribute maxAcceptableCoverageGapDuration :> ISQ::time = 5 [min]; // estimated
		require constraint {
			(actualSurveillanceCoveragePercentage >= minSurveillanceCoveragePercentage) and
			(maxAllowedCoverageGapDuration <= maxAcceptableCoverageGapDuration)
		}
		#refinement dependency 'MR-002' to CapabilitiesPackage::AirborneControlAndEarlyWarning;
		#refinement dependency 'MR-002' to CapabilitiesPackage::AirspaceSurveillanceAndControl;
	}

	requirement def <'MR-003'> PermanentAirDefensePostureRequirement {
		doc /* The mission shall maintain permanent air defense posture at Areas of Interest with capability to control alert assets during flight and execute rapid response to detected incursions. */
		@Rationale {
			text = "Readiness and reaction speed directly influence interception success; delays allow UAS to penetrate deeper into ZIDA. Combat Air Patrol (CAP) posture at six designated points enables < 30 min response time.";
		}
		attribute actualResponseTime :> ISQ::time;
		attribute maxAllowedResponseTime :> ISQ::time = 30 [min];
		attribute activeCAPPositions : ScalarValues::Integer;
		attribute minRequiredCAPPositions : ScalarValues::Integer = 6;
		require constraint {
			(actualResponseTime <= maxAllowedResponseTime) and
			(activeCAPPositions >= minRequiredCAPPositions)
		}
		#refinement dependency 'MR-003' to CapabilitiesPackage::AirborneAlert;
	}

	requirement def <'MR-004'> InterceptorTacticalControlSupportRequirement {
		doc /* The mission shall provide expanded coverage and control support to interceptor aircraft through real-time intelligence data and precise target vectoring during UAS interception. */
		@Rationale {
			text = "Target cueing from E-99M/DECEA eliminates pilot search time and reduces cumulative trajectory error during pursuit. Vectoring updates at defined intervals enable course correction.";
		}
		attribute targetCueUpdateFrequency :> ISQ::frequency;
		attribute minUpdateFrequency :> ISQ::frequency = 2 [Hz]; // estimated
		attribute cumulativeTrajectoryError :> ISQ::length;
		attribute maxAcceptableTrajectoryError :> ISQ::length = 500 [m]; // estimated
		require constraint {
			(targetCueUpdateFrequency >= minUpdateFrequency) and
			(cumulativeTrajectoryError <= maxAcceptableTrajectoryError)
		}
		#refinement dependency 'MR-004' to CapabilitiesPackage::AirborneControlAndEarlyWarning;
	}

	requirement def <'MR-005'> InterceptorPlatformModernizationRequirement {
		doc /* The mission shall enhance the A-29 interceptor platform's competence in detecting, identifying, tracking, and neutralizing illicit UAS through modernization of avionic systems (C-UAS capability). */
		@Rationale {
			text = "New technologies (datalink, EO/IR sensor, laser-guided armament) address baseline limitations in visual acquisition distance, reaction time, and small-target detection penalty.";
		}
		attribute visualAcquisitionRange :> ISQ::length;
		attribute minVisualAcquisitionRange :> ISQ::length = 5 [km]; // estimated for modernized platform
		attribute avionicsModernizationStatus : ScalarValues::Boolean;
		attribute dataLinkIntegrationStatus : ScalarValues::Boolean;
		attribute eOIRSensorIntegrationStatus : ScalarValues::Boolean;
		require constraint {
			(visualAcquisitionRange >= minVisualAcquisitionRange) and
			avionicsModernizationStatus and
			dataLinkIntegrationStatus and
			eOIRSensorIntegrationStatus
		}
		#refinement dependency 'MR-005' to CapabilitiesPackage::A29NModernizedInterception;
	}

	requirement def <'MR-006'> FARPLogisticsPositioningRequirement {
		doc /* The mission shall position interceptor aircraft at optimal Combat Air Patrol points with full fuel and ordnance loads through Forward Arming and Refueling Point (FARP) logistics. */
		@Rationale {
			text = "FARPs minimize transit time to CAP points, maximizing time-on-station for active Airspace Policing (PEA). Optimized FARP positioning balances coverage and endurance.";
		}
		attribute transitTimeFromFARPToCAP :> ISQ::time;
		attribute maxAllowedTransitTime :> ISQ::time = 15 [min]; // estimated
		attribute aircraftTimeOnStation :> ISQ::time;
		attribute minRequiredTimeOnStation :> ISQ::time = 120 [min]; // estimated
		attribute fuelLoadAtDeparture :> ISQ::mass;
		attribute minRequiredFuelLoad :> ISQ::mass = 1500 [kg]; // estimated
		require constraint {
			(transitTimeFromFARPToCAP <= maxAllowedTransitTime) and
			(aircraftTimeOnStation >= minRequiredTimeOnStation) and
			(fuelLoadAtDeparture >= minRequiredFuelLoad)
		}
		#refinement dependency 'MR-006' to CapabilitiesPackage::CombatSustainment;
	}

	requirement def <'MR-007'> RulesOfEngagementAuthorityRequirement {
		doc /* The mission shall employ Rules of Engagement (ROE) that authorize immediate lethal engagement (Deterrence Shot, TDE) against non-cooperative UAS detected within continental ZIDA. */
		@Rationale {
			text = "Narcotrafficking UAS represent asymmetric threat with illicit intent; escalated MPEA sequence is impractical and dangerous; TDE provides proportionate response under applicable international law.";
		}
		attribute roeLethalEngagementAuthorized : ScalarValues::Boolean;
		attribute deterrenceShotCapabilityEnabled : ScalarValues::Boolean;
		attribute targetCooperativeStatus : ScalarValues::Boolean;
		attribute targetLocationVerified : ScalarValues::Boolean;
		require constraint {
			roeLethalEngagementAuthorized and
			deterrenceShotCapabilityEnabled and
			(not targetCooperativeStatus) and
			targetLocationVerified
		}
		#refinement dependency 'MR-007' to CapabilitiesPackage::AirspacePolicing;
	}

	requirement def <'MR-008'> WeaponSystemEngagementEnvelopeRequirement {
		doc /* The mission shall employ weapon systems (SBAT-70 unguided baseline; SBAT-70 + APKWS guided alternative) capable of engaging targets within designated employment envelopes and achieving required hit probability. */
		@Rationale {
			text = "Unguided armament has limited effectiveness against small, maneuverable targets; guided armament extends engagement window and improves lethality.";
		}
		attribute maxEngagementRange :> ISQ::length;
		attribute minEngagementRangeCapability :> ISQ::length = 3 [km]; // estimated
		attribute hitProbability : ScalarValues::Real;
		attribute minRequiredHitProbability : ScalarValues::Real = 0.75; // estimated
		attribute guidedArmamentAvailable : ScalarValues::Boolean;
		require constraint {
			(maxEngagementRange >= minEngagementRangeCapability) and
			(hitProbability >= minRequiredHitProbability) and
			guidedArmamentAvailable
		}
		#refinement dependency 'MR-008' to CapabilitiesPackage::A29BaselineInterception;
		#refinement dependency 'MR-008' to CapabilitiesPackage::A29NModernizedInterception;
	}

}
