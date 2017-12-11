
// Module names are of the form poly_<inkscape-path-id>().  As a result,
// you can associate a polygon in this OpenSCAD program with the corresponding
// SVG element in the Inkscape document by looking for the XML element with
// the attribute id="inkscape-path-id".

// fudge value is used to ensure that subtracted solids are a tad taller
// in the z dimension than the polygon being subtracted from.  This helps
// keep the resulting .stl file manifold.


module doge(h=1)
{
	fudge = 0.1;

  scale([25.4/90, -25.4/90, 1]) union()
  {
    difference()
    {
       linear_extrude(height=h)
         polygon([[-223.879961,211.755625],[-219.343711,201.578125],[-218.419121,198.980430],[-217.758555,196.323438],[-217.452129,193.588164],[-217.589961,190.755625],[-218.232617,187.487363],[-219.262461,183.957656],[-222.134961,176.504375],[-225.509961,169.176719],[-228.689961,162.755625],[-234.946211,150.606250],[-241.074961,138.385625],[-243.882930,132.172422],[-246.408711,125.850000],[-248.568867,119.387891],[-250.279961,112.755625],[-251.985977,103.620430],[-253.366211,93.522188],[-254.371445,82.783164],[-254.952461,71.725625],[-255.060039,60.671836],[-254.644961,49.944063],[-253.658008,39.864570],[-252.049961,30.755625],[-249.903086,22.677031],[-247.857461,17.381875],[-245.530586,12.523594],[-242.539961,5.755625],[-235.439961,-15.244375],[-216.929961,-75.244375],[-213.699492,-82.260312],[-209.663711,-89.529375],[-205.003555,-96.363438],[-202.495879,-99.402305],[-199.899961,-102.074375],[-153.159961,-137.254375],[-151.280410,-139.976816],[-149.487930,-143.495781],[-146.246211,-151.988125],[-143.598867,-160.861094],[-141.709961,-168.244375],[-138.288867,-182.889375],[-134.463711,-200.924375],[-131.319180,-218.869375],[-130.341113,-226.720625],[-129.939961,-233.244375],[-129.810430,-239.899062],[-129.517559,-243.416836],[-128.911211,-246.859375],[-127.870332,-250.075039],[-126.273867,-252.912187],[-124.000762,-255.219180],[-120.929961,-256.844375],[-118.633711,-257.546094],[-116.404961,-257.755625],[-114.191211,-257.509531],[-111.939961,-256.844375],[-108.838711,-255.059375],[-106.029961,-252.914375],[-103.641150,-250.569497],[-101.187754,-247.730352],[-96.127930,-240.834688],[-90.931934,-232.758242],[-85.681211,-224.031875],[-75.341367,-206.752813],[-70.415137,-199.261836],[-65.759961,-193.244375],[-62.504854,-189.847385],[-59.026445,-186.766113],[-55.344482,-183.983230],[-51.478711,-181.481406],[-43.274727,-177.251621],[-34.572461,-173.938125],[-25.529883,-171.402285],[-16.304961,-169.505469],[-7.055664,-168.109043],[2.060039,-167.074375],[25.060039,-165.244375],[44.060039,-164.114375],[50.021289,-163.274375],[53.083945,-163.329687],[55.780039,-164.114375],[57.669258,-165.687031],[59.801289,-167.928125],[63.470039,-172.244375],[77.210039,-188.244375],[87.557852,-199.439375],[98.800039,-210.386875],[110.709727,-220.588125],[116.843984,-225.253047],[123.060039,-229.544375],[131.935977,-234.955312],[136.612422,-237.242539],[141.402539,-238.976875],[146.272344,-239.952773],[151.187852,-239.964687],[153.652124,-239.544917],[156.115078,-238.807070],[158.572466,-237.725454],[161.020039,-236.274375],[164.323750,-233.353730],[167.077852,-229.581719],[169.346797,-225.175723],[171.195039,-220.353125],[172.687031,-215.331309],[173.887227,-210.327656],[175.670039,-201.244375],[177.319414,-191.282500],[179.077539,-178.601875],[180.479414,-165.992500],[181.060039,-156.244375],[181.060039,-139.244375],[176.150039,-100.244375],[177.078516,-94.732852],[179.030977,-88.617812],[181.714219,-82.059805],[184.835039,-75.219375],[191.216602,-61.333438],[193.890937,-54.609023],[195.830039,-48.244375],[202.270039,3.755625],[203.723320,8.981094],[205.293789,12.724375],[206.959883,16.233281],[208.700039,20.755625],[212.630039,41.755625],[223.180039,67.755625],[231.490039,105.755625],[236.337539,120.593125],[239.379102,128.410312],[242.370039,134.755625],[245.470820,139.540781],[248.501289,143.276875],[251.256133,146.752344],[253.530039,150.755625],[254.553789,153.956875],[254.992539,157.158125],[255.060039,163.755625],[251.387637,161.925469],[247.638945,159.066875],[243.905488,155.437656],[240.278789,151.295625],[233.711758,142.504375],[228.670039,134.755625],[225.175039,128.905625],[223.593477,125.707813],[222.610039,122.755625],[222.368066,120.679023],[222.502383,118.887187],[223.481289,115.920625],[224.709570,113.381562],[225.350039,110.795625],[224.948477,108.707656],[223.930039,106.871875],[222.731602,104.977969],[221.790039,102.715625],[221.455352,100.238281],[221.632539,97.821875],[221.888477,95.362344],[221.790039,92.755625],[221.266562,90.573535],[220.433477,88.716406],[218.257539,85.716875],[216.100352,83.236719],[215.290703,82.028809],[214.800039,80.755625],[214.725410,79.315469],[215.101133,78.080625],[216.616289,75.975625],[218.170820,73.938125],[218.595762,72.787656],[218.590039,71.465625],[217.804570,69.650469],[216.341289,67.309375],[213.500039,62.755625],[212.393164,59.620469],[211.725039,56.439375],[210.974414,53.166406],[209.620039,49.755625],[201.740039,38.755625],[200.249258,34.762344],[199.578789,30.974375],[199.221445,27.327031],[198.670039,23.755625],[194.310039,13.755625],[193.476289,10.470000],[193.130039,7.300625],[193.060039,0.755625],[192.150039,-9.244375],[191.100664,-20.672969],[189.507539,-31.935625],[187.318164,-43.102656],[184.480039,-54.244375],[182.709727,-60.483125],[180.630039,-66.331875],[179.280234,-69.061953],[177.620352,-71.636875],[175.572812,-74.037422],[173.060039,-76.244375],[171.608164,-71.276875],[171.450039,-68.409375],[171.636914,-66.209375],[171.220039,-63.244375],[169.936602,-60.167187],[168.205039,-57.571875],[166.413477,-55.062812],[164.950039,-52.244375],[164.364355,-49.919707],[164.153320,-47.238906],[164.591289,-41.278125],[165.736133,-35.300469],[167.060039,-30.244375],[162.818789,-33.414062],[157.820039,-38.194375],[155.620195,-40.849258],[153.931289,-43.499687],[152.986758,-46.009961],[153.020039,-48.244375],[153.812559,-50.015684],[155.036445,-51.822969],[158.021289,-55.520625],[159.403730,-57.398574],[160.460508,-59.287656],[161.002363,-61.181660],[160.840039,-63.074375],[159.427539,-65.479375],[158.643477,-66.803750],[158.180039,-68.334375],[158.317656,-69.907949],[158.969727,-71.894844],[161.272539,-76.590625],[166.060039,-85.244375],[156.060039,-87.244375],[161.540039,-94.339375],[163.940664,-97.847500],[166.180039,-102.244375],[167.539199,-105.883047],[168.808945,-110.181250],[170.973789,-119.929375],[172.461758,-129.835000],[173.060039,-138.244375],[173.066289,-153.477500],[172.510039,-167.326875],[171.091289,-181.135000],[168.510039,-196.244375],[166.176445,-206.778750],[164.434551,-212.735469],[162.178789,-218.576875],[159.311309,-223.871719],[157.617595,-226.179414],[155.734258,-228.188750],[153.649065,-229.845820],[151.349785,-231.096719],[148.824187,-231.887539],[146.060039,-232.164375],[142.503223,-231.592012],[138.575508,-230.034219],[134.434746,-227.729941],[130.238789,-224.918125],[122.312695,-218.727656],[116.060039,-213.374375],[108.563203,-206.670645],[100.931602,-199.492656],[85.317539,-184.588125],[77.361797,-177.298691],[69.324727,-170.409219],[61.219687,-164.138262],[53.060039,-158.704375],[47.758789,-155.984375],[44.798320,-154.983437],[42.060039,-154.644375],[39.807227,-155.045000],[37.695039,-155.869375],[35.515352,-156.843750],[33.060039,-157.694375],[29.608008,-158.319063],[25.168789,-158.806875],[17.060039,-159.244375],[-24.939961,-159.244375],[-29.447461,-159.378125],[-31.695586,-159.760469],[-33.729961,-160.554375],[-36.008711,-162.404531],[-37.852461,-164.518125],[-40.187461,-166.487344],[-41.828633,-167.290371],[-43.939961,-167.904375],[-73.939961,-170.244375],[-71.232305,-171.073750],[-68.583711,-172.386875],[-67.506270,-173.285781],[-66.713242,-174.378750],[-66.294512,-175.690156],[-66.339961,-177.244375],[-77.259961,-194.244375],[-99.359961,-231.244375],[-102.135742,-235.484844],[-106.183711,-240.905625],[-108.436621,-243.427871],[-110.709805,-245.488281],[-112.904004,-246.834551],[-114.919961,-247.214375],[-116.093398,-246.936621],[-117.141211,-246.379844],[-118.874961,-244.648125],[-120.151211,-242.457031],[-120.999961,-240.244375],[-122.393711,-234.542656],[-123.232461,-228.800625],[-124.519961,-217.244375],[-126.590117,-202.568281],[-128.136211,-193.150625],[-130.374180,-183.779844],[-134.519961,-169.244375],[-135.647930,-165.579375],[-136.891211,-160.804375],[-137.401367,-156.149375],[-137.116387,-154.251250],[-136.329961,-152.844375],[-135.122441,-152.143066],[-133.326055,-151.756406],[-128.663711,-151.655625],[-119.939961,-152.244375],[-121.335527,-149.400020],[-123.596992,-146.640156],[-126.502754,-143.984590],[-129.831211,-141.453125],[-136.869805,-136.841719],[-142.939961,-132.964375],[-176.939961,-106.674375],[-183.758086,-102.427813],[-189.192461,-99.386875],[-191.697773,-97.640586],[-194.225586,-95.382187],[-196.898711,-92.340508],[-199.839961,-88.244375],[-203.201523,-82.410156],[-206.129961,-76.070625],[-211.129961,-63.244375],[-226.059961,-18.244375],[-228.699961,-4.244375],[-230.313613,0.849746],[-232.359805,5.646094],[-237.091211,14.744375],[-239.447129,19.245762],[-241.576992,23.848281],[-243.316152,28.651660],[-244.499961,33.755625],[-247.929961,65.755625],[-247.824746,70.157930],[-247.375117,75.179688],[-245.718711,86.255625],[-243.512930,97.331563],[-241.309961,106.755625],[-237.774258,119.794180],[-233.881836,131.800313],[-229.489727,142.980977],[-224.454961,153.543125],[-218.634570,163.693711],[-211.885586,173.639688],[-204.065039,183.588008],[-195.029961,193.745625],[-186.799961,202.320625],[-182.486211,206.413125],[-177.939961,210.235625],[-173.839023,213.022500],[-170.729961,214.515625],[-168.250898,215.461250],[-166.039961,216.605625],[-163.719336,218.760781],[-161.934961,221.359375],[-160.330586,224.113594],[-158.549961,226.735625],[-155.330430,229.979062],[-151.386211,232.890625],[-147.121367,235.367188],[-142.939961,237.305625],[-131.789648,241.213906],[-120.292461,244.159375],[-108.619023,246.360469],[-96.939961,248.035625],[-85.710117,249.491250],[-76.131211,250.425625],[-66.456680,250.550000],[-54.939961,249.575625],[-25.939961,241.905625],[-21.990117,240.842812],[-17.943711,240.033125],[-13.895430,239.872188],[-11.900176,240.158633],[-9.939961,240.755625],[-15.284434,244.031523],[-21.034492,247.149688],[-27.098848,250.024570],[-33.386211,252.570625],[-39.805293,254.702305],[-46.264805,256.334063],[-52.673457,257.380352],[-58.939961,257.755625],[-96.939961,255.925625],[-123.939961,254.295625],[-128.381914,253.272051],[-132.841211,251.842656],[-141.667461,248.029375],[-150.129961,243.381719],[-157.939961,238.425625],[-167.075742,231.985469],[-174.873711,225.424375],[-178.402559,221.849746],[-181.754805,217.946406],[-184.983066,213.614863],[-188.139961,208.755625],[-190.426836,205.065313],[-193.594961,200.593125],[-195.381758,198.527305],[-197.235586,196.822188],[-199.105352,195.663164],[-200.939961,195.235625],[-202.668105,195.584609],[-204.341992,196.535000],[-205.938301,197.941953],[-207.433711,199.660625],[-210.028555,203.453750],[-211.939961,206.755625],[-214.004805,210.756406],[-216.091211,215.526875],[-217.796992,220.411719],[-218.719961,224.755625],[-218.719961,233.755625],[-219.459492,235.694687],[-220.563711,237.545625],[-221.801055,239.501562],[-222.939961,241.755625],[-223.671309,243.999141],[-224.106992,246.115625],[-224.836211,249.868125],[-225.502168,251.454453],[-226.617305,252.814375],[-228.367832,253.923047],[-230.939961,254.755625],[-231.810469,249.451992],[-231.965898,243.995312],[-231.513359,238.451914],[-230.559961,232.888125],[-229.212813,227.370273],[-227.579023,221.964688],[-223.879961,211.755625]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[242.060039,150.755625],[243.060039,151.755625],[243.060039,150.755625],[242.060039,150.755625]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-206.939961,195.755625],[-205.939961,196.755625],[-205.939961,195.755625],[-206.939961,195.755625]]);
    }
    difference()
    {
       linear_extrude(height=h)
         polygon([[74.890039,-136.254375],[78.140039,-140.244375],[81.127480,-144.721094],[83.520195,-149.116250],[85.465020,-153.456094],[87.108789,-157.766875],[90.080508,-166.406250],[93.610039,-175.244375],[96.656504,-181.100352],[100.369883,-187.127187],[104.632402,-193.180742],[109.326289,-199.116875],[114.333770,-204.791445],[119.537070,-210.060312],[124.818418,-214.779336],[130.060039,-218.804375],[134.613789,-221.581719],[140.112539,-223.953125],[142.983086,-224.709746],[145.810039,-225.032656],[148.500117,-224.811113],[150.960039,-223.934375],[153.213477,-222.130625],[155.037539,-219.666875],[157.750039,-214.244375],[160.588008,-206.687344],[163.308789,-196.793125],[164.286270,-191.692324],[164.827695,-186.874531],[164.797480,-182.628848],[164.060039,-179.244375],[155.010039,-208.244375],[153.884102,-211.243906],[152.430039,-214.420625],[150.518477,-217.231719],[149.350703,-218.330527],[148.020039,-219.134375],[146.719355,-219.504453],[145.324570,-219.552500],[142.401289,-218.924375],[139.547383,-217.733750],[137.060039,-216.464375],[130.470820,-212.350156],[124.298789,-207.370625],[118.529883,-201.882969],[113.150039,-196.244375],[108.883320,-191.207812],[104.801289,-185.456875],[101.313633,-179.349688],[98.830039,-173.244375],[95.370039,-160.244375],[93.300977,-154.856562],[90.960039,-149.579375],[85.800039,-139.244375],[82.835039,-134.059375],[81.080664,-131.709687],[78.970039,-129.504375],[75.040039,-126.411875],[73.468789,-124.605000],[72.958789,-123.505156],[72.700039,-122.224375],[73.051309,-119.033379],[74.450820,-115.549531],[76.652129,-111.929043],[79.408789,-108.328125],[85.602383,-101.809844],[91.060039,-97.244375],[92.304141,-100.456328],[94.109102,-104.103750],[96.373906,-107.956484],[98.997539,-111.784375],[101.878984,-115.357266],[104.917227,-118.445000],[108.011250,-120.817422],[111.060039,-122.244375],[110.426055,-119.112129],[109.477539,-116.384531],[107.092539,-111.838125],[104.816289,-107.994844],[104.003711,-106.146152],[103.560039,-104.244375],[103.754570,-101.906641],[104.741289,-99.530000],[106.337383,-97.173047],[108.360039,-94.894375],[112.953789,-90.806250],[117.060039,-87.734375],[120.322539,-85.691875],[122.139414,-85.028750],[124.020039,-84.894375],[126.066445,-85.574531],[127.918789,-86.923125],[130.970039,-90.264375],[144.080039,-109.244375],[151.215039,-119.283125],[154.264102,-124.303906],[157.000039,-130.244375],[165.060039,-161.244375],[164.961133,-150.809531],[164.268789,-140.345625],[163.514629,-135.175723],[162.389570,-130.086094],[160.819434,-125.105918],[158.730039,-120.264375],[156.665820,-117.031719],[154.471289,-114.885625],[151.573633,-111.923906],[147.400039,-106.244375],[142.812539,-98.391875],[138.382539,-88.941875],[136.551211,-84.008047],[135.148789,-79.143125],[134.305117,-74.503203],[134.150039,-70.244375],[137.060039,-54.244375],[134.296504,-56.591523],[131.697383,-59.259062],[126.671289,-65.186875],[121.339570,-71.290937],[118.358418,-74.178789],[115.060039,-76.834375],[112.072695,-78.516250],[107.181289,-81.011875],[100.979258,-84.456250],[94.060039,-88.984375],[87.750352,-93.801250],[81.345039,-99.289375],[75.382227,-105.212500],[70.400039,-111.334375],[64.020039,-121.244375],[60.433008,-125.538750],[57.388789,-128.516875],[54.920195,-131.611250],[53.912012,-133.649687],[53.060039,-136.254375],[56.897031,-135.233496],[59.997852,-133.963594],[64.830039,-131.758125],[66.980937,-131.363262],[69.234727,-131.800781],[71.801172,-133.341035],[74.890039,-136.254375]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[57.060039,-131.244375],[58.060039,-130.244375],[58.060039,-131.244375],[57.060039,-131.244375]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[62.060039,-128.244375],[63.060039,-127.244375],[63.060039,-128.244375],[62.060039,-128.244375]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[153.060039,-120.244375],[154.060039,-119.244375],[154.060039,-120.244375],[153.060039,-120.244375]]);
    }
    difference()
    {
       linear_extrude(height=h)
         polygon([[117.020039,-154.244375],[116.795547,-155.411328],[116.210352,-156.471875],[114.577539,-158.436875],[113.839766,-159.422891],[113.360977,-160.465625],[113.296094,-161.605859],[113.800039,-162.884375],[115.128477,-164.246094],[117.130039,-165.610625],[121.060039,-167.774375],[126.311602,-170.315469],[131.745039,-172.458125],[137.335977,-174.126406],[143.060039,-175.244375],[142.163574,-172.981582],[140.907695,-170.908281],[139.350176,-169.020840],[137.548789,-167.315625],[133.445508,-164.437344],[129.060039,-162.244375],[129.060039,-160.244375],[145.060039,-155.244375],[136.800039,-147.154375],[135.640977,-144.852188],[135.042539,-142.634375],[134.350352,-140.199062],[132.910039,-137.244375],[130.278535,-133.472910],[127.489883,-130.512031],[124.519121,-128.314512],[121.341289,-126.833125],[117.931426,-126.020645],[114.264570,-125.829844],[110.315762,-126.213496],[106.060039,-127.124375],[101.466289,-128.433125],[97.060039,-130.244375],[105.326289,-132.120625],[109.672695,-133.578594],[113.030039,-135.234375],[114.398477,-136.265312],[115.622539,-137.579375],[116.295352,-139.118437],[116.010039,-140.824375],[115.127930,-141.869473],[113.775664,-142.663906],[110.180039,-143.720625],[106.261914,-144.434219],[103.060039,-145.244375],[106.665820,-146.623906],[111.296289,-148.660625],[113.479277,-149.889395],[115.298633,-151.239219],[116.547754,-152.695684],[117.020039,-154.244375]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[136.060039,-172.244375],[137.060039,-171.244375],[137.060039,-172.244375],[136.060039,-172.244375]]);
    }
    difference()
    {
       linear_extrude(height=h)
         polygon([[-163.379961,-40.244375],[-161.829492,-37.746250],[-159.646211,-35.401875],[-158.370293,-34.500625],[-156.999805,-33.893750],[-155.555957,-33.666562],[-154.059961,-33.904375],[-152.270430,-34.986250],[-151.511211,-36.544375],[-151.631367,-38.365000],[-152.479961,-40.234375],[-154.547930,-42.642344],[-157.001211,-44.685625],[-159.298867,-46.558281],[-160.899961,-48.454375],[-161.529160,-50.228379],[-161.549805,-51.983281],[-161.108965,-53.757168],[-160.353711,-55.588125],[-158.488242,-59.573594],[-157.672168,-61.804277],[-157.129961,-64.244375],[-156.801211,-68.339375],[-156.175117,-70.128125],[-154.649961,-71.594375],[-152.588025,-72.505972],[-150.369160,-72.921367],[-148.037532,-72.882720],[-145.637305,-72.432187],[-143.212644,-71.611929],[-140.807715,-70.464102],[-136.233711,-67.354375],[-132.268613,-63.440273],[-129.265742,-59.059062],[-128.235554,-56.798687],[-127.578418,-54.548008],[-127.338499,-52.349185],[-127.559961,-50.244375],[-128.315703,-47.774414],[-129.456523,-45.081562],[-132.524961,-39.384375],[-136.028398,-33.867188],[-139.229961,-29.244375],[-167.939961,7.755625],[-157.453711,8.117813],[-153.132148,8.722773],[-149.164961,9.745625],[-145.357148,11.287852],[-141.513711,13.450938],[-137.439648,16.336367],[-132.939961,20.045625],[-129.573867,23.076406],[-126.606211,26.411875],[-125.443184,28.251582],[-124.585430,30.236719],[-124.101504,32.390371],[-124.059961,34.735625],[-124.464961,36.930625],[-124.937461,37.927813],[-125.679961,38.765625],[-126.626348,39.231035],[-128.004805,39.543281],[-131.528711,39.819375],[-137.939961,39.755625],[-141.382461,39.669375],[-143.055898,39.377344],[-144.659961,38.735625],[-146.842930,37.074062],[-149.403711,34.870625],[-152.412617,32.944688],[-154.107090,32.341836],[-155.939961,32.115625],[-157.590017,32.282900],[-159.020098,32.768984],[-160.231946,33.533389],[-161.227305,34.535625],[-162.575527,37.091641],[-163.078711,40.113125],[-162.750801,43.276172],[-161.605742,46.256875],[-159.657480,48.731328],[-158.386506,49.677490],[-156.919961,50.375625],[-155.221582,50.683242],[-153.540430,50.468438],[-150.238711,48.980625],[-147.032617,46.930313],[-143.939961,45.335625],[-140.777617,44.856875],[-136.213711,44.700625],[-127.939961,44.755625],[-131.165879,48.994727],[-134.517305,52.712813],[-137.988496,56.034805],[-141.573711,59.085625],[-149.063242,64.873438],[-156.939961,71.075625],[-160.511211,74.505156],[-163.497461,77.406875],[-165.100508,78.508926],[-166.952461,79.297969],[-169.185039,79.713652],[-171.929961,79.695625],[-173.894941,79.345937],[-175.462305,78.686875],[-176.721934,77.763438],[-177.763711,76.620625],[-181.549961,70.755625],[-185.584492,65.861563],[-189.811211,61.153125],[-193.799805,56.245937],[-195.570332,53.597695],[-197.119961,50.755625],[-198.423867,47.179531],[-200.111211,43.124375],[-201.237246,41.591270],[-202.625430,40.747344],[-204.331191,40.862246],[-206.409961,42.205625],[-207.792754,43.676152],[-208.879180,45.307344],[-210.286211,48.929375],[-210.877617,52.827031],[-210.899961,56.755625],[-210.346445,61.111367],[-209.139961,65.614062],[-207.365352,70.140664],[-205.107461,74.568125],[-202.451133,78.773398],[-199.481211,82.633438],[-196.282539,86.025195],[-192.939961,88.825625],[-190.265449,90.525977],[-187.473867,91.806563],[-184.684395,92.561680],[-182.016211,92.685625],[-179.588496,92.072695],[-177.520430,90.617188],[-175.931191,88.213398],[-174.939961,84.755625],[-171.093945,84.907305],[-168.604961,85.335312],[-167.040352,86.044102],[-165.967461,87.038125],[-163.566211,89.899688],[-161.372539,91.776133],[-157.939961,93.955625],[-150.755898,97.374219],[-141.814961,100.866875],[-132.686523,103.941406],[-124.939961,106.105625],[-117.841641,107.509121],[-111.115273,108.339219],[-104.642500,108.711582],[-98.304961,108.741875],[-85.562148,108.238906],[-71.939961,107.755625],[-66.232773,107.353594],[-60.909961,106.841875],[-58.277266,106.800059],[-55.602148,107.037031],[-52.838438,107.654863],[-49.939961,108.755625],[-61.588867,113.045313],[-75.106211,117.220625],[-82.033809,118.994102],[-88.790430,120.413437],[-95.163379,121.370117],[-100.939961,121.755625],[-106.223965,121.491934],[-112.640117,120.688594],[-127.513711,118.019375],[-142.850430,114.860781],[-155.939961,112.325625],[-161.759961,111.225625],[-167.939961,110.755625],[-171.550742,110.655781],[-175.698711,110.781875],[-177.702559,111.101035],[-179.514805,111.682344],[-181.026816,112.594355],[-182.129961,113.905625],[-182.610078,115.324355],[-182.580898,116.821719],[-182.144375,118.354473],[-181.402461,119.879375],[-179.410273,122.732656],[-177.419961,125.035625],[-173.535742,129.037344],[-169.416211,132.786875],[-160.939961,140.035625],[-155.998711,144.433125],[-153.311055,145.958750],[-149.939961,146.685625],[-129.939961,144.835625],[-121.939961,144.835625],[-104.939961,143.715625],[-94.514961,142.840625],[-89.476836,143.119375],[-86.799570,143.726562],[-83.939961,144.755625],[-89.025820,146.565957],[-94.675586,147.999531],[-100.720039,149.112715],[-106.989961,149.961875],[-119.529336,151.093594],[-130.939961,151.845625],[-150.939961,153.755625],[-154.973457,153.632930],[-158.114805,153.154688],[-160.594043,152.301914],[-162.641211,151.055625],[-164.486348,149.396836],[-166.359492,147.306563],[-171.109961,141.755625],[-176.127617,136.264844],[-180.741211,130.964375],[-184.929180,125.309531],[-188.669961,118.755625],[-190.428711,114.268281],[-191.362461,110.561875],[-192.674961,106.452344],[-195.569961,100.755625],[-208.699961,82.755625],[-211.005352,78.697168],[-212.808711,74.612344],[-214.124570,70.486973],[-214.967461,66.306875],[-215.351914,62.057871],[-215.292461,57.725781],[-214.803633,53.296426],[-213.899961,48.755625],[-212.822163,44.954436],[-211.467422,41.282988],[-208.016523,34.304531],[-203.726094,27.770684],[-198.774961,21.631875],[-193.341953,15.838535],[-187.605898,10.341094],[-175.939961,0.035625],[-160.939961,-13.254375],[-158.218711,-15.953125],[-156.795742,-17.542031],[-155.939961,-18.824375],[-155.729277,-20.164434],[-156.101367,-21.536719],[-156.919941,-22.906895],[-158.048711,-24.240625],[-160.691680,-26.661406],[-162.939961,-28.524375],[-167.208711,-32.591875],[-169.123242,-34.813125],[-170.809961,-37.244375],[-172.431016,-40.688281],[-173.544648,-44.736875],[-174.050313,-49.077969],[-173.847461,-53.399375],[-172.835547,-57.388906],[-171.994771,-59.161660],[-170.914023,-60.734375],[-169.580737,-62.068027],[-167.982344,-63.123594],[-166.106274,-63.862051],[-163.939961,-64.244375],[-165.622930,-58.299219],[-166.055840,-55.252285],[-166.191211,-52.188125],[-166.010176,-49.130996],[-165.493867,-46.105156],[-164.623418,-43.134863],[-163.379961,-40.244375]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-158.939961,-27.244375],[-157.939961,-26.244375],[-157.939961,-27.244375],[-158.939961,-27.244375]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-178.939961,4.755625],[-177.939961,5.755625],[-177.939961,4.755625],[-178.939961,4.755625]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-201.939961,26.755625],[-200.939961,27.755625],[-200.939961,26.755625],[-201.939961,26.755625]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-164.939961,34.755625],[-163.939961,35.755625],[-163.939961,34.755625],[-164.939961,34.755625]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-149.939961,61.755625],[-148.939961,62.755625],[-148.939961,61.755625],[-149.939961,61.755625]]);
    }
    difference()
    {
       linear_extrude(height=h)
         polygon([[-40.939961,-10.004375],[-44.540742,-11.905312],[-48.176211,-14.209375],[-51.401055,-16.970937],[-52.720332,-18.540273],[-53.769961,-20.244375],[-54.557129,-22.378086],[-54.828555,-24.519062],[-54.655371,-26.644570],[-54.108711,-28.731875],[-52.179492,-32.700937],[-49.609961,-36.244375],[-46.680391,-39.501094],[-43.172148,-42.873125],[-39.209688,-46.202031],[-34.917461,-49.329375],[-30.419922,-52.096719],[-25.841523,-54.345625],[-21.306719,-55.917656],[-16.939961,-56.654375],[-13.714229,-56.650259],[-10.615352,-56.251602],[-7.633311,-55.497690],[-4.758086,-54.427812],[0.711992,-51.497305],[5.875039,-47.774375],[10.811211,-43.573320],[15.600664,-39.208438],[20.323555,-34.994023],[25.060039,-31.244375],[20.577539,-25.755625],[17.902227,-23.277969],[15.060039,-21.414375],[12.391211,-20.492305],[8.865039,-19.852188],[0.337539,-19.304375],[-8.328711,-19.544062],[-14.939961,-20.344375],[-17.101660,-20.614883],[-19.179805,-20.618438],[-22.923711,-20.421875],[-24.508613,-20.520352],[-25.848242,-20.949062],[-26.902168,-21.857305],[-27.629961,-23.394375],[-27.981855,-25.526973],[-27.910117,-27.862656],[-27.456113,-30.293262],[-26.661211,-32.710625],[-25.566777,-35.006582],[-24.214180,-37.072969],[-22.644785,-38.801621],[-20.899961,-40.084375],[-18.844648,-40.937500],[-16.562461,-41.719375],[-14.501523,-42.778750],[-13.694062,-43.521484],[-13.109961,-44.464375],[-12.862148,-46.369844],[-13.632461,-47.970625],[-15.104023,-49.100781],[-16.959961,-49.594375],[-19.191367,-49.259687],[-21.663711,-48.251875],[-25.939961,-45.634375],[-30.039961,-42.115625],[-33.839961,-38.244375],[-35.663867,-36.064531],[-37.361211,-33.608125],[-38.715430,-30.969844],[-39.509961,-28.244375],[-39.602930,-25.815293],[-39.121211,-23.607344],[-38.150117,-21.623223],[-36.774961,-19.865625],[-35.081055,-18.337246],[-33.153711,-17.040781],[-28.939961,-15.154375],[-24.289746,-14.060859],[-19.523867,-13.638125],[-14.739473,-13.672891],[-10.033711,-13.951875],[-1.246680,-14.389375],[2.640293,-14.121328],[6.060039,-13.244375],[0.117363,-10.314863],[-5.678242,-7.952656],[-11.390645,-6.234746],[-17.083711,-5.238125],[-22.821309,-5.039785],[-28.667305,-5.716719],[-34.685566,-7.345918],[-40.939961,-10.004375]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-33.939961,-44.244375],[-32.939961,-43.244375],[-32.939961,-44.244375],[-33.939961,-44.244375]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[-35.939961,-40.244375],[-34.939961,-39.244375],[-34.939961,-40.244375],[-35.939961,-40.244375]]);
       translate([0, 0, -fudge])
         linear_extrude(height=h+2*fudge)
           polygon([[19.060039,-33.244375],[20.060039,-32.244375],[20.060039,-33.244375],[19.060039,-33.244375]]);
    }
    linear_extrude(height=h)
      polygon([[132.830039,-18.794375],[134.365723,-17.447168],[135.388008,-15.709844],[135.919746,-13.742598],[135.983789,-11.705625],[135.602988,-9.759121],[134.800195,-8.063281],[133.598262,-6.778301],[132.020039,-6.064375],[130.012656,-6.074844],[128.545977,-6.931875],[127.466953,-8.388906],[126.622539,-10.199375],[125.025352,-13.894375],[123.966484,-15.285781],[122.530039,-16.044375],[120.992578,-16.010508],[118.943477,-15.488437],[113.975039,-13.606875],[108.954102,-11.654063],[106.839375,-11.042930],[105.210039,-10.884375],[104.044336,-11.225156],[103.103164,-11.962500],[102.474180,-13.006406],[102.245039,-14.266875],[102.503398,-15.653906],[103.336914,-17.077500],[104.833242,-18.447656],[107.080039,-19.674375],[112.540664,-20.213281],[120.307539,-20.400625],[127.898164,-20.004844],[130.851602,-19.515918],[132.830039,-18.794375]]);
    linear_extrude(height=h)
      polygon([[167.730039,28.755625],[167.942266,31.720352],[167.687852,34.814688],[167.047656,37.978867],[166.102539,41.153125],[163.620977,47.292812],[160.890039,52.755625],[139.400039,91.755625],[135.890039,101.755625],[132.532852,107.799531],[127.580039,115.119375],[122.252227,122.257344],[117.770039,127.755625],[114.609570,131.357500],[111.176289,134.843125],[107.362383,137.785000],[105.279004,138.918438],[103.060039,139.755625],[104.795605,135.826309],[106.695820,132.501094],[110.861289,126.914375],[115.298633,121.498281],[117.538691,118.386348],[119.750039,114.755625],[137.150039,76.755625],[153.980039,51.755625],[155.425977,49.034063],[156.810039,45.950625],[157.639102,42.769687],[157.691406,41.225273],[157.420039,39.755625],[155.854883,36.996250],[153.313789,34.135625],[148.060039,28.755625],[151.612539,28.049375],[153.415039,27.533594],[154.910039,26.825625],[156.128472,25.832126],[157.000469,24.698105],[157.558579,23.442649],[157.835352,22.084844],[157.675078,19.138535],[156.780039,16.011875],[155.410625,12.857559],[153.827227,9.828281],[151.060039,4.755625],[156.186133,9.536406],[161.296289,15.596875],[163.553301,18.888145],[165.455820,22.236719],[166.887012,25.555059],[167.730039,28.755625]]);
    linear_extrude(height=h)
      polygon([[-85.989961,35.815625],[-87.845605,34.283613],[-89.881367,33.009531],[-93.826211,30.916875],[-95.401777,29.939160],[-96.490430,28.901094],[-96.925410,27.723105],[-96.539961,26.325625],[-95.629648,25.481562],[-94.409961,25.250625],[-91.919961,25.765625],[-89.153867,27.112969],[-85.781211,29.209375],[-79.949961,33.425625],[-76.411914,36.956660],[-73.515586,41.221406],[-71.373945,45.997324],[-70.099961,51.061875],[-69.806602,56.192520],[-70.062959,58.713083],[-70.606836,61.166719],[-71.452354,63.525608],[-72.613633,65.761934],[-74.104795,67.847878],[-75.939961,69.755625],[-76.655215,65.809258],[-77.098242,61.614688],[-78.021211,52.808125],[-78.927949,48.359727],[-80.416055,43.990313],[-82.698926,39.781680],[-85.989961,35.815625]]);
    linear_extrude(height=h)
      polygon([[184.800039,178.755625],[181.907637,184.469063],[178.610820,190.244375],[174.868926,195.841563],[170.641289,201.020625],[165.887246,205.541562],[163.300115,207.480234],[160.566133,209.164375],[157.680217,210.563984],[154.637285,211.649062],[151.432253,212.389609],[148.060039,212.755625],[168.060039,186.755625],[165.060039,185.755625],[168.486602,181.949531],[172.155039,178.796875],[175.980977,175.623594],[179.880039,171.755625],[183.032695,167.690469],[184.978789,164.119375],[188.060039,155.755625],[189.117617,158.551055],[189.575664,161.455938],[189.524648,164.426914],[189.055039,167.420625],[187.221914,173.302813],[184.800039,178.755625]]);
  }
}

module dogeThumbnail()
{
	xyScale = 0.1720;
	scale([xyScale, xyScale, 1])
	doge();
}