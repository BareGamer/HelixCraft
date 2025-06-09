uses graph3d,graphwpfbase,chunks{cubes},meshing,timers,filehelpers;
uses System.text;

//TODO: see if g3d is smart enough to cache materials

//const 
//    chunksize=16;
//    chunksize_minus_1=chunksize-1;
//    chunksize_square=chunksize*chunksize;
//    chunksize_cube=chunksize_square*chunksize;

const wintitle:string='what';

var fps:integer;

procedure measurefps(dt:real);
begin
  //window.Title:='what '+dt+'ms'
  fps+=1;
end;

procedure everysecond();
begin
  if not wine then
  begin
    window.Caption:=fps+' fps';
  end else begin
    window.Caption:=fps+' fps [wine]';
  end;
  fps:=0;
end;

begin
//  ondrawframe:=measurefps;
//  var second:timer:=new timer(1000,everysecond);
//  second.Start;
  
  //graph3d.hvp.ShowFrameRate:=true;
  //graph3d.hvp.ShowTriangleCountInfo:=true;
  if not wine then
  begin
    graph3d.Window.title:=wintitle;
  end else begin
    graph3d.Window.title:=wintitle + ' [wine]';
  end;
  graph3d.View3D.BackgroundColor:=graph3d.Colors.AliceBlue;
//  var points:sequence of point3d;
//  points := Seq(new Point3D(0,0,0),new Point3D(10,0,0),new Point3D(5,10,0),new Point3D(0,0,0));
//  graph3d.Polygon3D(points,1,colors.Black);
//  graph3d.View3D.HideAll;
//  graph3d.View3D.ShowCameraInfo:=true;

//  graph3d.HideObjects;

//small chunk test
//  var height:integer=16{384};
//  milliseconds;
//  {$omp parallel for}
//  for var i:integer:=0 to 15 do
//  begin
//    for var j:integer:=0 to 15 do
//    begin
//      for var k:integer:=0 to height do
//      begin
//        new monotone_cube(i*blocksize, j*blocksize, k*blocksize, 0);
//      end;
//    end;
//  end;
//  //window.Caption:=millisecondsdelta.ToString;
//  writeln(millisecondsdelta);

//big chunk test
//  var cubes:array[0..chunksize-1,0..chunksize-1,0..316{chunksize-1}] of cube;
//  //var cubes:array[0..chunksize_cube_minus_1] of cube;
//  for var i:integer:=0 to 15 do
//  begin
//    for var j:integer:=0 to 15 do
//    begin
//      for var k:integer:=0 to 316 do
//      begin
//        cubes[i][j][k]:=new cube(i*blocksize,j*blocksize,k*blocksize,0);
//        //cubes[i+j*chunksize+k*chunksize_square]:=new cube(i*blocksize,j*blocksize,k*blocksize,0);
//        //graph3d.Cube(i*blocksize,j*blocksize,k*blocksize,1,imagematerial(matsfolder+'0.png',1,1));
//        //count+=1;
//        //window.Caption:=count +' done out of '+ (316*256)
//      end;
//    end;
//    for var l:integer:=0 to 316 do
//    begin
//      var temp:blocks;
//      for var m:integer:=0 to 15 do
//      begin
//        temp[m]:=cubes[i][m][l];
//        //temp[m]:=cubes[i+m*chunksize+l*chunksize_square];
//      end;
//      optimise(temp);
//      //cubet.Load('greedytest');
//    end;
//  end;
//  window.Caption:=millisecondsdelta.ToString;
//  writeln(millisecondsdelta);
//  graph3d.ShowObjects;
//  writeln(millisecondsdelta);

//test optimisation
  var cubes:blocks;
  for var i:integer:=0 to chunksize_minus_1 do
  begin
    cubes[i]:=new cube(0,i*blocksize,0,0);    
  end;
  
  optimise(cubes);

//graph3d.Cube(0,0,0,2);

//var cv3d:=helixtoolkit.Wpf.CubeVisual3D.Create();
//var obj:=objectwithmaterial3d.Create();
//var model:=new system.Windows.Media.Media3D.GeometryModel3D();

{TODO
var model:=new system.Windows.Media.Media3D.MeshGeometry3d();
writeln(model.TextureCoordinates.Count);
var test:=new system.windows.media.media3d.Point3DCollection;
}

//  var t:object3d{:=graph3d.cube(0,0,0,2)};
//  var t:=graph3d.DeserializeObject3D('serialization');
//  t.Serialize('serialization');
//  t.Save('cube_as_obj3d');
//  var a:=t.Clone;
//  randomize();
//  graph3d.HideObjects;

//  var b:meshing.blocks;
//  for var i:integer :=0 to chunksize_minus_1 do
//  begin
//    b[i]:=new cube(0,i*blocksize,0,0{random(4)});
//    write(b[i].id+' ');
//  end;
//  writeln('');
//  milliseconds;
//  optimise(b);
//  writeln(millisecondsdelta);
//  graph3d.ShowObjects;
//  var a:=cubet.Load('greedytest');

//  a:=a.MoveByX(2);
//  var c:=a.AnimRotate(0,0,1,720,60);
//  c.Begin;
  //new monotone_cube(0,0,0,3);
  //var t2:=cubet.Load('grass_block');
  //t2.model.SetCurrentValue
  //var anim:=t2.AnimRotateAtAbsolute(new Vector3D(0,0,1),360*9,new point3d(0,0,0),120);
  //anim.Begin;
  //var t2:=graph3d.Cube(0,0,0,1);
  //t2.Visible:=false;
  //t2.Save('invisible');
  ondrawframe:=measurefps;
  //graph3d.view3d.CameraMode:=cameramode.WalkAround;
  graph3d.View3D.ShowCameraInfo:=true;
  //var t2:=cubet.Load('invisible');
  //var paralelepiped:=graph3d.Box(0,0,0,1,2,3,imagematerial('tex/0.png',0.5,0.5));{graph3d.Segment3D(p3d(0,0,0),p3d(10,10,10),10,colors.Red);}{graph3d.Lego(0,0,0,2,3,1);}
  //paralelepiped.Save('paratest');
  //writeln(graph3d.View3D.CameraMode);
  //var a:=graph3d.Box(0,0,0,1,1,1);
  //new monotone_cube(0,0,0,2);
  //writeln(GraphWPFBase.Invoke&<boolean>(()->(nonmonotonecubes[0].model as Helixtoolkit.Wpf.MeshElement3D).Visible));
end.