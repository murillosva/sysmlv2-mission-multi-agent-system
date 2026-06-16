package TechnicalRequirementsPackage {

	private import SI::*;
	private import ISQ::*;
	private import ScalarValues::*;
	private import CoSMAPackage::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import ModelingMetadata::*;
	private import FunctionalRequirementsPackage::*;
	requirement def <'TR-001'> A29EnduranceSpecificationRequirement {
		doc /* A-29 endurance shall be minimum 5.2 hours with 2 external fuel tanks and integrated EO/IR sensor equipment weight. */
		@Rationale {
			text = "Maximum endurance defines time-on-station for Airspace Policing; constrains cumulative mission window per aircraft (3 h 05 min to 4 h 30 min). Endurance < 5.2 h reduces detection opportunity.";
		}
		attribute actualEndurance :> ISQ::time;
		attribute minEndurance :> ISQ::time = 5.2 [h];
		require constraint { actualEndurance >= minEndurance }
		#refinement dependency 'TR-001' to FunctionalRequirementsPackage::'FR-017';
	}
	requirement def <'TR-002'> A29CruiseSpeedSpecificationRequirement {
		doc /* A-29 cruise speed shall be 280 KCAS (≈ 144 m/s) for all transit and patrol phases. */
		@Rationale {
			text = "Normalized cruise speed enables predictable fuel burn, consistent mission timeline, and interception geometry; variations degrade fuel endurance or timeline fidelity.";
		}
		attribute actualCruiseSpeed :> ISQ::speed;
		attribute nominalCruiseSpeed :> ISQ::speed = 144 [m/s];
		require constraint { actualCruiseSpeed == nominalCruiseSpeed }
		#refinement dependency 'TR-002' to FunctionalRequirementsPackage::'FR-002';
	}
	requirement def <'TR-003'> BaselineVectoringUpdateIntervalSpecificationRequirement {
		doc /* A-29 baseline shall receive target heading vector from E-99M via VHF voice communication at intervals drawn from uniform distribution [5, 60] seconds. */
		@Rationale {
			text = "Voice communication is legacy air defense standard; interval distribution models human operator variability in traffic load and communication window availability.";
		}
		attribute minUpdateInterval :> ISQ::time = 5 [s];
		attribute maxUpdateInterval :> ISQ::time = 60 [s];
		require constraint { (minUpdateInterval > 0) and (maxUpdateInterval >= minUpdateInterval) }
		#refinement dependency 'TR-003' to FunctionalRequirementsPackage::'FR-003';
	}
	requirement def <'TR-004'> A29NDataLinkUpdateIntervalSpecificationRequirement {
		doc /* A-29N shall receive target geographic coordinate via Rohde & Schwarz R&S®M3AR datalink (30 MHz–400 MHz V/UHF, 16 kbit/s data capability) at intervals drawn from uniform distribution [1, 10] seconds. */
		@Rationale {
			text = "Datalink enables faster, more accurate target cueing than voice; narrower update interval reduces trajectory error and enables EO/IR sensor scan convergence.";
		}
		attribute minDataLinkUpdateInterval :> ISQ::time = 1 [s];
		attribute maxDataLinkUpdateInterval :> ISQ::time = 10 [s];
		require constraint { (minDataLinkUpdateInterval > 0) and (maxDataLinkUpdateInterval >= minDataLinkUpdateInterval) }
		#refinement dependency 'TR-004' to FunctionalRequirementsPackage::'FR-004';
	}
	requirement def <'TR-005'> A29NCoordinateReceptionSensitivitySpecificationRequirement {
		doc /* A-29N coordinate reception sensitivity shall be parameterized as pilot manual entry time [1, 10] seconds (uniform distribution). */
		@Rationale {
			text = "Modeling hypothesis for human factors in A-29N cockpit workflow; represents time from datalink reception to coordinate input and navigation system display update.";
		}
		attribute minManualEntryTime :> ISQ::time = 1 [s];
		attribute maxManualEntryTime :> ISQ::time = 10 [s];
		require constraint { (minManualEntryTime > 0) and (maxManualEntryTime >= minManualEntryTime) }
		#refinement dependency 'TR-005' to FunctionalRequirementsPackage::'FR-005';
	}
	requirement def <'TR-006'> BaselineVisualAcquisitionRangeSpecificationRequirement {
		doc /* A-29 baseline pilot visual acquisition distance shall be maximum 13 kilometers (7 nautical miles). */
		@Rationale {
			text = "Physiological and atmospheric limit for naked-eye detection and recognition of small aerial targets in equatorial jungle environment.";
		}
		attribute actualVisualAcquisitionRange :> ISQ::length;
		attribute maxVisualAcquisitionRange :> ISQ::length = 13 [km];
		require constraint { actualVisualAcquisitionRange <= maxVisualAcquisitionRange }
		#refinement dependency 'TR-006' to FunctionalRequirementsPackage::'FR-006';
	}
	requirement def <'TR-007'> BaselineAcquisitionReactionTimeSpecificationRequirement {
		doc /* A-29 baseline pilot visual acquisition and reaction time shall be minimum 12.5 seconds (cumulative: see, recognize, decide, motor response). */
		@Rationale {
			text = "Empirical human factors constraint from Woo et al. (2020); represents latency from visual contact to heading modification initiation.";
		}
		attribute actualAcquisitionReactionTime :> ISQ::time;
		attribute minAcquisitionReactionTime :> ISQ::time = 12.5 [s];
		require constraint { actualAcquisitionReactionTime >= minAcquisitionReactionTime }
		#refinement dependency 'TR-007' to FunctionalRequirementsPackage::'FR-007';
	}
	requirement def <'TR-008'> BaselineMultirotorVisualPenaltySpecificationRequirement {
		doc /* A-29 baseline visual acquisition shall include dimensional penalty (1/14 ratio) for multi-rotor UAS due to reduced visible area and background contrast. */
		@Rationale {
			text = "Multi-rotor visual cross-section (~1 m) is 1/14 of fixed-wing (~14 m); jungle background contrast degrades small-target visibility.";
		}
		attribute multirotorVisualPenaltyFactor : ScalarValues::Real = 0.0714;
		attribute fixedwingVisualPenaltyFactor : ScalarValues::Real = 1.0;
		require constraint { (multirotorVisualPenaltyFactor > 0) and (multirotorVisualPenaltyFactor < fixedwingVisualPenaltyFactor) }
		#refinement dependency 'TR-008' to FunctionalRequirementsPackage::'FR-008';
	}
	requirement def <'TR-009'> EORIRSensorSpecificationRequirement {
		doc /* A-29N EO/IR sensor (FLIR Star SAFIRE II) shall have laser rangefinder maximum range 20 kilometers, range accuracy 5 meters, azimuth 360° continuous, elevation +30° to −120°, and slew rate 60°/s. */
		@Rationale {
			text = "Maximum range enables target detection beyond visual range; range accuracy supports laser designation for guided armament; azimuth/elevation coverage ensures tracking across search volume.";
		}
		attribute maxSensorRange :> ISQ::length = 20 [km];
		attribute rangeAccuracy :> ISQ::length = 5 [m];
		attribute azimuthCoverage :> ISQ::planeAngle = 360 ['°'];
		attribute elevationMin :> ISQ::planeAngle = -120 ['°'];
		attribute elevationMax :> ISQ::planeAngle = 30 ['°'];
		attribute slewRate : ScalarValues::Real = 60;
		require constraint { (maxSensorRange > 0) and (rangeAccuracy > 0) and (slewRate > 0) }
		#refinement dependency 'TR-009' to FunctionalRequirementsPackage::'FR-009';
	}
	requirement def <'TR-010'> A29NMultirotorSensorTrackingPenaltySpecificationRequirement {
		doc /* A-29N EO/IR tracking shall incorporate dimensional penalty (1/5 ratio) for multi-rotor UAS based on target size relative to sensor accuracy (5 meters). */
		@Rationale {
			text = "Multi-rotor (~1 m) is 1/5 of sensor accuracy (5 m); tracking loss occurs intermittently when target dimension < sensor resolution.";
		}
		attribute sensorAccuracy :> ISQ::length = 5 [m];
		attribute multirotorTrackingPenaltyFactor : ScalarValues::Real = 0.2;
		attribute fixedwingTrackingPenaltyFactor : ScalarValues::Real = 1.0;
		require constraint { (multirotorTrackingPenaltyFactor > 0) and (multirotorTrackingPenaltyFactor < fixedwingTrackingPenaltyFactor) }
		#refinement dependency 'TR-010' to FunctionalRequirementsPackage::'FR-010';
	}
	requirement def <'TR-011'> BaselineUnguideArmamentSpecificationRequirement {
		doc /* A-29 baseline armament shall be SBAT-70 unguided rocket (70 mm diameter, solid propellant, ballistic), with maximum employment range 2 kilometers and minimum range 0.5 kilometers. */
		@Rationale {
			text = "Unguided ballistic trajectory; maximum range modeling hypothesis = APKWS minimum range for comparative baseline; minimum range reflects safety/minimum fuse time.";
		}
		attribute rocketDiameter : ScalarValues::Real = 70;
		attribute minEmploymentRange :> ISQ::length = 0.5 [km];
		attribute maxEmploymentRange :> ISQ::length = 2 [km];
		require constraint { (minEmploymentRange > 0) and (maxEmploymentRange > minEmploymentRange) }
		#refinement dependency 'TR-011' to FunctionalRequirementsPackage::'FR-011';
	}
	requirement def <'TR-012'> BaselineUnguideHitProbabilitySpecificationRequirement {
		doc /* A-29 baseline SBAT-70 hit probability shall be linear function from 80% at minimum range (0.5 km) to 0% at maximum range (2 km), including dimensional penalty (1 for fixed-wing, 0.5 for multi-rotor). */
		@Rationale {
			text = "Linear ballistic degradation models unguided trajectory spread; dimensional penalty reflects inherent difficulty engaging small targets.";
		}
		attribute hitProbabilityAtMinRange : ScalarValues::Real = 0.8;
		attribute hitProbabilityAtMaxRange : ScalarValues::Real = 0.0;
		attribute fixedwingEngagementPenalty : ScalarValues::Real = 1.0;
		attribute multirotorEngagementPenalty : ScalarValues::Real = 0.5;
		require constraint { (hitProbabilityAtMinRange > hitProbabilityAtMaxRange) and (multirotorEngagementPenalty < fixedwingEngagementPenalty) }
		#refinement dependency 'TR-012' to FunctionalRequirementsPackage::'FR-012';
	}
	requirement def <'TR-013'> ModernizedAPKWSArmamentSpecificationRequirement {
		doc /* A-29N armament shall be SBAT-70 rocket with Advanced Precision Kill Weapon System (APKWS) laser-guided kit, minimum range 2 kilometers, maximum range 14 kilometers, with 80% hit probability at minimum range. */
		@Rationale {
			text = "APKWS semi-active laser guidance extends maximum range (14 km vs. 2 km baseline); manufacturer-specified 80% hit within 2 m radius; enables safe standoff engagement.";
		}
		attribute minAPKWSRange :> ISQ::length = 2 [km];
		attribute maxAPKWSRange :> ISQ::length = 14 [km];
		attribute hitProbabilityAPKWS : ScalarValues::Real = 0.8;
		attribute desigationAccuracy :> ISQ::length = 2 [m];
		require constraint { (minAPKWSRange > 0) and (maxAPKWSRange > minAPKWSRange) and (hitProbabilityAPKWS > 0) }
		#refinement dependency 'TR-013' to FunctionalRequirementsPackage::'FR-013';
	}
	requirement def <'TR-014'> ModernizedAPKWSHitProbabilitySpecificationRequirement {
		doc /* A-29N APKWS hit probability shall be linear function from 80% at minimum range (2 km) to 0% at maximum range (14 km), including dimensional penalty (1 for fixed-wing, 0.5 for multi-rotor). */
		@Rationale {
			text = "Linear guidance degradation models laser spot tracking error vs. range; dimensional penalty reflects target aspect and seeker acquisition difficulty.";
		}
		attribute apkwsHitProbabilityAtMinRange : ScalarValues::Real = 0.8;
		attribute apkwsHitProbabilityAtMaxRange : ScalarValues::Real = 0.0;
		attribute fixedwingAPKWSPenalty : ScalarValues::Real = 1.0;
		attribute multirotorAPKWSPenalty : ScalarValues::Real = 0.5;
		require constraint { (apkwsHitProbabilityAtMinRange > apkwsHitProbabilityAtMaxRange) and (multirotorAPKWSPenalty < fixedwingAPKWSPenalty) }
		#refinement dependency 'TR-014' to FunctionalRequirementsPackage::'FR-014';
	}
	requirement def <'TR-015'> AirborneRadarDetectionRangeSpecificationRequirement {
		doc /* E-99M PS-890 Erieye radar shall operate in S-band with reported detection range on order of hundreds of kilometers and continuous availability assumption (no operational gaps or sensor failures). */
		@Rationale {
			text = "S-band (8–12 GHz) is optimal for medium/long-range surveillance; hundreds-km range covers extended area; idealized availability isolates A-29 platform performance impact.";
		}
		attribute radarFrequencyBandMin : ScalarValues::Real = 8.0E9 [Hz];
		attribute radarFrequencyBandMax : ScalarValues::Real = 12.0E9 [Hz];
		attribute detectionRangeOrder :> ISQ::length = 250 [km];
		attribute continuousAvailability : ScalarValues::Boolean = true;
		require constraint { (radarFrequencyBandMin > 0) and (radarFrequencyBandMax > radarFrequencyBandMin) and continuousAvailability }
		#refinement dependency 'TR-015' to FunctionalRequirementsPackage::'FR-015';
	}
	requirement def <'TR-016'> FARPNetworkTransitDistanceSpecificationRequirement {
		doc /* FARP network shall consist of four aerodromes (SBRB, SBCZ, SDCG, SWKU) positioned to cover all six CAP points within acceptable transit distance (≤ 26 minutes per aircraft). */
		@Rationale {
			text = "Optimal FARP positioning minimizes transit time, maximizing PEA window; longer transit reduces on-station time proportionally.";
		}
		attribute maxTransitTime :> ISQ::time = 26 [min];
		attribute numFARPs : ScalarValues::Integer = 4;
		attribute numCAPPoints : ScalarValues::Integer = 6;
		require constraint { (maxTransitTime > 0) and (numFARPs > 0) and (numCAPPoints > 0) }
		#refinement dependency 'TR-016' to FunctionalRequirementsPackage::'FR-016';
	}
	requirement def <'TR-017'> FARPFuelServicingConfigurationSpecificationRequirement {
		doc /* FARP fuel servicing shall refill A-29 to two external tanks enabling 5.2-hour endurance (per fuel burn model). */
		@Rationale {
			text = "Endurance directly constrains mission window; two tanks balance weight/balance vs. endurance (three tanks would exceed desired endurance or degrade performance).";
		}
		attribute numExternalTanks : ScalarValues::Integer = 2;
		attribute targetEndurance :> ISQ::time = 5.2 [h];
		require constraint { (numExternalTanks > 0) and (targetEndurance > 0) }
		#refinement dependency 'TR-017' to FunctionalRequirementsPackage::'FR-017';
	}
	requirement def <'TR-018'> FARPBaselineOrdnanceLoadSpecificationRequirement {
		doc /* FARP ordnance loading (baseline) shall configure SBAT-70 rocket pods with sufficient ammunition load for projected sortie engagement count. */
		@Rationale {
			text = "Ammunition load-out per mission plan; limited pod capacity vs. endurance constrains reload cycles at FARP.";
		}
		attribute rocketType : ScalarValues::String = "SBAT-70";
		attribute armamentConfigured : ScalarValues::Boolean = true;
		require constraint { armamentConfigured }
		#refinement dependency 'TR-018' to FunctionalRequirementsPackage::'FR-018';
	}
	requirement def <'TR-019'> FARPModernizedOrdnanceLoadSpecificationRequirement {
		doc /* FARP ordnance loading (A-29N) shall integrate SBAT-70 rockets with APKWS laser-guided kits, including subsystem preflight and laser designator checks. */
		@Rationale {
			text = "A-29N integration adds complexity: datalink checkout, EO/IR sensor alignment, laser designator boresight verification, kit mechanical attachment.";
		}
		attribute apkwsKitIntegrated : ScalarValues::Boolean = true;
		attribute laserDesignatorChecked : ScalarValues::Boolean = true;
		attribute dataLinkCheckoutPerformed : ScalarValues::Boolean = true;
		require constraint { apkwsKitIntegrated and laserDesignatorChecked and dataLinkCheckoutPerformed }
		#refinement dependency 'TR-019' to FunctionalRequirementsPackage::'FR-019';
	}
	requirement def <'TR-020'> ContinentalZIDACoverageSectorSpecificationRequirement {
		doc /* Continental ZIDA surveillance shall cover six Areas of Interest, each assigned one A-29 CAP point, spaced 300 kilometers apart enabling ~30 minutes flight time between points for mutual support. */
		@Rationale {
			text = "300 km spacing balances coverage density with aircraft endurance and mutual support capability; 30-minute transit enables relief swaps or mutual support.";
		}
		attribute capPointSpacing :> ISQ::length = 300 [km];
		attribute numAreasOfInterest : ScalarValues::Integer = 6;
		attribute mutualSupportTransitTime :> ISQ::time = 30 [min];
		require constraint { (capPointSpacing > 0) and (numAreasOfInterest > 0) and (mutualSupportTransitTime > 0) }
		#refinement dependency 'TR-020' to FunctionalRequirementsPackage::'FR-020';
	}
	requirement def <'TR-021'> SimultaneousAuthorizationMilestoneSpecificationRequirement {
		doc /* CINDACTA IV shall generate simultaneous Airspace Policing (PEA) authorization to all six A-29 aircraft at T+153 minutes mission milestone (arrival of last aircraft at CAP point). */
		@Rationale {
			text = "Synchronized start enables comparative analysis of baseline vs. A-29N under identical initial conditions; T+153 min is defined by longest transit path (A-29-6, 132 min to SWKU + 21 min to CAP-6).";
		}
		attribute peaMilestoneTime :> ISQ::time = 153 [min];
		attribute numAuthorizedAircraft : ScalarValues::Integer = 6;
		require constraint { (peaMilestoneTime > 0) and (numAuthorizedAircraft == 6) }
		#refinement dependency 'TR-021' to FunctionalRequirementsPackage::'FR-021';
	}
	requirement def <'TR-022'> UASThreatGenerationMethodologySpecificationRequirement {
		doc /* UAS threat modeling shall employ stochastic entry coordinates and headings from Barros (2025) random generation methodology, with sector distribution [μ=39, σ≈3.67] over Amazon border sectors 28–50, and equally likely multi-rotor vs. fixed-wing archetype (50/50 probability). */
		@Rationale {
			text = "Stochastic modeling introduces realistic tactical uncertainty; equal archetype probability ensures impartial comparison; geometric variation prevents baseline/A-29N differences from being confounded by favourable threat geometry.";
		}
		attribute sectorMean : ScalarValues::Real = 39.0;
		attribute sectorStdDev : ScalarValues::Real = 3.67;
		attribute minSector : ScalarValues::Integer = 28;
		attribute maxSector : ScalarValues::Integer = 50;
		attribute multirotorProbability : ScalarValues::Real = 0.5;
		attribute fixedwingProbability : ScalarValues::Real = 0.5;
		require constraint { (sectorMean > 0) and (sectorStdDev > 0) and (minSector < maxSector) and (multirotorProbability == 0.5) and (fixedwingProbability == 0.5) }
	}
	requirement def <'TR-023'> BaselineVHFRadioSystemSpecificationRequirement {
		doc /* A-29 baseline shall be equipped with VHF radio communication suite (voice-only) receiving heading vectors from E-99M at intervals [5, 60] seconds. */
		@Rationale {
			text = "VHF voice-only communication is legacy air defense standard compatible with baseline A-29 avionics; interval variability models real-world communication load.";
		}
		attribute radioType : ScalarValues::String = "VHF";
		attribute voiceOnlyCapability : ScalarValues::Boolean = true;
		attribute minUpdateInterval :> ISQ::time = 5 [s];
		attribute maxUpdateInterval :> ISQ::time = 60 [s];
		require constraint { voiceOnlyCapability and (minUpdateInterval > 0) and (maxUpdateInterval >= minUpdateInterval) }
		#refinement dependency 'TR-023' to FunctionalRequirementsPackage::'FR-003';
	}
	requirement def <'TR-024'> A29NPilotVisualSystemSpecificationRequirement {
		doc /* A-29 baseline pilot visual acquisition shall be limited to human vision with maximum acquisition distance 13 km, visual acuity 1.0 arcmin, acquisition + reaction time 12.5 seconds, with small target contrast penalty (multi-rotor 1/14 scale factor relative to fixed-wing). */
		@Rationale {
			text = "Baseline configuration relies on naked-eye acquisition; human physiology and jungle environment constraints degrade detection of small targets.";
		}
		attribute maxAcquisitionDistance :> ISQ::length = 13 [km];
		attribute visualAcuity :> ISQ::planeAngle = 1.0 ['arcmin'];
		attribute totalAcquisitionReactionTime :> ISQ::time = 12.5 [s];
		attribute multirotorVisualContrastPenalty : ScalarValues::Real = 0.0714;
		require constraint { (maxAcquisitionDistance > 0) and (visualAcuity > 0) and (totalAcquisitionReactionTime > 0) and (multirotorVisualContrastPenalty > 0) }
		#refinement dependency 'TR-024' to FunctionalRequirementsPackage::'FR-006';
		#refinement dependency 'TR-024' to FunctionalRequirementsPackage::'FR-007';
		#refinement dependency 'TR-024' to FunctionalRequirementsPackage::'FR-008';
	}
	requirement def <'TR-025'> RohdeSchwartzDataLinkSpecificationRequirement {
		doc /* A-29N shall be equipped with Rohde & Schwarz R&S®M3AR datalink suite (MR6000R/L) with frequency range 30 MHz–400 MHz (V/UHF), control interfaces MIL-STD-1553B / RS-485, data capability up to 16 kbit/s, and SECOS voice/data network with TDMA up to 128 participants. */
		@Rationale {
			text = "Datalink provides digital coordinate transmission capability superior to voice baseline; V/UHF frequency band and TDMA protocol enable reliable air-to-air communications.";
		}
		attribute freqMin :> ISQ::frequency = 30.0E6 [Hz];
		attribute freqMax :> ISQ::frequency = 400.0E6 [Hz];
		attribute dataCapability : ScalarValues::Real = 16;
		attribute maxTDMAParticipants : ScalarValues::Integer = 128;
		require constraint { (freqMin > 0) and (freqMax > freqMin) and (dataCapability > 0) and (maxTDMAParticipants > 0) }
		#refinement dependency 'TR-025' to FunctionalRequirementsPackage::'FR-004';
	}
	requirement def <'TR-026'> FLIRSAFIREIISensorSpecificationRequirement {
		doc /* A-29N shall be equipped with FLIR Star SAFIRE II EO/IR sensor with laser rangefinder having maximum range 20 km, range accuracy 5 m, azimuth 360° continuous, elevation +30° to −120°, slew rate 60°/s, and control via SCU/serial digital/MIL-STD-1553B/ARINC at max operational speed 405 KCAS (≈ 208 m/s). */
		@Rationale {
			text = "Sensor specifications enable beyond-visual-range target acquisition, precise laser designation, and continuous tracking support for engagement phase.";
		}
		attribute maxLaserRange :> ISQ::length = 20 [km];
		attribute rangeAccuracy :> ISQ::length = 5 [m];
		attribute azimuthCoverage :> ISQ::planeAngle = 360 ['°'];
		attribute elevationMin :> ISQ::planeAngle = -120 ['°'];
		attribute elevationMax :> ISQ::planeAngle = 30 ['°'];
		attribute slewRate : ScalarValues::Real = 60;
		attribute maxOperationalSpeed :> ISQ::speed = 208 [m/s];
		require constraint { (maxLaserRange > 0) and (rangeAccuracy > 0) and (slewRate > 0) and (maxOperationalSpeed > 0) }
		#refinement dependency 'TR-026' to FunctionalRequirementsPackage::'FR-009';
	}
	requirement def <'TR-027'> APKWSLaserGuidedKitSpecificationRequirement {
		doc /* A-29N armament shall include Advanced Precision Kill Weapon System (APKWS) laser-guided kit with minimum range 2 km, maximum range 14 km, 80% hit probability within 2 m radius at center of laser spot (at minimum range), platform speed capability 80–550 KCAS (≈ 41–283 m/s), launch altitude −200 to 25,000 feet (≈ −61 to 7,620 m), and weight 15.8 kg per kit. */
		@Rationale {
			text = "APKWS specifications define employment envelope and performance characteristics for A-29N modernized engagement profile.";
		}
		attribute minRange :> ISQ::length = 2 [km];
		attribute maxRange :> ISQ::length = 14 [km];
		attribute hitProbabilitySpec : ScalarValues::Real = 0.8;
		attribute accuracyRadius :> ISQ::length = 2 [m];
		attribute minPlatformSpeed :> ISQ::speed = 41 [m/s];
		attribute maxPlatformSpeed :> ISQ::speed = 283 [m/s];
		attribute minLaunchAltitude :> ISQ::length = -61 [m];
		attribute maxLaunchAltitude :> ISQ::length = 7620 [m];
		attribute kitWeight :> ISQ::mass = 15.8 [kg];
		require constraint { (minRange > 0) and (maxRange > minRange) and (hitProbabilitySpec > 0) and (kitWeight > 0) }
		#refinement dependency 'TR-027' to FunctionalRequirementsPackage::'FR-013';
	}
	requirement def <'TR-028'> E99MAirframePerformanceSpecificationRequirement {
		doc /* E-99M (EMB-145 AEW&C) shall have cruise speed 450 KCAS (≈ 232 m/s), ceiling 37,000 feet (≈ 11,278 m), rate of climb (sea level) 2,560 feet/min (≈ 13.0 m/s), range 1,330 nautical miles (≈ 2,463 km), and endurance 8 hours. */
		@Rationale {
			text = "E-99M performance specifications enable sustained airborne surveillance and command/control relay throughout multi-hour mission activation.";
		}
		attribute cruiseSpeed :> ISQ::speed = 232 [m/s];
		attribute ceiling :> ISQ::length = 11278 [m];
		attribute rateOfClimb :> ISQ::speed = 13.0 [m/s];
		attribute range :> ISQ::length = 2463 [km];
		attribute endurance :> ISQ::time = 8 [h];
		require constraint { (cruiseSpeed > 0) and (ceiling > 0) and (rateOfClimb > 0) and (range > 0) and (endurance > 0) }
		#refinement dependency 'TR-028' to FunctionalRequirementsPackage::'FR-015';
	}
	requirement def <'TR-029'> MultirotorUASThreatModelSpecificationRequirement {
		doc /* Multi-rotor UAS threat archetype shall have maximum dimensions 1 m × 1 m × 0.63 m, carbon fiber fuselage, maximum endurance 3 hours, maximum payload 8 kg, ceiling 6 km, maximum speed 29 m/s, propeller propulsion, operating frequencies 900 MHz–5.8 GHz, small heat signature, and small radar cross-section. */
		@Rationale {
			text = "Multi-rotor threat model characteristics inform acquisition penalty factors and engagement probability calculations for baseline and modernized configurations.";
		}
		attribute maxDimensionX :> ISQ::length = 1 [m];
		attribute maxDimensionY :> ISQ::length = 1 [m];
		attribute maxDimensionZ :> ISQ::length = 0.63 [m];
		attribute maxEndurance :> ISQ::time = 3 [h];
		attribute maxPayload :> ISQ::mass = 8 [kg];
		attribute ceiling :> ISQ::length = 6 [km];
		attribute maxSpeed :> ISQ::speed = 29 [m/s];
		attribute freqMin :> ISQ::frequency = 900.0E6 [Hz];
		attribute freqMax :> ISQ::frequency = 5800.0E6 [Hz];
		require constraint { (maxDimensionX > 0) and (maxEndurance > 0) and (maxPayload > 0) and (ceiling > 0) and (maxSpeed > 0) }
		#refinement dependency 'TR-029' to FunctionalRequirementsPackage::'FR-022';
	}
	requirement def <'TR-030'> FixedwingUASThreatModelSpecificationRequirement {
		doc /* Fixed-wing UAS threat archetype shall have maximum dimensions 14 m × 1.7 m × 4 m, carbon fiber fuselage, maximum endurance 42 hours, maximum payload 100 kg, ceiling 18 km, maximum speed 130 m/s, propeller propulsion, operating frequencies 900 MHz–5.8 GHz, very small heat signature, and small-to-medium radar cross-section. */
		@Rationale {
			text = "Fixed-wing threat model characteristics inform baseline visual contrast (normalized to 1.0 relative to 14 m dimension) and engagement probability calculations.";
		}
		attribute maxDimensionX :> ISQ::length = 14 [m];
		attribute maxDimensionY :> ISQ::length = 1.7 [m];
		attribute maxDimensionZ :> ISQ::length = 4 [m];
		attribute maxEndurance :> ISQ::time = 42 [h];
		attribute maxPayload :> ISQ::mass = 100 [kg];
		attribute ceiling :> ISQ::length = 18 [km];
		attribute maxSpeed :> ISQ::speed = 130 [m/s];
		attribute freqMin :> ISQ::frequency = 900.0E6 [Hz];
		attribute freqMax :> ISQ::frequency = 5800.0E6 [Hz];
		attribute visualContrastNormalization : ScalarValues::Real = 1.0;
		require constraint { (maxDimensionX > 0) and (maxEndurance > 0) and (maxPayload > 0) and (ceiling > 0) and (maxSpeed > 0) }
		#refinement dependency 'TR-030' to FunctionalRequirementsPackage::'FR-022';
	}
}