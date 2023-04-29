object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 659
  ClientWidth = 1190
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Button1: TButton
    Left = 760
    Top = 248
    Width = 185
    Height = 25
    Caption = 'Regenerate'
    TabOrder = 0
    OnClick = Button1Click
  end
  object RadioGroup1: TRadioGroup
    Left = 760
    Top = 8
    Width = 185
    Height = 225
    Caption = 'Sorting'
    ItemIndex = 0
    Items.Strings = (
      'No'
      'Width ascending'
      'Width descending '
      'Height ascending'
      'Height descending '
      'Area ascending'
      'Area descending ')
    TabOrder = 1
  end
end
