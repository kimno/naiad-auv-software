with Ada.Numerics.Elementary_Functions;
with Ada.Numerics;
with Ada.Text_IO;
with Exception_Handling;

package body Navigation.Thruster_Configurator is

   function pxCreate return pCThrusterConfigurator is
      use Ada.Numerics.Elementary_Functions;
      use Ada.Numerics;

      pxNewThrusterConfigurator : pCThrusterConfigurator;
      tfThrusterEffects : Navigation.Thrusters.TThrusterEffects;

   begin

      pxNewThrusterConfigurator := new CThrusterConfigurator;

      tfThrusterEffects := Navigation.Thrusters.tfMake_Thruster_Effects(fXPosition => -Sin(Pi/3.0),
                                                                        fYPosition => Sin(Pi/6.0),
                                                                        FZPosition => 0.0,
                                                                        fXRotation => 0.0,
                                                                        fYRotation => 0.0,
                                                                        fZRotation => 1.0);
      pxNewThrusterConfigurator.pxThrusterList := Navigation.Thrusters.pxCreate(tfThrusterEffects);

      tfThrusterEffects := Navigation.Thrusters.tfMake_Thruster_Effects(fXPosition => 0.0,
                                                                        fYPosition => -1.0,
                                                                        FZPosition => 0.0,
                                                                        fXRotation => 0.0,
                                                                        fYRotation => 0.0,
                                                                        fZRotation => 1.0);
      pxNewThrusterConfigurator.pxThrusterList.Add_Thruster_With_Effects(tfThrusterEffects);

      tfThrusterEffects := Navigation.Thrusters.tfMake_Thruster_Effects(fXPosition => Sin(Pi/3.0),
                                                                        fYPosition => Sin(Pi/6.0),
                                                                        FZPosition => 0.0,
                                                                        fXRotation => 0.0,
                                                                        fYRotation => 0.0,
                                                                        fZRotation => 1.0);
      pxNewThrusterConfigurator.pxThrusterList.Add_Thruster_With_Effects(tfThrusterEffects);

      tfThrusterEffects := Navigation.Thrusters.tfMake_Thruster_Effects(fXPosition => 0.0,
                                                                        fYPosition => 0.0,
                                                                        FZPosition => 1.0,
                                                                        fXRotation => Sin(Pi/3.0),
                                                                        fYRotation => -Sin(Pi/6.0),
                                                                        fZRotation => 0.0);
      pxNewThrusterConfigurator.pxThrusterList.Add_Thruster_With_Effects(tfThrusterEffects);

      tfThrusterEffects := Navigation.Thrusters.tfMake_Thruster_Effects(fXPosition => 0.0,
                                                                        fYPosition => 0.0,
                                                                        FZPosition => 1.0,
                                                                        fXRotation => 0.0,
                                                                        fYRotation => 1.0,
                                                                        fZRotation => 0.0);
      pxNewThrusterConfigurator.pxThrusterList.Add_Thruster_With_Effects(tfThrusterEffects);

      tfThrusterEffects := Navigation.Thrusters.tfMake_Thruster_Effects(fXPosition => 0.0,
                                                                        fYPosition => 0.0,
                                                                        FZPosition => 1.0,
                                                                        fXRotation => -Sin(Pi/3.0),
                                                                        fYRotation => -Sin(Pi/6.0),
                                                                        fZRotation => 0.0);
      pxNewThrusterConfigurator.pxThrusterList.Add_Thruster_With_Effects(tfThrusterEffects);

      pxNewThrusterConfigurator.Set_Inverse;

      return pxNewThrusterConfigurator;
   end pxCreate;

   procedure Set_Inverse(this : in out CThrusterConfigurator) is
      tfExtendedMatrix : TExtendedMatrix;
   begin
      tfExtendedMatrix := this.tfCreate_Extended_Matrix;

      Perform_Gauss_Jordan_Elimination_On(tfExtendedMatrix => tfExtendedMatrix);

      this.tfInverseMatrixForThrusterConfiguration := tfGet_Inverse_Part_Of(tfExtendedMatrix => tfExtendedMatrix);
   end Set_Inverse;


   function tfGet_Inverse_Part_Of(tfExtendedMatrix : in TExtendedMatrix) return TMatrix is
      tfMatrix : TMatrix;
   begin
      for iY in tfMatrix'Range(1) loop
         for iX in tfMatrix'Range(2) loop
            tfMatrix(iY, iX) := tfExtendedMatrix(iY, iX + 6);
         end loop;
      end loop;
      return tfMatrix;
   end tfGet_Inverse_Part_Of;




   function iGet_Number_Of_Thrusters (this : in CThrusterConfigurator) return integer is
   begin
      return this.pxThrusterList.iGet_Count;
   end iGet_Number_Of_Thrusters;

   function tfGet_Thruster_Effects_Matrix (this : in CThrusterConfigurator) return Navigation.Thrusters.TThrusterEffectsMatrix is
   begin
      return this.pxThrusterList.txGet_Thruster_Effects_Matrix;
   end tfGet_Thruster_Effects_Matrix;


   function tfGet_Thruster_Values(this : in CThrusterConfigurator; tfComponentValues : in Navigation.Thrusters.TThrusterEffects) return Navigation.Thrusters.TThrusterValuesArray is

   begin

      return this.tfMultiply_Values_With_Matrix(tfComponentValues);
   end tfGet_Thruster_Values;

   function tfMultiply_Values_With_Matrix(this : in CThrusterConfigurator; tfComponentValues : in Navigation.Thrusters.TThrusterEffects) return Navigation.Thrusters.TThrusterValuesArray is
      tfThrusterValues : Navigation.Thrusters.TThrusterValuesArray;
      fValue : float;
   begin
      for iThrusterIndex in tfThrusterValues'Range loop
         fValue := 0.0;
         for iColumn in tfComponentValues'Range loop
            fValue := fValue + (this.tfInverseMatrixForThrusterConfiguration(iThrusterIndex, Navigation.Thrusters.EThrusterEffectsComponents'Pos(iColumn)+1) * tfComponentValues(iColumn));
         end loop;
         tfThrusterValues(iThrusterIndex) := fValue;
      end loop;

      return tfThrusterValues;
   end tfMultiply_Values_With_Matrix;


   procedure Insert_Component_Values_In_Extended_Matrix(tfExtendedMatrix : in out TExtendedMatrix; tfComponentValues : in Navigation.Thrusters.TThrusterEffects) is
      iIterator : integer;

   begin
      iIterator := 1;

      for n in tfComponentValues'Range
      loop
         tfExtendedMatrix(iIterator, tfExtendedMatrix'Last(2)) := tfComponentValues(n);
         iIterator := iIterator + 1;
      end loop;

   end Insert_Component_Values_In_Extended_Matrix;


   procedure Swap_Values_In_Extended_Matrix(fValue1 : in out float; fValue2 : in out float) is
      fTemp : float;
   begin
      fTemp := fValue1;
      fValue1 := fValue2;
      fValue2 := fTemp;
   end Swap_Values_In_Extended_Matrix;

   procedure Swap_Rows_In_Extended_Matrix(tfExtendedMatrix : in out TExtendedMatrix; iRow1 : in integer; iRow2 : in integer) is
   begin
      for col in tfExtendedMatrix'Range(2)
      loop
         Swap_Values_In_Extended_Matrix(fValue1 => tfExtendedMatrix(iRow1,col),
                                        fValue2 => tfExtendedMatrix(iRow2,col));
      end loop;

   end Swap_Rows_In_Extended_Matrix;

   procedure Scale_Row_In_Extended_Matrix(tfExtendedMatrix : in out TExtendedMatrix; iStartingColumn : in integer) is
      iY : integer := iStartingColumn;

   begin
      for iX in reverse iStartingColumn .. tfExtendedMatrix'Last(2)
      loop
         tfExtendedMatrix(iY, iX) := tfExtendedMatrix(iY, iX) / tfExtendedMatrix(iY, iStartingColumn);
      end loop;

   end Scale_Row_In_Extended_Matrix;

   procedure Remove_Component_In_Following_Rows(tfExtendedMatrix : in out TExtendedMatrix; iRow : in integer) is
   begin
      for iY in iRow+1 .. tfExtendedMatrix'Last(1)
      loop
         for iX in reverse iRow .. tfExtendedMatrix'Last(2)
         loop
            tfExtendedMatrix(iY, iX) := tfExtendedMatrix(iY, iX) - (tfExtendedMatrix(iRow, iX) * tfExtendedMatrix(iY, iRow));
         end loop;

      end loop;

   end Remove_Component_In_Following_Rows;


   procedure Remove_Component_In_Leading_Rows(tfExtendedMatrix : in out TExtendedMatrix; iRow : in integer) is
   begin
      for iY in reverse tfExtendedMatrix'First(1) .. (iRow-1)
      loop
         for iX in reverse iRow .. tfExtendedMatrix'Last(2)
         loop
            tfExtendedMatrix(iY, iX) := tfExtendedMatrix(iY, iX) - (tfExtendedMatrix(iRow, iX) * tfExtendedMatrix(iY, iRow));
         end loop;

      end loop;

   end Remove_Component_In_Leading_Rows;

   function Find_Row_With_Highest_Component(tfExtendedMatrix : in TExtendedMatrix; iColumn : in integer) return integer is
      iMaxValueComponent : integer := iColumn;
   begin
      for iRow in iColumn+1 .. tfExtendedMatrix'Last(1)
      loop
         if abs(tfExtendedMatrix(iRow, iColumn)) > abs(tfExtendedMatrix(iMaxValueComponent, iColumn)) then
            iMaxValueComponent := iRow;
         end if;

      end loop;

      return iMaxValueComponent;
   end Find_Row_With_Highest_Component;

   function bMatrix_Has_No_Inverse(fValue : in float) return boolean is
   begin
      if abs(fValue) > 0.0 then
         return false;
      end if;
      return true;
   end bMatrix_Has_No_Inverse;

   procedure Perform_Gauss_Jordan_Elimination_On(tfExtendedMatrix : in out TExtendedMatrix) is
      iRowWithMaxComponent : integer;

   begin
      for iRowAndColumn in tfExtendedMatrix'Range(1)
      loop
         iRowWithMaxComponent := Find_Row_With_Highest_Component(tfExtendedMatrix => tfExtendedMatrix,
                                                                 iColumn          => iRowAndColumn);

         if bMatrix_Has_No_Inverse(tfExtendedMatrix(iRowWithMaxComponent, iRowAndColumn)) then
            raise Exception_Handling.SingularMatrix;
         end if;

         if iRowWithMaxComponent /= iRowAndColumn then
            Swap_Rows_In_Extended_Matrix(tfExtendedMatrix => tfExtendedMatrix,
                                         iRow1            => iRowAndColumn,
                                         iRow2            => iRowWithMaxComponent);
         end if;

         Scale_Row_In_Extended_Matrix(tfExtendedMatrix => tfExtendedMatrix,
                                      iStartingColumn  => iRowAndColumn);

         Remove_Component_In_Following_Rows(tfExtendedMatrix => tfExtendedMatrix,
                                            iRow             => iRowAndColumn);

         Remove_Component_In_Leading_Rows(tfExtendedMatrix => tfExtendedMatrix,
                                          iRow             => iRowAndColumn);
      end loop;

   end Perform_Gauss_Jordan_Elimination_On;

--     function tfGet_Results_Vector_From(tfExtendedMatrix : in TExtendedMatrix) return Navigation.Thrusters.TThrusterValuesArray is
--        tfResults : Navigation.Thrusters.TThrusterValuesArray(1 .. tfExtendedMatrix'Last(1));
--
--     begin
--        for iY in tfExtendedMatrix'Range(1)
--        loop
--              tfResults(iY) := tfExtendedMatrix(iY, tfExtendedMatrix'Last(2));
--        end loop;
--
--        return tfResults;
--     end tfGet_Results_Vector_From;

   function tfCreate_Extended_Matrix(this : in CThrusterConfigurator) return TExtendedMatrix is
      tfExtendedMatrix : TExtendedMatrix;
      tfThrusterMatrix : Navigation.Thrusters.TThrusterEffectsMatrix;
      --iIterator : integer;

   begin
      tfThrusterMatrix := this.tfGet_Thruster_Effects_Matrix;
      for iThrusterIndex in tfExtendedMatrix'Range(2)
      loop

         --iIterator := 1;
         if iThrusterIndex <= this.iGet_Number_Of_Thrusters then
            for iY in tfThrusterMatrix(iThrusterIndex)'Range
            loop
               tfExtendedMatrix(Navigation.Thrusters.EThrusterEffectsComponents'Pos(iY)+1, iThrusterIndex) := tfThrusterMatrix(iThrusterIndex)(iY);
               --iIterator := iIterator + 1;
            end loop;
         else
            for iY in tfExtendedMatrix'Range(1) loop
               tfExtendedMatrix(iY, iThrusterIndex) := 0.0;
            end loop;
            tfExtendedMatrix(iThrusterIndex - this.iGet_Number_Of_Thrusters, iThrusterIndex) := 1.0;
         end if;

      end loop;

      return tfExtendedMatrix;
   end tfCreate_Extended_Matrix;

   procedure Free(pxThrusterConfiguratorToDeallocate : in out pCThrusterConfigurator) is
      procedure Dealloc is new Ada.Unchecked_Deallocation(CThrusterConfigurator, pCThrusterConfigurator);

   begin
      Dealloc(pxThrusterConfiguratorToDeallocate);
   end Free;

   procedure Finalize(this : in out CThrusterConfigurator) is
      use Navigation.Thrusters;

   begin
      if this.pxThrusterList /= null then
         Free(this.pxThrusterList);
      end if;
   end Finalize;



end Navigation.Thruster_Configurator;
