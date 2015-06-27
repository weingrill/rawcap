unit UParams;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXSpin;

type
  TFParams = class(TForm)
    SEkr: TRxSpinEdit;
    SEkg: TRxSpinEdit;
    SEkb: TRxSpinEdit;
    SEdr: TRxSpinEdit;
    SEdg: TRxSpinEdit;
    SEdb: TRxSpinEdit;
    procedure SEkrChange(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FParams: TFParams;

implementation

uses UMain;

{$R *.DFM}

procedure TFParams.SEkrChange(Sender: TObject);
begin
  FMain.kr := SEkr.Value;
  FMain.kg := SEkg.Value;
  FMain.kb := SEkb.Value;
  FMain.dr := SEdr.Value;
  FMain.dg := SEdg.Value;
  FMain.db := SEdb.Value;
end;

end.
