unit UMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, Inifiles, RXSpin, StdCtrls, Mask, ToolEdit, Buttons,
  Menus, JPEG, FileCtrl, Placemnt;

type
  TColorMode = (cmColor,cmMono,cmRAW);
  TFMain = class(TForm)
    Panel1: TPanel;
    SBInfo: TStatusBar;
    Image1: TImage;
    FEFiles: TFilenameEdit;
    SPCount: TRxSpinEdit;
    SBSettings: TSpeedButton;
    SpeedButton1: TSpeedButton;
    MainMenu1: TMainMenu;
    MIProgram: TMenuItem;
    MIClose: TMenuItem;
    MIOptions: TMenuItem;
    MIlowgain: TMenuItem;
    MImedgain: TMenuItem;
    MIhighgain: TMenuItem;
    N1: TMenuItem;
    MIColor: TMenuItem;
    MIMono: TMenuItem;
    SBRecord: TSpeedButton;
    FPMain: TFormPlacement;
    N2: TMenuItem;
    MItimestamp: TMenuItem;
    MIremark: TMenuItem;
    CBWB: TCheckBox;
    MIraw: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SBSettingsClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure MICloseClick(Sender: TObject);
    procedure MIlowgainClick(Sender: TObject);
    procedure MImedgainClick(Sender: TObject);
    procedure MIhighgainClick(Sender: TObject);
    procedure MIColorClick(Sender: TObject);
    procedure MIMonoClick(Sender: TObject);
    procedure FEFilesChange(Sender: TObject);
    procedure SBRecordClick(Sender: TObject);
    procedure MItimestampClick(Sender: TObject);
    procedure MIremarkClick(Sender: TObject);
    procedure MIrawClick(Sender: TObject);
  private
    { Private-Deklarationen }
    buffer: array[-1..640,-1..480] of byte;
    gain: byte;
    CMode: TColorMode;
    fileno: integer;
    filename, remark: string;
    FilesToCapture: Integer;
    function SetFrameName: String;
    procedure Capture;
  public
    { Public-Deklarationen }
    Bitmap: TBitmap;
    IniFile: TInifile;
    kr,kg,kb,dr,dg,db: single;
    procedure ProcessImage;
  end;

type
  TRGBValue = packed record
    Blue: Byte;
    Green: Byte;
    Red: Byte;
  end;
  TMonoValue = packed record
    Mono: Byte;
  end;

var
  FMain: TFMain;

implementation

uses USource, UHistogramm, UParams;

{$R *.DFM}

procedure TFMain.FormCreate(Sender: TObject);
begin
  Bitmap := TBitmap.Create;
  with Bitmap do
  begin
    PixelFormat := pf24Bit;
    Width := 640;
    Height := 480;
  end;
  Image1.Picture.bitmap.Pixelformat := pf24bit;
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0))+'RawCap.Ini');
  FEFiles.Text := IniFile.ReadString('Settings','Filename','C:\Cap.bmp');
  remark := IniFile.ReadString('Settings','Remark','');

  SPCount.Value := IniFile.ReadInteger('Settings','Bitmaps',20);
  cMode := cmColor;
  gain := 3;
  fileno := 0;
  FilesToCapture := 0;
  kr := 1.0; kg := 1.0; kb := 1.0; dr := 0.0; dg := 0.0; dg := 0.0;
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  with Inifile do
  begin
    WriteString('Settings','Filename',FEFiles.Text);
    WriteString('Settings','Remark',remark);
    WriteInteger('Settings','Bitmaps',SPCount.AsInteger);
    Free;
  end;
  Bitmap.Free;
end;

procedure minswap(var x1,x2:word);
var t: word;
begin
  if x1 < x2 then exit;
  t := x1; x1 := x2; x2 := t;
end;

function median(x1,x2,x3,x4:word):word;
var a1,a2,a3,a4:word;
begin
{
  a1 := x1;
  a2 := x2;
  a3 := x3;
  a4 := x4;
  minswap(a1,a2);
  minswap(a1,a3);
  minswap(a1,a4);
  minswap(a2,a3);
  minswap(a2,a4);
  minswap(a3,a4);
  result := (a2+a3) div 2;
}
  result := (x1+x2+x3+x4) div 4;
end;

procedure TFMain.ProcessImage;
var x,y,dimx,dimy,ty: integer;
    Pixel: ^TRGBValue;
    c,c1,r,g,b,rmin,gmin,umin,bmin,rmax,gmax,umax,bmax: integer;
begin
  c := 0; c1 := 0;
  dimx := Bitmap.Width;
  dimy := Bitmap.Height;
  for x := 0 to 255 do
  begin
    FHisto.rhist[x] := 0;
    FHisto.ghist[x] := 0;
    FHisto.uhist[x] := 0;
    FHisto.bhist[x] := 0;
  end;
  if CBWB.CHecked then
  begin
    rmin := 255; gmin := 255; umin := 255; bmin := 255;
    rmax :=   0; gmax :=   0; umax :=   0; bmax :=   0;
  end
  else
  begin
    rmin :=   0; gmin :=   0; umin :=   0; bmin :=   0;
    rmax := 255; gmax := 255; umax := 255; bmax := 255;
  end;
  for y := 0 to dimy-1 do
  begin
    Pixel := Bitmap.Scanline[y];
    for x := 0 to dimx-1 do
    begin
      c := round((Pixel.Red+Pixel.Green+Pixel.Blue) / gain);
      if c>255 then c:=255;
      if (x mod 2=1) and (y mod 2=0) then
      begin
        if c<rmin then rmin := c;
        if c>rmax then rmax := c;
      end;
      if (x mod 2=0) and (y mod 2=0) then
      begin
        if c<gmin then gmin := c;
        if c>gmax then gmax := c;
      end;
      if (x mod 2=1) and (y mod 2=1) then
      begin
        if c<umin then umin := c;
        if c>umax then umax := c;
      end;
      if (x mod 2=0) and (y mod 2=1) then
      begin
        if c<bmin then bmin := c;
        if c>bmax then bmax := c;
      end;
      buffer[x,y] := c;
      Inc(Pixel);
    end;
  end;
  for y := 0 to dimy-1 do
  begin
    for x := 0 to dimx-1 do
    begin
      if (x mod 2=1) and (y mod 2=0) then begin c := rmin; c1 := rmax; end;
      if (x mod 2=0) and (y mod 2=0) then begin c := gmin; c1 := gmax; end;
      if (x mod 2=1) and (y mod 2=1) then begin c := umin; c1 := umax; end;
      if (x mod 2=0) and (y mod 2=1) then begin c := gmin; c1 := bmax; end;
      buffer[x,y] := Round(255*(buffer[x,y] - c)/(c1-c));
    end;
  end;
  if cMode= cmColor then
  for y := 0 to dimy-1 do
  begin
    Pixel := Image1.Picture.Bitmap.Scanline[y];
    for x := 0 to dimx-1 do
    begin
      r := 0; g := 0; b := 0;
      if (x mod 2=1) and (y mod 2=0) then // Red
      begin
        r :=   buffer[x  ,y  ];
        g := median( buffer[x-1,y  ],
               buffer[x+1,y  ],
               buffer[x  ,y-1],
               buffer[x  ,y+1]);
        b := median( buffer[x-1,y-1],
               buffer[x+1,y-1],
               buffer[x-1,y+1],
               buffer[x+1,y+1]);
      end;
      if (x mod 2=0) and (y mod 2=0) then // Green1
      begin
        b := ( buffer[x  ,y-1]+
               buffer[x  ,y+1]) div 2;
        g :=   buffer[x  ,y  ];
        r := ( buffer[x-1,y  ]+
               buffer[x+1,y  ]) div 2;
      end;
      if (x mod 2=1) and (y mod 2=1) then // Green2
      begin
        b := ( buffer[x-1,y  ]+
               buffer[x+1,y  ]) div 2;
        g :=   buffer[x  ,y  ];
        r := ( buffer[x  ,y-1]+
               buffer[x  ,y+1]) div 2;
      end;
      if (x mod 2=0) and (y mod 2=1) then // Blue
      begin
        r := median( buffer[x-1,y-1],
               buffer[x+1,y-1],
               buffer[x-1,y+1],
               buffer[x+1,y+1]);
        g := median( buffer[x-1,y  ],
               buffer[x+1,y  ],
               buffer[x  ,y-1],
               buffer[x  ,y+1]);
        b :=   buffer[x  ,y  ];
      end;
      r := Round(r*kr + dr);
      g := Round(g*kg + dg);
      b := Round(b*kb + db);
      inc(FHisto.rhist[r]); // Red
      inc(FHisto.ghist[g]); // green
      inc(FHisto.bhist[b]); // blue
      Pixel.Red :=   r;
      Pixel.Green := g;
      Pixel.Blue :=  b;
      Inc(Pixel);
    end; // x y
  end; // for y ...
  if cMode= cmMono then
  for y := 0 to dimy-1 do
  begin
    Pixel := Image1.Picture.Bitmap.Scanline[y];
    for x := 0 to dimx-1 do
    begin
      c := 0;
      c := median(buffer[x,y],buffer[x+1,y],buffer[x,y+1],buffer[x+1,y+1]);
      {if (x mod 2=1) and (y mod 2=0) then // Red
        c := ((buffer[x+1,y]+buffer[x,y+1])div 2+buffer[x,y]+buffer[x+1,y+1]) div 3;
      if (x mod 2=0) and (y mod 2=0) then // Green1
        c := ((buffer[x,y]+buffer[x+1,y+1])div 2+buffer[x+1,y]+buffer[x,y+1]) div 3;
      if (x mod 2=1) and (y mod 2=1) then // Green2
        c := ((buffer[x,y]+buffer[x+1,y+1])div 2+buffer[x+1,y]+buffer[x,y+1]) div 3;
      if (x mod 2=0) and (y mod 2=1) then // Blue
        c := ((buffer[x+1,y]+buffer[x,y+1])div 2+buffer[x,y]+buffer[x+1,y+1]) div 3; }
      inc(FHisto.rhist[c]); // Red
      inc(FHisto.ghist[c]); // green
      inc(FHisto.bhist[c]); // blue
      Pixel.Red := c;
      Pixel.Green := c;
      Pixel.Blue := c;
      Inc(Pixel);
    end; // x y
  end; // for y ...
  if cMode= cmRAW then
  for y := 0 to dimy-1 do
  begin
    Pixel := Image1.Picture.Bitmap.Scanline[y];
    for x := 0 to dimx-1 do
    begin
      c := 0;
      c := buffer[x,y];
      inc(FHisto.rhist[c]); // Red
      inc(FHisto.ghist[c]); // green
      inc(FHisto.bhist[c]); // blue
      Pixel.Red := c;
      Pixel.Green := c;
      Pixel.Blue := c;
      Inc(Pixel);
    end; // x y
  end; // for y ...

  {for y := 0 to dimy-1 do
  begin
    Pixel := Image1.Picture.Bitmap.Scanline[y];
    for x := 0 to dimx-1 do
    begin
      c := Pixel.Green;
      buffer[x,y] := c;
      Inc(Pixel);
    end;
  end; }
  {if cMode = cmMono then
  for y := 0 to dimy-1 do
  begin
    Pixel := Image1.Picture.Bitmap.Scanline[y];
    for x := 0 to dimx-1 do
    begin
      c := Round((4*1.1-1)*buffer[x,y]-(buffer[x-1,y]+buffer[x+1,y]+buffer[x,y-1]+buffer[x,y+1]))div 4;
      if c<0 then c:=0;
      if c>255 then c:= 255;
      Pixel.Red := c;
      Pixel.Green := c;
      Pixel.Blue := c;
      Inc(Pixel);
    end;
  end;  }
  if MItimestamp.CHecked then
  begin
    ty := Image1.Picture.Bitmap.Canvas.TextHeight('Weingrill');
    Image1.Picture.Bitmap.Canvas.TextOut(0,dimy-ty,FormatDatetime('yyyy/mm/dd hh:nn:ss.zzz',Now)+' '+remark);
  end;
  Image1.Refresh;
  FHisto.Refresh;
  if (FilesToCapture>0) then
  begin
    Capture;
    Dec(FilesToCapture);
    if FilesToCapture=0 then
    begin
      SBRecord.Enabled := True;
      MessageBeep(MB_ICONASTERISK);
    end;
  end;
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  FSource.Show;
  FHisto.Show;
  FParams.Show;
end;

procedure TFMain.SBSettingsClick(Sender: TObject);
begin
  if FSource.VideoCap1.HasDlgSource then
    FSource.VideoCap1.DlgVSource;
end;

procedure TFMain.SpeedButton1Click(Sender: TObject);
begin
  if FSource.VideoCap1.HasDlgFormat then
    FSource.VideoCap1.DlgVFormat;
end;

procedure TFMain.MICloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFMain.MIlowgainClick(Sender: TObject);
begin
  gain := 3;
  MIlowgain.Checked := true;
end;

procedure TFMain.MImedgainClick(Sender: TObject);
begin
  gain := 2;
  MImedgain.Checked := true;
end;

procedure TFMain.MIhighgainClick(Sender: TObject);
begin
  gain := 1;
  MIhighgain.Checked := true;
end;

procedure TFMain.MIColorClick(Sender: TObject);
begin
  CMode := cmColor;
  MIColor.checked := true;
end;

procedure TFMain.MIMonoClick(Sender: TObject);
begin
  CMode := cmMono;
  MIMono.checked := true;
end;

function isJPEG(FileName: string): Boolean;
var ext: string;
begin
  ext := UpperCase(ExtractFileExt(filename));
  if (Pos('.JPEG',ext)>0) or (Pos('.JPG',ext)>0) then
    Result := True
  else
    Result := False;
end;

function TFMain.SetFrameName: String;
var path,name,ext: String;
    p,l : integer;
    currentdate,currenttime: string;
begin
  currentdate := FormatDateTime('yyyymmdd',Now);
  currenttime := FormatDateTime('hhnnss',Now);
  filename := StringReplace(filename,'%d',currentdate,[rfReplaceAll,rfIgnoreCase]);
  filename := StringReplace(filename,'%t',currenttime,[rfReplaceAll,rfIgnoreCase]);
  path := ExtractFilePath(filename);
  ForceDirectories(path);
  name := ExtractFileName(filename);
  ext := ExtractFileExt(filename);
  if ext='.' then ext:='.bmp';
  p := Pos(ext,name);
  l := Length(ext);
  Delete(name,p,l);
  repeat
    Result := Format('%s%s%5.5d%s',[path,name,FileNo,ext]);
    inc(Fileno);
  until not FileExists(Result);
  SBInfo.SimpleText := Result;
end;

procedure TFMain.Capture;
var jpg: TJpegImage;
begin
  if IsJPEG(Filename) then
  begin
    jpg:=TJPEGImage.Create;
    jpg.CompressionQuality := 100;
    jpg.ProgressiveEncoding := false;
    if cMode = cmColor then
      jpg.PixelFormat := jf24Bit
    else
      jpg.Pixelformat := jf8Bit;
    jpg.Smoothing := false;
    jpg.Assign(Image1.Picture.Bitmap);
    jpg.Compress;
    jpg.SaveToFile(SetFrameName);
    jpg.Free;
  end
  else
  begin
    if cMode = cmColor then
      Image1.Picture.Bitmap.PixelFormat := pf24Bit
    else
      Image1.Picture.Bitmap.Pixelformat := pf8Bit;
    Image1.Picture.SaveToFile(SetFrameName);
    Image1.Picture.Bitmap.PixelFormat := pf24Bit;
  end;
end;


procedure TFMain.FEFilesChange(Sender: TObject);
begin
  filename := FEFiles.Filename;
end;

procedure TFMain.SBRecordClick(Sender: TObject);
begin
  FilesToCapture := SPCount.AsInteger;
  Filename := FEFiles.Text;
  SBRecord.Enabled := False;
  Fileno := 0;
end;

procedure TFMain.MItimestampClick(Sender: TObject);
begin
  MItimestamp.checked := not MItimestamp.checked;
end;

procedure TFMain.MIremarkClick(Sender: TObject);
begin
  MIremark.checked := not MIremark.checked;
  if MIremark.checked then remark := InputBox('Image Information','Enter a remark',remark);
end;

procedure TFMain.MIrawClick(Sender: TObject);
begin
  CMode := cmRAW;
  MIraw.checked := true;
end;

end.
