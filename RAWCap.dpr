program RAWCap;

uses
  Forms,
  UMain in 'UMain.pas' {FMain},
  USource in 'USource.pas' {FSource},
  UHistogramm in 'UHistogramm.pas' {FHisto},
  UParams in 'UParams.pas' {FParams};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'RAWCap';
  Application.CreateForm(TFMain, FMain);
  Application.CreateForm(TFSource, FSource);
  Application.CreateForm(TFHisto, FHisto);
  Application.CreateForm(TFParams, FParams);
  Application.Run;
end.
