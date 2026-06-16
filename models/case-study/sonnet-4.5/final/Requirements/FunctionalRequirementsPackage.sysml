package FunctionalRequirementsPackage {

	private import SI::*;
	private import ISQ::*;
	private import ScalarValues::*;
	private import CoSMAPackage::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import ModelingMetadata::*;
	private import MissionRequirementsPackage::*;
	requirement def <'FR-001'> E99MAirborneRadarDetectionRequirement {
		doc /* The system shall employ E-99M airborne radar to detect illicit UAS incursions crossing the Brazilian border into ZIDA airspace. */
		@Rationale {
			text = "Continuous airborne surveillance is essential to complement ground radar and detect low-altitude UAS incursions across the vast Amazon border area, enabling timely interceptor notification.";
		}
		attribute actualDetectionProbability : ScalarValues::Real;
		attribute minDetectionProbability : ScalarValues::Real = 0.85;
		attribute maxDetectionLatency :> ISQ::time;
		attribute allowedDetectionLatency :> ISQ::time = 60 [s];
		require constraint {
			(actualDetectionProbability >= minDetectionProbability) and
			(maxDetectionLatency <= allowedDetectionLatency)
		}
		#refinement dependency 'FR-001' to MissionRequirementsPackage::'MR-002';
		#refinement dependency 'FR-001' to MissionRequirementsPackage::'MR-003';
	}
	requirement def <'FR-002'> InterceptorAssignmentRequirement {
		doc /* The system shall assign the nearest A-29 interceptor on CAP to engage detected illicit UAS with engagement exclusivity. */
		@Rationale {
			text = "Engagement exclusivity prevents simultaneous multi-target complexity and ensures resource allocation efficiency, enabling isolation of single-engagement performance characteristics.";
		}
		attribute simultaneousEngagements : ScalarValues::Integer;
		attribute maxSimultaneousEngagements : ScalarValues::Integer = 1;
		attribute assignmentLatency :> ISQ::time;
		attribute maxAssignmentLatency :> ISQ::time = 30 [s];
		require constraint {
			(simultaneousEngagements <= maxSimultaneousEngagements) and
			(assignmentLatency <= maxAssignmentLatency)
		}
		#refinement dependency 'FR-002' to MissionRequirementsPackage::'MR-005';
	}
	requirement def <'FR-003'> VectoringInformationTransmissionRequirement {
		doc /* The system shall transmit vectoring information to interceptors to enable pursuit geometry updates. */
		@Rationale {
			text = "Real-time vectoring data is critical to guide interceptors toward UAS targets, compensating for the lack of onboard UAS detection capability in baseline configuration.";
		}
		attribute vectoringUpdateRate :> ISQ::frequency;
		attribute minVectoringUpdateRate :> ISQ::frequency = 0.1 [Hz];
		attribute dataLinkReliability : ScalarValues::Real;
		attribute minDataLinkReliability : ScalarValues::Real = 0.95;
		require constraint {
			(vectoringUpdateRate >= minVectoringUpdateRate) and
			(dataLinkReliability >= minDataLinkReliability)
		}
		#refinement dependency 'FR-003' to MissionRequirementsPackage::'MR-005';
	}
	requirement def <'FR-004'> UASAcquisitionCapabilityRequirement {
		doc /* The system shall enable interceptor aircraft to acquire illicit UAS through visual or sensor-based means. */
		@Rationale {
			text = "Target acquisition is the prerequisite for tracking and engagement, directly impacting the interceptor's ability to execute the kill chain within ZIDA boundaries.";
		}
		attribute acquisitionRange :> ISQ::length;
		attribute minAcquisitionRange :> ISQ::length = 5 [nmi];
		attribute acquisitionProbability : ScalarValues::Real;
		attribute minAcquisitionProbability : ScalarValues::Real = 0.80;
		require constraint {
			(acquisitionRange >= minAcquisitionRange) and
			(acquisitionProbability >= minAcquisitionProbability)
		}
		#refinement dependency 'FR-004' to MissionRequirementsPackage::'MR-003';
	}
	requirement def <'FR-005'> ContinuousTrackingMaintenanceRequirement {
		doc /* The system shall maintain continuous tracking of illicit UAS from acquisition until weapon employment range is achieved. */
		@Rationale {
			text = "Tracking loss results in mission failure; continuous lock ensures the interceptor can close distance and execute engagement before UAS evades beyond ZIDA boundary.";
		}
		attribute trackingContinuityProbability : ScalarValues::Real;
		attribute minTrackingContinuityProbability : ScalarValues::Real = 0.90;
		attribute maxTrackingLossDuration :> ISQ::time;
		attribute allowedTrackingLossDuration :> ISQ::time = 10 [s];
		require constraint {
			(trackingContinuityProbability >= minTrackingContinuityProbability) and
			(maxTrackingLossDuration <= allowedTrackingLossDuration)
		}
		#refinement dependency 'FR-005' to MissionRequirementsPackage::'MR-003';
	}
	requirement def <'FR-006'> WeaponEmploymentEnvelopeEntryRequirement {
		doc /* The system shall enable interceptor aircraft to enter weapon employment envelope within UAS engagement timeline. */
		@Rationale {
			text = "Failure to close distance within armament range before UAS crosses 80 nmi ZIDA boundary results in mission failure.";
		}
		attribute closingTimeToEnvelope :> ISQ::time;
		attribute maxClosingTimeToEnvelope :> ISQ::time = 600 [s];
		attribute employmentEnvelopeRange :> ISQ::length;
		attribute minEmploymentEnvelopeRange :> ISQ::length = 2 [nmi];
		require constraint {
			(closingTimeToEnvelope <= maxClosingTimeToEnvelope) and
			(employmentEnvelopeRange >= minEmploymentEnvelopeRange)
		}
		#refinement dependency 'FR-006' to MissionRequirementsPackage::'MR-003';
	}
	requirement def <'FR-007'> KineticNeutralizationExecutionRequirement {
		doc /* The system shall execute kinetic neutralization of illicit UAS using available armament within employment envelope. */
		@Rationale {
			text = "Direct kinetic engagement is the terminal phase of the kill chain, physically destroying the UAS to prevent territorial penetration.";
		}
		attribute neutralizationProbability : ScalarValues::Real;
		attribute minNeutralizationProbability : ScalarValues::Real = 0.75;
		attribute engagementExecutionTime :> ISQ::time;
		attribute maxEngagementExecutionTime :> ISQ::time = 120 [s];
		require constraint {
			(neutralizationProbability >= minNeutralizationProbability) and
			(engagementExecutionTime <= maxEngagementExecutionTime)
		}
		#refinement dependency 'FR-007' to MissionRequirementsPackage::'MR-001';
		#refinement dependency 'FR-007' to MissionRequirementsPackage::'MR-003';
		#refinement dependency 'FR-007' to MissionRequirementsPackage::'MR-006';
	}
	requirement def <'FR-008'> EngagementOutcomeAssessmentRequirement {
		doc /* The system shall assess engagement outcome to determine UAS neutralization or evasion status. */
		@Rationale {
			text = "Outcome assessment is necessary to terminate engagement, report mission success/failure, and initiate return to CAP for subsequent interception cycles.";
		}
		attribute assessmentAccuracy : ScalarValues::Real;
		attribute minAssessmentAccuracy : ScalarValues::Real = 0.95;
		attribute assessmentLatency :> ISQ::time;
		attribute maxAssessmentLatency :> ISQ::time = 30 [s];
		require constraint {
			(assessmentAccuracy >= minAssessmentAccuracy) and
			(assessmentLatency <= maxAssessmentLatency)
		}
		#refinement dependency 'FR-008' to MissionRequirementsPackage::'MR-001';
	}
	requirement def <'FR-009'> CAPPointHoldingRequirement {
		doc /* The system shall maintain interceptor aircraft at CAP points for continuous airspace policing readiness. */
		@Rationale {
			text = "Persistent presence at CAP points ensures interceptors are positioned for rapid response to illicit UAS incursions, maximizing time available for engagement.";
		}
		attribute capHoldingDuration :> ISQ::time;
		attribute minCAPHoldingDuration :> ISQ::time = 120 [min];
		attribute positionDeviationFromCAP :> ISQ::length;
		attribute maxPositionDeviationFromCAP :> ISQ::length = 5 [nmi];
		require constraint {
			(capHoldingDuration >= minCAPHoldingDuration) and
			(positionDeviationFromCAP <= maxPositionDeviationFromCAP)
		}
		#refinement dependency 'FR-009' to MissionRequirementsPackage::'MR-002';
	}
	requirement def <'FR-010'> FARPRefuelingCapabilityRequirement {
		doc /* The system shall enable refueling operations at FARP points to restore aircraft endurance for return leg to main base. */
		@Rationale {
			text = "Forward refueling extends operational radius and eliminates the need for direct return to Porto Velho, maximizing time on station for airspace policing.";
		}
		attribute refuelingTime :> ISQ::time;
		attribute maxRefuelingTime :> ISQ::time = 30 [min];
		attribute fuelTransferRate :> ISQ::mass;
		attribute minFuelTransferRate :> ISQ::mass = 1000 [kg];
		require constraint {
			(refuelingTime <= maxRefuelingTime) and
			(fuelTransferRate >= minFuelTransferRate)
		}
		#refinement dependency 'FR-010' to MissionRequirementsPackage::'MR-004';
	}
	requirement def <'FR-011'> FARPOptimizedPositioningRequirement {
		doc /* The system shall position FARP points to minimize transit time and maximize proportion of endurance dedicated exclusively to airspace policing. */
		@Rationale {
			text = "FARP optimization methodology ensures the largest possible proportion of aircraft endurance is dedicated to PEA phase, reducing transit overhead and maximizing interception capability.";
		}
		attribute peaPhaseEnduranceProportion : ScalarValues::Real;
		attribute minPEAPhaseEnduranceProportion : ScalarValues::Real = 0.60;
		attribute farpToCapDistance :> ISQ::length;
		attribute maxFARPToCAPDistance :> ISQ::length = 200 [nmi];
		require constraint {
			(peaPhaseEnduranceProportion >= minPEAPhaseEnduranceProportion) and
			(farpToCapDistance <= maxFARPToCAPDistance)
		}
		#refinement dependency 'FR-011' to MissionRequirementsPackage::'MR-004';
	}
	requirement def <'FR-012'> MissionSynchronizationRequirement {
		doc /* The system shall synchronize Phase 4 (PEA) commencement at T+153 minutes when all aircraft reach CAP points. */
		@Rationale {
			text = "Simultaneous PEA activation ensures that stochastic UAS incursions are exposed to the full defensive posture from a common temporal baseline, enabling fair comparative analysis.";
		}
		attribute peaCommencementTime :> ISQ::time;
		attribute requiredPEACommencementTime :> ISQ::time = 153 [min];
		attribute synchronizationTolerance :> ISQ::time;
		attribute maxSynchronizationTolerance :> ISQ::time = 5 [min];
		require constraint {
			(peaCommencementTime == requiredPEACommencementTime) and
			(synchronizationTolerance <= maxSynchronizationTolerance)
		}
		#refinement dependency 'FR-012' to MissionRequirementsPackage::'MR-002';
	}
	requirement def <'FR-013'> EngagementCycleRepetitionRequirement {
		doc /* The system shall enable interceptors to execute multiple interception cycles (notification → pursuit → engagement → CAP return) until minimum fuel threshold is reached. */
		@Rationale {
			text = "Continuous interception cycles maximize the number of UAS neutralizations per sortie, directly contributing to mission effectiveness and ZIDA boundary protection.";
		}
		attribute completedEngagementCycles : ScalarValues::Integer;
		attribute minCompletedEngagementCycles : ScalarValues::Integer = 2;
		attribute remainingFuelAtCycleEnd :> ISQ::mass;
		attribute minRemainingFuel :> ISQ::mass = 800 [kg];
		require constraint {
			(completedEngagementCycles >= minCompletedEngagementCycles) and
			(remainingFuelAtCycleEnd >= minRemainingFuel)
		}
		#refinement dependency 'FR-013' to MissionRequirementsPackage::'MR-002';
		#refinement dependency 'FR-013' to MissionRequirementsPackage::'MR-003';
	}
	requirement def <'FR-014'> StochasticUASIncursionGenerationRequirement {
		doc /* The system shall randomly generate illicit UAS incursions via Monte Carlo simulation over 23 border sectors (28-50) with equal probability of multi-rotor or fixed-wing class. */
		@Rationale {
			text = "Stochastic incursion generation ensures realistic spatial and temporal variability, avoiding deterministic bias and enabling statistically representative mission effectiveness assessment.";
		}
		attribute borderSectorCount : ScalarValues::Integer;
		attribute requiredBorderSectorCount : ScalarValues::Integer = 23;
		attribute uasClassProbability : ScalarValues::Real;
		attribute requiredUASClassProbability : ScalarValues::Real = 0.50;
		attribute monteCarloIterations : ScalarValues::Integer;
		attribute minMonteCarloIterations : ScalarValues::Integer = 1000;
		require constraint {
			(borderSectorCount == requiredBorderSectorCount) and
			(uasClassProbability == requiredUASClassProbability) and
			(monteCarloIterations >= minMonteCarloIterations)
		}
	}
	requirement def <'FR-015'> MissionEffectivenessReportingRequirement {
		doc /* The system shall calculate and report mission effectiveness metrics (MOS-1, MOS-2) and operational performance metrics (MOE-1, MOE-2, MOE-3) to decision-makers. */
		@Rationale {
			text = "Quantitative assessment of mission outcomes is essential to evaluate configuration effectiveness and inform capability modernization decisions.";
		}
		attribute reportedMetricsCount : ScalarValues::Integer;
		attribute requiredMetricsCount : ScalarValues::Integer = 5;
		attribute reportGenerationLatency :> ISQ::time;
		attribute maxReportGenerationLatency :> ISQ::time = 10 [min];
		attribute reportCompleteness : ScalarValues::Real;
		attribute minReportCompleteness : ScalarValues::Real = 1.0;
		require constraint {
			(reportedMetricsCount >= requiredMetricsCount) and
			(reportGenerationLatency <= maxReportGenerationLatency) and
			(reportCompleteness >= minReportCompleteness)
		}
	}
}

%viz--view mixed--style lr FunctionalRequirementsPackage::'FR-001' -- FunctionalRequirementsPackage::'FR-015';