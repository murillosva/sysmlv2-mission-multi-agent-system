package FunctionalRequirementsPackage {

	private import SI::*;
	private import ISQ::*;
	private import ScalarValues::*;
	private import CoSMAPackage::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import ModelingMetadata::*;
	private import MissionRequirementsPackage::*;

	requirement def <'FR-001'> AircraftTakeoffResponseTimeRequirement {
		doc /* The system shall execute aircraft takeoff sequence from SBPV within 5 minutes of mission activation authorization. */
		@Rationale {
			text = "Rapid response requirement ensures interceptor availability window is maximized; directly supports ALEVOO (Alerta Vermelha) air defense posture readiness.";
		}
		attribute actualTakeoffTime :> ISQ::time;
		attribute maxAllowedTakeoffTime :> ISQ::time = 5 [min];
		require constraint {
			actualTakeoffTime <= maxAllowedTakeoffTime
		}
		#refinement dependency 'FR-001' to MissionRequirementsPackage::'MR-006';
	}

	requirement def <'FR-002'> CruiseSpeedNormalizationRequirement {
		doc /* The system shall maintain direct-route cruise speed of 280 KCAS (≈144 m/s) during all transits (SBPV→FARP, FARP→CAP, CAP→FARP, FARP→SBPV). */
		@Rationale {
			text = "Fixed cruise speed simplifies fuel burn calculations, ensures predictable arrival times at FARP/CAP points, and optimizes total endurance budget for mission window.";
		}
		attribute requiredCruiseSpeed :> ISQ::speed = 144 [m/s];
		attribute cruiseSpeedTolerance :> ISQ::speed = 5 [m/s];
		require constraint {
			(requiredCruiseSpeed - cruiseSpeedTolerance) <= actualCruiseSpeed and actualCruiseSpeed <= (requiredCruiseSpeed + cruiseSpeedTolerance)
		}
		#refinement dependency 'FR-002' to MissionRequirementsPackage::'MR-006';
	}

	requirement def <'FR-003'> BaselineVoiceCommunicationVectoringRequirement {
		doc /* The system shall enable A-29 baseline aircraft to receive target heading vectors from E-99M via VHF voice communication at intervals sampled from uniform distribution [5, 60] seconds. */
		@Rationale {
			text = "Voice communication is legacy air defense standard; interval distribution models human operator variability in traffic load and communication window availability.";
		}
		attribute minVoiceUpdateInterval :> ISQ::time = 5 [s];
		attribute maxVoiceUpdateInterval :> ISQ::time = 60 [s];
		require constraint {
			voiceVectoringInterval >= minVoiceUpdateInterval and voiceVectoringInterval <= maxVoiceUpdateInterval
		}
		#refinement dependency 'FR-003' to MissionRequirementsPackage::'MR-004';
	}

	requirement def <'FR-004'> DataLinkCoordinateReceptionRequirement {
		doc /* The system shall enable A-29N aircraft to receive target geographic coordinates via Rohde & Schwarz R&S®M3AR datalink at intervals sampled from uniform distribution [1, 10] seconds. */
		@Rationale {
			text = "Datalink enables faster, more accurate target cueing than voice; narrower update interval reduces trajectory error and enables EO/IR sensor scan to converge on target.";
		}
		attribute minDataLinkUpdateInterval :> ISQ::time = 1 [s];
		attribute maxDataLinkUpdateInterval :> ISQ::time = 10 [s];
		require constraint {
			dataLinkUpdateInterval >= minDataLinkUpdateInterval and dataLinkUpdateInterval <= maxDataLinkUpdateInterval
		}
		#refinement dependency 'FR-004' to MissionRequirementsPackage::'MR-005';
	}

	requirement def <'FR-005'> CoordinateReceptionSensitivityRequirement {
		doc /* The system shall parameterize A-29N coordinate reception sensitivity as pilot manual entry time with uniform distribution [1, 10] seconds. */
		@Rationale {
			text = "Modeling hypothesis for human factors in A-29N cockpit workflow; represents time from datalink reception to coordinate input and navigation system display update.";
		}
		attribute minPilotEntryTime :> ISQ::time = 1 [s];
		attribute maxPilotEntryTime :> ISQ::time = 10 [s];
		require constraint {
			pilotManualEntryTime >= minPilotEntryTime and pilotManualEntryTime <= maxPilotEntryTime
		}
		#refinement dependency 'FR-005' to MissionRequirementsPackage::'MR-005';
	}

	requirement def <'FR-006'> BaselineVisualAcquisitionDistanceRequirement {
		doc /* The system shall limit A-29 baseline pilot visual acquisition distance to maximum 13 kilometers (7 nautical miles). */
		@Rationale {
			text = "This is the physiological and atmospheric limit for naked-eye detection and recognition of small aerial targets in equatorial jungle environment.";
		}
		attribute maxVisualAcquisitionDistance :> ISQ::length = 13 [km];
		require constraint {
			visualAcquisitionDistance <= maxVisualAcquisitionDistance
		}
		#refinement dependency 'FR-006' to MissionRequirementsPackage::'MR-004';
	}

	requirement def <'FR-007'> BaselineAcquisitionReactionTimeRequirement {
		doc /* The system shall impose minimum 12.5 seconds cumulative time (see, recognize, decide, motor response) for A-29 baseline pilot visual acquisition and reaction. */
		@Rationale {
			text = "Empirical human factors constraint representing latency from visual contact to heading modification initiation; shorter times violate human physiology.";
		}
		attribute minAcquisitionReactionTime :> ISQ::time = 12.5 [s];
		require constraint {
			acquisitionReactionTime >= minAcquisitionReactionTime
		}
		#refinement dependency 'FR-007' to MissionRequirementsPackage::'MR-004';
	}

	requirement def <'FR-008'> BaselineMultirotorVisualPenaltyRequirement {
		doc /* The system shall apply dimensional penalty (1/14 ratio) to A-29 baseline visual acquisition for multi-rotor UAS due to reduced visible area and background contrast. */
		@Rationale {
			text = "Multi-rotor visual cross-section (~1 m) is 1/14 of fixed-wing (~14 m); jungle background contrast degrades small-target visibility.";
		}
		attribute multirotorVisualPenaltyRatio : ScalarValues::Real = 0.0714;
		attribute fixedWingVisualPenaltyRatio : ScalarValues::Real = 1.0;
		require constraint {
			multirotorVisualPenaltyRatio == (1.0 / 14.0)
		}
		#refinement dependency 'FR-008' to MissionRequirementsPackage::'MR-004';
	}

	requirement def <'FR-009'> EORIRSensorRangeRequirement {
		doc /* The system shall equip A-29N with EO/IR sensor (FLIR Star SAFIRE II) having laser rangefinder maximum range 20 kilometers, range accuracy 5 meters, azimuth 360° continuous, elevation +30° to −120°, and slew rate 60°/s. */
		@Rationale {
			text = "Maximum range enables target detection beyond visual range; range accuracy supports laser designation for guided armament; azimuth/elevation coverage ensures tracking across search volume.";
		}
		attribute maxSensorRange :> ISQ::length = 20 [km];
		attribute rangeAccuracy :> ISQ::length = 5 [m];
		attribute azimuthCoverage :> ISQ::planeAngle = 360 ['°'];
		attribute elevationMin :> ISQ::planeAngle = -120 ['°'];
		attribute elevationMax :> ISQ::planeAngle = 30 ['°'];
		attribute slewRate : ScalarValues::Real = 60 // [°/s];
		require constraint {
			(maxSensorRange == 20 [km]) and (rangeAccuracy == 5 [m]) and (azimuthCoverage == 360 ['°']) and (elevationMin == -120 ['°']) and (elevationMax == 30 ['°']) and (slewRate == 60 // [°/s])
		}
		#refinement dependency 'FR-009' to MissionRequirementsPackage::'MR-005';
	}

	requirement def <'FR-010'> A29NMultirotorSensorTrackingPenaltyRequirement {
		doc /* The system shall incorporate dimensional penalty (1/5 ratio) for multi-rotor UAS in A-29N EO/IR tracking based on target size relative to sensor accuracy (5 meters). */
		@Rationale {
			text = "Multi-rotor (~1 m) is 1/5 of sensor accuracy (5 m); tracking loss occurs intermittently when target dimension < sensor resolution.";
		}
		attribute multirotorTrackingPenaltyRatio : ScalarValues::Real = 0.2;
		attribute sensorAccuracy :> ISQ::length = 5 [m];
		require constraint {
			multirotorTrackingPenaltyRatio == (1.0 / 5.0)
		}
		#refinement dependency 'FR-010' to MissionRequirementsPackage::'MR-005';
	}

	requirement def <'FR-011'> BaselineUnguideArmamentEnvelopeRequirement {
		doc /* The system shall configure A-29 baseline armament as SBAT-70 unguided rocket (70 mm diameter, solid propellant, ballistic) with maximum employment range 2 kilometers and minimum range 0.5 kilometers. */
		@Rationale {
			text = "Unguided ballistic trajectory defines employment envelope for baseline configuration; range limits reflect safety constraints and fuse time requirements.";
		}
		attribute rocketDiameter :> ISQ::length = 70 [mm];
		attribute minEmploymentRange :> ISQ::length = 0.5 [km];
		attribute maxEmploymentRange :> ISQ::length = 2 [km];
		require constraint {
			(minEmploymentRange == 0.5 [km]) and (maxEmploymentRange == 2 [km])
		}
		#refinement dependency 'FR-011' to MissionRequirementsPackage::'MR-008';
	}

	requirement def <'FR-012'> BaselineUnguideHitProbabilityRequirement {
		doc /* The system shall implement A-29 baseline SBAT-70 hit probability as linear function from 80% at minimum range (0.5 km) to 0% at maximum range (2 km), including dimensional penalty (1 for fixed-wing, 0.5 for multi-rotor). */
		@Rationale {
			text = "Linear ballistic degradation models unguided trajectory spread; dimensional penalty reflects inherent difficulty engaging small targets.";
		}
		attribute hitProbabilityAtMinRange : ScalarValues::Real = 0.8;
		attribute hitProbabilityAtMaxRange : ScalarValues::Real = 0.0;
		attribute fixedWingPenalty : ScalarValues::Real = 1.0;
		attribute multirotorPenalty : ScalarValues::Real = 0.5;
		require constraint {
			(hitProbabilityAtMinRange == 0.8) and (hitProbabilityAtMaxRange == 0.0)
		}
		#refinement dependency 'FR-012' to MissionRequirementsPackage::'MR-008';
	}

	requirement def <'FR-013'> ModernizedAPKWSArmamentEnvelopeRequirement {
		doc /* The system shall configure A-29N armament as SBAT-70 rocket with Advanced Precision Kill Weapon System (APKWS) laser-guided kit, minimum range 2 kilometers, maximum range 14 kilometers, with 80% hit probability at minimum range. */
		@Rationale {
			text = "APKWS semi-active laser guidance extends maximum range significantly (14 km vs. 2 km baseline); enables engagement beyond unguided envelope at safer standoff distance.";
		}
		attribute apkwsMinRange :> ISQ::length = 2 [km];
		attribute apkwsMaxRange :> ISQ::length = 14 [km];
		attribute apkwsHitProbabilityAtMinRange : ScalarValues::Real = 0.8;
		require constraint {
			(apkwsMinRange == 2 [km]) and (apkwsMaxRange == 14 [km]) and (apkwsHitProbabilityAtMinRange == 0.8)
		}
		#refinement dependency 'FR-013' to MissionRequirementsPackage::'MR-008';
	}

	requirement def <'FR-014'> ModernizedAPKWSHitProbabilityRequirement {
		doc /* The system shall implement A-29N APKWS hit probability as linear function from 80% at minimum range (2 km) to 0% at maximum range (14 km), including dimensional penalty (1 for fixed-wing, 0.5 for multi-rotor). */
		@Rationale {
			text = "Linear guidance degradation models laser spot tracking error vs. range; dimensional penalty reflects target aspect and seeker acquisition difficulty.";
		}
		attribute apkwsHitProbabilityAtMax : ScalarValues::Real = 0.0;
		attribute apkwsFixedWingPenalty : ScalarValues::Real = 1.0;
		attribute apkwsMultirotorPenalty : ScalarValues::Real = 0.5;
		require constraint {
			(apkwsHitProbabilityAtMax == 0.0) and (apkwsFixedWingPenalty == 1.0) and (apkwsMultirotorPenalty == 0.5)
		}
		#refinement dependency 'FR-014' to MissionRequirementsPackage::'MR-008';
	}

	requirement def <'FR-015'> AirborneRadarContinuousAvailabilityRequirement {
		doc /* The system shall assume E-99M PS-890 Erieye radar operates in S-band with reported detection range on order of hundreds of kilometers and continuous availability (no operational gaps or sensor failures). */
		@Rationale {
			text = "S-band operation is optimal for medium/long-range surveillance; continuous availability assumption isolates A-29 platform performance impact from radar system variability.";
		}
		attribute radarBandDesignation : ScalarValues::String = "S-band";
		attribute minDetectionRange :> ISQ::length = 100 [km];
		attribute radarAvailability : ScalarValues::Real = 1.0;
		require constraint {
			radarAvailability >= 1.0
		}
		#refinement dependency 'FR-015' to MissionRequirementsPackage::'MR-002';
	}

	requirement def <'FR-016'> FARPNetworkCoverageRequirement {
		doc /* The system shall implement FARP network consisting of four aerodromes (SBRB, SBCZ, SDCG, SWKU) positioned to cover all six CAP points within acceptable transit distance (≤ 26 minutes per aircraft). */
		@Rationale {
			text = "Optimal FARP positioning minimizes transit time, maximizing time-on-station for Airspace Policing phase; longer transit reduces operational window proportionally.";
		}
		attribute farpCount : ScalarValues::Integer = 4;
		attribute capPointCount : ScalarValues::Integer = 6;
		attribute maxTransitTime :> ISQ::time = 26 [min];
		require constraint {
			farpTransitTime <= maxTransitTime
		}
		#refinement dependency 'FR-016' to MissionRequirementsPackage::'MR-006';
	}

	requirement def <'FR-017'> FARPFuelServicingCapacityRequirement {
		doc /* The system shall configure FARP fuel servicing to refill A-29 with two external tanks enabling 5.2-hour endurance. */
		@Rationale {
			text = "Endurance directly constrains mission window; two tanks balance weight/balance vs. endurance requirements for sustained patrol operations.";
		}
		attribute externalTankCount : ScalarValues::Integer = 2;
		attribute requiredEndurance :> ISQ::time = 5.2 [h];
		require constraint {
			achievedEndurance >= requiredEndurance
		}
		#refinement dependency 'FR-017' to MissionRequirementsPackage::'MR-006';
	}

	requirement def <'FR-018'> FARPBaselineOrdnanceLoadingRequirement {
		doc /* The system shall configure FARP ordnance loading (baseline) to provision SBAT-70 rocket pods with sufficient ammunition load for projected sortie engagement count. */
		@Rationale {
			text = "Ammunition load-out per mission plan; limited pod capacity vs. endurance constrains reload cycles at FARP.";
		}
		attribute rocketPodCapacity : ScalarValues::Integer; // estimated
		attribute projecteddEngagementCount : ScalarValues::Integer; // estimated
		require constraint {
			rocketPodCapacity >= projecteddEngagementCount
		}
		#refinement dependency 'FR-018' to MissionRequirementsPackage::'MR-008';
	}

	requirement def <'FR-019'> FARPModernizedOrdnanceLoadingRequirement {
		doc /* The system shall configure FARP ordnance loading (A-29N) to integrate SBAT-70 rockets with APKWS laser-guided kits, including subsystem preflight and laser designator checks. */
		@Rationale {
			text = "A-29N integration adds complexity in datalink checkout, EO/IR sensor alignment, laser designator boresight verification, and kit mechanical attachment.";
		}
		attribute apkwsKitIntegrationRequired : ScalarValues::Boolean = true;
		attribute laserDesignatorBoresightCheckRequired : ScalarValues::Boolean = true;
		attribute eoirSensorAlignmentCheckRequired : ScalarValues::Boolean = true;
		require constraint {
			apkwsKitIntegrationRequired and laserDesignatorBoresightCheckRequired and eoirSensorAlignmentCheckRequired
		}
		#refinement dependency 'FR-019' to MissionRequirementsPackage::'MR-005';
	}

	requirement def <'FR-020'> ContinentalZIDACoverageSectoringRequirement {
		doc /* The system shall organize continental ZIDA surveillance into six Areas of Interest, each assigned one A-29 CAP point, spaced 300 kilometers apart enabling ~30 minutes flight time between points for mutual support. */
		@Rationale {
			text = "300 km spacing balances coverage density with aircraft endurance and enables mutual support capability; 30-minute transit provides relief swap and tactical flexibility.";
		}
		attribute zidaAreaCount : ScalarValues::Integer = 6;
		attribute capPointSpacing :> ISQ::length = 300 [km];
		attribute mutualSupportTransitTime :> ISQ::time = 30 [min];
		require constraint {
			zidaAreaCount == 6
		}
		#refinement dependency 'FR-020' to MissionRequirementsPackage::'MR-002';
	}

	requirement def <'FR-021'> SimultaneousAirspacePolicingAuthorizationRequirement {
		doc /* The system shall authorize simultaneous Airspace Policing (PEA) to all six A-29 aircraft at T+153 minutes mission milestone (arrival of last aircraft at CAP point). */
		@Rationale {
			text = "Synchronized start enables comparative analysis of baseline vs. A-29N under identical initial conditions; T+153 min is defined by longest transit path.";
		}
		attribute airspacePolicingStartTime :> ISQ::time = 153 [min];
		attribute synchronizedFleetSize : ScalarValues::Integer = 6;
		require constraint {
			airspacePolicingStartTime == 153 [min]
		}
		#refinement dependency 'FR-021' to MissionRequirementsPackage::'MR-003';
	}

	requirement def <'FR-022'> UASThreatStochasticModelingRequirement {
		doc /* The system shall model UAS threat entries using stochastic methodology: entry coordinates and headings from Barros (2025) random generation with sector distribution [μ=39, σ≈3.67] over Amazon border sectors 28–50, and equally likely multi-rotor vs. fixed-wing archetype (50/50 probability). */
		@Rationale {
			text = "Stochastic modeling introduces realistic tactical uncertainty and prevents baseline/A-29N differences from being confounded by favourable threat geometry.";
		}
		attribute sectorDistributionMean : ScalarValues::Real = 39.0;
		attribute sectorDistributionStdDev : ScalarValues::Real = 3.67;
		attribute minSector : ScalarValues::Integer = 28;
		attribute maxSector : ScalarValues::Integer = 50;
		attribute multirotorProbability : ScalarValues::Real = 0.5;
		attribute fixedWingProbability : ScalarValues::Real = 0.5;
		require constraint {
			(multirotorProbability == 0.5) and (fixedWingProbability == 0.5)
		}
	}

	requirement def <'FR-023'> EngagementOutcomeAssessmentRequirement {
		doc /* The system shall assess engagement outcome for each interception as one of: (1) Neutralized — UAS destroyed; (2) Evaded — UAS crosses 80 nmi ZIDA boundary; (3) Tracking Lost — Tracking broken before weapon employment. */
		@Rationale {
			text = "Three-state outcome model captures all mission-relevant interception results and enables measurement of mission effectiveness and evasion reduction.";
		}
		attribute zidaBoundary :> ISQ::length = 80 [nmi];
		attribute outcomeNeutralized : ScalarValues::String = "Neutralized";
		attribute outcomeEvaded : ScalarValues::String = "Evaded";
		attribute outcomeTrackingLost : ScalarValues::String = "Tracking Lost";
		require constraint {
			engagementOutcome == outcomeNeutralized or engagementOutcome == outcomeEvaded or engagementOutcome == outcomeTrackingLost
		}
		#refinement dependency 'FR-023' to MissionRequirementsPackage::'MR-001';
	}

	requirement def <'FR-024'> FiringPhilosophyRandomSelectionRequirement {
		doc /* The system shall enable A-29 pilot to randomly select weapon firing philosophy (short/medium/long range) with equal probability (1/3 each) at moment of shot execution. */
		@Rationale {
			text = "Equal-probability firing philosophy selection introduces tactical variability and prevents deterministic bias in engagement geometry analysis.";
		}
		attribute shortRangeProbability : ScalarValues::Real = 0.333;
		attribute mediumRangeProbability : ScalarValues::Real = 0.333;
		attribute longRangeProbability : ScalarValues::Real = 0.334;
		require constraint {
			(shortRangeProbability >= 0.333) and (mediumRangeProbability >= 0.333) and (longRangeProbability >= 0.334)
		}
		#refinement dependency 'FR-024' to MissionRequirementsPackage::'MR-008';
	}

	requirement def <'FR-025'> LaserDesignationContinuityRequirement {
		doc /* The system shall maintain continuous laser target designation from A-29N throughout rocket flight until impact for APKWS semi-active guidance. */
		@Rationale {
			text = "Semi-active laser guidance requires uninterrupted seeker illumination; loss of designation before impact degrades hit probability to ballistic level.";
		}
		attribute laserDesignationRequired : ScalarValues::Boolean = true;
		attribute designationLossRecoveryTime :> ISQ::time = 0 [s];
		require constraint {
			laserDesignationRequired and designationLossRecoveryTime == 0 [s]
		}
		#refinement dependency 'FR-025' to MissionRequirementsPackage::'MR-005';
	}

}
