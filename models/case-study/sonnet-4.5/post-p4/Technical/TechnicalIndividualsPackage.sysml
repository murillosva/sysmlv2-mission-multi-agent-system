package TechnicalIndividualsPackage {

	private import CoSMAPackage::*;
	private import TechnicalComponentsPackage::*;
	private import CoSMAQuantitiesAndUnitsPackage::*;
	private import SI::*;
	private import ISQ::*;
	individual part def 'FARP-SBCZ' :> FARPPointSBCZ {
		doc /* Individual FARP point instance at SBCZ (Cruzeiro do Sul) */
	}
	individual part def 'FARP-SWKU' :> FARPPointSWKU {
		doc /* Individual FARP point instance at SWKU (Caruru) */
	}
	individual part def 'FARP-SDCG' :> FARPPointSDCG {
		doc /* Individual FARP point instance at SDCG (Coari) */
	}
	individual part def 'FARP-SBRB' :> FARPPointSBRB {
		doc /* Individual FARP point instance at SBRB (Rio Branco) */
	}
	individual part def 'MainBase-SBPV' :> GovernadorJorgeTeixeiraDeOliveiraAerodromeSBPV {
		doc /* Main operating base at Porto Velho (SBPV), home of 2°/3° GAV */
	}
}
