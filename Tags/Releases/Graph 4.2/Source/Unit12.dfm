object Form12: TForm12
  Left = 459
  Top = 264
  HelpContext = 60
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Insert tangent/normal'
  ClientHeight = 375
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  DesignSize = (
    297
    375)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TTntLabel
    Left = 8
    Top = 16
    Width = 11
    Height = 13
    Caption = 'x='
  end
  object Button1: TTntButton
    Left = 24
    Top = 344
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TTntButton
    Left = 112
    Top = 344
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 7
  end
  object Edit1: TMyEdit
    Left = 24
    Top = 16
    Width = 265
    Height = 21
    Hint = 'Coordinate where the tangent/normal will cross the function.'
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object RadioGroup1: TTntRadioGroup
    Left = 188
    Top = 216
    Width = 101
    Height = 57
    Hint = 'Choose if you want a tangent or a normal.'
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Type'
    ItemIndex = 0
    Items.Strings = (
      'Tangent'
      'Normal')
    TabOrder = 5
  end
  object GroupBox1: TTntGroupBox
    Left = 8
    Top = 48
    Width = 281
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Legend text'
    TabOrder = 1
    DesignSize = (
      281
      49)
    object Label10: TTntLabel
      Left = 8
      Top = 20
      Width = 56
      Height = 13
      Caption = 'Description:'
      FocusControl = Edit2
    end
    object Edit2: TTntEdit
      Left = 72
      Top = 18
      Width = 201
      Height = 21
      Hint = 
        'Write a descriptive text to show in the legend. If empty the equ' +
        'ation will be used.'
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object GroupBox2: TTntGroupBox
    Left = 7
    Top = 216
    Width = 174
    Height = 113
    Anchors = [akLeft, akBottom]
    Caption = 'Graph properties'
    TabOrder = 4
    object Label7: TTntLabel
      Left = 8
      Top = 20
      Width = 47
      Height = 13
      Caption = 'Line style:'
      FocusControl = LineSelect1
    end
    object Label8: TTntLabel
      Left = 8
      Top = 84
      Width = 31
      Height = 13
      Caption = 'Width:'
      FocusControl = Edit3
    end
    object Label9: TTntLabel
      Left = 8
      Top = 52
      Width = 27
      Height = 13
      Caption = 'Color:'
      FocusControl = ExtColorBox1
    end
    object Edit3: TTntEdit
      Left = 72
      Top = 82
      Width = 41
      Height = 21
      Hint = 'Width of graph in pixels.'
      TabOrder = 2
      Text = '1'
      OnKeyPress = Edit3KeyPress
    end
    object UpDown1: TUpDown
      Left = 113
      Top = 82
      Width = 15
      Height = 21
      Associate = Edit3
      Min = 1
      Max = 20
      Position = 1
      TabOrder = 3
      Wrap = False
    end
    object LineSelect1: TLineSelect
      Left = 72
      Top = 18
      Width = 81
      Height = 22
      Hint = 'Choose which line style to use for drawing the graph.'
      TabOrder = 0
      ItemHeight = 16
    end
    object ExtColorBox1: TExtColorBox
      Left = 72
      Top = 48
      Width = 81
      Height = 22
      Hint = 'Select the color of the graph.'
      Selected = clRed
      Style = [cbStandardColors, cbExtendedColors, cbCustomColor, cbPrettyNames]
      ItemHeight = 16
      TabOrder = 1
      AutoDroppedWidth = True
    end
  end
  object Button3: TTntButton
    Left = 198
    Top = 344
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Help'
    TabOrder = 8
    OnClick = Button3Click
  end
  object GroupBox3: TTntGroupBox
    Left = 7
    Top = 104
    Width = 282
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Argument range'
    TabOrder = 2
    DesignSize = (
      282
      49)
    object Label4: TTntLabel
      Left = 8
      Top = 20
      Width = 26
      Height = 13
      Caption = 'From:'
      FocusControl = Edit4
    end
    object Label5: TTntLabel
      Left = 172
      Top = 20
      Width = 16
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'To:'
      FocusControl = Edit5
    end
    object Edit4: TMyEdit
      Left = 38
      Top = 18
      Width = 84
      Height = 21
      Hint = 'Start of range interval for the used variable.'
      TabOrder = 0
    end
    object Edit5: TMyEdit
      Left = 190
      Top = 18
      Width = 84
      Height = 21
      Hint = 'End of range interval for the used variable.'
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
  end
  object GroupBox5: TTntGroupBox
    Left = 8
    Top = 160
    Width = 281
    Height = 49
    Caption = 'Endpoints'
    TabOrder = 3
    object Label11: TTntLabel
      Left = 8
      Top = 20
      Width = 25
      Height = 13
      Caption = 'Start:'
      FocusControl = ComboBox1
    end
    object Label12: TTntLabel
      Left = 176
      Top = 20
      Width = 22
      Height = 13
      Caption = 'End:'
      FocusControl = ComboBox2
    end
    object ComboBox1: TTntComboBox
      Left = 40
      Top = 16
      Width = 65
      Height = 22
      Hint = 
        'Select marker to show at the start of the interval. Only used if' +
        ' an argument range is specified.'
      Style = csOwnerDrawFixed
      ItemHeight = 16
      TabOrder = 0
      OnDrawItem = ComboBoxDrawItem
      Items.Strings = (
        ''
        ''
        ''
        ''
        ''
        '')
    end
    object ComboBox2: TTntComboBox
      Left = 208
      Top = 16
      Width = 65
      Height = 22
      Hint = 
        'Select marker to show at the end of the interval. Only used if a' +
        'n argument range is specified.'
      Style = csOwnerDrawFixed
      ItemHeight = 16
      TabOrder = 1
      OnDrawItem = ComboBoxDrawItem
      Items.Strings = (
        ''
        ''
        ''
        ''
        ''
        '')
    end
  end
end