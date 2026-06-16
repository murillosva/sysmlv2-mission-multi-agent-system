package TechnicalRequirementsPackage {

	private import SI::*;
	private import ISQ::*;
	private import ScalarValues::*;
	private import CoSMAPackage::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import ModelingMetadata::*;
	private import FunctionalRequirementsPackage::*;

	requirement def <'TR-001'> BaselineSBAT70UnguidedRocketRequirement {
		doc /* The A-29 baseline shall employ SBAT-70 unguided rockets with a maximum employment range of 2 km for UAS neutralization. */
		@Rationale {
			text = "This requirement establishes the comparison baseline representing conventional air defense capability without precision guidance, enabling evaluation of the modernized configuration's impact.";
		}
		attribute actualEmploymentRange :> ISQ::length;
		attribute maxEmploymentRange :> ISQ::length = 2 [km];
		require constraint {
			actualEmploymentRange <= maxEmploymentRange
		}
		#refinement dependency 'TR-001' to FunctionalRequirementsPackage::'FR-007';
	}

	requirement def <'TR-002'> ModernizedAPKWSLaserGuidedRocketRequirement {
		doc /* The A-29N shall employ APKWS laser-guided rockets with a maximum employment range of 14 km for UAS neutralization. */
		@Rationale {
			text = "Precision guidance technology extends the engagement envelope and increases hit probability against small, maneuverable UAS targets compared to unguided munitions.";
		}
		attribute actualEmploymentRange :> ISQ::length;
		attribute maxEmploymentRange :> ISQ::length = 14 [km];
		require constraint {
			actualEmploymentRange <= maxEmploymentRange
		}
		#refinement dependency 'TR-002' to FunctionalRequirementsPackage::'FR-007';
	}

	requirement def <'TR-003'> BaselineVHFVoiceVectoringRequirement {
		doc /* The A-29 baseline shall receive UAS heading information from E-99M via VHF voice communication at update intervals randomly drawn from [5, 60] seconds. */
		@Rationale {
			text = "This requirement reflects the operational limitation of voice vectoring without digital datalink, constraining the interceptor's ability to rapidly update pursuit geometry and contributing to the baseline performance characterization.";
		}
		attribute actualUpdateInterval :> ISQ::time;
		attribute minUpdateInterval :> ISQ::time = 5 [s];
		attribute maxUpdateInterval :> ISQ::time = 60 [s];
		require constraint {
			(actualUpdateInterval >= minUpdateInterval) and
			(actualUpdateInterval <= maxUpdateInterval)
		}
		#refinement dependency 'TR-003' to FunctionalRequirementsPackage::'FR-003';
	}

	requirement def <'TR-004'> ModernizedDatalinkCueingRequirement {
		doc /* The A-29N shall receive UAS geographic coordinates from E-99M via R&S M3AR digital datalink at update intervals randomly drawn from [1, 10] seconds. */
		@Rationale {
			text = "The C-UAS avionic system's capability to provide faster, more precise target cueing via digital datalink reduces interceptor reaction time and enables more effective tracking compared to voice communication.";
		}
		attribute actualUpdateInterval :> ISQ::time;
		attribute minUpdateInterval :> ISQ::time = 1 [s];
		attribute maxUpdateInterval :> ISQ::time = 10 [s];
		require constraint {
			(actualUpdateInterval >= minUpdateInterval) and
			(actualUpdateInterval <= maxUpdateInterval)
		}
		#refinement dependency 'TR-004' to FunctionalRequirementsPackage::'FR-003';
	}

	requirement def <'TR-005'> BaselineNakedEyeVisualAcquisitionRequirement {
		doc /* The A-29 baseline shall rely on naked-eye visual acquisition of UAS within a maximum distance of 13 km, subject to a minimum acquisition and reaction time of 12.5 seconds. */
		@Rationale {
			text = "This requirement reflects the physiological limitations of human vision and cognitive reaction time, constraining the baseline interceptor's ability to acquire and respond to small UAS targets without sensor augmentation.";
		}
		attribute actualAcquisitionDistance :> ISQ::length;
		attribute maxAcquisitionDistance :> ISQ::length = 13 [km];
		attribute actualAcquisitionTime :> ISQ::time;
		attribute minAcquisitionTime :> ISQ::time = 12.5 [s];
		require constraint {
			(actualAcquisitionDistance <= maxAcquisitionDistance) and
			(actualAcquisitionTime >= minAcquisitionTime)
		}
		#refinement dependency 'TR-005' to FunctionalRequirementsPackage::'FR-004';
	}

	requirement def <'TR-006'> ModernizedEOIRSensorAcquisitionRequirement {
		doc /* The A-29N shall employ a FLIR Star SAFIRE II EO/IR sensor with laser rangefinder maximum range of 20 km and accuracy of 5 m for UAS acquisition, tracking, and designation. */
		@Rationale {
			text = "This requirement overcomes the visual acquisition limitations of the baseline configuration, enabling earlier detection, continuous tracking, and precision laser designation of UAS targets at extended ranges.";
		}
		attribute actualLaserRangefinderRange :> ISQ::length;
		attribute maxLaserRangefinderRange :> ISQ::length = 20 [km];
		attribute actualRangefinderAccuracy :> ISQ::length;
		attribute maxRangefinderAccuracy :> ISQ::length = 5 [m];
		require constraint {
			(actualLaserRangefinderRange <= maxLaserRangefinderRange) and
			(actualRangefinderAccuracy <= maxRangefinderAccuracy)
		}
		#refinement dependency 'TR-006' to FunctionalRequirementsPackage::'FR-004';
		#refinement dependency 'TR-006' to FunctionalRequirementsPackage::'FR-005';
	}

	requirement def <'TR-007'> E99MPS890RadarDetectionRequirement {
		doc /* The E-99M shall employ a PS-890 Erieye S-band airborne radar to detect illicit UAS incursions crossing the Brazilian border into ZIDA airspace. */
		@Rationale {
			text = "Continuous airborne surveillance is necessary to complement ground radar and detect low-altitude UAS incursions across the vast Amazon border area, enabling timely interceptor notification.";
		}
		attribute radarBand : ScalarValues::String = "S-band";
		attribute radarDesignation : ScalarValues::String = "PS-890 Erieye";
		require constraint {
			radarBand == "S-band"
		}
		#refinement dependency 'TR-007' to FunctionalRequirementsPackage::'FR-001';
	}

	requirement def <'TR-008'> SixCAPPointSpacingRequirement {
		doc /* The mission shall position six A-29 aircraft at CAP points spaced 300 km apart to enable mutual support and comprehensive coverage of six Areas of Interest. */
		@Rationale {
			text = "This requirement ensures operational coverage of the Amazon border segment while maintaining the capability for mutual support among interceptors, with 300 km spacing enabling approximately 30 minutes flight time between CAP points.";
		}
		attribute actualCAPPointCount : ScalarValues::Integer;
		attribute requiredCAPPointCount : ScalarValues::Integer = 6;
		attribute actualCAPPointSpacing :> ISQ::length;
		attribute requiredCAPPointSpacing :> ISQ::length = 300 [km];
		require constraint {
			(actualCAPPointCount == requiredCAPPointCount) and
			(actualCAPPointSpacing == requiredCAPPointSpacing)
		}
		#refinement dependency 'TR-008' to FunctionalRequirementsPackage::'FR-009';
	}

	requirement def <'TR-009'> FourFARPOptimizedPositioningRequirement {
		doc /* The mission shall employ four FARP points (SBCZ, SWKU, SDCG, SBRB) positioned to minimize transit time and maximize time on station for airspace policing. */
		@Rationale {
			text = "FARP optimization methodology ensures the largest possible proportion of aircraft endurance is dedicated exclusively to airspace policing, reducing transit time and maximizing interception capability.";
		}
		attribute actualFARPCount : ScalarValues::Integer;
		attribute requiredFARPCount : ScalarValues::Integer = 4;
		require constraint {
			actualFARPCount == requiredFARPCount
		}
		#refinement dependency 'TR-009' to FunctionalRequirementsPackage::'FR-011';
	}

	requirement def <'TR-010'> CruiseSpeedStandardizationRequirement {
		doc /* The A-29 aircraft shall operate at cruise speed (280 KCAS ≈ 144 m/s) during all flight phases (SBPV to FARP, FARP to CAP, CAP to FARP, FARP to SBPV). */
		@Rationale {
			text = "Standardized flight profile assumptions are necessary for endurance calculations and ensure consistent mission timeline modeling across all aircraft in the simulation.";
		}
		attribute actualCruiseSpeed :> ISQ::speed;
		attribute requiredCruiseSpeed :> ISQ::speed = 144 [m/s];
		require constraint {
			actualCruiseSpeed == requiredCruiseSpeed
		}
		#refinement dependency 'TR-010' to FunctionalRequirementsPackage::'FR-011';
	}

	requirement def <'TR-011'> MaximumEnduranceConstraintRequirement {
		doc /* The A-29 aircraft shall achieve a maximum endurance of 5.2 hours with two external tanks and EO/IR sensor configuration. */
		@Rationale {
			text = "This requirement constrains the maximum time available for airspace policing per sortie, directly limiting the duration of Phase 4 (PEA) and necessitating FARP refueling for return leg.";
		}
		attribute actualEndurance :> ISQ::time;
		attribute maxEndurance :> ISQ::time = 5.2 [h];
		require constraint {
			actualEndurance <= maxEndurance
		}
		#refinement dependency 'TR-011' to FunctionalRequirementsPackage::'FR-010';
		#refinement dependency 'TR-011' to FunctionalRequirementsPackage::'FR-013';
	}

	requirement def <'TR-012'> BaselineVisualAcquisitionDimensionalPenaltyRequirement {
		doc /* The A-29 baseline visual acquisition system shall apply a dimensional penalty (1/14 modifier) for multi-rotor UAS relative to fixed-wing UAS. */
		@Rationale {
			text = "This requirement reflects the realistic challenge of visually acquiring diminutive multi-rotor targets (1 m) against jungle background contrast compared to larger fixed-wing UAS (14 m), directly impacting baseline interception success probability.";
		}
		attribute actualDimensionalPenalty : ScalarValues::Real;
		attribute requiredDimensionalPenalty : ScalarValues::Real = 0.071428571; // 1/14
		require constraint {
			actualDimensionalPenalty == requiredDimensionalPenalty
		}
		#refinement dependency 'TR-012' to FunctionalRequirementsPackage::'FR-004';
	}

	requirement def <'TR-013'> ModernizedEOIRTrackingDimensionalPenaltyRequirement {
		doc /* The A-29N EO/IR sensor tracking system shall apply a dimensional penalty (1/5 modifier) for multi-rotor UAS relative to sensor accuracy. */
		@Rationale {
			text = "This requirement accounts for intermittent tracking losses when the multi-rotor UAS dimension (1 m) is smaller than the laser rangefinder accuracy (5 m), requiring datalink coordinate updates for track recovery.";
		}
		attribute actualDimensionalPenalty : ScalarValues::Real;
		attribute requiredDimensionalPenalty : ScalarValues::Real = 0.2; // 1/5
		require constraint {
			actualDimensionalPenalty == requiredDimensionalPenalty
		}
		#refinement dependency 'TR-013' to FunctionalRequirementsPackage::'FR-005';
	}

	requirement def <'TR-014'> APKWSHitProbabilitySpecificationRequirement {
		doc /* The APKWS laser-guided rocket shall achieve an 80% hit probability within 2 meters of the laser spot center at minimum range (2 km), decreasing linearly to 0% at maximum range (14 km). */
		@Rationale {
			text = "This requirement represents the public performance specification of the APKWS system on fixed-wing platforms, establishing the precision capability advantage over unguided rockets for UAS neutralization.";
		}
		attribute actualHitProbabilityAtMinRange : ScalarValues::Real;
		attribute requiredHitProbabilityAtMinRange : ScalarValues::Real = 0.8;
		attribute actualHitProbabilityAtMaxRange : ScalarValues::Real;
		attribute requiredHitProbabilityAtMaxRange : ScalarValues::Real = 0.0;
		attribute laserSpotAccuracy :> ISQ::length = 2 [m];
		attribute minRange :> ISQ::length = 2 [km];
		attribute maxRange :> ISQ::length = 14 [km];
		require constraint {
			(actualHitProbabilityAtMinRange >= requiredHitProbabilityAtMinRange) and
			(actualHitProbabilityAtMaxRange == requiredHitProbabilityAtMaxRange)
		}
		#refinement dependency 'TR-014' to FunctionalRequirementsPackage::'FR-007';
	}

	requirement def <'TR-015'> SBAT70UnguidedHitProbabilityRequirement {
		doc /* The A-29 baseline SBAT-70 unguided rocket shall achieve an 80% hit probability at minimum range (0.5 km), decreasing linearly to 0% at maximum range (2 km). */
		@Rationale {
			text = "This requirement is a modeling hypothesis to represent the reduced precision of unguided munitions compared to laser-guided rockets, enabling comparative analysis of neutralization effectiveness between configurations.";
		}
		attribute actualHitProbabilityAtMinRange : ScalarValues::Real;
		attribute requiredHitProbabilityAtMinRange : ScalarValues::Real = 0.8;
		attribute actualHitProbabilityAtMaxRange : ScalarValues::Real;
		attribute requiredHitProbabilityAtMaxRange : ScalarValues::Real = 0.0;
		attribute minRange :> ISQ::length = 0.5 [km];
		attribute maxRange :> ISQ::length = 2 [km];
		require constraint {
			(actualHitProbabilityAtMinRange >= requiredHitProbabilityAtMinRange) and
			(actualHitProbabilityAtMaxRange == requiredHitProbabilityAtMaxRange)
		}
		#refinement dependency 'TR-015' to FunctionalRequirementsPackage::'FR-007';
	}

	requirement def <'TR-016'> MultiRotorEngagementDimensionalPenaltyRequirement {
		doc /* The mission shall apply a 0.5 dimensional penalty modifier to hit probability for both configurations when engaging multi-rotor UAS. */
		@Rationale {
			text = "This requirement accounts for the reduced dimensions of multi-rotor UAS (1 m) relative to APKWS accuracy specification (2 m), reflecting the increased difficulty of achieving kinetic neutralization against smaller targets.";
		}
		attribute actualDimensionalPenalty : ScalarValues::Real;
		attribute requiredDimensionalPenalty : ScalarValues::Real = 0.5;
		require constraint {
			actualDimensionalPenalty == requiredDimensionalPenalty
		}
		#refinement dependency 'TR-016' to FunctionalRequirementsPackage::'FR-007';
	}

	requirement def <'TR-017'> E99MContinuousPresenceRequirement {
		doc /* The E-99M shall maintain continuous presence and full coverage in the scenario border area for the duration of the mission. */
		@Rationale {
			text = "This requirement is an idealization adopted to isolate A-29 performance analysis, ensuring that AEW capability does not limit the mission and that vectoring support is always available to interceptors.";
		}
		attribute actualCoveragePercentage : ScalarValues::Real;
		attribute requiredCoveragePercentage : ScalarValues::Real = 1.0; // 100%
		require constraint {
			actualCoveragePercentage >= requiredCoveragePercentage
		}
		#refinement dependency 'TR-017' to FunctionalRequirementsPackage::'FR-001';
	}

	requirement def <'TR-018'> E99MRadarDetectionIdealizedRequirement {
		doc /* The E-99M radar detection performance shall be idealized with no failures to isolate A-29 performance analysis. */
		@Rationale {
			text = "This requirement removes E-99M radar detection variability as a confounding factor, ensuring that mission effectiveness differences are attributable solely to A-29 configuration capabilities.";
		}
		attribute actualDetectionFailureRate : ScalarValues::Real;
		attribute maxDetectionFailureRate : ScalarValues::Real = 0.0;
		require constraint {
			actualDetectionFailureRate == maxDetectionFailureRate
		}
		#refinement dependency 'TR-018' to FunctionalRequirementsPackage::'FR-001';
	}

	requirement def <'TR-019'> UASEntryPointStochasticDistributionRequirement {
		doc /* The mission shall randomly draw UAS entry points from a normal distribution over 23 sectors (28-50) of the Amazon border polygon with μ = 39 and σ ≈ 3.67. */
		@Rationale {
			text = "This requirement implements the stochastic Monte Carlo simulation methodology to ensure realistic spatial variability of illicit incursions across the Peru-Colombia border segment, avoiding deterministic bias.";
		}
		attribute actualSectorCount : ScalarValues::Integer;
		attribute requiredSectorCount : ScalarValues::Integer = 23;
		attribute minSector : ScalarValues::Integer = 28;
		attribute maxSector : ScalarValues::Integer = 50;
		attribute distributionMean : ScalarValues::Real = 39.0;
		attribute distributionStdDev : ScalarValues::Real = 3.67;
		require constraint {
			(actualSectorCount == requiredSectorCount) and
			(minSector == 28) and
			(maxSector == 50)
		}
	}

	requirement def <'TR-020'> UASHeadingVariationRequirement {
		doc /* The mission shall randomly draw UAS heading with a perpendicular baseline to the entry segment ± 45° variation (normal distribution, σ = 15°). */
		@Rationale {
			text = "This requirement ensures that UAS trajectories exhibit realistic directional variability upon crossing the border, contributing to the unpredictability and representativeness of the interception geometry in the simulation.";
		}
		attribute actualHeadingVariation :> ISQ::planeAngle;
		attribute maxHeadingVariation :> ISQ::planeAngle = 45 ['°'];
		attribute headingStdDev :> ISQ::planeAngle = 15 ['°'];
		require constraint {
			(actualHeadingVariation <= maxHeadingVariation) and
			(actualHeadingVariation >= -maxHeadingVariation)
		}
	}

	requirement def <'TR-021'> UASClassEquiprobabilityRequirement {
		doc /* The mission shall randomly assign illicit incursions as either multi-rotor or fixed-wing UAS with equal probability (50% each) through discrete uniform distribution. */
		@Rationale {
			text = "This requirement maintains impartial equiprobability between the two UAS threat classes, ensuring that simulation results reflect performance against both threat types without bias toward either configuration's strengths.";
		}
		attribute actualMultiRotorProbability : ScalarValues::Real;
		attribute actualFixedWingProbability : ScalarValues::Real;
		attribute requiredProbability : ScalarValues::Real = 0.5;
		require constraint {
			(actualMultiRotorProbability == requiredProbability) and
			(actualFixedWingProbability == requiredProbability)
		}
	}

	requirement def <'TR-022'> FiringPhilosophyEquiprobabilityRequirement {
		doc /* The A-29 pilot shall randomly draw firing philosophy (short, medium, or long range) with equal probability (1/3 each) through discrete uniform distribution. */
		@Rationale {
			text = "This requirement simplifies pilot decision-making variability in an impartial manner, ensuring that firing distance selection does not introduce bias toward either interceptor configuration's optimal engagement range.";
		}
		attribute actualShortRangeProbability : ScalarValues::Real;
		attribute actualMediumRangeProbability : ScalarValues::Real;
		attribute actualLongRangeProbability : ScalarValues::Real;
		attribute requiredProbability : ScalarValues::Real = 0.333333333; // 1/3
		require constraint {
			(actualShortRangeProbability == requiredProbability) and
			(actualMediumRangeProbability == requiredProbability) and
			(actualLongRangeProbability == requiredProbability)
		}
	}

	requirement def <'TR-023'> PEASimultaneousCommencementRequirement {
		doc /* The mission shall commence Phase 4 (PEA) simultaneously for all aircraft at T+153 minutes when the last aircraft (A-29-6) reaches its CAP point. */
		@Rationale {
			text = "This requirement synchronizes the start of airspace policing across all six interceptors, ensuring that stochastic UAS incursions are exposed to the full defensive posture from a common temporal baseline.";
		}
		attribute actualPEACommencementTime :> ISQ::time;
		attribute requiredPEACommencementTime :> ISQ::time = 153 [min];
		require constraint {
			actualPEACommencementTime == requiredPEACommencementTime
		}
		#refinement dependency 'TR-023' to FunctionalRequirementsPackage::'FR-012';
	}

	requirement def <'TR-024'> EngagementExclusivityRequirement {
		doc /* The A-29 aircraft shall maintain engagement exclusivity such that while intercepting a UAS, no new target is assigned to that aircraft. */
		@Rationale {
			text = "This requirement prevents simultaneous multi-target engagement complexity, simplifying the simulation to isolate single-engagement performance characteristics and avoid resource contention effects.";
		}
		attribute actualSimultaneousTargets : ScalarValues::Integer;
		attribute maxSimultaneousTargets : ScalarValues::Integer = 1;
		require constraint {
			actualSimultaneousTargets <= maxSimultaneousTargets
		}
		#refinement dependency 'TR-024' to FunctionalRequirementsPackage::'FR-002';
	}

	requirement def <'TR-025'> EngagementTerminationAndCAPReturnRequirement {
		doc /* The A-29 aircraft shall terminate interception upon neutralization or evasion from continental ZIDA, immediately returning to CAP point for further interceptions until minimum fuel is reached. */
		@Rationale {
			text = "This requirement defines the engagement cycle termination condition, enabling continuous interception attempts throughout the available endurance window while preserving fuel reserve for return to FARP.";
		}
		attribute neutralizationAchieved : ScalarValues::Boolean;
		attribute evasionFromZIDA : ScalarValues::Boolean;
		attribute minFuelReached : ScalarValues::Boolean;
		require constraint {
			(neutralizationAchieved or evasionFromZIDA) or minFuelReached
		}
		#refinement dependency 'TR-025' to FunctionalRequirementsPackage::'FR-013';
	}

	requirement def <'TR-026'> DatalinkLatencyIdealizedRequirement {
		doc /* The datalink coordinate transmission latency from E-99M to A-29N shall be idealized as instantaneous. */
		@Rationale {
			text = "This idealization isolates the A-29N pilot's manual coordinate entry time ([1, 10] s) as the sole latency factor, avoiding confounding communication delay variability and ensuring consistent performance assessment.";
		}
		attribute actualDatalinkLatency :> ISQ::time;
		attribute maxDatalinkLatency :> ISQ::time = 0 [s];
		require constraint {
			actualDatalinkLatency == maxDatalinkLatency
		}
		#refinement dependency 'TR-026' to FunctionalRequirementsPackage::'FR-003';
	}

	requirement def <'TR-027'> RefuelingDurationDisregardedRequirement {
		doc /* The FARP refueling duration shall be disregarded in simulation timeline calculations as a simplification assumption. */
		@Rationale {
			text = "This simplification eliminates variability in ground operations time, focusing the model exclusively on airborne mission phases and enabling direct comparison of airspace policing effectiveness.";
		}
		attribute actualRefuelingDuration :> ISQ::time;
		attribute modeledRefuelingDuration :> ISQ::time = 0 [s];
		require constraint {
			actualRefuelingDuration == modeledRefuelingDuration
		}
		#refinement dependency 'TR-027' to FunctionalRequirementsPackage::'FR-010';
	}

	requirement def <'TR-028'> MultiRotorMaxSpeedRequirement {
		doc /* The multi-rotor UAS shall operate at a maximum velocity of 29 m/s during flight within ZIDA airspace. */
		@Rationale {
			text = "This requirement reflects the physical performance limitation of multi-rotor UAS class, directly impacting pursuit timeline and evasion probability for baseline and modernized interceptors.";
		}
		attribute actualMaxSpeed :> ISQ::speed;
		attribute requiredMaxSpeed :> ISQ::speed = 29 [m/s];
		require constraint {
			actualMaxSpeed <= requiredMaxSpeed
		}
		#refinement dependency 'TR-028' to FunctionalRequirementsPackage::'FR-006';
	}

	requirement def <'TR-029'> FixedWingMaxSpeedRequirement {
		doc /* The fixed-wing UAS shall operate at a maximum velocity of 130 m/s during flight within ZIDA airspace. */
		@Rationale {
			text = "This requirement reflects the physical performance limitation of fixed-wing UAS class, establishing a faster-moving threat profile that challenges interceptor tracking and engagement timeline compared to multi-rotor.";
		}
		attribute actualMaxSpeed :> ISQ::speed;
		attribute requiredMaxSpeed :> ISQ::speed = 130 [m/s];
		require constraint {
			actualMaxSpeed <= requiredMaxSpeed
		}
		#refinement dependency 'TR-029' to FunctionalRequirementsPackage::'FR-006';
	}

	requirement def <'TR-030'> ZIDABoundaryDistanceRequirement {
		doc /* The continental ZIDA boundary shall be defined as 80 nautical miles (≈ 148 km) from the Brazilian border as the mission success threshold. */
		@Rationale {
			text = "This requirement establishes the geographic limit beyond which UAS penetration constitutes mission failure, directly determining the time and distance available for interception.";
		}
		attribute actualZIDABoundaryDistance :> ISQ::length;
		attribute requiredZIDABoundaryDistance :> ISQ::length = 80 [nmi];
		require constraint {
			actualZIDABoundaryDistance == requiredZIDABoundaryDistance
		}
	}
}
