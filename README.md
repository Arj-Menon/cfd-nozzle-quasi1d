# Quasi-1D Compressible Nozzle Solver

An analytical baseline for measuring viscous shock displacement in a
converging-diverging nozzle.

## Purpose

CFD gives one shock location. This solver gives the other. The offset
between them — decomposed into displacement-thickness and separation
effects — is the object of study. The solver also produces a continuous
shock-location-vs-back-pressure curve, where the NASA NPARC reference
case publishes only three discrete operating points.

Geometry: NASA NPARC CDV nozzle, Ae/At = 1.5, cosine area law.

## Status

- L0 gas-dynamic primitives — verified against Anderson Appendix A
- L1 bisection root-finder and area-Mach inversion — verified
- L2 nozzle geometry and its closed-form inverse — verified
- L3 physics logic — in progress
- L4 driver, plots, back-pressure sweep — pending