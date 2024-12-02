unit meshing;
uses chunks,xamlparser,filehelpers,types;

type
blocks=array[0..chunksize_minus_1] of chunks.cube;
xmlpieces=array[0..11] of string;

var
  texasstr:array[0..3] of string;

procedure optimise(b:blocks);
begin
  var pieces:xmlpieces;
  //pieces[0]:='<CubeVisual3D Center="0,0,0" SideLength="2" xmlns="http://helix-toolkit.org/wpf" xmlns:av="http://schemas.microsoft.com/winfx/2006/xaml/presentation"><CubeVisual3D.Material><av:DiffuseMaterial><av:DiffuseMaterial.Brush><av:ImageBrush ImageSource="C:\PABCWork.NET\mine\HelixCraft/tex/test.png" Viewport="';
  //pieces[1]:='" TileMode="Tile" /></av:DiffuseMaterial.Brush></av:DiffuseMaterial></CubeVisual3D.Material><CubeVisual3D.Content><av:GeometryModel3D><av:GeometryModel3D.Geometry><av:MeshGeometry3D Positions="-1,-1,-1 -1,1,-1 -1,1,1 -1,-1,1 1,-1,1 1,1,1 1,1,-1 1,-1,-1 1,-1,-1 -1,-1,-1 -1,-1,1 1,-1,1 1,1,1 -1,1,1 -1,1,-1 1,1,-1 -1,1,1 1,1,1 1,-1,1 -1,-1,1 -1,-1,-1 1,-1,-1 1,1,-1 -1,1,-1" TextureCoordinates="0.5,0.5, 0,0.5 0,0 0.5,0 1,1 0,1 0,0 1,0 1,1 0,1 0,0 1,0 1,1 0,1 0,0 1,0 1,1 0,1 0,0 1,0 1,1 0,1 0,0 1,0" TriangleIndices="2 1 0 0 3 2 6 5 4 4 7 6 10 9 8 8 11 10 14 13 12 12 15 14 18 17 16 16 19 18 22 21 20 20 23 22" /></av:GeometryModel3D.Geometry><av:GeometryModel3D.Material><av:DiffuseMaterial><av:DiffuseMaterial.Brush><av:ImageBrush ImageSource="C:\PABCWork.NET\mine\HelixCraft/tex/test.png" Viewport="';
  //pieces[2]:='" TileMode="Tile" /></av:DiffuseMaterial.Brush></av:DiffuseMaterial></av:GeometryModel3D.Material><av:GeometryModel3D.BackMaterial><av:MaterialGroup><av:MaterialGroup.Children><av:DiffuseMaterial AmbientColor="#FFFFFFFF" Brush="#FFADD8E6" /><av:SpecularMaterial Brush="#FFFFFFFF" SpecularPower="100" /></av:MaterialGroup.Children></av:MaterialGroup></av:GeometryModel3D.BackMaterial></av:GeometryModel3D></CubeVisual3D.Content><CubeVisual3D.Transform><av:Transform3DGroup><av:Transform3DGroup.Children><av:MatrixTransform3D /><av:ScaleTransform3D /><av:TranslateTransform3D OffsetX="0" OffsetY="0" OffsetZ="0" /><av:MatrixTransform3D /></av:Transform3DGroup.Children></av:Transform3DGroup></CubeVisual3D.Transform></CubeVisual3D>';
  var run:integer:=0;
  var results:array[0..chunksize_minus_1] of integer;
  for var i:integer:=0 to chunksize_minus_1-1 do
  begin
    if b[i].id=-1 then
    begin
      results[i]:=-1;
      continue;
    end else
    begin
      results[i]:=run;
      if not(b[i].id=b[i+1].id) then
      begin
        run+=1;
      end;
    end;
  end;
  if run=results[chunksize_minus_1-1] then
  begin
    results[chunksize_minus_1]:=run;
  end else
  begin
    results[chunksize_minus_1]:=run+1;
  end;
  //writeln(results);
  var counter:integer:=0;
  //var length:integer:=1;
  var start,finish:integer;
  start:=0;
  finish:=0;
  run:=0;
  while counter < chunksize_minus_1 do
  begin
    if (results[counter]=results[counter+1]) and (not(counter=chunksize_minus_1-1)) then
    begin
      //length+=1;  length = finish - start + 1, length should be >= 1
      finish+=1;
    end else begin
      //if (results[counter]=results[counter+1]) and (counter=chunksize_minus_1-1) then 
      var inverse_length:real:=1/(finish-start+1){length};
      //can't divide p3d by int. maybe need to do without p3d, they're cringe var center:=(P3D(b[start].x,b[start].y,b[start].z)+P3D(b[finish].x,b[finish].y,b[finish].z))/2;
      //var centery:=(b[start].{mesh.Position.}Y+b[finish].{mesh.Position.}Y)/2;
      var centery:=(b[start].Y+b[finish].Y)/2;
      //writeln('Finish is ' + b[finish].y);
      //Height Length Width -> Z X Y
      var matandfolder:string:=matsfolder+b[start].id.ToString+'.png'+'" Viewport="0,0,'+inverse_length.ToString+','+inverse_length.ToString;
      pieces[0]:='<BoxVisual3D Center="'+b[start].{mesh.}X.ToString+','+centery.ToString+','+b[start].{mesh.}Z.ToString+'" Height="'+blocksize.ToString+'" Length="'+blocksize.ToString+'" Width="'+(finish-start+1).ToString+'" xmlns="http://helix-toolkit.org/wpf" xmlns:av="http://schemas.microsoft.com/winfx/2006/xaml/presentation"><BoxVisual3D.Material><av:DiffuseMaterial><av:DiffuseMaterial.Brush><av:ImageBrush ImageSource="'+matandfolder;
      //when we tile, we repeat the texture 1/factor(<1) times, which is 1. When we want to negate the tiling, we mulltiply 1 * factor
      pieces[1]:='" TileMode="Tile" /></av:DiffuseMaterial.Brush></av:DiffuseMaterial></BoxVisual3D.Material><BoxVisual3D.Content><av:GeometryModel3D><av:GeometryModel3D.Geometry><av:MeshGeometry3D Positions="';
      
      //fml
      var positions:array[0..7] of string;
      //var textures:array[0..23] of string;
      var textures:array[0..6] of string;
      
      //0,9,20
      positions[0]:=verttostr(new vert(b[start].{mesh.}X-blocksize/2,centery-(finish-start+1)*blocksize/2,b[start].{mesh.}Z-blocksize/2));
      //1,14,23
      positions[1]:=verttostr(new vert(b[start].{mesh.}X-blocksize/2,centery+(finish-start+1)*blocksize/2,b[start].{mesh.}Z-blocksize/2));
      //2,13,16
      positions[2]:=verttostr(new vert(b[start].{mesh.}X-blocksize/2,centery+(finish-start+1)*blocksize/2,b[start].{mesh.}Z+blocksize/2));
      //3,10,19
      positions[3]:=verttostr(new vert(b[start].{mesh.}X-blocksize/2,centery-(finish-start+1)*blocksize/2,b[start].{mesh.}Z+blocksize/2));
      //4,11,18
      positions[4]:=verttostr(new vert(b[start].{mesh.}X+blocksize/2,centery-(finish-start+1)*blocksize/2,b[start].{mesh.}Z+blocksize/2));
      //5,12,17
      positions[5]:=verttostr(new vert(b[start].{mesh.}X+blocksize/2,centery+(finish-start+1)*blocksize/2,b[start].{mesh.}Z+blocksize/2));
      //6,15,22
      positions[6]:=verttostr(new vert(b[start].{mesh.}X+blocksize/2,centery+(finish-start+1)*blocksize/2,b[start].{mesh.}Z-blocksize/2));
      //7,8,21
      positions[7]:=verttostr(new vert(b[start].{mesh.}X+blocksize/2,centery-(finish-start+1)*blocksize/2,b[start].{mesh.}Z-blocksize/2));
      
      //positions[8]:=verttostr(new vert(b[start].{mesh.}X+blocksize/2,centery-(finish-start+1)*blocksize/2,b[start].{mesh.}Z-blocksize/2));
      //positions[9]:=verttostr(new vert(b[start].{mesh.}X-blocksize/2,centery-(finish-start+1)*blocksize/2,b[start].{mesh.}Z-blocksize/2));
      //positions[10]:=verttostr(new vert(b[start].{mesh.}X-blocksize/2,centery-(finish-start+1)*blocksize/2,b[start].{mesh.}Z+blocksize/2));
      //positions[11]:=verttostr(new vert(b[start].{mesh.}X+blocksize/2,centery-(finish-start+1)*blocksize/2,b[start].{mesh.}Z+blocksize/2));
      
      //positions[12]:=verttostr(new vert(b[start].{mesh.}X+blocksize/2,centery+(finish-start+1)*blocksize/2,b[start].{mesh.}Z+blocksize/2));
      //positions[13]:=verttostr(new vert(b[start].{mesh.}X-blocksize/2,centery+(finish-start+1)*blocksize/2,b[start].{mesh.}Z+blocksize/2));
      //positions[14]:=verttostr(new vert(b[start].{mesh.}X-blocksize/2,centery+(finish-start+1)*blocksize/2,b[start].{mesh.}Z-blocksize/2));
      //positions[15]:=verttostr(new vert(b[start].{mesh.}X+blocksize/2,centery+(finish-start+1)*blocksize/2,b[start].{mesh.}Z-blocksize/2));
      
      //positions[16]:=verttostr(new vert(b[start].{mesh.}X-blocksize/2,centery+(finish-start+1)*blocksize/2,b[start].{mesh.}Z+blocksize/2));
      //positions[17]:=verttostr(new vert(b[start].{mesh.}X+blocksize/2,centery+(finish-start+1)*blocksize/2,b[start].{mesh.}Z+blocksize/2));
      //positions[18]:=verttostr(new vert(b[start].{mesh.}X+blocksize/2,centery-(finish-start+1)*blocksize/2,b[start].{mesh.}Z+blocksize/2));
      //positions[19]:=verttostr(new vert(b[start].{mesh.}X-blocksize/2,centery-(finish-start+1)*blocksize/2,b[start].{mesh.}Z+blocksize/2));
      
      //positions[20]:=verttostr(new vert(b[start].{mesh.}X-blocksize/2,centery-(finish-start+1)*blocksize/2,b[start].{mesh.}Z-blocksize/2));
      //positions[21]:=verttostr(new vert(b[start].{mesh.}X+blocksize/2,centery-(finish-start+1)*blocksize/2,b[start].{mesh.}Z-blocksize/2));
      //positions[22]:=verttostr(new vert(b[start].{mesh.}X+blocksize/2,centery+(finish-start+1)*blocksize/2,b[start].{mesh.}Z-blocksize/2));
      //positions[23]:=verttostr(new vert(b[start].{mesh.}X-blocksize/2,centery+(finish-start+1)*blocksize/2,b[start].{mesh.}Z-blocksize/2));
 
      //pieces[2]:=positions.JoinIntoString(' ')+' 0,0,0';
      pieces[2]:=positions[0]+' '+positions[1]+' '+positions[2]+' '+positions[3]+' '+positions[4]+' '+positions[5]+' '+positions[6]+' '+positions[7];
      pieces[2]:=pieces[2]+' '+positions[7]+' '+positions[0]+' '+positions[3]+' '+positions[4]+' '+positions[5]+' '+positions[2]+' '+positions[1]+' '+positions[6];
      pieces[2]:=pieces[2]+' '+positions[2]+' '+positions[5]+' '+positions[4]+' '+positions[3]+' '+positions[0]+' '+positions[7]+' '+positions[6]+' '+positions[1]+' '+'0,0,0';
      
      pieces[3]:='" TextureCoordinates="';
      
      //fml 2, but kinda not as bad, cuz x=z, so they are copy-paste-able 
      //inverse length is like 1, inverse squared should produce 1 iter 
      textures[0]:=textostr(new tex(1,inverse_length));
      textures[1]:=textostr(new tex(0,inverse_length));
      textures[2]:=textostr(new tex(inverse_length,inverse_length));
      textures[3]:=textostr(new tex(inverse_length,0));
      textures[4]:=textostr(new tex(inverse_length,1));
      //14 in total
      //6+2+2 texasstr

      pieces[4]:=textures[0]+' '+textures[1]+' '+texasstr[2]+' '+texasstr[3]+' '+texasstr[2]+' '+texasstr[3]+' '+textures[0]+' '+textures[1]+' ';
      pieces[4]:=pieces[4]+textures[2]+' '+textures[1]+' '+texasstr[2]+' '+textures[3]+' '+texasstr[2]+' '+textures[3]+' '+textures[2]+' '+textures[1]+' ';
      pieces[4]:=pieces[4]+texasstr[2]+' '+textures[3]+' '+textures[4]+' '+texasstr[1]+' '+textures[4]+' '+texasstr[1]+' '+texasstr[2]+' '+textures[3];
//      textures[0]:=textostr(new tex(1,inverse_length));
//      textures[1]:=textostr(new tex(0,inverse_length));
//      //textures[2]:=textostr(new tex(0,0));
//      textures[2]:=texasstr[2];
//      //textures[3]:=textostr(new tex(1,0));
//      textures[3]:=texasstr[3];
//      
//      //textures[4]:=textostr(new tex(0,0));
//      //textures[5]:=textostr(new tex(1,0));
//      textures[4]:=texasstr[2];
//      textures[5]:=texasstr[3];
//      textures[6]:=textostr(new tex(1,inverse_length));
//      textures[7]:=textostr(new tex(0,inverse_length));
//      
//      textures[8]:=textostr(new tex(inverse_length,inverse_length));
//      textures[9]:=textostr(new tex(0,inverse_length));
//      //textures[10]:=textostr(new tex(0,0));
//      textures[10]:=texasstr[2];
//      textures[11]:=textostr(new tex(inverse_length,0));
//      
//      //textures[12]:=textostr(new tex(0,0));
//      textures[12]:=texasstr[2];
//      textures[13]:=textostr(new tex(inverse_length,0));
//      textures[14]:=textostr(new tex(inverse_length,inverse_length));
//      textures[15]:=textostr(new tex(0,inverse_length));
//      
//      //textures[16]:=textostr(new tex(0,0));
//      textures[16]:=texasstr[2];
//      textures[17]:=textostr(new tex(inverse_length,0));
//      textures[18]:=textostr(new tex(inverse_length,1));
//      //textures[19]:=textostr(new tex(0,1));
//      textures[19]:=texasstr[1];
//      
//      textures[20]:=textostr(new tex(inverse_length,1));
//      //textures[21]:=textostr(new tex(0,1));
//      textures[21]:=texasstr[1];
//      //textures[22]:=textostr(new tex(0,0));
//      textures[22]:=texasstr[2];
//      textures[23]:=textostr(new tex(inverse_length,0));
//      
//      pieces[4]:=textures.JoinIntoString(' ');
      
      pieces[5]:='" TriangleIndices="2 1 0 0 3 2 6 5 4 4 7 6 10 9 8 8 11 10 14 13 12 12 15 14 18 17 16 16 19 18 22 21 20 20 23 22" /></av:GeometryModel3D.Geometry><av:GeometryModel3D.Material><av:DiffuseMaterial><av:DiffuseMaterial.Brush><av:ImageBrush ImageSource="';
      pieces[6]:=matandfolder;//matsfolder+b[start].id.ToString+'.png'+'" Viewport="0,0,'+inverse_length.ToString+','+inverse_length.ToString;
      pieces[7]:='" TileMode="Tile" /></av:DiffuseMaterial.Brush></av:DiffuseMaterial></av:GeometryModel3D.Material><av:GeometryModel3D.BackMaterial><av:MaterialGroup><av:MaterialGroup.Children><av:DiffuseMaterial AmbientColor="#FFFFFFFF" Brush="#FFADD8E6" /><av:SpecularMaterial Brush="#FFFFFFFF" SpecularPower="100" /></av:MaterialGroup.Children></av:MaterialGroup></av:GeometryModel3D.BackMaterial></av:GeometryModel3D></BoxVisual3D.Content><BoxVisual3D.Transform><av:Transform3DGroup><av:Transform3DGroup.Children><av:MatrixTransform3D /><av:ScaleTransform3D /><av:TranslateTransform3D OffsetX="0" OffsetY="0" OffsetZ="0" /><av:MatrixTransform3D /></av:Transform3DGroup.Children></av:Transform3DGroup></BoxVisual3D.Transform></BoxVisual3D>';
      xamlparser.savefile('greedytest',pieces.JoinIntoString(''));
      start:=counter+1;
      finish:=counter+1;
    end;
      //length:=1;
    counter+=1;
  end;
end;

begin
  texasstr[0]:=textostr(new types.tex(1,1));
  texasstr[1]:=textostr(new types.tex(0,1));
  texasstr[2]:=textostr(new types.tex(0,0));
  texasstr[3]:=textostr(new types.tex(1,0));
end.