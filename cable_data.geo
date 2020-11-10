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

//=================================================
//               Material properties
//=================================================
// relative permittivity
epsr_polyethylene = 2.25;
epsr_polypropylene = 2.2;
epsr_xlpe = 2.5;

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

sigma_seabed = 1.5;
sigma_seawater = 4;

// thermal conductivity [W/mK]
kappa_steel = 50.2;
kappa_al = 237;
kappa_polyethylene = 0.46;
kappa_polypropylene = 0.1;
kappa_xlpe = 0.46;

kappa_seabed = 2;
kappa_seawater = 0.593;
