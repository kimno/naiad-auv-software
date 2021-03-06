--  This package has been generated automatically by GNATtest.
--  Do not edit any part of it, see GNATtest documentation for more details.

--  begin read only
with AUnit.Test_Caller;
with Gnattest_Generated;

package body Math.Matrices.CMatrix_Test_Data.CMatrix_Tests.Suite is

   package Runner_1 is new AUnit.Test_Caller
     (GNATtest_Generated.GNATtest_Standard.Math.Matrices.CMatrix_Test_Data.CMatrix_Tests.Test_CMatrix);

   Result : aliased AUnit.Test_Suites.Test_Suite;

   Case_1_1_Test_pxGet_Inverse_4c7f5a : aliased Runner_1.Test_Case;
   Case_2_1_Test_pxGet_Copy_3c9397 : aliased Runner_1.Test_Case;
   Case_3_1_Test_pxGet_Transpose_88bdfe : aliased Runner_1.Test_Case;
   Case_4_1_Test_tfGet_Raw_Matrix_d46bc2 : aliased Runner_1.Test_Case;
   Case_5_1_Test_fGet_Determinant_6a3440 : aliased Runner_1.Test_Case;
   Case_6_1_Test_pxGet_X_Vector_160735 : aliased Runner_1.Test_Case;
   Case_7_1_Test_pxGet_Y_Vector_2cb764 : aliased Runner_1.Test_Case;
   Case_8_1_Test_pxGet_Z_Vector_fd9c88 : aliased Runner_1.Test_Case;
   Case_9_1_Test_Copy_From_d33e2b : aliased Runner_1.Test_Case;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
   begin

      Runner_1.Create
        (Case_1_1_Test_pxGet_Inverse_4c7f5a,
         "math-matrices.ads:28:4:",
         Test_pxGet_Inverse_4c7f5a'Access);
      Runner_1.Create
        (Case_2_1_Test_pxGet_Copy_3c9397,
         "math-matrices.ads:29:4:",
         Test_pxGet_Copy_3c9397'Access);
      Runner_1.Create
        (Case_3_1_Test_pxGet_Transpose_88bdfe,
         "math-matrices.ads:30:4:",
         Test_pxGet_Transpose_88bdfe'Access);
      Runner_1.Create
        (Case_4_1_Test_tfGet_Raw_Matrix_d46bc2,
         "math-matrices.ads:31:4:",
         Test_tfGet_Raw_Matrix_d46bc2'Access);
      Runner_1.Create
        (Case_5_1_Test_fGet_Determinant_6a3440,
         "math-matrices.ads:32:4:",
         Test_fGet_Determinant_6a3440'Access);
      Runner_1.Create
        (Case_6_1_Test_pxGet_X_Vector_160735,
         "math-matrices.ads:34:4:",
         Test_pxGet_X_Vector_160735'Access);
      Runner_1.Create
        (Case_7_1_Test_pxGet_Y_Vector_2cb764,
         "math-matrices.ads:35:4:",
         Test_pxGet_Y_Vector_2cb764'Access);
      Runner_1.Create
        (Case_8_1_Test_pxGet_Z_Vector_fd9c88,
         "math-matrices.ads:36:4:",
         Test_pxGet_Z_Vector_fd9c88'Access);
      Runner_1.Create
        (Case_9_1_Test_Copy_From_d33e2b,
         "math-matrices.ads:38:4:",
         Test_Copy_From_d33e2b'Access);

      Result.Add_Test (Case_1_1_Test_pxGet_Inverse_4c7f5a'Access);
      Result.Add_Test (Case_2_1_Test_pxGet_Copy_3c9397'Access);
      Result.Add_Test (Case_3_1_Test_pxGet_Transpose_88bdfe'Access);
      Result.Add_Test (Case_4_1_Test_tfGet_Raw_Matrix_d46bc2'Access);
      Result.Add_Test (Case_5_1_Test_fGet_Determinant_6a3440'Access);
      Result.Add_Test (Case_6_1_Test_pxGet_X_Vector_160735'Access);
      Result.Add_Test (Case_7_1_Test_pxGet_Y_Vector_2cb764'Access);
      Result.Add_Test (Case_8_1_Test_pxGet_Z_Vector_fd9c88'Access);
      Result.Add_Test (Case_9_1_Test_Copy_From_d33e2b'Access);

      return Result'Access;

   end Suite;

end Math.Matrices.CMatrix_Test_Data.CMatrix_Tests.Suite;
--  end read only
