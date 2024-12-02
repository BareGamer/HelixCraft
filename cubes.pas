unit cubes;
uses graph3d;

const
blocksize=4;
chunksize=16;
chunksize_minus_1=chunksize-1;
chunksize_square=chunksize*chunksize;
chunksize_cube=chunksize_square*chunksize;

type noise=array[0..chunksize_minus_1,0..chunksize_minus_1] of double;

type cube=class
  private
  neighbors:array[0..5] of smallint;
  //faces:array[0..5] of rectanglet;
  //model:cubet;
  x,y,z:double;
  id,&type:double;
  public
  constructor create(x,y,z:double;blockid{,blocktype}:smallint);
  begin
    self.x:=x;
    self.y:=y;
    self.z:=z;
    self.id:=blockid;
    //self.&type:=blocktype;
  end;
end;

type cube0=class(cube)
  private
  const &type:smallint=0;
  model:cubet;
end;

type cube1=class(cube)
  private
  const &type:smallint=1;
  faces:array[0..5] of rectanglet;
end;

var blocks:array of cubet:=new cubet[1];

type chunk=class
  constructor create(x,y,z:double{;n:noise=nil});
  begin  
  end;
  private
  x,y,z:double;
  cubes:array[0..chunksize_minus_1,0..chunksize_minus_1,0..chunksize_minus_1] of cube;
end;

function spawncube(x,y,z:double;id,&type:smallint):cubet;
begin
  if &type=0 then
  begin
    result:=graph3d.Cube(x,y,z,blocksize,graph3d.ImageMaterial('tex\'+id.ToString+'.jpg',1,1));
  end;
end;

function filledchunk0(x,y,z:double;bid,btype:smallint):chunk;
begin
   milliseconds;
  {$omp parallel for}
  var c:chunk:=new chunk(0,0,0);
  for var i:integer:=0 to chunksize_minus_1 do
  begin
    //var ib:integer=i*blocksize;
    for var j:integer :=0 to chunksize_minus_1 do
    begin
      //var jb:integer=j*blocksize;
      for var k:integer :=0 to chunksize_minus_1 do
      begin
    c.cubes[i][j][k]:=new cube0(i,j,k,bid);
    c.cubes[i][j][k].model:=blocks[bid].clone;
    c.cubes[i][j][k].model.x:=i*blocksize;
    c.cubes[i][j][k].model.y:=j*blocksize;
    c.cubes[i][j][k].model.z:=k*blocksize;
    c.cubes[i][j][k].x:=i*blocksize;
    c.cubes[i][j][k].y:=j*blocksize;
    c.cubes[i][j][k].z:=k*blocksize;
    end;
    end;
  end;
  writeln(milliseconds);
  result:=c;
end;

//function joincubes(c:chunk);
//begin  
//end;

begin
  blocks[0]:=spawncube(0,0,0,0,0);
  //filledchunk0(0,0,0,0,0);
  var a:=graph3d.Cube(0,0,0,4,imagematerial('tex/0.jpg',1,1));
end.