//
// Original Copyright (c) 2026 AIRBUS and its affiliates.
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
// Modified for mission-agnostic multi-agent pipeline.
// Changes: Astronaut→Operator, MannedSpaceMission→CrewedMission.
//

library package CoSMAPackage {

\tprivate import NumericalFunctions::*;
\tprivate import States::*;
\tprivate import ISQ::*;
\tprivate import SI::*;
\tprivate import MeasurementReferences::*;
\tprivate import Quantities::*;
\tprivate import Base::DataValue;
\tprivate import Metaobjects::*;
\tprivate import CoSMAQuantitiesAndUnitsPackage::*;

\tpart def MassedThing {
\t\tattribute mass :> ISQ::mass;
\t\tattribute totalMass :> ISQ::mass;
\t}

\tpart def SimpleThing :> MassedThing {
\t\tattribute redefines totalMass = mass;
\t}

\tpart def CompositeThing :> MassedThing {
\t\tpart subcomponents: MassedThing[*];
\t\t:>> totalMass = mass + sum(subcomponents.totalMass);
\t}

\tabstract action def Operation;

\tabstract action def Function {
\t\taction subfunctions[*] : Function :>> subactions;
\t}

\tabstract part def SystemOfInterest;
\tabstract part def LogicalComponent;

\tabstract part def TechnicalComponent {
\t\tattribute failureRate :> ISQ::frequency;
\t}

\tabstract part def SoftwareComponent :> TechnicalComponent;
\tabstract part def HardwareComponent :> TechnicalComponent, SimpleThing;

\tabstract part def PowerProvider :> HardwareComponent {
\t\tattribute powerGenerated :> ISQ::power default 0 [W];
\t}

\tabstract part def PowerConsumer :> HardwareComponent {
\t\tattribute powerLoad :> ISQ::power;
\t}

\tpart def Program {
\t\tpart missions[1..*] : Mission;
\t}

\tstate def Phase :> StateAction;

\tpart def Capability;

\tpart def Operator :> Person;

\tabstract part def CrewedMission :> Mission {
\t\tpart crew[1..*] : Operator;
\t}

\tabstract part def Mission {
\t\trequirement goals[1..*] : Goal;
\t\tpart system : System;
\t\tpart context : Context;
\t\texhibit state phases : StateAction;
\t\tpart requiredCapabilites[0..*];
\t\tabstract connection capabilityToGoals[*] : CapabilityToGoalDerivation;
\t\tattribute plannedDuration :> ISQ::duration;

\t\tattribute researchAndDevelopmentCost :> currency;
\t\tattribute manufacturingCost :> currency;
\t\tattribute operationsCost :> currency;
\t\tattribute personnelCost :> currency;
\t}

\tabstract connection def CapabilityToGoalDerivation {
\t\tref part capability[1] : Capability :> participant;
\t\tref requirement goals[1..*] : Goal :> participant;
\t}

\trequirement def Goal;

\titem def Concern;

\tenum def StakeholderInfluenceKind {
\t\tenum direct;
\t\tenum indirect;
\t}

\tenum def StakeholderInfluenceLevel {
\t\tenum high;
\t\tenum medium;
\t\tenum low;
\t}

\tpart def Person;

\trequirement def StakeholderNeed;

\tpart def Stakeholder {
\t\tattribute influenceLevel: StakeholderInfluenceLevel;
\t\tattribute influenceKind: StakeholderInfluenceKind;
\t\titem concerns[*]: Concern;
\t\trequirement needs[*]: StakeholderNeed;
\t}

\tpart def Context :> System {
\t\tpart externalSystems[*] : System;
\t}

\tpart def System :> CompositeThing {

\t}

\tpart def SystemOfSystems :> System {
\t\tpart constituentSystems[*] : ConstituentSystem;
\t}

\tpart def ConstituentSystem :> System {

\t}

}
