unit UHistogramm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Placemnt, ExtCtrls,Math;

type
  TFHisto = class(TForm)
    FPHisto: TFormPlacement;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private-Deklarationen }
    Bitmap: TBitmap;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    { Public-Deklarationen }
    rhist,ghist,uhist,bhist: array[0..256] of integer;
  end;
type
  TRGBValue = packed record
    Blue: Byte;
    Green: Byte;
    Red: Byte;
  end;

var
  FHisto: TFHisto;

implementation

{$R *.DFM}

procedure TFHisto.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin // avoid clearing the background (causes flickering and speed penalty)
  Message.Result:=0
end;

function scale(i:integer):integer;
begin
  Result := Round(log2(i+1)*100);
end;

procedure TFHisto.FormPaint(Sender: TObject);
var x,y,r,g,b,u,m: integer;
    Pixel: ^TRGBValue;
begin
  m:=1;
  for x := 0 to 255 do
  begin
    if scale(rhist[x])>m then m:=scale(rhist[x]);
    if scale(ghist[x])>m then m:=scale(ghist[x]);
    if scale(bhist[x])>m then m:=scale(bhist[x]);
    if scale(uhist[x])>m then m:=scale(uhist[x]);
  end;
  for y:= 0 to 199 do
  begin
    Pixel := Bitmap.Scanline[y];
    for x:= 0 to 255 do
    begin
      if 200-(scale(rhist[x])*200 div m)<y then Pixel.Red := 255 else Pixel.Red := 0;
      if 200-(scale(ghist[x])*200 div m)<y then Pixel.Green := 255 else Pixel.Green := 0;
      if 200-(scale(bhist[x])*200 div m)<y then Pixel.Blue := 255 else Pixel.Blue := 0;
      inc(Pixel);
    end;
  end;
  Canvas.draw(0,0,BitMap);
end;

procedure TFHisto.FormCreate(Sender: TObject);
begin
  Bitmap := TBitmap.Create;
  Bitmap.Width := 256;
  Bitmap.Height := 200;
  Bitmap.Pixelformat := pf24bit;
end;

procedure TFHisto.FormDestroy(Sender: TObject);
begin
  BitMap.free;
end;

end.
