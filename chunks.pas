unit chunks;
uses graph3d;

const
blocksize=1;
chunksize=16;
chunksize_minus_1=chunksize-1;
chunksize_square=chunksize*chunksize;
chunksize_square_minus_1=chunksize_square-1;
chunksize_cube=chunksize_square*chunksize;
chunksize_cube_minus_1=chunksize_cube-1;

//type non_monotone_blocks=(grass,trunk);
//helixtoolkit.wpf.noise2d | mousegesturehandler

var mats:array[0..15] of System.Windows.Media.Media3D.Material;
var monotonecubes:array[0..15] of cubet;
var nonmonotonecubes:array[0..15] of object3d;

type cube=class
  public
  x,y,z:real;
  id:integer;
  constructor Create(x,y,z:real;id:integer);
  begin
    self.x:=x;
    self.y:=y;
    self.z:=z;
    self.id:=id;
  end;
end;

type monotone_cube=class(cube)
  public
  mesh:cubet;
  constructor Create(x,y,z,id:integer);
  begin
//    self.x:=x;
//    self.y:=y;
//    self.z:=z;
    self.id:=id;
    //mesh:=graph3d.cube(x,y,z,blocksize,mats[id]);
    //mesh:=graph3d.cube(x,y,z,blocksize,imagematerial('tex/'+id+'.png',1,1));
    mesh:=monotonecubes[id].Clone;
    mesh.Position:=new Point3D(x,y,z);
  end;
end;

type non_monotone_cube=class(cube)
  public 
  mesh:object3d;
  constructor Create(x,y,z,id:integer);
  begin
//    self.x:=x;
//    self.y:=y;
//    self.z:=z;
    self.id:=id;
    //mesh:=cubet.load(x,y,z,non_monotone_blocks.ord);
  end;
end;

//procedure Load(self:Objectwithmaterial3d;visible:boolean);override;
//begin
//  var obj:=object3d.Create(;
//  (obj.model as MeshElement3D).Visible := not(visible);
//end;

type chunk=class
  private 
  x,y,z:integer;
  elements:array[0..chunksize_minus_1,0..chunksize_minus_1,0..chunksize_minus_1] of cube;
  public
  constructor Create(x,y,z:integer);
  begin
    self.x:=x;
    self.y:=y;
    self.z:=z;
  end;
end;

begin
//  mats[0]:=imagematerial('tex/0.png',1,1);
//  mats[2]:=imagematerial('tex/2.png',1,1);
//  mats[3]:=imagematerial('tex/3.png',1,1);
  graph3d.HideObjects;
  for var i:integer:=0 to 2 do 
  begin
    monotonecubes[i]:=graph3d.cube(0,0,0,blocksize,imagematerial('tex/'+i+'.png',1,1));
    monotonecubes[i].Visible:=false;  
  end;
  //weirdly enough, object3d doesn't have the "visible" property, so we can't do the same optimisation
  //nonmonotonecubes[0]:=cubet.Load('grass_block');
  //nonmonotonecubes[0].hide(true);
//  writeln(Invoke(()->(nonmonotonecubes[0].model as MeshElement3D).Visible));
  //writeln((nonmonotonecubes[0].model as helixToolkit.Wpf.MeshElement3d).Visible);
  graph3d.ShowObjects;
end.