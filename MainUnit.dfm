object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 659
  ClientWidth = 1190
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object PaintBox1: TPaintBox
    Left = 233
    Top = 0
    Width = 957
    Height = 659
    Align = alClient
    OnPaint = PaintBox1Paint
    ExplicitLeft = 552
    ExplicitTop = 296
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 233
    Height = 659
    Align = alLeft
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 448
      Width = 217
      Height = 25
      Caption = 'Regenerate'
      TabOrder = 0
      OnClick = Button1Click
    end
    object RadioGroup1: TRadioGroup
      Left = 8
      Top = 207
      Width = 217
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
    object GroupBox1: TGroupBox
      Left = 8
      Top = 8
      Width = 217
      Height = 105
      Caption = 'Package Size'
      TabOrder = 2
      object Label2: TLabel
        Left = 8
        Top = 48
        Width = 36
        Height = 15
        Caption = 'Height'
      end
      object Label1: TLabel
        Left = 8
        Top = 19
        Width = 32
        Height = 15
        Caption = 'Width'
      end
      object Edit1: TEdit
        Left = 88
        Top = 16
        Width = 121
        Height = 23
        NumbersOnly = True
        TabOrder = 0
        Text = '700'
      end
      object Edit2: TEdit
        Left = 88
        Top = 45
        Width = 121
        Height = 23
        NumbersOnly = True
        TabOrder = 1
        Text = '500'
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 74
        Width = 97
        Height = 17
        Caption = 'Client Size'
        TabOrder = 2
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 119
      Width = 217
      Height = 82
      Caption = 'Slots'
      TabOrder = 3
      object Label3: TLabel
        Left = 8
        Top = 27
        Width = 33
        Height = 15
        Caption = 'Count'
      end
      object CheckBox2: TCheckBox
        Left = 8
        Top = 53
        Width = 97
        Height = 17
        Caption = 'Random'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object Edit3: TEdit
        Left = 88
        Top = 24
        Width = 121
        Height = 23
        NumbersOnly = True
        TabOrder = 1
        Text = '100'
      end
    end
  end
end
