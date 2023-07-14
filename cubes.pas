unit cubes;
uses graph3d;

const

blocksize=4;
chunksize=32;
chunksize_minus_1=chunksize-1;
chunksize_square=chunksize*chunksize;
chunksize_cube=chunksize_square*chunksize;

type cube=class
  private
  faces:array[0..5] of rectanglet;
  neighbors:array[0..5] of smallint;
  x,y,z:double;
  id,&type:double;
  public
  constructor create(x,y,z:double;blockid,blocktype:smallint);
  begin
    self.x:=x;
    self.y:=y;
    self.z:=z;
    self.id:=blockid;
    self.&type:=blocktype;
  end;
end;

begin
end.