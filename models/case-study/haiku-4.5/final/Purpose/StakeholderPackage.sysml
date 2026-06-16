package StakeholderPackage {

	private import CoSMAPackage::*;
	private import StakeholderNeedsPackage::*;
	part def MilitaryCommandAuthority :> Stakeholder;
	part def MilitaryControlAuthority :> Stakeholder;
	part def MilitaryControlCenter :> Stakeholder;
	part def MilitaryOperationalUnit :> Stakeholder;
	part def MilitaryLogisticsAuthority :> Stakeholder;
	part def MilitarySystemManagementAuthority :> Stakeholder;
	part AerospaceOperationsCommand : MilitaryCommandAuthority {
		:> influenceLevel = StakeholderInfluenceLevel::high;
		:> influenceKind = StakeholderInfluenceKind::direct;
		item concern1 : Concern {
			doc /* Ensure illicit UAS incursions are neutralized before the 80-nautical-mile boundary of continental ZIDA to preserve airspace sovereignty */
		} :> concerns;
		item concern2 : Concern {
			doc /* Guide aerospace defense decisions through established rules of engagement */
		} :> concerns;
		requirement airspaceSovereigntyPreservation : AirspaceSovereigntyPreservation :> needs;
		requirement continuousAirDefensePosture : ContinuousAirDefensePosture :> needs;
	}
	part DepartmentOfAirspaceControl : MilitaryControlAuthority {
		:> influenceLevel = StakeholderInfluenceLevel::high;
		:> influenceKind = StakeholderInfluenceKind::direct;
		item concern1 : Concern {
			doc /* Maintain uninterrupted and comprehensive surveillance of airspace pertaining to continental ZIDA through capability to identify air traffic in the region */
		} :> concerns;
		requirement comprehensiveAirspaceSurveillance : ComprehensiveAirspaceSurveillance :> needs;
	}
	part FourthIntegratedAirDefenseCenter : MilitaryControlCenter {
		:> influenceLevel = StakeholderInfluenceLevel::high;
		:> influenceKind = StakeholderInfluenceKind::direct;
		item concern1 : Concern {
			doc /* Maintain permanent air defense of areas of interest and control of alert assets during flight */
		} :> concerns;
		item concern2 : Concern {
			doc /* Produce continuous surveillance and UAS identification */
		} :> concerns;
		requirement continuousAirDefensePosture : ContinuousAirDefensePosture :> needs;
	}
	part SecondSixthAviationGroup : MilitaryOperationalUnit {
		:> influenceLevel = StakeholderInfluenceLevel::medium;
		:> influenceKind = StakeholderInfluenceKind::direct;
		item concern1 : Concern {
			doc /* Provide expanded coverage and control support */
		} :> concerns;
		item concern2 : Concern {
			doc /* Enhance situational awareness of interceptor aircraft through precise target vectoring during UAS interception */
		} :> concerns;
		requirement targetVectoringAndSituationalAwareness : TargetVectoringAndSituationalAwareness :> needs;
	}
	part SecondThirdAviationGroup : MilitaryOperationalUnit {
		:> influenceLevel = StakeholderInfluenceLevel::high;
		:> influenceKind = StakeholderInfluenceKind::direct;
		item concern1 : Concern {
			doc /* Enhance competence in intercepting and neutralizing illicit UAS through C-UAS capability */
		} :> concerns;
		item concern2 : Concern {
			doc /* Elevate operational performance and mission success impact */
		} :> concerns;
		requirement enhancedInterceptionCapability : EnhancedInterceptionCapability :> needs;
	}
	part GeneralSupportCommand : MilitaryLogisticsAuthority {
		:> influenceLevel = StakeholderInfluenceLevel::low;
		:> influenceKind = StakeholderInfluenceKind::indirect;
		item concern1 : Concern {
			doc /* Provide logistical support of all aeronautical, ordnance, structural, and patrimonial materiel of the mission */
		} :> concerns;
	}
	part AeronauticsLogisticsCenter : MilitaryLogisticsAuthority {
		:> influenceLevel = StakeholderInfluenceLevel::low;
		:> influenceKind = StakeholderInfluenceKind::indirect;
		item concern1 : Concern {
			doc /* Distribution of mission support equipment */
		} :> concerns;
	}
	part DirectorateOfAeronauticalAndOrdnanceMateriel : MilitaryLogisticsAuthority {
		:> influenceLevel = StakeholderInfluenceLevel::low;
		:> influenceKind = StakeholderInfluenceKind::indirect;
		item concern1 : Concern {
			doc /* Standardize, supervise, and support activities related to mission's aeronautical and ordnance materiel */
		} :> concerns;
	}
	part CombatAircraftProgramCoordinatingCommission : MilitarySystemManagementAuthority {
		:> influenceLevel = StakeholderInfluenceLevel::low;
		:> influenceKind = StakeholderInfluenceKind::indirect;
		item concern1 : Concern {
			doc /* Manage and oversee modernized avionic system integration on A-29 platform */
		} :> concerns;
	}
}
