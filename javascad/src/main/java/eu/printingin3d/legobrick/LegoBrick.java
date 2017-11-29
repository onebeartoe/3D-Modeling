package eu.printingin3d.legobrick;

import java.util.ArrayList;
import java.util.List;

import eu.printingin3d.javascad.coords.Coords3d;
import eu.printingin3d.javascad.coords.Dims3d;
import eu.printingin3d.javascad.enums.Side;
import eu.printingin3d.javascad.models.Abstract3dModel;
import eu.printingin3d.javascad.models.Cube;
import eu.printingin3d.javascad.models.Cylinder;
import eu.printingin3d.javascad.tranzitions.Difference;
import eu.printingin3d.javascad.tranzitions.Union;

public class LegoBrick extends Union {
	private static final double ONE_SEGMENT_WIDTH = 8.0;
	private static final double HEIGHT = 9.6;
	private static final double HORIZONTAL_GAP = 2*0.1;
	private static final double WALL_THICKNESS = 1.5;
	private static final double AXLE_INNER_DIAMETER = 4.75;
	private static final double AXLE_OUTER_DIAMETER = 6.51;
	private static final double AXLE_ONE_DIAMETER = 3.0;
	private static final double KNOB_DIAMETER = 4.85;
	private static final double KNOB_HEIGTH = 1.8;
	
	public LegoBrick(int xSize, int ySize) {
		super(getModels(xSize, ySize));
	}

	private static List<Abstract3dModel> getModels(int xSize, int ySize) {
		List<Abstract3dModel> models = new ArrayList<>();
		Difference base = new Difference(
						new Cube(new Dims3d(ONE_SEGMENT_WIDTH*xSize-HORIZONTAL_GAP, ONE_SEGMENT_WIDTH*ySize-HORIZONTAL_GAP, HEIGHT)),
						new Cube(new Dims3d(ONE_SEGMENT_WIDTH*xSize-HORIZONTAL_GAP-WALL_THICKNESS*2, ONE_SEGMENT_WIDTH*ySize-HORIZONTAL_GAP-WALL_THICKNESS*2, HEIGHT-WALL_THICKNESS)).move(Coords3d.zOnly(-WALL_THICKNESS))						
				);
		models.add(base);
		models.add(addAxles(xSize, ySize));
		models.add(getKnobs(base, xSize, ySize));
		return models;
	}

	private static Abstract3dModel getKnobs(Abstract3dModel base, int xSize, int ySize) {
		List<Coords3d> moves = new ArrayList<>();
		for (int x=0;x<xSize;x++) {
			for (int y=0;y<ySize;y++) {
				moves.add(new Coords3d((x-(xSize-1.0)/2.0)*ONE_SEGMENT_WIDTH, (y-(ySize-1.0)/2.0)*ONE_SEGMENT_WIDTH, 0.0));
			}
		}
		return getKnob(base).moves(moves);
	}
	
	private static Abstract3dModel addAxles(int xSize, int ySize) {
		List<Coords3d> moves = new ArrayList<>();
		if (xSize==1) {
			for (int y=0;y<ySize-1;y++) {
				moves.add(Coords3d.yOnly((y-(ySize-2.0)/2.0)*ONE_SEGMENT_WIDTH));
			}
			return getAxleOne().moves(moves);
		}
		else if (ySize==1) {
			for (int x=0;x<xSize-1;x++) {
				moves.add(Coords3d.xOnly((x-(xSize-2.0)/2.0)*ONE_SEGMENT_WIDTH));
			}
			return getAxleOne().moves(moves);
		}
		else {		
			for (int x=0;x<xSize-1;x++) {
				for (int y=0;y<ySize-1;y++) {
					moves.add(new Coords3d((x-(xSize-2.0)/2.0)*ONE_SEGMENT_WIDTH, (y-(ySize-2.0)/2.0)*ONE_SEGMENT_WIDTH, 0.0));
				}
			}
			return getAxle().moves(moves);
		}
	}
	
	private static Abstract3dModel getKnob(Abstract3dModel base) {
		return new Cylinder(KNOB_HEIGTH, KNOB_DIAMETER/2.0).align(Side.TOP, base, false);
	}
	
	private static Abstract3dModel getAxle() {
		return new Difference(
				new Cylinder(HEIGHT, AXLE_OUTER_DIAMETER/2.0),
				new Cylinder(HEIGHT, AXLE_INNER_DIAMETER/2.0).move(Coords3d.zOnly(-0.01))
		);
	}
	
	private static Abstract3dModel getAxleOne() {
		return new Cylinder(HEIGHT, AXLE_ONE_DIAMETER/2.0);
	}
}
