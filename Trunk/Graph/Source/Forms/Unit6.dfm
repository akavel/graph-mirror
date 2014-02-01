object Form6: TForm6
  Left = 390
  Top = 223
  HelpContext = 10
  BorderIcons = []
  Caption = 'Insert text label'
  ClientHeight = 289
  ClientWidth = 543
  Color = clBtnFace
  Constraints.MinHeight = 250
  Constraints.MinWidth = 551
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCanResize = FormCanResize
  OnShow = FormShow
  DesignSize = (
    543
    289)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 53
    Height = 13
    Caption = 'Font name:'
    FocusControl = IFontBox1
  end
  object Label2: TLabel
    Left = 248
    Top = 8
    Width = 45
    Height = 13
    Caption = 'Font size:'
    FocusControl = ComboBox1
  end
  object Label3: TLabel
    Left = 312
    Top = 8
    Width = 50
    Height = 13
    Caption = 'Font color:'
    FocusControl = ColorBox1
  end
  object Label4: TLabel
    Left = 432
    Top = 8
    Width = 87
    Height = 13
    Caption = 'Background color:'
    FocusControl = ColorBox2
  end
  object Button1: TButton
    Left = 286
    Top = 256
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 374
    Top = 256
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object ComboBox1: TComboBox
    Left = 248
    Top = 24
    Width = 49
    Height = 21
    Hint = 'Text size.'
    AutoComplete = False
    ItemIndex = 0
    TabOrder = 5
    Text = '8'
    OnExit = ComboBox1Exit
    OnKeyDown = ComboBoxKeyDown
    OnKeyPress = ComboBoxKey1Press
    OnSelect = ComboBox1Exit
    Items.Strings = (
      '8'
      '9'
      '10'
      '11'
      '12'
      '14'
      '16'
      '18'
      '20'
      '22'
      '24'
      '26'
      '28'
      '30'
      '36'
      '48'
      '72')
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 56
    Width = 527
    Height = 187
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Text string'
    DoubleBuffered = False
    ParentDoubleBuffered = False
    TabOrder = 0
    object IRichEdit1: TIRichEdit
      Left = 2
      Top = 39
      Width = 523
      Height = 146
      OnOleError = IRichEdit1OleError
      OnActivateObject = IRichEdit1ActivateObject
      EnableOLE = True
      HideSelection = False
      ScrollBars = ssBoth
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      PopupMenu = PopupMenu1
      ParentFont = False
      TabOrder = 0
      OnSelectionChange = IRichEdit1SelectionChange
      OnKeyDown = IRichEdit1KeyDown
      OnKeyPress = IRichEdit1KeyPress
      OnMouseDown = IRichEdit1MouseDown
      ExplicitTop = 153
      ExplicitHeight = 32
    end
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 523
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object ToolBar1: TToolBar
        AlignWithMargins = True
        Left = 221
        Top = 0
        Width = 299
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alRight
        AutoSize = True
        DoubleBuffered = False
        Images = ImageList1
        ParentDoubleBuffered = False
        TabOrder = 0
        Transparent = True
        Wrapable = False
        ExplicitLeft = 9
        ExplicitHeight = 41
        object ToolButton11: TToolButton
          Left = 0
          Top = 0
          Hint = 'Insert symbol (Ctrl+G)'
          ImageIndex = 9
          OnClick = ToolButton11Click
        end
        object ToolButton13: TToolButton
          Left = 23
          Top = 0
          Hint = 'Insert object.'
          ImageIndex = 10
          OnClick = ToolButton13Click
        end
        object ToolButton12: TToolButton
          Left = 46
          Top = 0
          Width = 23
          ImageIndex = 7
          Style = tbsSeparator
        end
        object ToolButton1: TToolButton
          Left = 69
          Top = 0
          Hint = 'Bold (Ctrl+B)'
          ImageIndex = 0
          Style = tbsCheck
          OnClick = ToolButton1Click
        end
        object ToolButton2: TToolButton
          Left = 92
          Top = 0
          Hint = 'Italic (Ctrl+I)'
          ImageIndex = 1
          Style = tbsCheck
          OnClick = ToolButton2Click
        end
        object ToolButton3: TToolButton
          Left = 115
          Top = 0
          Hint = 'Underline (Ctrl+U)'
          ImageIndex = 2
          Style = tbsCheck
          OnClick = ToolButton3Click
        end
        object ToolButton4: TToolButton
          Left = 138
          Top = 0
          Hint = 'Strikethrough (Ctrl+S)'
          ImageIndex = 3
          Style = tbsCheck
          OnClick = ToolButton4Click
        end
        object ToolButton9: TToolButton
          Left = 161
          Top = 0
          Hint = 'Superscript (Ctrl++)'
          ImageIndex = 7
          Style = tbsCheck
          OnClick = ToolButton9Click
        end
        object ToolButton10: TToolButton
          Left = 184
          Top = 0
          Hint = 'Subscript (Ctrl+=)'
          ImageIndex = 8
          Style = tbsCheck
          OnClick = ToolButton10Click
        end
        object ToolButton8: TToolButton
          Left = 207
          Top = 0
          Width = 23
          ImageIndex = 7
          Style = tbsSeparator
        end
        object ToolButton5: TToolButton
          Left = 230
          Top = 0
          Hint = 'Align left (Ctrl+L)'
          Down = True
          Grouped = True
          ImageIndex = 4
          Style = tbsCheck
          OnClick = ParagraphChange
        end
        object ToolButton6: TToolButton
          Left = 253
          Top = 0
          Hint = 'Center (Ctrl+E)'
          Grouped = True
          ImageIndex = 5
          Style = tbsCheck
          OnClick = ParagraphChange
        end
        object ToolButton7: TToolButton
          Left = 276
          Top = 0
          Hint = 'Align right (Ctrl+R)'
          Grouped = True
          ImageIndex = 6
          Style = tbsCheck
          OnClick = ParagraphChange
        end
      end
    end
  end
  object IFontBox1: TIFontBox
    Left = 8
    Top = 24
    Width = 225
    Height = 22
    Hint = 'Text font.'
    Sample = 'abc ABC'
    SamplePos = 100
    TabOrder = 4
    OnCloseUp = IFontBox1Exit
    OnExit = IFontBox1Exit
    OnKeyDown = ComboBoxKeyDown
    OnKeyPress = IFontBox1KeyPress
  end
  object Button3: TButton
    Left = 462
    Top = 256
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Help'
    TabOrder = 3
    OnClick = Button3Click
  end
  object ColorBox1: TExtColorBox
    Left = 312
    Top = 24
    Width = 105
    Height = 22
    Hint = 'Text color.'
    TabOrder = 6
    OnChange = ColorBox1Change
    OnKeyDown = ComboBoxKeyDown
    AutoDroppedWidth = True
    Selected = clScrollBar
    DefaultName = 'Default'
    CustomName = 'Custom...'
  end
  object ColorBox2: TExtColorBox
    Left = 432
    Top = 24
    Width = 105
    Height = 22
    Hint = 'Select background color of the text label.'
    TabOrder = 7
    OnChange = ColorBox2Change
    OnKeyDown = ComboBoxKeyDown
    AutoDroppedWidth = True
    ShowDefault = True
    Selected = clScrollBar
    DefaultName = 'Transparent'
    CustomName = 'Custom...'
  end
  object ImageList1: TImageList
    ColorDepth = cd32Bit
    Left = 8
    Top = 256
    Bitmap = {
      494C01010B0018002C0010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F79684FF9C2B49FF9C2B
      49FF9C2B49FF9C2B49FF00000000000000000000000000000000F79684FF9C2B
      49FF9C2B49FF9C2B49FF9C2B49FF000000000000000000000000726462FF7264
      62FF726462FF726462FF726462FF726462FF726462FF726462FF726462FF7264
      62FF726462FF726462FF726462FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F79684FF9C2B49FFF79684FFF796
      84FFF79684FFF79684FF9C2B49FF0000000000000000F79684FF9C2B49FFF796
      84FFF79684FFF79684FFF79684FF9C2B49FF000000000000000084706AFFFFFB
      FFFFF7F7F7FFF7F7F7FFF7F3F7FFF7F3F7FFF7F3F7FFEFEFEFFFEFEFEFFFEFEB
      EFFFEFEBEFFFEFEBEFFF84706AFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      00FFFF0000FFFF0000FFFF0000FFFF0000FFF79684FF9C2B49FF000000000000
      000000000000F79684FF9C2B49FF0000000000000000F79684FF9C2B49FF0000
      00000000000000000000F79684FF9C2B49FF00000000000000008C7C7AFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFEFEBEFFF8C7C7AFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      00FF00000000000000000000000000000000F79684FF9C2B49FF000000000000
      000000000000F79684FF9C2B49FF0000000000000000F79684FF9C2B49FF0000
      00000000000000000000F79684FF9C2B49FF00000000000000009C8A84FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFEFEFEFFF9C8A84FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000FF000000000000000000000000F79684FF9C2B49FF000000000000
      000000000000F79684FF9C2B49FF0000000000000000F79684FF9C2B49FF0000
      00000000000000000000F79684FF9C2B49FF0000000000000000A59A94FFFFFF
      FFFFFFBEADFF9C2B49FFFFBEADFFFFFFFFFF9C2B49FF9C2B49FFFFFFFFFF9C2B
      49FF9C2B49FFF7F3F7FFA59A94FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF0000000000000000000000FF000000FF000000FF000000FF0000
      000000000000FF0000FF000000000000000000000000F79684FF9C2B49FF9C2B
      49FF9C2B49FF9C2B49FF9C2B49FF9C2B49FF9C2B49FF9C2B49FF9C2B49FF9C2B
      49FF9C2B49FF9C2B49FF9C2B49FFF79684FF0000000000000000ADA2A5FFFFFF
      FFFF9C2B49FFFFFFFFFF9C2B49FFFFFFFFFF9C2B49FFFFFFFFFFFFFFFFFF9C2B
      49FFFFFFFFFFF7F7F7FFADA2A5FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF00000000000000000000000000000000000000FF000000FF000000000000
      00000000000000000000FF0000FF000000000000000000000000F79684FFF796
      84FFF79684FFF79684FF9C2B49FFF79684FFF79684FFF79684FF9C2B49FFF796
      84FFF79684FFF79684FFF79684FF000000000000000000000000ADA2A5FFFFFF
      FFFF9C2B49FFFFFFFFFF9C2B49FFFFFFFFFF9C2B49FFFFFFFFFFFFFFFFFF9C2B
      49FF9C2B49FFFFFBFFFFADA2A5FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000FF000000FF0000000000000000FF00
      00FF000000000000000000000000FF0000FF0000000000000000000000000000
      000000000000000000009C2B49FF0000000000000000F79684FF9C2B49FF0000
      0000000000000000000000000000000000000000000000000000ADA2A5FFFFFF
      FFFF9C2B49FFFFFFFFFF9C2B49FFFFFFFFFF9C2B49FFFFFFFFFFFFFFFFFF9C2B
      49FFFFFFFFFFFFFBFFFFADA2A5FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000FF0000FFFF0000FFFF0000FF000000000000000000000000000000000000
      000000000000000000009C2B49FF0000000000000000F79684FF9C2B49FF0000
      0000000000000000000000000000000000000000000000000000ADA2A5FFFFFF
      FFFFFFBEADFF9C2B49FFFFBEADFFFFFFFFFF9C2B49FFFFFFFFFFFFFFFFFF9C2B
      49FF9C2B49FFFFFFFFFFADA2A5FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F79684FF9C2B49FF9C2B
      49FF9C2B49FF9C2B49FF9C2B49FF9C2B49FF9C2B49FF9C2B49FF9C2B49FF9C2B
      49FF9C2B49FF9C2B49FF9C2B49FF000000000000000000000000ADA2A5FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFADA2A5FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000FF0000000000000000000000000000
      000000000000000000000000000000000000EDA497FF9C2B49FFF79684FFF796
      84FFF79684FFF79684FF9C2B49FFF79684FFF79684FFF79684FF9C2B49FFF796
      84FFF79684FFF79684FFF79684FF9C2B49FF0000000000000000ADA2A5FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F3
      F7FFF7F3F7FFF7F3F7FFA5928CFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000FF000000FF00000000000000000000
      000000000000000000000000000000000000EDA497FF9C2B49FF000000000000
      000000000000F79684FF9C2B49FF0000000000000000F79684FF9C2B49FF0000
      00000000000000000000F79684FF9C2B49FF0000000000000000ADA2A5FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA5928CFF7264
      62FF726462FF726462FF726462FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF00000000000000000000000000000000000000FF000000FF000000000000
      000000000000000000000000000000000000EDA497FF9C2B49FF000000000000
      000000000000F79684FF9C2B49FF0000000000000000F79684FF9C2B49FF0000
      00000000000000000000F79684FF9C2B49FF0000000000000000ADA2A5FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADA2A5FFFFFF
      FFFFFFFFFFFFF7F3F7FF7A706AFF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF0000000000000000000000FF000000FF000000FF000000FF0000
      000000000000000000000000000000000000E7ADA3FF9C2B49FFF79684FF0000
      000000000000F79684FF9C2B49FF0000000000000000F79684FF9C2B49FF0000
      00000000000000000000F79684FF9C2B49FF0000000000000000ADA2A5FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADA2A5FFFFFF
      FFFFF7F3F7FF7A706AFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F79684FF9C2B49FF9C2B
      49FF9C2B49FF9C2B49FFF79684FF000000000000000000000000F79684FF9C2B
      49FF9C2B49FF9C2B49FF9C2B49FFF79684FF0000000000000000ADA2A5FFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFADA2A5FFF7F3
      F7FF7A706AFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F79684FFF796
      84FFF79684FFF79684FF0000000000000000000000000000000000000000F796
      84FFF79684FFF79684FFF79684FF000000000000000000000000ADA2A5FFA592
      8CFFA5928CFFA5928CFFA5928CFFA5928CFFA5928CFFA5928CFFADA2A5FF7A70
      6AFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF0000000000000000000000FF000000FF000000FF000000FF0000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000FF0000
      00FF00000000000000000000000000000000000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000FF000000FF00000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000FF000000FF00000000000000000000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000FF0000
      00FF00000000000000000000000000000000000000FF000000FF000000000000
      FFFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF0000000000000000000000FF000000FF000000FF000000FF0000
      00000000FFFF000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FFFF00000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FFFF0000000000000000000000000000FFFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FFFF0000FFFF0000FFFF00000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF0000000000000000000000FF000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000FF00000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF0000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000000000000000000000808080FF000000FF0000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000808080FF000000FF000000FF808080FF0000000000000000000000000000
      00FF000000FF000000FF000000FF000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080FF0000
      00FF808080FF0000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000000000000000000000000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF0000000000000000000000000000000000000000000000008080
      80FF000000FF000000FF808080FF000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000000000000000000000000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000FF000000FF000000FF000000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF000000FF000000000000000000000000000000FF000000FF0000
      00FF000000000000000000000000000000000000000000000000000000008080
      80FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000000000000000000000000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      000000000000000000FF000000FF000000FF000000FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000FF000000FF00000000000000000000000000000000808080FF0000
      00FF000000FF808080FF00000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000000000000000000000000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      00000000000000000000000000FF000000FF000000FF000000FF000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000808080FF000000FF808080FF000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      00FF000000FF000000FF000000FF000000000000000000000000000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      00FF000000FF000000FF000000FF000000000000000000000000000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      00000000000000000000000000FF000000FF00000000000000FF000000FF8080
      80FF000000000000000000000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000000000000000000000000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      00000000000000000000808080FF000000FF000000FF000000FF000000FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000000000000000000000000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000FF000000FF000000FF808080FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00FF000000FF000000FF000000FF000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000FF0000
      00FF000000FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080FF000000FF000000FF000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000FF000000FF0000
      00FF000000FF000000FF000000FF00000000000000FF000000FF000000FF0000
      00FF000000FF000000FF00000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000FF808080FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000}
  end
  object PopupMenu1: TPopupActionBar
    OnPopup = PopupMenu1Popup
    Left = 48
    Top = 256
    object Popup_Undo: TMenuItem
      Caption = 'Undo'
      Hint = 'Undo last action.'
      ShortCut = 16474
      OnClick = Popup_UndoClick
    end
    object Popup_Redo: TMenuItem
      Caption = 'Redo'
      Hint = 'Redo last undone action.'
      ShortCut = 16473
      OnClick = Popup_RedoClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Popup_Cut: TMenuItem
      Caption = 'Cut'
      Hint = 'Cut the selected text to the clipboard.'
      ShortCut = 16472
      OnClick = Popup_CutClick
    end
    object Popup_Copy: TMenuItem
      Caption = 'Copy'
      Hint = 'Copy the selected text to the clipboard.'
      ShortCut = 16451
      OnClick = Popup_CopyClick
    end
    object Popup_Paste: TMenuItem
      Caption = 'Paste'
      Hint = 'Paste the contents of the clipboard.'
      ShortCut = 16470
      OnClick = Popup_PasteClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Popup_PasteSpecial: TMenuItem
      Caption = 'Paste special...'
      Hint = 'Select which clipboard representation you want to paste.'
      OnClick = Popup_PasteSpecialClick
    end
    object Popup_InsertObject: TMenuItem
      Caption = 'Insert object...'
      Hint = 'Create a new OLE object.'
      OnClick = Popup_InsertObjectClick
    end
    object Popup_EditObject: TMenuItem
      Caption = 'Edit object'
      Hint = 'Edit selected OLE object.'
      OnClick = Popup_EditObjectClick
    end
  end
  object SymbolDialog1: TSymbolDialog
    FontName = 'Symbol'
    CharacterSet = csUnicodeSet
    OnShow = SymbolDialog1Show
    OnInsertAnsiChar = SymbolDialog1InsertAnsiChar
    OnInsertWideChar = SymbolDialog1InsertWideChar
    Left = 88
    Top = 256
  end
end
