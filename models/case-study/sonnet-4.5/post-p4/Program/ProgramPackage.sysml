package ProgramPackage {

	private import MissionPackage::*;
	private import CoSMAPackage::*;

	part def AmazonAirspaceProtectionCampaign :> Program {
		doc /* The Amazon Airspace Protection Campaign (Campanha de Proteção do Espaço Aéreo Amazônico) is a strategic-operational level campaign aimed at ensuring sovereignty and airspace integrity in the Brazilian Amazon, with the objective of suppressing cross-border illicit activities that rely on low-signature, low-cost aerial means, with focus on UAS, to provide surveillance of a region of low population density and vast border extent. This campaign integrates one of the points of great relevance for ... */

		part continentalZIDAShieldOperation : ContinentalZIDAShieldOperation :> missions;
		part ostiumOperation : Mission {
			doc /* Permanent airspace surveillance operation for suppression of irregular traffic linked to narcotrafficking crimes */
		} :> missions;
	}
}
