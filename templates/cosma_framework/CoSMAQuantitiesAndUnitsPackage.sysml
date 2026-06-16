//
// Original Copyright (c) 2026 AIRBUS and its affiliates.
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
// Modified for mission-agnostic multi-agent pipeline.
// Changes: Added aviation/maritime/ISR domain units (knot, nmi, arcmin, arcsec, fathom).
//

library package CoSMAQuantitiesAndUnitsPackage {

\tprivate import NumericalFunctions::*;
\tprivate import ISQ::*;
\tprivate import SI::*;
\tprivate import MeasurementReferences::*;
\tprivate import Quantities::*;
\tprivate import Base::DataValue;

\tattribute def RatioValue :> MeasurementReferences::DimensionOneValue {
\t\tdoc /* Quantity of dimension one value that represents a ratio */
\t\tattribute :>> num: ScalarValues::Real;
\t\tattribute :>> mRef: RatioUnit;
\t}

\tattribute ratio : RatioValue nonunique :> Quantities::scalarQuantities;
\tattribute def RatioUnit :> MeasurementReferences::DimensionOneUnit;

\tattribute <'%'> 'per cent' : RatioUnit {
\t\tattribute :>> unitConversion {
\t\t\tattribute :>> conversionFactor = RationalFunctions::rat(1, 100);
\t\t}
\t}

\tattribute <'m³⋅s⁻²'> 'metre to the power 3 second to the power minus 2' : SimpleUnit;

\t// --- SI-derived units (from original CoSMA) ---
\tattribute <kN> kilonewton : ForceUnit { :>> unitConversion: ConversionByPrefix { :>> prefix = kilo; :>> referenceUnit = N; } }
\tattribute <kPa> kilopascal : PressureUnit { :>> unitConversion: ConversionByPrefix { :>> prefix = kilo; :>> referenceUnit = Pa; } }
\tattribute <MN> meganewton : ForceUnit { :>> unitConversion: ConversionByPrefix { :>> prefix = mega; :>> referenceUnit = N; } }
\tattribute <gn> standardgravity : AccelerationUnit {:>> unitConversion: ConversionByConvention { :>> referenceUnit = 'm⋅s⁻²'; :>> conversionFactor = 9.80665; :>> isExact = false; }}
\tattribute <fps> framespersecond : FrequencyUnit;
\tattribute <kB> kilobyte : StorageCapacityUnit { :>> unitConversion: ConversionByPrefix { :>> prefix = kilo; :>> referenceUnit = B; } }
\tattribute <yr> year : TimeUnit {:>> unitConversion: ConversionByConvention { :>> referenceUnit = 's'; :>> conversionFactor = 31536000; :>> isExact = false; }}

\t// --- Aviation and maritime domain units ---
\tattribute <kn> knot : SpeedUnit {:>> unitConversion: ConversionByConvention { :>> referenceUnit = 'm/s'; :>> conversionFactor = 0.514444; :>> isExact = false; }}
\tattribute <nmi> nauticalmile : LengthUnit {:>> unitConversion: ConversionByConvention { :>> referenceUnit = m; :>> conversionFactor = 1852; :>> isExact = true; }}

\t// --- Sensor and ISR domain units ---
\tattribute <'arcmin'> arcminute : SimpleUnit {:>> unitConversion: ConversionByConvention { :>> referenceUnit = rad; :>> conversionFactor = 2.908882E-4; :>> isExact = false; }}
\tattribute <'arcsec'> arcsecond : SimpleUnit {:>> unitConversion: ConversionByConvention { :>> referenceUnit = rad; :>> conversionFactor = 4.848137E-6; :>> isExact = false; }}

\t// --- Maritime domain units ---
\tattribute <ftm> fathom : LengthUnit {:>> unitConversion: ConversionByConvention { :>> referenceUnit = m; :>> conversionFactor = 1.8288; :>> isExact = true; }}

\t// --- Currency ---
\tattribute def CurrencyUnit :> SimpleUnit {
\t\tprivate attribute currencyPF: QuantityPowerFactor[1] { :>> quantity = Currency; :>> exponent = 1; }
\t\tattribute :>> quantityDimension { :>> quantityPowerFactors = currencyPF; }
\t}

\tattribute def CurrencyValue :> ScalarQuantityValue {
\t\tdoc
\t\t/*
\t\t* application domain: generic
\t\t* name: Currency
\t\t* measurement unit(s): $
\t\t* tensor order: 0
\t\t*/
\t\tattribute :>> num: Real;
\t\tattribute :>> mRef: CurrencyUnit[1];
\t}

\tattribute Currency: CurrencyValue[1];
\tattribute currency: CurrencyValue[*] nonunique :> scalarQuantities;
\tattribute <'$'> dollar : CurrencyUnit;
\tattribute <'€'> euro : CurrencyUnit;

\t// --- Rocket engineering (retained from original CoSMA) ---
\tattribute def SpecificImpulseValue :> ScalarQuantityValue {
\t\tdoc
\t\t/*
\t\t* application domain: rocket engineering
\t\t* name: Specific Impulse
\t\t* measurement unit(s): s
\t\t* tensor order: 0
\t\t*/
\t\tattribute :>> num: Real;
\t\tattribute :>> mRef: DurationUnit[1];
\t}

\tattribute SpecificImpulse: SpecificImpulseValue[1];
\tattribute specificImpulse: SpecificImpulseValue[*] nonunique :> scalarQuantities;

\tcalc <ln> naturalLogarithm { in x: DataValue[1]; in y: DataValue[1]; return : DataValue[1]; }
}
