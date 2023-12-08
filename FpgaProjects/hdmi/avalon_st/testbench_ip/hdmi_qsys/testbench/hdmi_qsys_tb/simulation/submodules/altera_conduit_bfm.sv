// (C) 2001-2018 Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License Subscription 
// Agreement, Intel FPGA IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Intel and sold by 
// Intel or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/main/ip/sopc/components/verification/altera_tristate_conduit_bfm/altera_tristate_conduit_bfm.sv.terp#7 $
// $Revision: #7 $
// $Date: 2010/08/05 $
// $Author: klong $
//-----------------------------------------------------------------------------
// =head1 NAME
// altera_conduit_bfm
// =head1 SYNOPSIS
// Bus Functional Model (BFM) for a Standard Conduit BFM
//-----------------------------------------------------------------------------
// =head1 DESCRIPTION
// This is a Bus Functional Model (BFM) for a Standard Conduit Master.
// This BFM sampled the input/bidirection port value or driving user's value to 
// output ports when user call the API.  
// This BFM's HDL is been generated through terp file in Qsys/SOPC Builder.
// Generation parameters:
// output_name:                                       altera_conduit_bfm
// role:width:direction:                              blue_n:1:input,blue_p:1:input,clk_pix_n:1:input,clk_pix_p:1:input,clk_st:1:input,green_n:1:input,green_p:1:input,horz:11:input,red_n:1:input,red_p:1:input,vert:11:input,x:11:input,y:11:input
// 1
//-----------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module altera_conduit_bfm
(
   clk,
   reset,
   reset_n,
   sig_blue_n,
   sig_blue_p,
   sig_clk_pix_n,
   sig_clk_pix_p,
   sig_clk_st,
   sig_green_n,
   sig_green_p,
   sig_horz,
   sig_red_n,
   sig_red_p,
   sig_vert,
   sig_x,
   sig_y
);

   //--------------------------------------------------------------------------
   // =head1 PINS 
   // =head2 User defined interface
   //--------------------------------------------------------------------------
   input clk;
   input reset;
   input reset_n;
   input sig_blue_n;
   input sig_blue_p;
   input sig_clk_pix_n;
   input sig_clk_pix_p;
   input sig_clk_st;
   input sig_green_n;
   input sig_green_p;
   input [10 : 0] sig_horz;
   input sig_red_n;
   input sig_red_p;
   input [10 : 0] sig_vert;
   input [10 : 0] sig_x;
   input [10 : 0] sig_y;

   // synthesis translate_off
   import verbosity_pkg::*;
   
   typedef logic ROLE_blue_n_t;
   typedef logic ROLE_blue_p_t;
   typedef logic ROLE_clk_pix_n_t;
   typedef logic ROLE_clk_pix_p_t;
   typedef logic ROLE_clk_st_t;
   typedef logic ROLE_green_n_t;
   typedef logic ROLE_green_p_t;
   typedef logic [10 : 0] ROLE_horz_t;
   typedef logic ROLE_red_n_t;
   typedef logic ROLE_red_p_t;
   typedef logic [10 : 0] ROLE_vert_t;
   typedef logic [10 : 0] ROLE_x_t;
   typedef logic [10 : 0] ROLE_y_t;

   logic [0 : 0] sig_blue_n_in;
   logic [0 : 0] sig_blue_n_local;
   logic [0 : 0] sig_blue_p_in;
   logic [0 : 0] sig_blue_p_local;
   logic [0 : 0] sig_clk_pix_n_in;
   logic [0 : 0] sig_clk_pix_n_local;
   logic [0 : 0] sig_clk_pix_p_in;
   logic [0 : 0] sig_clk_pix_p_local;
   logic [0 : 0] sig_clk_st_in;
   logic [0 : 0] sig_clk_st_local;
   logic [0 : 0] sig_green_n_in;
   logic [0 : 0] sig_green_n_local;
   logic [0 : 0] sig_green_p_in;
   logic [0 : 0] sig_green_p_local;
   logic [10 : 0] sig_horz_in;
   logic [10 : 0] sig_horz_local;
   logic [0 : 0] sig_red_n_in;
   logic [0 : 0] sig_red_n_local;
   logic [0 : 0] sig_red_p_in;
   logic [0 : 0] sig_red_p_local;
   logic [10 : 0] sig_vert_in;
   logic [10 : 0] sig_vert_local;
   logic [10 : 0] sig_x_in;
   logic [10 : 0] sig_x_local;
   logic [10 : 0] sig_y_in;
   logic [10 : 0] sig_y_local;

   //--------------------------------------------------------------------------
   // =head1 Public Methods API
   // =pod
   // This section describes the public methods in the application programming
   // interface (API). The application program interface provides methods for 
   // a testbench which instantiates, controls and queries state in this BFM 
   // component. Test programs must only use these public access methods and 
   // events to communicate with this BFM component. The API and module pins
   // are the only interfaces of this component that are guaranteed to be
   // stable. The API will be maintained for the life of the product. 
   // While we cannot prevent a test program from directly accessing internal
   // tasks, functions, or data private to the BFM, there is no guarantee that
   // these will be present in the future. In fact, it is best for the user
   // to assume that the underlying implementation of this component can 
   // and will change.
   // =cut
   //--------------------------------------------------------------------------
   
   event signal_reset_asserted;
   event signal_input_blue_n_change;
   event signal_input_blue_p_change;
   event signal_input_clk_pix_n_change;
   event signal_input_clk_pix_p_change;
   event signal_input_clk_st_change;
   event signal_input_green_n_change;
   event signal_input_green_p_change;
   event signal_input_horz_change;
   event signal_input_red_n_change;
   event signal_input_red_p_change;
   event signal_input_vert_change;
   event signal_input_x_change;
   event signal_input_y_change;
   
   function automatic string get_version();  // public
      // Return BFM version string. For example, version 9.1 sp1 is "9.1sp1" 
      string ret_version = "18.0";
      return ret_version;
   endfunction

   // -------------------------------------------------------
   // blue_n
   // -------------------------------------------------------
   function automatic ROLE_blue_n_t get_blue_n();
   
      // Gets the blue_n input value.
      $sformat(message, "%m: called get_blue_n");
      print(VERBOSITY_DEBUG, message);
      return sig_blue_n_in;
      
   endfunction

   // -------------------------------------------------------
   // blue_p
   // -------------------------------------------------------
   function automatic ROLE_blue_p_t get_blue_p();
   
      // Gets the blue_p input value.
      $sformat(message, "%m: called get_blue_p");
      print(VERBOSITY_DEBUG, message);
      return sig_blue_p_in;
      
   endfunction

   // -------------------------------------------------------
   // clk_pix_n
   // -------------------------------------------------------
   function automatic ROLE_clk_pix_n_t get_clk_pix_n();
   
      // Gets the clk_pix_n input value.
      $sformat(message, "%m: called get_clk_pix_n");
      print(VERBOSITY_DEBUG, message);
      return sig_clk_pix_n_in;
      
   endfunction

   // -------------------------------------------------------
   // clk_pix_p
   // -------------------------------------------------------
   function automatic ROLE_clk_pix_p_t get_clk_pix_p();
   
      // Gets the clk_pix_p input value.
      $sformat(message, "%m: called get_clk_pix_p");
      print(VERBOSITY_DEBUG, message);
      return sig_clk_pix_p_in;
      
   endfunction

   // -------------------------------------------------------
   // clk_st
   // -------------------------------------------------------
   function automatic ROLE_clk_st_t get_clk_st();
   
      // Gets the clk_st input value.
      $sformat(message, "%m: called get_clk_st");
      print(VERBOSITY_DEBUG, message);
      return sig_clk_st_in;
      
   endfunction

   // -------------------------------------------------------
   // green_n
   // -------------------------------------------------------
   function automatic ROLE_green_n_t get_green_n();
   
      // Gets the green_n input value.
      $sformat(message, "%m: called get_green_n");
      print(VERBOSITY_DEBUG, message);
      return sig_green_n_in;
      
   endfunction

   // -------------------------------------------------------
   // green_p
   // -------------------------------------------------------
   function automatic ROLE_green_p_t get_green_p();
   
      // Gets the green_p input value.
      $sformat(message, "%m: called get_green_p");
      print(VERBOSITY_DEBUG, message);
      return sig_green_p_in;
      
   endfunction

   // -------------------------------------------------------
   // horz
   // -------------------------------------------------------
   function automatic ROLE_horz_t get_horz();
   
      // Gets the horz input value.
      $sformat(message, "%m: called get_horz");
      print(VERBOSITY_DEBUG, message);
      return sig_horz_in;
      
   endfunction

   // -------------------------------------------------------
   // red_n
   // -------------------------------------------------------
   function automatic ROLE_red_n_t get_red_n();
   
      // Gets the red_n input value.
      $sformat(message, "%m: called get_red_n");
      print(VERBOSITY_DEBUG, message);
      return sig_red_n_in;
      
   endfunction

   // -------------------------------------------------------
   // red_p
   // -------------------------------------------------------
   function automatic ROLE_red_p_t get_red_p();
   
      // Gets the red_p input value.
      $sformat(message, "%m: called get_red_p");
      print(VERBOSITY_DEBUG, message);
      return sig_red_p_in;
      
   endfunction

   // -------------------------------------------------------
   // vert
   // -------------------------------------------------------
   function automatic ROLE_vert_t get_vert();
   
      // Gets the vert input value.
      $sformat(message, "%m: called get_vert");
      print(VERBOSITY_DEBUG, message);
      return sig_vert_in;
      
   endfunction

   // -------------------------------------------------------
   // x
   // -------------------------------------------------------
   function automatic ROLE_x_t get_x();
   
      // Gets the x input value.
      $sformat(message, "%m: called get_x");
      print(VERBOSITY_DEBUG, message);
      return sig_x_in;
      
   endfunction

   // -------------------------------------------------------
   // y
   // -------------------------------------------------------
   function automatic ROLE_y_t get_y();
   
      // Gets the y input value.
      $sformat(message, "%m: called get_y");
      print(VERBOSITY_DEBUG, message);
      return sig_y_in;
      
   endfunction

   always @(posedge clk) begin
      sig_blue_n_in <= sig_blue_n;
      sig_blue_p_in <= sig_blue_p;
      sig_clk_pix_n_in <= sig_clk_pix_n;
      sig_clk_pix_p_in <= sig_clk_pix_p;
      sig_clk_st_in <= sig_clk_st;
      sig_green_n_in <= sig_green_n;
      sig_green_p_in <= sig_green_p;
      sig_horz_in <= sig_horz;
      sig_red_n_in <= sig_red_n;
      sig_red_p_in <= sig_red_p;
      sig_vert_in <= sig_vert;
      sig_x_in <= sig_x;
      sig_y_in <= sig_y;
   end
   

   always @(posedge reset or negedge reset_n) begin
      -> signal_reset_asserted;
   end

   always @(sig_blue_n_in) begin
      if (sig_blue_n_local != sig_blue_n_in)
         -> signal_input_blue_n_change;
      sig_blue_n_local = sig_blue_n_in;
   end
   
   always @(sig_blue_p_in) begin
      if (sig_blue_p_local != sig_blue_p_in)
         -> signal_input_blue_p_change;
      sig_blue_p_local = sig_blue_p_in;
   end
   
   always @(sig_clk_pix_n_in) begin
      if (sig_clk_pix_n_local != sig_clk_pix_n_in)
         -> signal_input_clk_pix_n_change;
      sig_clk_pix_n_local = sig_clk_pix_n_in;
   end
   
   always @(sig_clk_pix_p_in) begin
      if (sig_clk_pix_p_local != sig_clk_pix_p_in)
         -> signal_input_clk_pix_p_change;
      sig_clk_pix_p_local = sig_clk_pix_p_in;
   end
   
   always @(sig_clk_st_in) begin
      if (sig_clk_st_local != sig_clk_st_in)
         -> signal_input_clk_st_change;
      sig_clk_st_local = sig_clk_st_in;
   end
   
   always @(sig_green_n_in) begin
      if (sig_green_n_local != sig_green_n_in)
         -> signal_input_green_n_change;
      sig_green_n_local = sig_green_n_in;
   end
   
   always @(sig_green_p_in) begin
      if (sig_green_p_local != sig_green_p_in)
         -> signal_input_green_p_change;
      sig_green_p_local = sig_green_p_in;
   end
   
   always @(sig_horz_in) begin
      if (sig_horz_local != sig_horz_in)
         -> signal_input_horz_change;
      sig_horz_local = sig_horz_in;
   end
   
   always @(sig_red_n_in) begin
      if (sig_red_n_local != sig_red_n_in)
         -> signal_input_red_n_change;
      sig_red_n_local = sig_red_n_in;
   end
   
   always @(sig_red_p_in) begin
      if (sig_red_p_local != sig_red_p_in)
         -> signal_input_red_p_change;
      sig_red_p_local = sig_red_p_in;
   end
   
   always @(sig_vert_in) begin
      if (sig_vert_local != sig_vert_in)
         -> signal_input_vert_change;
      sig_vert_local = sig_vert_in;
   end
   
   always @(sig_x_in) begin
      if (sig_x_local != sig_x_in)
         -> signal_input_x_change;
      sig_x_local = sig_x_in;
   end
   
   always @(sig_y_in) begin
      if (sig_y_local != sig_y_in)
         -> signal_input_y_change;
      sig_y_local = sig_y_in;
   end
   


// synthesis translate_on

endmodule

