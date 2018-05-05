
use <../../water-pump-filter.scad>

// outer diameter: 5/16" = 7.94mm
snorkelOuterRadius = 7.94 / 2.0;

waterPumpFilter(snorkel = true,
				snorkelOuterRadius = snorkelOuterRadius,
				xLength = 100);
