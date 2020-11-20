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
   DomainS_Mag   = Region[ {Inds}} ]; // If using Current_2D

   DomainCwithI_Mag = Region[ {} ];
   Domain_Mag = Region[ {DomainCC_Mag, DomainC_Mag} ];

}
