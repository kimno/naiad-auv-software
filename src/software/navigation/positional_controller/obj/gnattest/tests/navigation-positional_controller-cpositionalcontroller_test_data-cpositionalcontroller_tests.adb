--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Navigation.Positional_Controller.CPositionalController_Test_Data.

with AUnit.Assertions; use AUnit.Assertions;

package body Navigation.Positional_Controller.CPositionalController_Test_Data.CPositionalController_Tests is


--  begin read only
   procedure Test_xGet_Positional_Thruster_Control_Values (Gnattest_T : in out Test_CPositionalController);
   procedure Test_xGet_Positional_Thruster_Control_Values_1d7d6d (Gnattest_T : in out Test_CPositionalController) renames Test_xGet_Positional_Thruster_Control_Values;
--  id:2.1/1d7d6de9f88b64a2/xGet_Positional_Thruster_Control_Values/1/0/
   procedure Test_xGet_Positional_Thruster_Control_Values (Gnattest_T : in out Test_CPositionalController) is
   --  navigation-positional_controller.ads:14:4:xGet_Positional_Thruster_Control_Values
--  end read only

      pragma Unreferenced (Gnattest_T);

      use Navigation.Motion_Component;

      pxPositionalController : Navigation.Positional_Controller.pCPositionalController;

      pxNewWanted : Math.Vectors.pCVector := Math.Vectors.pxCreate(5.0,5.0,5.0);

      pxCurrentPosition : Math.Vectors.pCVector := Math.Vectors.pxCreate(0.0,0.0,0.0);
      pxCurrentOrientation : Math.Matrices.pCMatrix := Math.Matrices.xCreate_Identity.pxGet_Copy;

      pxPositionalScalings : Navigation.PID_Controller.TPIDComponentScalings := (1.0,1.0,1.0);


      xPositionalControlValues : Navigation.Thrusters.TThrusterEffects;
   begin

      pxPositionalController := Navigation.Positional_Controller.pxCreate(pxCurrentAbsolutePosition    => pxCurrentPosition,
                                                                          pxWantedAbsolutePosition     => pxNewWanted,
                                                                          pxCurrentAbsoluteOrientation => pxCurrentOrientation);

      pxPositionalController.Set_New_PID_Component_Scalings(Navigation.Motion_Component.AllComponents, pxPositionalScalings);

      pxPositionalController.Update_Current_Errors;

      xPositionalControlValues := pxPositionalController.xGet_Positional_Thruster_Control_Values(1.0);

      AUnit.Assertions.Assert(Condition => abs(xPositionalControlValues(Thrusters.XPosition)) > 0.00001,
                              Message => "PositionalControlvalue component 1 is 0");

      AUnit.Assertions.Assert(Condition => abs(xPositionalControlValues(Thrusters.YPosition)) > 0.00001,
                              Message => "PositionalControlvalue component 1 is 0");

      AUnit.Assertions.Assert(Condition => abs(xPositionalControlValues(Thrusters.ZPosition)) > 0.00001,
                              Message => "PositionalControlvalue component 1 is 0");

      Navigation.Positional_Controller.Free(pxPositionalControllerToDeallocate => pxPositionalController);
      Math.Vectors.Free(pxVectorToDeallocate => pxNewWanted);
      Math.Vectors.Free(pxVectorToDeallocate => pxCurrentPosition);
      Math.Matrices.Free(pxMatrixToDeallocate => pxCurrentOrientation);


--  begin read only
   end Test_xGet_Positional_Thruster_Control_Values;
--  end read only


--  begin read only
   procedure Test_Update_Current_Errors (Gnattest_T : in out Test_CPositionalController);
   procedure Test_Update_Current_Errors_db8191 (Gnattest_T : in out Test_CPositionalController) renames Test_Update_Current_Errors;
--  id:2.1/db81912ffacc7cfb/Update_Current_Errors/1/0/
   procedure Test_Update_Current_Errors (Gnattest_T : in out Test_CPositionalController) is
   --  navigation-positional_controller.ads:16:4:Update_Current_Errors
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

	--TODO m�ste ha mocking f�r att kunna testa
--  begin read only
      null;
   end Test_Update_Current_Errors;
--  end read only


--  begin read only
   procedure Test_Set_New_PID_Component_Scalings (Gnattest_T : in out Test_CPositionalController);
   procedure Test_Set_New_PID_Component_Scalings_90f3b2 (Gnattest_T : in out Test_CPositionalController) renames Test_Set_New_PID_Component_Scalings;
--  id:2.1/90f3b2739b4fefa7/Set_New_PID_Component_Scalings/1/0/
   procedure Test_Set_New_PID_Component_Scalings (Gnattest_T : in out Test_CPositionalController) is
   --  navigation-positional_controller.ads:19:4:Set_New_PID_Component_Scalings
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      --TODO m�ste ha mocking f�r att kunna testa

--  begin read only
      null;
   end Test_Set_New_PID_Component_Scalings;
--  end read only

end Navigation.Positional_Controller.CPositionalController_Test_Data.CPositionalController_Tests;
