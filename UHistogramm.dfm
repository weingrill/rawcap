object FHisto: TFHisto
  Left = 748
  Top = 486
  BorderStyle = bsToolWindow
  Caption = 'Histogramm'
  ClientHeight = 200
  ClientWidth = 255
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object FPHisto: TFormPlacement
    IniFileName = 'Software\Weingrill\RAWCap'
    IniSection = 'HistogramForm'
    UseRegistry = True
    Left = 44
    Top = 28
  end
end
