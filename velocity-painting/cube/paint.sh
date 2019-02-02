
# the gcode was configured to print at a spreed of 50mm/s
# but the application takes mm/min
# 50mm/s -> 3000 mm/min

# Tom's initial recomendation
# Target -> 50
# Low    -> 20 -> 1200mm/min
# High   -> 80 -> 4800mm/min

velPaint -spherical 1 1 \
			1 1 1 \
			3000  4800 1200 pattern-01.png cube.gcode >  painted-cube.gcode
