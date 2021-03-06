--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Pressure_Sensor.Test_Data.

with AUnit.Assertions; use AUnit.Assertions;

package body Pressure_Sensor.Test_Data.Tests is


--  begin read only
   procedure Test_Init (Gnattest_T : in out Test);
   procedure Test_Init_40ca0e (Gnattest_T : in out Test) renames Test_Init;
--  id:2.1/40ca0ec478974011/Init/1/0/
   procedure Test_Init (Gnattest_T : in out Test) is
   --  pressure_sensor.ads:21:4:Init
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      AUnit.Assertions.Assert
        (Gnattest_Generated.Default_Assert_Value,
         "Test not implemented.");

--  begin read only
   end Test_Init;
--  end read only


--  begin read only
   procedure Test_u16GetPressure (Gnattest_T : in out Test);
   procedure Test_u16GetPressure_a48520 (Gnattest_T : in out Test) renames Test_u16GetPressure;
--  id:2.1/a485205fc84b4155/u16GetPressure/1/0/
   procedure Test_u16GetPressure (Gnattest_T : in out Test) is
   --  pressure_sensor.ads:23:4:u16GetPressure
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      AUnit.Assertions.Assert
        (Gnattest_Generated.Default_Assert_Value,
         "Test not implemented.");

--  begin read only
   end Test_u16GetPressure;
--  end read only

end Pressure_Sensor.Test_Data.Tests;
