package ContextPackage {

	private import CoSMAPackage::*;
	private import LogicalComponentsPackage::*;
	private import SI::*;
	private import ISQ::*;
	private import ScalarValues::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;

	part def AmazonianOperatingEnvironment {
		doc /* The physical environment of the Amazon border region where the mission takes place. */
		attribute ambientTemperature :> ISQ::thermodynamicTemperature = 305 [K]; // estimated
		attribute standardAtmosphericPressure :> ISQ::pressure = 101325 [Pa];
		attribute maxAltitudeA29 :> ISQ::length = 10668 [m]; // Service ceiling
		attribute maxAltitudeMultiRotorUAS :> ISQ::length = 6000 [m];
		attribute maxAltitudeFixedWingUAS :> ISQ::length = 18000 [m];
	}

	part def MainOperatingBase :> System, GroundSupportSystem {
		doc /* Main Operating Base for 2°/3° GAV A-29 squadron. */
		attribute name : ScalarValues::String = "SBPV (Governador Jorge Teixeira de Oliveira aerodrome, Porto Velho, RO)";
		attribute location : ScalarValues::String = "Porto Velho, Rondônia, Brazil";
		attribute geographicCoordinates : ScalarValues::String = "8°42'59.61\"S, 63°54'7.46\"W";
	}

	part def E99MEMB145AEWC :> System {
		doc /* Airborne Control and Early Warning aircraft providing C2 and sensing; monitors airspace; complements ground radar signals; provides real-time intelligence data; vectors interceptors toward illicit UAS; relays target position and heading via datalink (A-29N) or voice (baseline A-29); S-band radar operation */
		attribute radarBand : ScalarValues::String = "S-band";
		attribute radarFrequencyMin :> ISQ::frequency = 2.0E9 [Hz]; // S-band: 2-4 GHz
		attribute radarFrequencyMax :> ISQ::frequency = 4.0E9 [Hz];
		attribute capabilityC2 : ScalarValues::Boolean = true;
		attribute capabilitySensing : ScalarValues::Boolean = true;
		attribute datalinkCapability : ScalarValues::Boolean = true;
	}

	part def DECEAGroundRadars :> System {
		doc /* Ground-based airspace surveillance and control infrastructure subordinate to Department of Airspace Control (DECEA); provides airspace surveillance data to E-99M; detects, identifies, tracks, and controls aircraft within airspace of interest; maintains uninterrupted and comprehensive surveillance of airspace pertaining to continental ZIDA */
		attribute organization : ScalarValues::String = "Department of Airspace Control (DECEA)";
		attribute surveillanceCapability : ScalarValues::Boolean = true;
		attribute trackingCapability : ScalarValues::Boolean = true;
		attribute continuousCoverage : ScalarValues::Boolean = true;
	}

	part def MultiRotorUASThreat :> System {
		doc /* Illicit unmanned aerial system for surveillance and small payload carrying; crosses border into Brazilian airspace; conducts clandestine aerial surveying; provides logistical, surveillance, and intelligence support to drug trafficking; operating frequencies: 900 MHz to 5.8 GHz; service ceiling: 6 km */
		attribute operatingFrequencyMin :> ISQ::frequency = 900.0E6 [Hz];
		attribute operatingFrequencyMax :> ISQ::frequency = 5.8E9 [Hz];
		attribute serviceCeiling :> ISQ::length = 6000 [m];
		attribute threatType : ScalarValues::String = "Illicit surveillance and payload transport";
		attribute missionProfile : ScalarValues::String = "Clandestine aerial surveying, drug trafficking support";
	}

	part def FixedWingUASThreat :> System {
		doc /* Illicit unmanned aerial system with greater range, payload capacity, and endurance compared to multi-rotor; crosses border into Brazilian airspace; conducts clandestine aerial surveying; provides logistical support to drug trafficking; operating frequencies: 900 MHz to 5.8 GHz; service ceiling: 18 km */
		attribute operatingFrequencyMin :> ISQ::frequency = 900.0E6 [Hz];
		attribute operatingFrequencyMax :> ISQ::frequency = 5.8E9 [Hz];
		attribute serviceCeiling :> ISQ::length = 18000 [m];
		attribute threatType : ScalarValues::String = "Illicit surveillance and payload transport (extended range/endurance)";
		attribute missionProfile : ScalarValues::String = "Clandestine aerial surveying, drug trafficking support";
		attribute capabilityAdvantage : ScalarValues::String = "Greater range, payload capacity, and endurance vs. multi-rotor";
	}

	part def COMAEAerospaceOperationsCommandComandoDeOperaesAeroespaciais :> System {
		doc /* Central body of Brazilian Aerospace Defense System; responsible for employment of aerospace means and air force actions; plans, coordinates, and executes airspace policing actions; establishes rules of engagement; defines air defense alert postures; conceives mission CONOPS */
		attribute organizationName : ScalarValues::String = "Aerospace Operations Command (COMAE / Comando de Operações Aeroespaciais)";
		attribute role : ScalarValues::String = "Central body of Brazilian Aerospace Defense System";
		attribute responsibilities : ScalarValues::String = "Plans, coordinates, executes airspace policing; establishes ROE; defines alert postures; conceives CONOPS";
	}

	part def CINDACTAIVFourthIntegratedAirDefenseAndAirTrafficControlCenterQuartoCentroIntegradoDeDefesaAreaEControleDeTrfegoAreo :> System {
		doc /* Regional airspace control and management body subordinate to DECEA; controls alert assets during flight; provides permanent air defense of areas of interest; produces UAS identifications through continuous surveillance */
		attribute organizationName : ScalarValues::String = "CINDACTA IV (Fourth Integrated Air Defense and Air Traffic Control Center / Quarto Centro Integrado de Defesa Aérea e Controle de Tráfego Aéreo)";
		attribute subordinateTo : ScalarValues::String = "DECEA";
		attribute role : ScalarValues::String = "Regional airspace control and management; alert asset control; permanent air defense";
		attribute surveillanceCapability : ScalarValues::Boolean = true;
		attribute uasIdentificationCapability : ScalarValues::Boolean = true;
	}

	part def COMGAPGeneralSupportCommandComandoGeralDeApoio :> System {
		doc /* Combat logistics sustainment body; provides logistical support of all aeronautical, ordnance, structural, and patrimonial materiel of the mission */
		attribute organizationName : ScalarValues::String = "General Support Command (COMGAP / Comando-Geral de Apoio)";
		attribute role : ScalarValues::String = "Combat logistics sustainment";
		attribute supportAreas : ScalarValues::String = "Aeronautical, ordnance, structural, and patrimonial materiel";
	}

	part def CELOGAeronauticsLogisticsCenterCentroLogsticoDaAeronutica :> System {
		doc /* Logistics distribution center; distributes mission support equipment */
		attribute organizationName : ScalarValues::String = "Aeronautics Logistics Center (CELOG / Centro Logístico da Aeronáutica)";
		attribute role : ScalarValues::String = "Logistics distribution center";
		attribute function : ScalarValues::String = "Distributes mission support equipment";
	}

	part def DIRMABDirectorateOfAeronauticalAndOrdnanceMaterielDiretoriaDeMaterialAeronuticoEBlico :> System {
		doc /* Materiel management directorate; standardizes, supervises, and supports activities related to mission's aeronautical and ordnance materiel */
		attribute organizationName : ScalarValues::String = "Directorate of Aeronautical and Ordnance Materiel (DIRMAB / Diretoria de Material Aeronáutico e Bélico)";
		attribute role : ScalarValues::String = "Materiel management directorate";
		attribute responsibilities : ScalarValues::String = "Standardizes, supervises, and supports aeronautical and ordnance materiel activities";
	}

	part def COPACCombatAircraftProgramCoordinatingCommissionComissoCoordenadoraDoProgramaAeronaveDeCombate :> System {
		doc /* Program management for combat aircraft; manages modernized avionic system under study on the A-29 */
		attribute organizationName : ScalarValues::String = "Combat Aircraft Program Coordinating Commission (COPAC / Comissão Coordenadora do Programa Aeronave de Combate)";
		attribute role : ScalarValues::String = "Program management for combat aircraft";
		attribute programFocus : ScalarValues::String = "Modernized avionic system for A-29";
	}

	part def ContinentalZIDAShieldOperationContext :> Context {
		doc /* The scenario was constructed to enable comparison, under controlled conditions provided by computational simulation, of the conventional air defense approach (A-29 baseline lacking specific C-UAS avionic systems) against the approach afforded by the modernized aircraft (A-29N) specialized in the C-UAS mission. The investigation aims to measure the improvement in protection outcomes for the continental ZIDA with the new capability. */
		part e99MEMB145AEWC : E99MEMB145AEWC :> externalSystems;
		part deceaGroundRadars : DECEAGroundRadars :> externalSystems;
		part multiRotorUASThreat : MultiRotorUASThreat :> externalSystems;
		part fixedWingUASThreat : FixedWingUASThreat :> externalSystems;
		part comaeAerospaceOperationsCommandComandoDeOperaesAeroespaciais : COMAEAerospaceOperationsCommandComandoDeOperaesAeroespaciais :> externalSystems;
		part cindactaivFourthIntegratedAirDefenseAndAirTrafficControlCenterQuartoCentroIntegradoDeDefesaAreaEControleDeTrfegoAreo : CINDACTAIVFourthIntegratedAirDefenseAndAirTrafficControlCenterQuartoCentroIntegradoDeDefesaAreaEControleDeTrfegoAreo :> externalSystems;
		part comgapGeneralSupportCommandComandoGeralDeApoio : COMGAPGeneralSupportCommandComandoGeralDeApoio :> externalSystems;
		part celogAeronauticsLogisticsCenterCentroLogsticoDaAeronutica : CELOGAeronauticsLogisticsCenterCentroLogsticoDaAeronutica :> externalSystems;
		part dirmabDirectorateOfAeronauticalAndOrdnanceMaterielDiretoriaDeMaterialAeronuticoEBlico : DIRMABDirectorateOfAeronauticalAndOrdnanceMaterielDiretoriaDeMaterialAeronuticoEBlico :> externalSystems;
		part copacCombatAircraftProgramCoordinatingCommissionComissoCoordenadoraDoProgramaAeronaveDeCombate : COPACCombatAircraftProgramCoordinatingCommissionComissoCoordenadoraDoProgramaAeronaveDeCombate :> externalSystems;
	}
}
