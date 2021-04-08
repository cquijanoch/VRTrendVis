# Comparing Scatterplot Variants for Temporal Trends Visualization in Immersive Virtual Environments

This repository contains supplemental material for a research paper **Comparing Scatterplot Variants for Temporal Trends Visualization in Immersive Virtual Environments** by [Carlos Quijano Ch.](mailto:cquijanochavez@gmail.com), [Luciana Nedel](mailto:nedel@inf.ufrgs.br) and [Carla M. D. S. Freitas](mailto:carla@inf.ufrgs.br). 

Please, check the presentation [video](https://youtu.be/1uY5zL9Bxck)

It contains including source code for software used in an experiment as well as experimental data and analysis scripts.

## Application Source Code

A desktop-only VR application for evaluating scatterplot variants in Virtual Reality.

1. Navigate to Application folder.

2. Ensure that Unity Version: 2018.3.10f1 and Steam VR: 1.3.10 are is installed (lastest version tested).

3. VR support should be enabled and run.

4. Data is saved in the folter "Experiments" in the deploy directory.

## Analysis Data

This folder contais the statistical scripts used to analyze results.

1. Navigate to Analysis folder.

2. Ensure that [R](https://www.r-project.org/) is installed.

3. In the R terminal, `> source(main.R)`, which will ingest CSVs files (tasks, tracking and forms), compute (bootstrap) CIs, and export plots.

4. All of the .png charts will appear in this directory.

## Additional:

This study is Motivated by [Robertson et al.](http://dx.doi.org/10.1109/TVCG.2008.125) and [Brehmer et al.](https://dx.doi.org/10.1109/TVCG.2019.2934397) studies.

We adapt CI calculation and functions from [A Comparative Evaluation of Animation and Small Multiples For Trend Visualization on Mobile Phones](https://github.com/microsoft/MobileTrendVis/tree/master/data_analysis).

