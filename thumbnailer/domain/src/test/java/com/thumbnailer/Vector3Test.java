package com.thumbnailer;

import com.thumbnailer.model.Vector3;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class Vector3Test {

    @Test
    public void testVectorOperations() {
        Vector3 a = new Vector3(1, 2, 3);
        Vector3 b = new Vector3(4, 5, 6);

        Vector3 sum = a.add(b);
        assertEquals(5.0, sum.x(), 1e-6);
        assertEquals(7.0, sum.y(), 1e-6);
        assertEquals(9.0, sum.z(), 1e-6);

        Vector3 diff = b.subtract(a);
        assertEquals(3.0, diff.x(), 1e-6);
        assertEquals(3.0, diff.y(), 1e-6);
        assertEquals(3.0, diff.z(), 1e-6);

        double dot = a.dot(b);
        assertEquals(4 + 10 + 18, dot, 1e-6);

        Vector3 cross = new Vector3(1, 0, 0).cross(new Vector3(0, 1, 0));
        assertEquals(0.0, cross.x(), 1e-6);
        assertEquals(0.0, cross.y(), 1e-6);
        assertEquals(1.0, cross.z(), 1e-6);

        Vector3 norm = new Vector3(0, 3, 4).normalize();
        assertEquals(0.0, norm.x(), 1e-6);
        assertEquals(0.6, norm.y(), 1e-6);
        assertEquals(0.8, norm.z(), 1e-6);
        assertEquals(1.0, norm.length(), 1e-6);
    }
}
