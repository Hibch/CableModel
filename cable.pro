Include "cable_data.geo"; // Optional file but recommended as data are often common to geometry and finite-element description

DefineConstant[
  Flag_AnalysisType = {0,
    Choices{
      0="Electric",
      1="Magnetic",
      2="Magneto-thermal (linear)",
      3="Magneto-thermal (nonlinear)"
    },
    Name "{00Parameters/00Type of analysis", Highlight "Blue"}

  Flag_sigma_funcT = (Flag_AnalysisType==3)?1:0, // Only useful in the magneto-thermal coupled case

  nb_iter = 20,
  relaxation_factor = 1,
  stop_criterion = 1e-6,

  // r_ = {"Analysis", Name "GetDP/1ResolutionChoices", Visible 1} // You can predefine, but not needed
  c_ = {"-solve -v2", Name "GetDP/9ComputeCommand", Visible 1},
  p_ = {"", Name "GetDP/2PostOperationChoices", Visible 1, Closed 1}
];

Group ={
   WaterInCable = Region[{WATER_IN}];
   WaterAboveSoil = Region[{WATER_OUT}];
   WaterEM = Region[{WaterInCable}];
   WaterTH = Region[{WaterAboveSoil}];
   Water = Region[{WaterEM,WaterTH}];

   ConductorScreen =  Region[{CONDUCTOR_SCREEN}];
   Xlpe = Region[{XLPE}];
   InsuationScreen = Region[{INSULATION_SCREEN}];
   SwellingTape = Region[{TAPE}];
   MetallicSheath = Region[{METALLIC_SHEATH}];
   AntiCorrosionSheath = Region[{ANTI_CORR_SHEATH}];

   Bedding = Region[{BEDDING}];
   Armour = Region[{ARMOUR}];
   OuterServing = Region[{OUTER_SERVING}];

   XLPE = Region[{ConductorScreen, Xlpe, InsuationScreen}];
   Polyethylene =  Region[{SwellingTape, AntiCorrosionSheath, Bedding}];
   Steel = Region[{Armour}];
   Lead = Region[{MetallicSheath}];
   Polypropylene = Region[{OuterServing}];

   SoilEM = Region[{SOIL_EM}];
   SoilTH = Region[{SOIL_TH}];
   Soil = Region[{SoilEM,SoilTH}];

   For k In {1:NbWires}
    Ind~{k} = Region[{(WIRE+k-1)}];
    Inds   += Region[{(WIRE+k-1)}];
   EndFor

   Cable = Region[{Inds, ConductorScreen, XLPE, InsuationScreen, SwellingTape, MetallicSheath, AntiCorrosionSheath, Bedding, Armour, OuterServing, WaterInCable}];

   //Magnetodynamics
   SurfaceGe0 = Region[{OUTBND_EM}]; // NB: =0 on this boundary

   DomainCC_Mag  = Region[ {WaterEM,Inds} ];
   DomainCC_Mag += Region[ {XLPE, SwellingTape, Polyethylene, Polypropylene} ];
   DomainC_Mag   = Region[ {Steel,Lead} ];

   DomainS0_Mag  = Region[ {} ]; // If imposing source with jS0[]
   DomainS_Mag   = Region[ {Inds}} ]; // If using Current_2D, it allows accounting for the dependance of sigma with T

   DomainCwithI_Mag = Region[ {} ];
   Domain_Mag = Region[ {DomainCC_Mag, DomainC_Mag} ];

    //Electrodynamics
    Domain_Ele = Region[{Domain_Mag}]; // same domain as Magnetodynamics

    //Thermal domain
    Vol_Thermal = Region[{Domain_Mag, WaterTH, SoilTH}];
    Vol_QSource_Thermal = Region[{DomainC_Mag}];
    Vol_QSource0_Thermal = Region[{DomainS0_Mag}];
    Vol_QSourceB_Thermal = Region[{DomainS_Mag}];
    Sur_Convection_Thermal = Region[{}];
    Sur_Dirichlet_Thermal = Region[{OUTBND_TH}];
    Domain_Thermal = Region[{Vol_Thermal, Sur_Convection_Thermal}];

}
