// Include "cable_data.geo"; // Optional file but recommended as data are often common to geometry and finite-element description

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

Group {
  // electrodynamics
  Cable = Region[{}];
  Sur_Dirichlet_Ele = Region[{}]; // boundary
  Domain_Ele = Region[ {Cable} ]; // total domain for electrodynamic computation


  // magnetodynamics
  Sur_Dirichlet_Mag = Region[{}]; // n.b=0 on this boundary

  DomainCC_Mag  = Region[ {} ]; // Non-conduction domain
  DomainC_Mag   = Region[ {} ]; // Conducting domain

  DomainS0_Mag = Region[ {} ]; // If imposing source with js0[]
  DomainS_Mag  = Region[ {} ]; // If using Current_2D, it allows accounting for the dependance of sigma with T

  DomainCWithI_Mag  = Region[ {} ];
  Domain_Mag = Region[ {DomainCC_Mag, DomainC_Mag} ];


  // Thermal domain
  Vol_Thermal          = Region[{}];
  Vol_QSource_Thermal  = Region[{DomainC_Mag}];
  Vol_QSource0_Thermal = Region[{DomainS0_Mag}];
  Vol_QSourceB_Thermal = Region[{DomainS_Mag}];
  Sur_Convection_Thermal =  Region[{}];
  Sur_Dirichlet_Thermal = Region[{}];
  Domain_Thermal = Region[{Vol_Thermal, Sur_Convection_Thermal}];

  DomainDummy = Region[{12345}];
}

Function {
  mu0 = 4.e-7 * Pi;
  eps0 = 8.854187818e-12;

  // TO DEFINE FOR ALL MATERIALS
  nu[Region[{***}]]  = 1./mu0;
  sigma[***]  = ***;

  // Examples of nonlinear functions for the sigma dependence with the temperature
  // Attention alpha_cu, alpha_al, Tref have to be defined somewhere before this
  fT_cu[] = (1+alpha_cu*($1-Tref)); // $1 is current temperature in [K], alpha in [1/K]
  fT_al[] = (1+alpha_al*($1-Tref));

  If (!Flag_sigma_funcT)
    sigma[***]      = sigma_cu;
  Else
    sigma[***]      = sigma_cu/fT_cu[$1];
  EndIf

  epsilon[Region[{***}]] = eps0;
  epsilon[Region[{***}]] = eps0*epsr_polyethylene;

  Freq = 50; // Adapt if needed
  Omega = 2*Pi*Freq;

  // Example for a three phase system
  Pa = 0.; Pb = -120./180.*Pi; Pc = -240./180.*Pi;
  I = 406; // maximum value current in data sheet
  js0[Ind_1] = Vector[0,0,1] * I / SurfaceArea[] * F_Cos_wt_p[]{Omega, Pa};
  js0[Ind_2] = Vector[0,0,1] * I / SurfaceArea[] * F_Cos_wt_p[]{Omega, Pb};
  js0[Ind_3] = Vector[0,0,1] * I / SurfaceArea[] * F_Cos_wt_p[]{Omega, Pc};

  Ns[]= 1;
  Sc[]= SurfaceArea[];

  // second order calculation
  _deg2_hierarchical = 0; // change value if you wanna try second order basis functions
  //Flag_Degree_a = _deg2_hierarchical ? 2 : 1;
  //Flag_Degree_v = _deg2_hierarchical ? 2 : 1;

  // thermal parameters
  Tambient[] = Tamb; // [K]

  // thermal conductivities [W/(m K)]
  k[***] = kappa_steel;

  // * heat conduction mechanism is the main heat transfer mechanism for an underground cable system
  // * all materials have constant thermal properties, including the thermal resistivity of the soil
  // * radiation and convection are not considered

  // * force convection on ground surface due to wind: h = 7.371 + 6.43*v^0.75
  // example of function with wind speed
  h[] = 7.371 + 6.43*v_wind^0.75; // 1, 10 ... Convective coefficient [W/(m^2 K)]
}

Constraint {
  // All the constraint hereafter must be adapted to your problem. Commented definitions are kept as example.

  // Electrical constraints
  { Name ElectricScalarPotential;
    Case {
      // { Region Ind_1; Value V0; TimeFunction F_Cos_wt_p[]{2*Pi*Freq, Pa}; }
      // { Region Ind_2; Value V0; TimeFunction F_Cos_wt_p[]{2*Pi*Freq, Pb}; }
      // { Region Ind_3; Value V0; TimeFunction F_Cos_wt_p[]{2*Pi*Freq, Pc}; }

      // { Region Sur_Dirichlet_Ele; Value 0; }
    }
  }
  /*{ Name ZeroElectricScalarPotential; // Only if second order basis functions - Ignore
    Case {
      // For k In {1:3}
      //   { Region Ind~{k}; Value 0; }
      // EndFor
      // { Region Sur_Dirichlet_Ele; Value 0; }
    }*/
  }

  // Magnetic constraints
  { Name MagneticVectorPotential_2D;
    Case {
      { Region Sur_Dirichlet_Mag; Value 0.; }
    }
  }
  { Name Voltage_2D;
    Case {
    }
  }
  { Name Current_2D;
    Case {
      // constraint used if Inds in DomainS_Mag
      // { Region Ind_1; Value I; TimeFunction F_Cos_wt_p[]{2*Pi*Freq, Pa}; }
      // { Region Ind_2; Value I; TimeFunction F_Cos_wt_p[]{2*Pi*Freq, Pb}; }
      // { Region Ind_3; Value I; TimeFunction F_Cos_wt_p[]{2*Pi*Freq, Pc}; }
    }
  }

  // Thermal constraints
  { Name DirichletTemp ;
    Case {
      // { Type Assign; Region Sur_Dirichlet_Thermal ; Value Tambient[]; }
    }
  }

}


Include "Jacobian_Integration.pro"; // Normally no modification is needed

// The following files contain: basis functions, formulations, resolution, post-processing, post-operation
// Some adaptations may be needed
If (Flag_AnalysisType ==0)
  Include "electrodynamic_formulation.pro";
EndIf
If (Flag_AnalysisType ==1)
  Include "darwin_formulation.pro";
EndIf
If (Flag_AnalysisType > 2)
  Include "magneto-thermal_formulation.pro";
EndIf
