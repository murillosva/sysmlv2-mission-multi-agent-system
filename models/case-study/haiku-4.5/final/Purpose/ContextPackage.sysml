package ContextPackage {

	private import CoSMAPackage::*;
	private import LogicalComponentsPackage::*;
	private import SI::*;
	private import ISQ::*;
	private import ScalarValues::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;

	part def AmazonBiomeEnvironment {
		doc /* Operating environment: tropical rainforest biome with dense forest, extensive river network, low population density, vast border extent. */
		attribute terrain : ScalarValues::String = "tropical rainforest";
		attribute description : ScalarValues::String = "Amazon biome; dense forest with extensive river network; low population density; vast border extent";
		attribute surfaceTemperatureDay :> ISQ::thermodynamicTemperature = 305 [K];
		attribute surfaceTemperatureNight :> ISQ::thermodynamicTemperature = 285 [K];
		attribute ambientPressure :> ISQ::pressure = 101325 [Pa];
		attribute humidity : ScalarValues::Real = 0.85;
	}

	part def ContinentalZIDAOperatingBoundary {
		doc /* Continental ZIDA operational boundary: 80 nautical miles from Brazilian border extending into national territory bordering Peru and Colombia. */
		attribute name : ScalarValues::String = "Continental ZIDA";
		attribute boundaryDistance :> ISQ::length = 148.16 [km];
		attribute boundaryDescription : ScalarValues::String = "80 nautical miles from Brazilian border extending into national territory";
		attribute countries : ScalarValues::String = "Peru, Colombia";
		attribute successCriterion : ScalarValues::String = "80% neutralization rate of UAS incursions before crossing boundary";
		attribute multiRotorCeiling :> ISQ::length = 6 [km];
		attribute fixedWingCeiling :> ISQ::length = 18 [km];
		attribute a29ServiceCeiling :> ISQ::length = 10668 [m];
		attribute e99mServiceCeiling :> ISQ::length = 11278 [m];
	}

	part def PortoVelhoAirBase {
		doc /* Primary operating base for A-29 Super Tucano aircraft and mission coordination. Governador Jorge Teixeira de Oliveira Aerodrome (SBPV); home station for 2°/3° GAV A-29 operations. */
		attribute name : ScalarValues::String = "Governador Jorge Teixeira de Oliveira Aerodrome (SBPV)";
		attribute icaoCode : ScalarValues::String = "SBPV";
		attribute location : ScalarValues::String = "Porto Velho, Rondônia (RO), Brazil";
		attribute geographicCoordinates : ScalarValues::String = "8°42'59.61\"S, 63°54'7.46\"O";
		attribute latitude : ScalarValues::String = "8°42'59.61\"S";
		attribute longitude : ScalarValues::String = "63°54'7.46\"O";
		attribute operatorSquadron : ScalarValues::String = "2°/3° GAV";
		attribute primaryAircraft : ScalarValues::String = "A-29 Super Tucano";
	}

	part def ForwardArmingAndRefuelingPoint_SBRB {
		doc /* FARP location optimized via Set Covering Problem methodology for coverage of southern Areas of Interest. */
		attribute name : ScalarValues::String = "SBRB";
		attribute geographicCoordinates : ScalarValues::String = "9°52'12.82\"S, 67°53'44.23\"O";
		attribute latitude : ScalarValues::String = "9°52'12.82\"S";
		attribute longitude : ScalarValues::String = "67°53'44.23\"O";
		attribute coverage : ScalarValues::String = "southern Areas of Interest";
		attribute purpose : ScalarValues::String = "Forward Arming and Refueling Point";
	}

	part def ForwardArmingAndRefuelingPoint_SBCZ {
		doc /* FARP location optimized via Set Covering Problem methodology for coverage of central Areas of Interest. */
		attribute name : ScalarValues::String = "SBCZ";
		attribute geographicCoordinates : ScalarValues::String = "7°35'59.86\"S, 72°46'23.12\"O";
		attribute latitude : ScalarValues::String = "7°35'59.86\"S";
		attribute longitude : ScalarValues::String = "72°46'23.12\"O";
		attribute coverage : ScalarValues::String = "central Areas of Interest";
		attribute purpose : ScalarValues::String = "Forward Arming and Refueling Point";
	}

	part def ForwardArmingAndRefuelingPoint_SDCG {
		doc /* FARP location optimized via Set Covering Problem methodology for coverage of northern Areas of Interest. */
		attribute name : ScalarValues::String = "SDCG";
		attribute geographicCoordinates : ScalarValues::String = "3°28'9.00\"S, 68°55'16.00\"O";
		attribute latitude : ScalarValues::String = "3°28'9.00\"S";
		attribute longitude : ScalarValues::String = "68°55'16.00\"O";
		attribute coverage : ScalarValues::String = "northern Areas of Interest";
		attribute purpose : ScalarValues::String = "Forward Arming and Refueling Point";
	}

	part def ForwardArmingAndRefuelingPoint_SWKU {
		doc /* FARP location optimized via Set Covering Problem methodology for coverage of far-northern Areas of Interest. */
		attribute name : ScalarValues::String = "SWKU";
		attribute geographicCoordinates : ScalarValues::String = "1°7'11.98\"N, 66°50'29.59\"O";
		attribute latitude : ScalarValues::String = "1°7'11.98\"N";
		attribute longitude : ScalarValues::String = "66°50'29.59\"O";
		attribute coverage : ScalarValues::String = "far-northern Areas of Interest";
		attribute purpose : ScalarValues::String = "Forward Arming and Refueling Point";
	}

	part def E99MEMB145AEWCAirborneControlAndEarlyWarningAircraft :> System {
		doc /* Provides real-time airborne radar detection, identification, and early warning of UAS incursions; vectors A-29 aircraft toward targets via voice communication (baseline) or datalink (A-29N); complements DECEA ground radar coverage in jungle environment. Detects UAS crossing border; provides heading guidance (baseline) or geographic coordinates (A-29N) to fighter; maintains continuous surveillance of 6 AoI. Operated by 2°/6° GAV (STK-004). §1.1, §1.2.1.1, §2.1.2.1.2, §2.1.2.1.4 */
		attribute serviceCeiling :> ISQ::length = 11278 [m];
		attribute maxSpeed :> ISQ::speed = 297.8 [m/s];
		attribute radarRange :> ISQ::length = 300 [km];
		attribute radarFrequency :> ISQ::frequency = 3E9 [Hz];
		attribute communicationMode : ScalarValues::String = "voice and/or datalink";
		attribute updateInterval :> ISQ::duration = 5 [s];
		attribute operator : ScalarValues::String = "2°/6° GAV";
	}

	part def DECEADepartmentOfAirspaceControlGroundRadarNetwork :> System {
		doc /* Provides persistent ground-based airspace surveillance and control; feeds UAS detections to CINDACTA IV and E-99M; maintains primary tactical picture for C2. Detects and identifies UAS incursions; initiates alert notifications to CAP-stationed A-29; feeds data to airborne CAV asset (E-99M). §1.1, §1.2.1.1, §1.3, §2.1.2.1.4 */
		attribute systemType : ScalarValues::String = "ground-based airspace surveillance and control network";
		attribute coverage : ScalarValues::String = "continental ZIDA and border regions";
		attribute detectionCapability : ScalarValues::String = "UAS incursion detection and identification";
		attribute dataDistribution : ScalarValues::String = "feeds to CINDACTA IV and E-99M";
		attribute alertCapability : ScalarValues::String = "initiates notifications to CAP-stationed A-29";
	}

	part def CINDACTAIVFourthIntegratedAirDefenseAndAirTrafficControlCenter :> System {
		doc /* Regional air defense and traffic control authority subordinate to DECEA (STK-003); produces UAS identifications through continuous surveillance; controls alert assets during flight and manages permanent air defense of AoI. Receives UAS detections from DECEA ground radar; coordinates with COMAE for engagement authorization; provides tactical direction to CAP-stationed A-29; monitors air defense posture of AoI. §1.3 */
		attribute command : ScalarValues::String = "CINDACTA IV";
		attribute parentAuthority : ScalarValues::String = "DECEA";
		attribute responsibility : ScalarValues::String = "regional air defense and traffic control authority";
		attribute dataInput : ScalarValues::String = "UAS detections from DECEA ground radar";
		attribute coordinationPartner : ScalarValues::String = "COMAE";
		attribute tacticalOutput : ScalarValues::String = "tactical direction to CAP-stationed A-29";
	}

	part def COMAEAerospaceOperationsCommand :> System {
		doc /* Strategic-operational decision authority (SH-001); plans, coordinates, and executes air defense and airspace policing actions; establishes rules of engagement (ROE) and mission CONOPS; determines engagement authorization thresholds. Authorizes engagement of detected UAS; establishes ROE (immediate TDE authorization for UAS threat); sets success criteria (80% neutralization before 80-nmi boundary); receives mission results for capability assessment. §1.3, §2.2.1.1.3 */
		attribute command : ScalarValues::String = "COMAE";
		attribute authority : ScalarValues::String = "strategic-operational decision authority";
		attribute responsibility : ScalarValues::String = "air defense and airspace policing operations";
		attribute roleEngagement : ScalarValues::String = "authorizes engagement of detected UAS";
		attribute rulesOfEngagement : ScalarValues::String = "immediate TDE authorization for UAS threat";
		attribute successCriterionNeutralizations : ScalarValues::Real = 0.80;
		attribute successCriterionBoundary :> ISQ::length = 148.16 [km];
	}

	part def X26GAV2nd6thAviationGroupE99MSquadron :> System {
		doc /* Operates and maintains E-99M airborne early warning platform (SH-004); provides real-time intelligence data and vectoring capability to A-29 interceptors during flight; manages E-99M positioning and radar coverage. Maintains E-99M airborne in scenario; relays target position updates to A-29 (voice or datalink); provides independent radar track confirmation; coordinates with 2°/3° GAV for interception geometry. §1.3, §1.2.1.1 */
		attribute squadron : ScalarValues::String = "2°/6° GAV";
		attribute platform : ScalarValues::String = "E-99M (EMB-145 AEW&C)";
		attribute responsibility : ScalarValues::String = "operates and maintains airborne early warning platform";
		attribute capability : ScalarValues::String = "real-time intelligence data and vectoring capability";
		attribute dataType : ScalarValues::String = "target position updates via voice or datalink";
		attribute updateInterval :> ISQ::duration = 5 [s];
		attribute coordinationPartner : ScalarValues::String = "2°/3° GAV";
	}

	part def A29SuperTucanoBaselineConfigurationCONFIGB :> System {
		doc /* Primary interceptor asset configured without C-UAS modernization (SYS-INTEREST); operates from SBPV main base via FARPs; conducts CAP and ALEVOO at designated points; executes visual interception and engagement with unguided SBAT-70 rockets. Equipped with: voice communication (E-99M heading vectors at 5–60 s intervals), naked-eye visual target acquisition (max 13 km range with 12.5 s reaction time), unguided SBAT-70 rockets (max 2 km range, linear hit probability degradation from 80% at 0.5 km to 0% at 2 km); multi-rotor targets penalized by 1/14 visible area factor due to size. §2.1.2.1.1, §2.2.1, §2.2.1.1.1 */
		attribute configuration : ScalarValues::String = "CONFIG-B (baseline)";
		attribute modernization : ScalarValues::String = "without C-UAS modernization";
		attribute homeBase : ScalarValues::String = "SBPV (Porto Velho)";
		attribute operatingBases : ScalarValues::String = "SBPV main base and FARPs (SBRB, SBCZ, SDCG, SWKU)";
		attribute mission : ScalarValues::String = "CAP (Combat Air Patrol) and ALEVOO (air policing)";
		attribute communicationMode : ScalarValues::String = "voice communication";
		attribute vectorUpdateInterval :> ISQ::duration = 30 [s];
		attribute visualAcquisitionRange :> ISQ::length = 13 [km];
		attribute visualReactionTime :> ISQ::duration = 12.5 [s];
		attribute primaryWeapon : ScalarValues::String = "unguided SBAT-70 rockets";
		attribute weaponMaxRange :> ISQ::length = 2 [km];
		attribute hitProbabilityAtMinRange : ScalarValues::Real = 0.80;
		attribute hitProbabilityAtMaxRange : ScalarValues::Real = 0.00;
		attribute multiRotorTargetPenalty : ScalarValues::Real = 1.0 / 14.0;
		attribute serviceCeiling :> ISQ::length = 10668 [m];
		attribute maxSpeed :> ISQ::speed = 190.6 [m/s];
	}

	part def A29NSuperTucanoModernizedCUASConfigurationCONFIGM :> System {
		doc /* Primary interceptor asset configured with C-UAS modernization (SYS-INTEREST); operates from SBPV main base via FARPs; conducts CAP and ALEVOO at designated points; executes sensor-based interception and engagement with laser-guided APKWS rockets. Equipped with: (1) dedicated datalink for receiving geographic target coordinates (1–10 s update intervals), (2) onboard EO/IR sensor (20 km max range, 5 m accuracy, 60°/s slew rate) for autonomous search and laser designation, (3) Advanced Precision Kill Weapon System (APKWS) laser-guided rockets (2–14 km employment range, 80% hit probability at 2 km, linear degradation to 0% at 14 km); multi-rotor targets penalized by 1/5 ratio. §2.1.2.1.1, §2.2.1, §2.2.1.1.2, §1.2 */
		attribute configuration : ScalarValues::String = "CONFIG-M (modernized)";
		attribute modernization : ScalarValues::String = "with C-UAS modernization";
		attribute homeBase : ScalarValues::String = "SBPV (Porto Velho)";
		attribute operatingBases : ScalarValues::String = "SBPV main base and FARPs (SBRB, SBCZ, SDCG, SWKU)";
		attribute mission : ScalarValues::String = "CAP (Combat Air Patrol) and ALEVOO (air policing)";
		attribute communicationMode : ScalarValues::String = "dedicated datalink";
		attribute datalinkUpdateInterval :> ISQ::duration = 5 [s];
		attribute sensorType : ScalarValues::String = "EO/IR (Electro-Optical/Infrared)";
		attribute sensorMaxRange :> ISQ::length = 20 [km];
		attribute sensorAccuracy :> ISQ::length = 5 [m];
		attribute sensorSlewRate : ScalarValues::Real = 60;
		attribute laserDesignation : ScalarValues::String = "autonomous tracking with laser designation";
		attribute primaryWeapon : ScalarValues::String = "APKWS (Advanced Precision Kill Weapon System) laser-guided rockets";
		attribute weaponMinRange :> ISQ::length = 2 [km];
		attribute weaponMaxRange :> ISQ::length = 14 [km];
		attribute hitProbabilityAtMinRange : ScalarValues::Real = 0.80;
		attribute hitProbabilityAtMaxRange : ScalarValues::Real = 0.00;
		attribute multiRotorTargetPenalty : ScalarValues::Real = 1.0 / 5.0;
		attribute serviceCeiling :> ISQ::length = 10668 [m];
		attribute maxSpeed :> ISQ::speed = 190.6 [m/s];
		attribute cognitiveWorkloadReduction : ScalarValues::String = "reduced pilot cognitive workload via autonomous routing and sensor integration";
	}

	part def MultiRotorIllicitUASArchetype :> System {
		doc /* Threat: Represents low-cost, low-speed, low-altitude aerial platform employed for short-range surveillance and ISR support to narcotrafficking; dimensions 1 m × 1 m × 0.63 m; small RCS and heat signature; max endurance 3 h, payload 8 kg, max speed 29 m/s (105 km/h), ceiling 6 km. Crosses ZIDA boundary at random entry point and heading; penetrates toward interior Amazon territory if undetected; provides increased interception difficulty for baseline A-29 due to small size; subject to equal 50% probability of generation in random mission scenario. §1.1, §2.1.2.1.3, §2.2.2 */
		attribute threatType : ScalarValues::String = "illicit UAS";
		attribute category : ScalarValues::String = "multi-rotor";
		attribute purpose : ScalarValues::String = "surveillance and ISR support to narcotrafficking";
		attribute wingspan :> ISQ::length = 1 [m];
		attribute length :> ISQ::length = 1 [m];
		attribute height :> ISQ::length = 0.63 [m];
		attribute rcsCharacteristic : ScalarValues::String = "small";
		attribute heatSignature : ScalarValues::String = "small";
		attribute maxEndurance :> ISQ::duration = 3 [h];
		attribute maxPayload :> ISQ::mass = 8 [kg];
		attribute maxSpeed :> ISQ::speed = 29 [m/s];
		attribute ceiling :> ISQ::length = 6 [km];
		attribute operationMode : ScalarValues::String = "crosses ZIDA boundary at random entry point and heading; penetrates toward interior Amazon territory if undetected";
		attribute interceptionDifficulty : ScalarValues::String = "increased difficulty for baseline A-29 due to small size";
		attribute scenarioProbability : ScalarValues::Real = 0.50;
	}

	part def FixedWingIllicitUASArchetype :> System {
		doc /* Threat: Represents higher-capability long-range aerial platform employed for extended narcotics transport and sustained surveillance; dimensions 14 m × 1.7 m × 4 m; small-medium RCS; max endurance 42 h, payload 100 kg, max speed 130 m/s (468 km/h), ceiling 18 km. Crosses ZIDA boundary at random entry point and heading; penetrates toward interior Amazon territory if undetected; provides reduced interception difficulty for baseline A-29 due to large size; subject to equal 50% probability of generation in random mission scenario. §1.1, §2.1.2.1.3, §2.2.2 */
		attribute threatType : ScalarValues::String = "illicit UAS";
		attribute category : ScalarValues::String = "fixed-wing";
		attribute purpose : ScalarValues::String = "narcotics transport and sustained surveillance";
		attribute wingspan :> ISQ::length = 14 [m];
		attribute length :> ISQ::length = 1.7 [m];
		attribute height :> ISQ::length = 4 [m];
		attribute rcsCharacteristic : ScalarValues::String = "small-medium";
		attribute maxEndurance :> ISQ::duration = 42 [h];
		attribute maxPayload :> ISQ::mass = 100 [kg];
		attribute maxSpeed :> ISQ::speed = 130 [m/s];
		attribute ceiling :> ISQ::length = 18 [km];
		attribute operationMode : ScalarValues::String = "crosses ZIDA boundary at random entry point and heading; penetrates toward interior Amazon territory if undetected";
		attribute interceptionDifficulty : ScalarValues::String = "reduced difficulty for baseline A-29 due to large size";
		attribute scenarioProbability : ScalarValues::Real = 0.50;
	}

	part def TransnationalCriminalNetworksNarcotraffickingFactions :> System {
		doc /* Threat (Strategic-level adversary): Operates narcotrafficking logistics network across Amazon region; employs UAS for surveillance and payload transport; source of illicit UAS incursions into continental ZIDA; represents geopolitical asymmetric threat to Brazilian state sovereignty. Plans and executes UAS incursions; selects entry points and timing; operates multi-rotor and fixed-wing UAS platforms; attempts to evade detection and neutralization by air defense forces. §1.1, §2.1.1.4 */
		attribute threatLevel : ScalarValues::String = "strategic-level adversary";
		attribute operationalArea : ScalarValues::String = "Amazon region";
		attribute logistics : ScalarValues::String = "narcotrafficking logistics network";
		attribute capability : ScalarValues::String = "operates multi-rotor and fixed-wing UAS platforms for surveillance and payload transport";
		attribute threatVector : ScalarValues::String = "illicit UAS incursions into continental ZIDA";
		attribute geopoliticalThreat : ScalarValues::String = "asymmetric threat to Brazilian state sovereignty";
		attribute operationalTactic : ScalarValues::String = "plans and executes UAS incursions; selects entry points and timing; attempts to evade detection and neutralization";
	}

	part def FARPNetworkForwardArmingAndRefuelingPoints :> System {
		doc /* ExternalSystem / Constituent: Forward operating bases providing logistical support (refueling, rearming) to A-29 aircraft; four FARPs (SBRB, SBCZ, SDCG, SWKU) optimized via Set Covering Problem methodology; extends aircraft range and on-station time by reducing transit distances from main base (SBPV) to CAP points. Receives A-29 aircraft for refueling/rearming; enables extended air patrol coverage across 6 AoI; reduces time required for aircraft to reach CAP points; allows multiple sorties during 24-hour operations; returns aircraft to main base (SBPV) at end of sortie. §2.1.1.3, §2.2.1 */
		attribute systemType : ScalarValues::String = "Forward Operating Base Network";
		attribute designation : ScalarValues::String = "Forward Arming and Refueling Points (FARPs)";
		attribute numberOfFARPs : ScalarValues::Integer = 4;
		attribute farpLocations : ScalarValues::String = "SBRB (southern), SBCZ (central), SDCG (northern), SWKU (far-northern)";
		attribute optimizationMethod : ScalarValues::String = "Set Covering Problem methodology";
		attribute supportFunction : ScalarValues::String = "refueling and rearming of A-29 aircraft";
		attribute primaryBenefit : ScalarValues::String = "extends aircraft range and on-station time";
		attribute missionImprovement : ScalarValues::String = "enables extended air patrol coverage across 6 Areas of Interest; allows multiple sorties during 24-hour operations";
		attribute baseIntegration : ScalarValues::String = "operates with main base SBPV for sortie planning and aircraft recovery";
	}

	part def ContinentalZIDAShieldOperation :> Context {
		doc /* Enable controlled computational simulation comparison of conventional air defense approach (baseline A-29) against modernized C-UAS approach (A-29N) specialized in counter-UAS mission; measure improvement in protection outcomes for continental ZIDA with new capability. §2.1.1.1 */
		part amazonBiomeEnvironment : AmazonBiomeEnvironment :> externalSystems;
		part continentalZIDAOperatingBoundary : ContinentalZIDAOperatingBoundary :> externalSystems;
		part portoVelhoAirBase : PortoVelhoAirBase :> externalSystems;
		part forwardArmingAndRefuelingPointSBRB : ForwardArmingAndRefuelingPoint_SBRB :> externalSystems;
		part forwardArmingAndRefuelingPointSBCZ : ForwardArmingAndRefuelingPoint_SBCZ :> externalSystems;
		part forwardArmingAndRefuelingPointSDCG : ForwardArmingAndRefuelingPoint_SDCG :> externalSystems;
		part forwardArmingAndRefuelingPointSWKU : ForwardArmingAndRefuelingPoint_SWKU :> externalSystems;
		part e99MEMB145AEWCAirborneControlAndEarlyWarningAircraft : E99MEMB145AEWCAirborneControlAndEarlyWarningAircraft :> externalSystems;
		part deceaDepartmentOfAirspaceControlGroundRadarNetwork : DECEADepartmentOfAirspaceControlGroundRadarNetwork :> externalSystems;
		part cindactaivFourthIntegratedAirDefenseAndAirTrafficControlCenter : CINDACTAIVFourthIntegratedAirDefenseAndAirTrafficControlCenter :> externalSystems;
		part comaeAerospaceOperationsCommand : COMAEAerospaceOperationsCommand :> externalSystems;
		part x26GAV2nd6thAviationGroupE99MSquadron : X26GAV2nd6thAviationGroupE99MSquadron :> externalSystems;
		part a29SuperTucanoBaselineConfigurationCONFIGB : A29SuperTucanoBaselineConfigurationCONFIGB :> externalSystems;
		part a29NSuperTucanoModernizedCUASConfigurationCONFIGM : A29NSuperTucanoModernizedCUASConfigurationCONFIGM :> externalSystems;
		part multiRotorIllicitUASArchetype : MultiRotorIllicitUASArchetype :> externalSystems;
		part fixedWingIllicitUASArchetype : FixedWingIllicitUASArchetype :> externalSystems;
		part transnationalCriminalNetworksNarcotraffickingFactions : TransnationalCriminalNetworksNarcotraffickingFactions :> externalSystems;
		part farpNetworkForwardArmingAndRefuelingPoints : FARPNetworkForwardArmingAndRefuelingPoints :> externalSystems;
	}

}