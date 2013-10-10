package body Navigation.Planal_Controller is

   function pxCreate return pCPlanal_Controller is

      pxPlanalController : pCPlanal_Controller;

   begin

      pxPlanalController := new CPlanal_Controller;

      pxPlanalController.pxCurrentPlane := Math.Planes.pxCreate(Math.Vectors.pxCreate(0.0,0.0,1.0),0.0);
      pxPlanalController.pxWantedPlane := Math.Planes.pxCreate(Math.Vectors.pxCreate(0.0,0.0,1.0),0.0);

      pxPlanalController.pxPlanalMotionComponent := Navigation.Motion_Component.pxCreate(Navigation.Motion_Component.Plane,
                                                                                         Navigation.PID_Controller.TPIDComponentScalings'(0.0,0.0,0.0));

      return pxPlanalController;

   end pxCreate;

   function xGet_Planal_Thruster_Control_Values(this : in out CPlanal_Controller) return TPlanalControlValues is
      ABO : TPlanalControlValues;
   begin
      return ABO;
   end xGet_Planal_Thruster_Control_Values;


   procedure Update_Wanted_Plane(this : in out CPlanal_Controller; xWantedPlaneComponents : TPlanalComponents) is

   --   pxNewWantedPlane : Math.Planes.pCPlane;

    --  pxXVector, pxYVector : Math.Vectors.pCVector;

   begin

   --   pxXVector := Math.Vectors.pxCreate(Ada.Numerics.Elementary_Functions.Cos(float(xWantedPlaneComponents(1))),0.0,Ada.Numerics.Elementary_Functions.Sin(xWantedPlaneComponents(1)));
    --  pxYVector := Math.Vectors.pxCreate(Ada.Numerics.Elementary_Functions.Cos(float(0.0,xWantedPlaneComponents(2))),Ada.Numerics.Elementary_Functions.Sin(xWantedPlaneComponents(2)));
      null;


   end Update_Wanted_Plane;

   procedure Update_Current_Plane(this : in out CPlanal_Controller; xCurrentPlaneComponents : TPlanalComponents) is
   begin
      null;
   end Update_Current_Plane;

   procedure Set_New_PID_Component_Scalings (this : in out CPlanal_Controller; eComponentToUpdate : Navigation.Motion_Component.EMotionComponent; xNewPIDScaling : Navigation.PID_Controller.TPIDComponentScalings) is
   begin
      null;
   end Set_New_PID_Component_Scalings;



end Navigation.Planal_Controller;
