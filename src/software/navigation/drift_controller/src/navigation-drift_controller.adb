package body Navigation.Drift_Controller is

   ----------
   -- Free --
   ----------

   procedure Free (pxDriftControllerToDeallocate : in out pCDriftController)
   is
      procedure Dealloc is new Ada.Unchecked_Deallocation(CDriftController, pCDriftController);
   begin
      Dealloc(pxDriftControllerToDeallocate);
   end Free;

   --------------
   -- pxCreate --
   --------------

   function pxCreate
     (pxCurrentAbsolutePosition : in Math.Vectors.pCVector;
      pxWantedAbsolutePosition : in Math.Vectors.pCVector;
      pxCurrentAbsoluteOrientation : in Math.Matrices.pCMatrix;
      pxCurrentAbsoluteOrientationInverse : in Math.Matrices.pCMatrix)
      return pCDriftController
   is
      pxDriftController : pCDriftController;
   begin

      pxDriftController := new CDriftController;

      pxDriftController.pxWantedAbsolutePosition := pxWantedAbsolutePosition;
      pxDriftController.pxCurrentAbsolutePosition := pxCurrentAbsolutePosition;
      pxDriftController.pxCurrentAbsoluteOrientation := pxCurrentAbsoluteOrientation;
      pxDriftController.pxLastAbsolutePosition := pxDriftController.pxCurrentAbsolutePosition.pxGet_Copy;
      pxDriftController.pxCurrentAbsoluteOrientationInverse := pxCurrentAbsoluteOrientationInverse;

      pxDriftController.pxXDriftMotionComponent := Navigation.Motion_Component.pxCreate(eAxisIndex    => Navigation.Motion_Component.DriftX,
                                                                                       xPIDScalings => Navigation.PID_Controller.TPIDComponentScalings'(0.0,0.0,0.0));

      pxDriftController.pxYDriftMotionComponent := Navigation.Motion_Component.pxCreate(eAxisIndex    => Navigation.Motion_Component.DriftY,
                                                                                       xPIDScalings => Navigation.PID_Controller.TPIDComponentScalings'(0.0,0.0,0.0));

      pxDriftController.pxZDriftMotionComponent := Navigation.Motion_Component.pxCreate(eAxisIndex    => Navigation.Motion_Component.DriftZ,
                                                                                       xPIDScalings => Navigation.PID_Controller.TPIDComponentScalings'(0.0,0.0,0.0));

      return pxDriftController;
   end pxCreate;

   ---------------------------------------------
   -- xGet_Positional_Thruster_Control_Values --
   ---------------------------------------------

   function xGet_Positional_Thruster_Control_Values
     (this : in out CDriftController;
      fDeltaTime : float)
      return Navigation.Thrusters.TThrusterEffects
   is
   begin
      return Navigation.Thrusters.TThrusterEffects'(Navigation.Thrusters.XPosition => this.pxXDriftMotionComponent.xGet_New_Component_Control_Value(fDeltaTime).fValue,
              Navigation.Thrusters.YPosition => this.pxYDriftMotionComponent.xGet_New_Component_Control_Value(fDeltatime).fValue,
              Navigation.Thrusters.ZPosition => this.pxZDriftMotionComponent.xGet_New_Component_Control_Value(fDeltaTime).fValue,
              others => 0.0);
   end xGet_Positional_Thruster_Control_Values;

   ---------------------------
   -- Update_Current_Errors --
   ---------------------------

   procedure Update_Current_Errors (this : in CDriftController) is
      use Math.Vectors;
      use Math.Matrices;

      xRelativeDriftVelocityVector : Math.Vectors.CVector;
      xAbsoluteDirectionVector : Math.Vectors.CVector;
      xAbsoluteVelocityVector : Math.Vectors.CVector;
      xAbsoluteDriftVelocityVector : Math.Vectors.CVector;
      fDriftComponent : float;
   begin
      xAbsoluteDirectionVector := Math.Vectors.CVector(this.pxWantedAbsolutePosition.all - this.pxCurrentAbsolutePosition.all);
      if abs(xAbsoluteDirectionVector.fLength_Squared) /= 0.0 then
         xAbsoluteDirectionVector := xAbsoluteDirectionVector.xGet_Normalized;
      end if;

      xAbsoluteVelocityVector := this.pxCurrentAbsolutePosition.all - this.pxLastAbsolutePosition.all;

      fDriftComponent := Math.Vectors.fDot_Product(xAbsoluteVelocityVector, xAbsoluteDirectionVector);

      xAbsoluteDriftVelocityVector := xAbsoluteVelocityVector - (xAbsoluteDirectionVector * fDriftComponent);
      xRelativeDriftVelocityVector := this.pxCurrentAbsoluteOrientationInverse.all * xAbsoluteDriftVelocityVector;

      this.pxXDriftMotionComponent.Update_Current_Error(xRelativeDriftVelocityVector.fGet_X);
      this.pxYDriftMotionComponent.Update_Current_Error(xRelativeDriftVelocityVector.fGet_Y);
      this.pxZDriftMotionComponent.Update_Current_Error(xRelativeDriftVelocityVector.fGet_Z);

      this.pxLastAbsolutePosition.Copy_From(xSourceVector => this.pxCurrentAbsolutePosition.all);

   end Update_Current_Errors;

   ------------------------------------
   -- Set_New_PID_Component_Scalings --
   ------------------------------------

   procedure Set_New_PID_Component_Scalings
     (this : in out CDriftController;
      eComponentToUpdate : Navigation.Motion_Component.EMotionComponent;
      xNewPIDScaling : Navigation.PID_Controller.TPIDComponentScalings)
   is
   begin
      case eComponentToUpdate is
         when Navigation.Motion_Component.DriftX =>
            this.pxXDriftMotionComponent.Set_New_PID_Component_Scalings(xNewPIDScaling);
         when Navigation.Motion_Component.DriftY =>
            this.pxYDriftMotionComponent.Set_New_PID_Component_Scalings(xNewPIDScaling);
         when Navigation.Motion_Component.DriftZ =>
            this.pxZDriftMotionComponent.Set_New_PID_Component_Scalings(xNewPIDScaling);
         when Navigation.Motion_Component.AllComponents =>
            this.pxXDriftMotionComponent.Set_New_PID_Component_Scalings(xNewPIDScaling);
            this.pxYDriftMotionComponent.Set_New_PID_Component_Scalings(xNewPIDScaling);
            this.pxZDriftMotionComponent.Set_New_PID_Component_Scalings(xNewPIDScaling);
         when others =>
            null;
      end case;

   end Set_New_PID_Component_Scalings;

   --------------
   -- Finalize --
   --------------

   procedure Finalize (this : in out CDriftController) is
      use Navigation.Motion_Component;
      use Math.Vectors;
   begin
      if this.pxXDriftMotionComponent /= null then
         Navigation.Motion_Component.Free(pxMotionComponentToDeallocate => this.pxXDriftMotionComponent);
      end if;
      if this.pxYDriftMotionComponent /= null then
         Navigation.Motion_Component.Free(pxMotionComponentToDeallocate => this.pxYDriftMotionComponent);
      end if;
      if this.pxZDriftMotionComponent /= null then
         Navigation.Motion_Component.Free(pxMotionComponentToDeallocate => this.pxZDriftMotionComponent);
      end if;
      if this.pxLastAbsolutePosition /= null then
         Math.Vectors.Free(pxVectorToDeallocate => this.pxLastAbsolutePosition);
      end if;

   end Finalize;

end Navigation.Drift_Controller;
