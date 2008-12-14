object Form3: TForm3
  Left = 414
  Top = 211
  HelpContext = 30
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Edit axes'
  ClientHeight = 270
  ClientWidth = 422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poMainFormCenter
  ShowHint = True
  OnShow = FormShow
  DesignSize = (
    422
    270)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 404
    Height = 213
    ActivePage = TabSheet2
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'x-axis'
      DesignSize = (
        396
        185)
      object Label1: TLabel
        Left = 8
        Top = 12
        Width = 44
        Height = 13
        Caption = 'Minimum:'
        FocusControl = Edit1
      end
      object Label2: TLabel
        Left = 8
        Top = 44
        Width = 47
        Height = 13
        Caption = 'Maximum:'
        FocusControl = Edit2
      end
      object Label3: TLabel
        Left = 8
        Top = 76
        Width = 44
        Height = 13
        Caption = 'Tick unit:'
        FocusControl = Edit3
      end
      object Label4: TLabel
        Left = 187
        Top = 44
        Width = 102
        Height = 13
        Caption = 'The x-axis cross at y='
        FocusControl = Edit6
      end
      object Label14: TLabel
        Left = 8
        Top = 108
        Width = 42
        Height = 13
        Caption = 'Grid unit:'
        FocusControl = Edit4
      end
      object Edit1: TMyEdit
        Left = 72
        Top = 8
        Width = 100
        Height = 21
        Hint = 'Minimum x-value.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object Edit2: TMyEdit
        Left = 72
        Top = 40
        Width = 100
        Height = 21
        Hint = 'Maximum x-value.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object Edit3: TMyEdit
        Left = 72
        Top = 72
        Width = 100
        Height = 21
        Hint = 'Units between ticks on the x-axis.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 136
        Width = 369
        Height = 17
        Hint = 'Use logarithmic scale on the x-axis.'
        Caption = 'Logarithmic scale'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = CheckBox1Click
      end
      object CheckBox3: TCheckBox
        Left = 187
        Top = 10
        Width = 150
        Height = 17
        Hint = 
          'Show the label at the right side of the graphing area, above the' +
          ' x-axis.'
        Caption = 'Label:'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = CheckBoxClick
      end
      object Edit5: TMyEdit
        Left = 243
        Top = 8
        Width = 146
        Height = 21
        Hint = 'Edit the label for the axis here.'
        Anchors = [akLeft, akTop, akRight]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
      end
      object CheckBox2: TCheckBox
        Left = 8
        Top = 160
        Width = 177
        Height = 17
        Hint = 'Show units on the x-axis.'
        Caption = 'Show numbers'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = CheckBoxClick
      end
      object Edit6: TMyEdit
        Left = 299
        Top = 40
        Width = 90
        Height = 21
        Hint = 'The x-axis will intersect with the y-axis at this value.'
        Anchors = [akLeft, akTop, akRight]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
      end
      object Edit4: TMyEdit
        Left = 72
        Top = 104
        Width = 100
        Height = 21
        Hint = 'Units between the grid lines perpendicular to the x-axis.'
        TabOrder = 3
      end
      object CheckBox4: TCheckBox
        Left = 187
        Top = 74
        Width = 118
        Height = 17
        Hint = 'Determine the tick unit automatically.'
        Caption = 'Auto tick'
        TabOrder = 9
        OnClick = CheckBoxClick
      end
      object CheckBox5: TCheckBox
        Left = 187
        Top = 106
        Width = 118
        Height = 17
        Hint = 'Set the grid unit to the same as the tick unit.'
        Caption = 'Auto grid'
        TabOrder = 10
        OnClick = CheckBoxClick
      end
      object CheckBox6: TCheckBox
        Left = 264
        Top = 74
        Width = 121
        Height = 17
        Hint = 'Show tick marks on the x-axis.'
        Caption = 'Show ticks'
        TabOrder = 11
      end
      object CheckBox17: TCheckBox
        Left = 187
        Top = 160
        Width = 198
        Height = 17
        Hint = 'Show units on the selected axis as a fraction multiplied by pi.'
        Caption = 'Show as a multiple of pi'
        TabOrder = 13
      end
      object CheckBox7: TCheckBox
        Left = 264
        Top = 106
        Width = 121
        Height = 17
        Hint = 'Show vertical grid lines.'
        Caption = 'Show grid'
        TabOrder = 12
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'y-axis'
      DesignSize = (
        396
        185)
      object Label5: TLabel
        Left = 8
        Top = 12
        Width = 44
        Height = 13
        Caption = 'Minimum:'
        FocusControl = Edit7
      end
      object Label6: TLabel
        Left = 8
        Top = 44
        Width = 47
        Height = 13
        Caption = 'Maximum:'
        FocusControl = Edit8
      end
      object Label7: TLabel
        Left = 8
        Top = 76
        Width = 44
        Height = 13
        Caption = 'Tick unit:'
        FocusControl = Edit9
      end
      object Label8: TLabel
        Left = 187
        Top = 44
        Width = 102
        Height = 13
        Caption = 'The y-axis cross at x='
        FocusControl = Edit12
      end
      object Label9: TLabel
        Left = 8
        Top = 108
        Width = 42
        Height = 13
        Caption = 'Grid unit:'
        FocusControl = Edit10
      end
      object Edit7: TMyEdit
        Left = 72
        Top = 8
        Width = 100
        Height = 21
        Hint = 'Minimum y-value.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object Edit8: TMyEdit
        Left = 72
        Top = 40
        Width = 100
        Height = 21
        Hint = 'Maximum y-value.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object CheckBox8: TCheckBox
        Left = 8
        Top = 136
        Width = 377
        Height = 17
        Hint = 'Use logarithmic scale for the y-axis.'
        Caption = 'Logarithmic scale'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = CheckBox8Click
      end
      object Edit9: TMyEdit
        Left = 72
        Top = 72
        Width = 100
        Height = 21
        Hint = 'Units between ticks on the y-axis.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object CheckBox9: TCheckBox
        Left = 8
        Top = 160
        Width = 177
        Height = 17
        Hint = 'Show units on the y-axis.'
        Caption = 'Show numbers'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = CheckBoxClick
      end
      object CheckBox10: TCheckBox
        Left = 187
        Top = 10
        Width = 166
        Height = 17
        Hint = 
          'Show the label at the top of the graphing area, to the right of ' +
          'the y-axis.'
        Caption = 'Label:'
        TabOrder = 6
        OnClick = CheckBoxClick
      end
      object Edit11: TMyEdit
        Left = 243
        Top = 8
        Width = 146
        Height = 21
        Hint = 'Edit the label for the axis here.'
        Anchors = [akLeft, akTop, akRight]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
      end
      object Edit12: TMyEdit
        Left = 299
        Top = 40
        Width = 90
        Height = 21
        Hint = 'The y-axis will intersect with the x-axis at this value.'
        Anchors = [akLeft, akTop, akRight]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
      end
      object Edit10: TMyEdit
        Left = 72
        Top = 104
        Width = 100
        Height = 21
        Hint = 'Units between the grid lines perpendicular to the y-axis.'
        TabOrder = 3
      end
      object CheckBox11: TCheckBox
        Left = 187
        Top = 74
        Width = 142
        Height = 17
        Hint = 'Determine the tick unit automatically.'
        Caption = 'Auto tick'
        TabOrder = 9
        OnClick = CheckBoxClick
      end
      object CheckBox12: TCheckBox
        Left = 187
        Top = 106
        Width = 142
        Height = 17
        Hint = 'Set the grid unit to the same as the tick unit.'
        Caption = 'Auto grid'
        TabOrder = 10
        OnClick = CheckBoxClick
      end
      object CheckBox13: TCheckBox
        Left = 264
        Top = 74
        Width = 121
        Height = 17
        Hint = 'Show tick marks on the y-axis.'
        Caption = 'Show ticks'
        TabOrder = 11
      end
      object CheckBox18: TCheckBox
        Left = 187
        Top = 160
        Width = 198
        Height = 17
        Hint = 'Show units on the selected axis as a fraction multiplied by pi.'
        Caption = 'Show as a multiple of pi'
        TabOrder = 13
      end
      object CheckBox14: TCheckBox
        Left = 264
        Top = 106
        Width = 121
        Height = 17
        Hint = 'Show horizontal grid lines.'
        Caption = 'Show grid'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Settings'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        396
        185)
      object Label16: TLabel
        Left = 8
        Top = 12
        Width = 23
        Height = 13
        Caption = 'Title:'
        FocusControl = Edit13
      end
      object CheckBox15: TCheckBox
        Left = 8
        Top = 40
        Width = 137
        Height = 17
        Hint = 'Select to show a legend in the coordinate system.'
        Caption = 'Show legend'
        TabOrder = 2
        OnClick = CheckBox15Click
      end
      object RadioGroup1: TRadioGroup
        Left = 152
        Top = 64
        Width = 116
        Height = 73
        Hint = 
          'Choose if you want to show the axes, and if you want to show the' +
          'm crossed or at the left and bottom of the image.'
        Anchors = [akTop, akRight]
        Caption = 'Axes style'
        ItemIndex = 1
        Items.Strings = (
          'None'
          'Crossed'
          'Boxed')
        TabOrder = 4
        OnClick = RadioGroup1Click
      end
      object RadioGroup2: TRadioGroup
        Left = 283
        Top = 64
        Width = 97
        Height = 57
        Hint = 
          'Choose if trigonometric functions should calculate in radians or' +
          ' degrees.'
        Anchors = [akTop, akRight]
        Caption = 'Trigonometry'
        ItemIndex = 0
        Items.Strings = (
          'Radian'
          'Degree')
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
      end
      object Edit13: TMyEdit
        Left = 40
        Top = 8
        Width = 332
        Height = 21
        Hint = 'Enter a title to show above the coordinate system.'
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
      end
      object BitBtn1: TBitBtn
        Left = 371
        Top = 8
        Width = 21
        Height = 21
        Hint = 'Select the font for the title.'
        Anchors = [akTop, akRight]
        DoubleBuffered = True
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000230B0000230B00001000000010000000A64D4D00FF4D
          4D00D1D8DB00FFFFFF0000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000333333333333
          3333333000000000000333333333333333333330000033300003333330033333
          0033333333003333003311111330000000333311333300330033333113333003
          0033333311111100003333333113311000333333331131130033333333311113
          3333333333331113333333333333311333333333333333333333}
        ParentDoubleBuffered = False
        TabOrder = 1
        OnClick = BitBtn1Click
      end
      object RadioGroup3: TRadioGroup
        Left = 8
        Top = 64
        Width = 129
        Height = 89
        Hint = 'Choose where the legend should be placed.'
        Caption = 'Legend placement'
        Items.Strings = (
          'Top Right'
          'Bottom Right'
          'Top Left'
          'Bottom Left')
        TabOrder = 3
      end
      object CheckBox19: TCheckBox
        Left = 152
        Top = 40
        Width = 236
        Height = 17
        Hint = 
          'Check this to use complex numbers for calculations. Notice that ' +
          'this will slow graphing down.'
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Calculate with complex numbers'
        TabOrder = 6
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Font and color'
      ImageIndex = 3
      DesignSize = (
        396
        185)
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 193
        Height = 113
        Caption = 'Colors'
        TabOrder = 0
        object Label17: TLabel
          Left = 8
          Top = 82
          Width = 48
          Height = 13
          Caption = 'Grid color:'
          FocusControl = ExtColorBox3
        end
        object Label18: TLabel
          Left = 8
          Top = 50
          Width = 52
          Height = 13
          Caption = 'Axes color:'
          FocusControl = ExtColorBox2
        end
        object Label19: TLabel
          Left = 8
          Top = 18
          Width = 87
          Height = 13
          Caption = 'Background color:'
          FocusControl = ExtColorBox1
        end
        object ExtColorBox1: TExtColorBox
          Left = 104
          Top = 16
          Width = 81
          Height = 22
          Hint = 'Select the color of the image background.'
          ItemHeight = 16
          TabOrder = 0
          AutoDroppedWidth = True
          Selected = clScrollBar
          DefaultName = 'Default'
          CustomName = 'Custom...'
        end
        object ExtColorBox2: TExtColorBox
          Left = 104
          Top = 48
          Width = 81
          Height = 22
          Hint = 'Select the color of the axes.'
          ItemHeight = 16
          TabOrder = 1
          AutoDroppedWidth = True
          Selected = clScrollBar
          DefaultName = 'Default'
          CustomName = 'Custom...'
        end
        object ExtColorBox3: TExtColorBox
          Left = 104
          Top = 80
          Width = 81
          Height = 22
          Hint = 'Select the color of the grid lines.'
          ItemHeight = 16
          TabOrder = 2
          AutoDroppedWidth = True
          Selected = clScrollBar
          DefaultName = 'Default'
          CustomName = 'Custom...'
        end
      end
      object GroupBox4: TGroupBox
        Left = 235
        Top = 8
        Width = 145
        Height = 113
        Anchors = [akTop, akRight]
        Caption = 'Fonts'
        TabOrder = 1
        object Label20: TLabel
          Left = 8
          Top = 50
          Width = 61
          Height = 13
          Caption = 'Number font:'
          FocusControl = BitBtn3
        end
        object Label21: TLabel
          Left = 8
          Top = 18
          Width = 50
          Height = 13
          Caption = 'Label font:'
          FocusControl = BitBtn2
        end
        object Label10: TLabel
          Left = 8
          Top = 80
          Width = 60
          Height = 13
          Caption = 'Legend font:'
          FocusControl = BitBtn4
        end
        object BitBtn2: TBitBtn
          Left = 116
          Top = 14
          Width = 21
          Height = 21
          Hint = 'Select the font used to show the labels on the axes.'
          DoubleBuffered = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000130B0000130B00001000000010000000A64D4D00FF4D
            4D00D1D8DB000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000222222222222
            2222222000000000000222222222222222222220000022200002222220022222
            0022222222002222002211111220000000222211222200220022222112222002
            0022222211111100002222222112211000222222221121120022222222211112
            2222222222221112222222222222211222222222222222222222}
          ParentDoubleBuffered = False
          TabOrder = 0
          OnClick = BitBtn2Click
        end
        object BitBtn3: TBitBtn
          Left = 116
          Top = 46
          Width = 21
          Height = 21
          Hint = 'Select the font used to show the numbers on the axes.'
          DoubleBuffered = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000130B0000130B00001000000010000000A64D4D00FF4D
            4D00D1D8DB000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000222222222222
            2222222000000000000222222222222222222220000022200002222220022222
            0022222222002222002211111220000000222211222200220022222112222002
            0022222211111100002222222112211000222222221121120022222222211112
            2222222222221112222222222222211222222222222222222222}
          ParentDoubleBuffered = False
          TabOrder = 1
          OnClick = BitBtn3Click
        end
        object BitBtn4: TBitBtn
          Left = 116
          Top = 78
          Width = 21
          Height = 21
          Hint = 'Select the font used to show the legend text.'
          DoubleBuffered = True
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            04000000000080000000130B0000130B00001000000010000000A64D4D00FF4D
            4D00D1D8DB000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000222222222222
            2222222000000000000222222222222222222220000022200002222220022222
            0022222222002222002211111220000000222211222200220022222112222002
            0022222211111100002222222112211000222222221121120022222222211112
            2222222222221112222222222222211222222222222222222222}
          ParentDoubleBuffered = False
          TabOrder = 2
          OnClick = BitBtn4Click
        end
      end
    end
  end
  object Button2: TButton
    Left = 251
    Top = 235
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object Button3: TButton
    Left = 339
    Top = 235
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Help'
    TabOrder = 4
    OnClick = Button3Click
  end
  object CheckBox16: TCheckBox
    Left = 4
    Top = 239
    Width = 157
    Height = 17
    Hint = 'Select this to use these settings as defaults in the future.'
    Anchors = [akLeft, akBottom]
    Caption = 'Save as default'
    TabOrder = 1
  end
  object Button1: TButton
    Left = 163
    Top = 235
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [fdEffects, fdForceFontExist]
    Left = 336
    Top = 192
  end
end
