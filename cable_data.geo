//=================================================
//               Geometrical Data
//=================================================

mm = 1e-3;

dc = 16.9*mm; // Diameter of conductor
ti = 1.4*mm; // Conductor screen
txlpe = 9*mm; // Insulation
to = 1.4*mm; // Insulation screen
tt = 0.6*mm; //Swelling tape
tms = 2.3*mm; // Metallic sheath
tacs = 2.5*mm; // Anti-corrsion sheath

tbed = 3*mm; // Bedding
ta = 5*mm; // Armour
tos = 4*mm; // Outer serving

dtot = 2*67.3*mm;
dinf = 5*dtot; // Electromagnetic domain
depth_cable = 2; // [m] Laying depth of the cable
dinf_th = 3; //thermal analysis
dinf_th_water = 3 - depth_cable;

//=================================================
//               Material properties
//=================================================
// relative permittivity
epsr_polyethylene = 2.25;
epsr_polypropylene = 2.2;
epsr_xlpe = 2.5;
epsr_lead = 15;

epsr_seabed = 30;
epsr_seawater = 81;
// = 1 for steel, aluminium,

// relative permittivity
mur_steel = 4;
// = 1 for  al, PE, PP, xlpe, seabed, seawater

// electrical conductivity [S/m]
sigma_steel = 4.7e6;
sigma_al = 3.77e7;
sigma_polyethylene = 1e-18;
sigma_polypropylene = 6.25e-15;
sigma_xlpe = 1e-18;
sigma_lead = 4.87e6;

sigma_seabed = 1.5;
sigma_seawater = 4;

// thermal conductivity [W/mK]
kappa_steel = 50.2;
kappa_al = 237;
kappa_polyethylene = 0.46;
kappa_polypropylene = 0.1;
kappa_xlpe = 0.46;
kappa_lead = 33;

kappa_seabed = 2;
kappa_seawater = 0.593;

Tamb = 273.15 + 10; // K
Tref = 273.15 + 0; // K
alpha_al = 0.00390; // 1/K
alpha_lead = 39e-4;

//=================================================
//                Other parameters
//=================================================

NbWires = 3;
V0 = 66e3/1.732; // kV


//=================================================
//                Mesh properties
//=================================================
DefineConstant[ s = {1., Name "Parameters/Global mesh size factor"}];

//=================================================
//              Physical numbers
//=================================================
WATER_IN = 900;
WATER_OUT = 901;
WIRE = 1000;

CONDUCTOR_SCREEN = 2000;
XLPE = 3000;
INSULATION_SCREEN = 4000;
TAPE = 5000;
METALLIC_SHEATH = 6000;
ANTI_CORR_SHEATH = 7000;

BEDDING = 8000;
ARMOUR = 9000;
OUTER_SERVING = 10000;

SOIL_EM = 11000;
SOIL_TH = 12000;

OUTBND_EM = 1111;
OUTBND_TH = 2222;

INTERFACE_WATER_SOIL = 3333;
