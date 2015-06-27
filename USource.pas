unit USource;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Videocap, VideoHdr, Placemnt;

type
  TFSource = class(TForm)
    VideoCap1: TVideoCap;
    FPSource: TFormPlacement;
    procedure VideoCap1FrameCallback(sender: TObject; lpVhdr: PVIDEOHDR);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
    isfirst: boolean;
  public
    { Public-Deklarationen }
  end;

var
  FSource: TFSource;

implementation

uses UMain;

{$R *.DFM}

procedure TFSource.VideoCap1FrameCallback(sender: TObject;
  lpVhdr: PVIDEOHDR);
begin
  if isfirst then
  begin
    isfirst := false;
    FrameToBitmap(FMain.Image1.Picture.Bitmap,lpVhdr.lpData,Videocap1.BitMapInfo);
    FMain.Image1.Picture.bitmap.Pixelformat := pf24bit;
    FMain.Image1.Refresh;
  end
  else
  begin
    FrameToBitmap(FMain.Bitmap,lpVhdr.lpData,Videocap1.BitMapInfo);
    FMain.ProcessImage;
  end;
end;

procedure TFSource.FormCreate(Sender: TObject);
begin
  isfirst := true;
  with FMain.IniFile do
  begin
    VideoCap1.DriverIndex := ReadInteger('VideoCap','DriverIndex',0);
    VideoCap1.DriverName := ReadString('VideoCap','DriverName','Microsoft WDM Image Capture (Win32)');
    VideoCap1.FrameRate := ReadInteger('VideoCap','FrameRate',5);
    VideoCap1.PreviewRate := ReadInteger('VideoCap','PreviewRate',5);
  end;
  VideoCap1.DriverOpen := True;
  VideoCap1.VideoPreview := True;
end;

procedure TFSource.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  VideoCap1.DriverOpen := False;
  with FMain.Inifile do
  begin
    WriteInteger('VideoCap','DriverIndex',FSource.VideoCap1.DriverIndex);
    WriteString('VideoCap','DriverName',FSource.VideoCap1.DriverName);
    WriteInteger('VideoCap','FrameRate',FSource.VideoCap1.FrameRate);
    WriteInteger('VideoCap','PreviewRate',FSource.VideoCap1.PreviewRate);
  end;

end;

end.
