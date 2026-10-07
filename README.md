# UART TX — RTL to GDSII

## Overview

This project implements a UART Transmitter in Verilog HDL and takes the design through a complete RTL-to-GDSII physical design flow using OpenLane and the Sky130 PDK.

The project demonstrates the complete digital VLSI design flow from RTL design and functional simulation to synthesis, floorplanning, placement, routing, Static Timing Analysis (STA), physical verification, and final GDSII generation.

## Project Features

- UART transmitter RTL design
- Verilog HDL implementation
- RTL functional simulation
- VCD waveform generation
- GTKWave waveform verification
- Logic synthesis
- Floorplanning
- IO placement
- Power planning
- Standard-cell placement
- Clock-tree related analysis where applicable
- Global and detailed routing
- Multi-corner Static Timing Analysis
- Power analysis
- DRC verification
- LVS verification
- Antenna checking
- Final GDSII generation
- LEF, SPICE and SDF generation

## Project Flow

```text
UART RTL
   |
   v
RTL Simulation
   |
   v
VCD Waveform
   |
   v
Synthesis
   |
   v
Floorplanning
   |
   v
IO Placement
   |
   v
Power Planning
   |
   v
Placement
   |
   v
Routing
   |
   v
Static Timing Analysis
   |
   v
DRC / LVS / Antenna Checks
   |
   v
GDSII
