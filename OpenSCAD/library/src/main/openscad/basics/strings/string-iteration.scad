
font = "Bauhaus 93:style=Regular";
font = "Arial";

strings = [["ABC", "1234", "QRS1"], ["+-=", "foo", "bar"]];

oneString = strings[0][1];
echo(oneString);

endIndex = len(oneString) - 1;
for(i = [0 : endIndex])
{
    element = oneString;
    
    // print a single character
    ch = element[i];
    echo(ch);
    
    translate([i*6, 0, 0])
    linear_extrude(height=4)
    text(ch, font=font, size=6);
}
