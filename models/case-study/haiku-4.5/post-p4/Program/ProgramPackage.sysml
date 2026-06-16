package ProgramPackage {

	private import MissionPackage::*;
	private import CoSMAPackage::*;

	part def BrazilianAmazonSovereigntyAndAirspaceDefenseCampaign :> Program {
		doc /* The Continental ZIDA Shield Operation is conceived within a strategic-operational campaign aimed at ensuring sovereignty and airspace integrity in the Brazilian Amazon, with the objective of suppressing cross-border illicit activities that rely on low-signature, low-cost aerial means, particularly Unmanned Aerial Systems (UAS) employed for surveillance and logistical support to narcotrafficking and other illicit activities. The program integrates logistical-operational optimization through Fo... */

		part continentalZIDAShieldOperation : ContinentalZIDAShieldOperation :> missions;
		part operationOstium : Mission {
			doc /* Actual FAB operation aimed at airspace surveillance for suppression of irregular traffic linked to narcotrafficking crimes. */
		} :> missions;
	}
}
