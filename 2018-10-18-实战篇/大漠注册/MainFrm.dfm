object Form1: TForm1
  Left = 352
  Top = 292
  Caption = #28216#25103#21161#25163
  ClientHeight = 355
  ClientWidth = 407
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 16
    Width = 75
    Height = 25
    Caption = #21551#21160#21161#25163
    TabOrder = 0
    OnClick = Button1Click
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 64
    Width = 409
    Height = 289
    ColCount = 4
    DefaultColWidth = 100
    DrawingStyle = gdsGradient
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    PopupMenu = PopupMenu1
    TabOrder = 1
  end
  object PopupMenu1: TPopupMenu
    Left = 216
    Top = 16
    object N1: TMenuItem
      Caption = #26242#20572
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #32487#32493
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #32456#27490
      OnClick = N3Click
    end
  end
end
