unit meshing;
uses graph3d,chunks,filehelpers,types,System.Runtime,System.Runtime.CompilerServices,system.Windows.Media.media3d;

type
blocks=array[0..chunksize_minus_1] of chunks.cube;
xmlpieces=array[0..11] of string;

procedure optimise(b:blocks);
begin
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
  
  var counter:integer:=0;
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
      var center:=(b[start].Y+b[finish].Y+1)/2;
      var startx:=b[start].X;
      var startz:=b[start].Z;
      var id:=b[start].id;
      Invoke(()->begin
      var geometry:system.windows.Media.media3d.geometrymodel3d:=new GeometryModel3D();
      var renderer:system.windows.Media.media3d.modelvisual3d:=new ModelVisual3D();
      var mesh:system.windows.Media.media3d.meshgeometry3d:=new MeshGeometry3D();
      
      var normals:system.windows.Media.media3d.vector3dcollection:=new Vector3DCollection();
      //-x
      normals.add(new Vector3D(-1,0,0));
      normals.add(new Vector3D(-1,0,0));
      normals.add(new Vector3D(-1,0,0));
      normals.add(new Vector3D(-1,0,0));
      normals.add(new Vector3D(-1,0,0));
      normals.add(new Vector3D(-1,0,0));
      //+x
      normals.add(new Vector3D(1,0,0));
      normals.add(new Vector3D(1,0,0));
      normals.add(new Vector3D(1,0,0));
      normals.add(new Vector3D(1,0,0));
      normals.add(new Vector3D(1,0,0));
      normals.add(new Vector3D(1,0,0));
      //-y
      normals.add(new Vector3D(0,-1,0));
      normals.add(new Vector3D(0,-1,0));
      normals.add(new Vector3D(0,-1,0));
      normals.add(new Vector3D(0,-1,0));
      normals.add(new Vector3D(0,-1,0));
      normals.add(new Vector3D(0,-1,0));
      //y
      normals.add(new Vector3D(0,1,0));
      normals.add(new Vector3D(0,1,0));
      normals.add(new Vector3D(0,1,0));
      normals.add(new Vector3D(0,1,0));
      normals.add(new Vector3D(0,1,0));
      normals.add(new Vector3D(0,1,0));
      //z
      normals.add(new Vector3D(0,0,1));
      normals.add(new Vector3D(0,0,1));
      normals.add(new Vector3D(0,0,1));
      normals.add(new Vector3D(0,0,1));
      normals.add(new Vector3D(0,0,1));
      normals.add(new Vector3D(0,0,1));
      //-z
      normals.add(new Vector3D(0,0,-1));
      normals.add(new Vector3D(0,0,-1));
      normals.add(new Vector3D(0,0,-1));
      normals.add(new Vector3D(0,0,-1));
      normals.add(new Vector3D(0,0,-1));
      normals.add(new Vector3D(0,0,-1));
      
      mesh.normals:=normals;
      
      //point3ds
      var vertexpositions:system.windows.Media.media3d.point3dcollection:=new Point3DCollection();
      var positions:array of system.Windows.Media.media3d.point3d:=new Point3D[25];
   
      var centery:=center;
      //0 1 2 3 4 5 6 7 7 0 3 4 5 2 1 6 2 5 4 3 0 7 6 1 (0,0,0)
   
      //0,9,20
      positions[0]:=new point3d(startx-blocksize/2,centery-(finish-start+1)*blocksize/2,startz-blocksize/2);
      //1,14,23
      positions[1]:=new point3d(startx-blocksize/2,centery+(finish-start+1)*blocksize/2,startz-blocksize/2);
      //2,13,16
      positions[2]:=new point3d(startx-blocksize/2,centery+(finish-start+1)*blocksize/2,startz+blocksize/2);
      //3,10,19
      positions[3]:=new point3d(startx-blocksize/2,centery-(finish-start+1)*blocksize/2,startz+blocksize/2);
      //4,11,18
      positions[4]:=new point3d(startx+blocksize/2,centery-(finish-start+1)*blocksize/2,startz+blocksize/2);
      //5,12,17
      positions[5]:=new point3d(startx+blocksize/2,centery+(finish-start+1)*blocksize/2,startz+blocksize/2);
      //6,15,22
      positions[6]:=new point3d(startx+blocksize/2,centery+(finish-start+1)*blocksize/2,startz-blocksize/2);
      //7,8,21
      positions[7]:=new point3d(startx+blocksize/2,centery-(finish-start+1)*blocksize/2,startz-blocksize/2);
      
      positions[8]:=positions[7];
      positions[9]:=positions[0];
      positions[10]:=positions[3];
      positions[11]:=positions[4];
      positions[12]:=positions[5];
      positions[13]:=positions[2];
      positions[14]:=positions[1];
      positions[15]:=positions[6];
      
      positions[16]:=positions[2];
      positions[17]:=positions[5];
      positions[18]:=positions[4];
      positions[19]:=positions[3];
      positions[20]:=positions[0];
      positions[21]:=positions[7];
      positions[22]:=positions[6];
      positions[23]:=positions[1];
      
      positions[24]:=new Point3D(0,0,0);
      
      for var i:integer:=0 to 5 do
      begin
        //i*4,i*4+1,i*4+2,i*4+3
        vertexpositions.add(positions[i*4]);
        vertexpositions.add(positions[i*4+1]);
        vertexpositions.add(positions[i*4+2]);
        vertexpositions.add(positions[i*4+3]);
      end;
      mesh.positions:=vertexpositions;
      
      //textures
      var texturepositions:system.windows.media.pointcollection:=new System.Windows.Media.PointCollection();
      var textures:array of system.windows.point:=new Point[24];
      var inverse_length:real:=1/(finish-start+1);
      
      //inverse length is 1 iter, a texture that's (0,0;inverse,inverse) should produce 1 iter 
      textures[0]:=(new system.windows.point(1,inverse_length));
      textures[1]:=(new system.windows.point(0,inverse_length));
      textures[2]:=(new system.windows.point(inverse_length,inverse_length));
      textures[3]:=(new system.windows.point(inverse_length,0));
      
      //0 1 2 3 2 3 0 1 2 1 2 3 2 3 2 1 2 3 4 1 4 1 2 3
      textures[4]:=textures[2]; 
      textures[5]:=textures[3];
      textures[6]:=textures[0];
      textures[7]:=textures[1];
      
      textures[8]:=textures[2]; 
      textures[9]:=textures[1];
      textures[10]:=textures[2];
      textures[11]:=textures[3];
      textures[12]:=textures[2]; 
      textures[13]:=textures[3];
      textures[14]:=textures[2];
      textures[15]:=textures[1];
      
      textures[16]:=textures[2]; 
      textures[17]:=textures[3];
      textures[18]:=textures[4];
      textures[19]:=textures[1];
      textures[20]:=textures[4]; 
      textures[21]:=textures[1];
      textures[22]:=textures[2];
      textures[23]:=textures[3];
      writeln(textures);
      
      for var i:integer:=0 to 5 do
      begin
        texturepositions.add(textures[i*4+2]);
        texturepositions.add(textures[i*4+1]);
        texturepositions.add(textures[i*4]);
        texturepositions.add(textures[i*4]);
        texturepositions.add(textures[i*4+3]);
        texturepositions.add(textures[i*4+2]);
      end;
      mesh.texturecoordinates:=texturepositions;
      
      //indices
      var triind:system.windows.Media.int32collection:=new System.Windows.Media.Int32Collection();
      
      //filling triangle indices
      for var i:integer:=0 to 5 do
      begin
        //i*4+2,i*4+1,i*4,i*4,i*4+3,i*4+2
        triind.add(i*4+2);
        triind.add(i*4+1);
        triind.add(i*4);
        triind.add(i*4);
        triind.add(i*4+3);
        triind.add(i*4+2);
      end;
      mesh.triangleindices:=triind;
      
      geometry.geometry:=mesh;
      
      var image:system.windows.Media.Imaging.BitmapImage:=new System.Windows.Media.Imaging.BitmapImage();
      image.BeginInit();
      image.UriSource:=new System.uri(matsfolder+'0.png',System.UriKind.RelativeOrAbsolute);
      image.EndInit();
      var imagebrush:System.Windows.Media.ImageBrush:=new System.Windows.Media.ImageBrush(image);
      imagebrush.TileMode:=System.Windows.Media.TileMode.Tile;
      imagebrush.Viewport:=new System.Windows.Rect(0,0,inverse_length,1);
      var material:system.windows.Media.media3d.diffusematerial:=new DiffuseMaterial(imagebrush);
      geometry.material:=material;
      
      renderer.content:=geometry;
      
      graph3d.hvp.Children.Add(renderer);
      
      start:=counter+1;
      finish:=counter+1;
      end);
    end;
    counter+=1;
  end;
end;

begin

end.