package StakeholderPackage {

	private import CoSMAPackage::*;
	private import StakeholderNeedsPackage::*;
	part def CommandAuthority :> Stakeholder;
	part def SupportAuthority :> Stakeholder;
	part def RegionalControlCenter :> Stakeholder;
	part def AirborneControlSquadron :> Stakeholder;
	part def FighterSquadron :> Stakeholder;
	part def LogisticsAuthority :> Stakeholder;
	part def LogisticsDistributionCenter :> Stakeholder;
	part def MaterielManagementDirectorate :> Stakeholder;
	part def ProgramManagementAuthority :> Stakeholder;
	part AerospaceOperationsCommand : CommandAuthority {
		:> influenceLevel = StakeholderInfluenceLevel::high;
		:> influenceKind = StakeholderInfluenceKind::direct;
		item concern1 : Concern {
			doc /* Illicit UAS incursions must be neutralized before the 80-nautical-mile boundary of continental ZIDA to preserve airspace sovereignty */
		} :> concerns;
		item concern2 : Concern {
			doc /* Planning, coordination, and execution of actions for identification, coercion, or detention of air traffic */
		} :> concerns;
		item concern3 : Concern {
			doc /* Establishing rules of engagement and mission CONOPS */
		} :> concerns;
		requirement zidaBoundaryProtection : ZIDABoundaryProtection :> needs;
		requirement airspaceSovereigntyPreservation : AirspaceSovereigntyPreservation :> needs;
		requirement rulesOfEngagementEstablishment : RulesOfEngagementEstablishment :> needs;
	}
	part DepartmentOfAirspaceControl : SupportAuthority {
		:> influenceLevel = StakeholderInfluenceLevel::high;
		:> influenceKind = StakeholderInfluenceKind::direct;
		item concern1 : Concern {
			doc /* Maintaining uninterrupted and comprehensive surveillance of airspace pertaining to continental ZIDA through capability to identify air traffic in the region */
		} :> concerns;
		requirement continuousAirspaceSurveillance : ContinuousAirspaceSurveillance :> needs;
		requirement airTrafficIdentificationCapability : AirTrafficIdentificationCapability :> needs;
	}
	part FourthIntegratedAirDefenseAndAirTrafficControlCenter : RegionalControlCenter {
		:> influenceLevel = StakeholderInfluenceLevel::medium;
		:> influenceKind = StakeholderInfluenceKind::direct;
		item concern1 : Concern {
			doc /* Producing UAS identifications through continuous surveillance */
		} :> concerns;
		item concern2 : Concern {
			doc /* Controlling alert assets during flight */
		} :> concerns;
		item concern3 : Concern {
			doc /* Permanent air defense of areas of interest */
		} :> concerns;
		requirement uasDetectionAndIdentification : UASDetectionAndIdentification :> needs;
		requirement alertAssetControl : AlertAssetControl :> needs;
		requirement permanentAirDefenseCoverage : PermanentAirDefenseCoverage :> needs;
	}
	part SecondSixthAviationGroup : AirborneControlSquadron {
		:> influenceLevel = StakeholderInfluenceLevel::high;
		:> influenceKind = StakeholderInfluenceKind::direct;
		item concern1 : Concern {
			doc /* Monitoring airspace and complementing ground radar signals to provide precise, real-time intelligence data to interceptor aircraft regarding low-altitude traffic */
		} :> concerns;
		item concern2 : Concern {
			doc /* Expanded coverage and enhanced situational awareness through vectoring */
		} :> concerns;
		requirement lowAltitudeTrafficIntelligence : LowAltitudeTrafficIntelligence :> needs;
		requirement expandedCoverageSupport : ExpandedCoverageSupport :> needs;
	}
	part SecondThirdAviationGroup : FighterSquadron {
		:> influenceLevel = StakeholderInfluenceLevel::high;
		:> influenceKind = StakeholderInfluenceKind::direct;
		item concern1 : Concern {
			doc /* Enhancement of competence in intercepting and neutralizing illicit UAS through C-UAS capability */
		} :> concerns;
		item concern2 : Concern {
			doc /* Elevating operational performance and mission success impact */
		} :> concerns;
		item concern3 : Concern {
			doc /* Ensuring air defense through operational employment in Amazon scenario */
		} :> concerns;
		requirement cuasCapabilityEnhancement : CUASCapabilityEnhancement :> needs;
		requirement operationalPerformanceElevation : OperationalPerformanceElevation :> needs;
	}
	part GeneralSupportCommand : LogisticsAuthority {
		:> influenceLevel = StakeholderInfluenceLevel::medium;
		:> influenceKind = StakeholderInfluenceKind::indirect;
		item concern1 : Concern {
			doc /* Logistical support of all aeronautical, ordnance, structural, and patrimonial materiel of the mission */
		} :> concerns;
		requirement combatLogisticsSustainment : CombatLogisticsSustainment :> needs;
	}
	part AeronauticsLogisticsCenter : LogisticsDistributionCenter {
		:> influenceLevel = StakeholderInfluenceLevel::medium;
		:> influenceKind = StakeholderInfluenceKind::indirect;
		item concern1 : Concern {
			doc /* Distribution of mission support equipment */
		} :> concerns;
		requirement equipmentDistributionSupport : EquipmentDistributionSupport :> needs;
	}
	part DirectorateOfAeronauticalAndOrdnanceMateriel : MaterielManagementDirectorate {
		:> influenceLevel = StakeholderInfluenceLevel::medium;
		:> influenceKind = StakeholderInfluenceKind::indirect;
		item concern1 : Concern {
			doc /* Standardizing, supervising, and supporting activities related to mission's aeronautical and ordnance materiel */
		} :> concerns;
		requirement materielStandardizationAndSupport : MaterielStandardizationAndSupport :> needs;
	}
	part CombatAircraftProgramCoordinatingCommission : ProgramManagementAuthority {
		:> influenceLevel = StakeholderInfluenceLevel::low;
		:> influenceKind = StakeholderInfluenceKind::indirect;
		item concern1 : Concern {
			doc /* Management of modernized avionic system under study on the A-29 */
		} :> concerns;
	}
}
