object Form20: TForm20
  Left = 452
  Top = 191
  HelpContext = 160
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Animation'
  ClientHeight = 398
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  ShowHint = True
  OnClose = TntFormClose
  DesignSize = (
    384
    398)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 8
    Top = 8
    Width = 369
    Height = 305
    Anchors = [akLeft, akTop, akRight, akBottom]
    PopupMenu = PopupMenu1
    TabOrder = 0
  end
  object TrackBar1: TTrackBar
    Left = 8
    Top = 320
    Width = 369
    Height = 33
    Anchors = [akLeft, akRight, akBottom]
    PopupMenu = PopupMenu1
    TabOrder = 1
    OnChange = TrackBar1Change
    OnKeyPress = TrackBar1KeyPress
  end
  object Panel2: TPanel
    Left = 8
    Top = 360
    Width = 185
    Height = 41
    Anchors = [akLeft, akBottom]
    BevelOuter = bvNone
    TabOrder = 2
    object ToolBar1: TToolBar
      Left = 0
      Top = 0
      Width = 177
      Height = 33
      Align = alNone
      ButtonHeight = 28
      ButtonWidth = 28
      EdgeInner = esNone
      EdgeOuter = esNone
      Images = ImageList1
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Hint = 'Play'
        ImageIndex = 0
        OnClick = ToolButton1Click
      end
      object ToolButton2: TToolButton
        Left = 28
        Top = 0
        Hint = 'Pause'
        Enabled = False
        ImageIndex = 1
        OnClick = ToolButton2Click
      end
      object ToolButton3: TToolButton
        Left = 56
        Top = 0
        Hint = 'Stop'
        Enabled = False
        ImageIndex = 2
        OnClick = ToolButton3Click
      end
      object ToolButton4: TToolButton
        Left = 84
        Top = 0
        Hint = 'Back'
        ImageIndex = 6
        OnClick = ToolButton7Click
      end
      object ToolButton5: TToolButton
        Left = 112
        Top = 0
        Hint = 'Step'
        ImageIndex = 5
        OnClick = ToolButton6Click
      end
      object ToolButton6: TToolButton
        Left = 140
        Top = 0
        Hint = 'Options'
        DropdownMenu = PopupMenu1
        ImageIndex = 7
        OnClick = ToolButton6Click
      end
    end
  end
  object LabeledEdit1: TLabeledEdit
    Left = 304
    Top = 368
    Width = 73
    Height = 21
    Anchors = [akRight, akBottom]
    Color = clBtnFace
    EditLabel.Width = 62
    EditLabel.Height = 13
    EditLabel.Caption = 'LabeledEdit1'
    LabelPosition = lpLeft
    ReadOnly = True
    TabOrder = 3
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'avi'
    Filter = 'Audio Video Interleave [*.avi]|*.avi'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofNoReadOnlyReturn, ofEnableSizing, ofDontAddToRecent]
    Left = 16
    Top = 16
  end
  object PopupMenu1: TPopupMenu
    Left = 80
    Top = 16
    object Speed1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Speed'
      object N101: TMenuItem
        AutoCheck = True
        Caption = '10%'
        GroupIndex = 1
        Hint = 'Change the speed used to play the animation.'
        RadioItem = True
        OnClick = SpeedClick
      end
      object N501: TMenuItem
        AutoCheck = True
        Caption = '50%'
        GroupIndex = 1
        Hint = 'Change the speed used to play the animation.'
        RadioItem = True
        OnClick = SpeedClick
      end
      object N1001: TMenuItem
        AutoCheck = True
        Caption = '100%'
        Checked = True
        GroupIndex = 1
        Hint = 'Change the speed used to play the animation.'
        RadioItem = True
        OnClick = SpeedClick
      end
      object N1501: TMenuItem
        AutoCheck = True
        Caption = '150%'
        GroupIndex = 1
        Hint = 'Change the speed used to play the animation.'
        RadioItem = True
        OnClick = SpeedClick
      end
      object N2001: TMenuItem
        AutoCheck = True
        Caption = '200%'
        GroupIndex = 1
        Hint = 'Change the speed used to play the animation.'
        RadioItem = True
        OnClick = SpeedClick
      end
      object N10001: TMenuItem
        AutoCheck = True
        Caption = '1000%'
        GroupIndex = 1
        Hint = 'Change the speed used to play the animation.'
        RadioItem = True
        OnClick = SpeedClick
      end
    end
    object Repeat1: TMenuItem
      AutoCheck = True
      Caption = 'Repeat'
      Hint = 'Repeat playing the animation until manually stopped.'
    end
    object Reverse1: TMenuItem
      AutoCheck = True
      Caption = 'Auto reverse'
      Hint = 
        'Play backwards when the end of the animation is reached. This is' +
        ' most useful in combination with the "Repeat" command.'
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Save1: TMenuItem
      Caption = 'Save as...'
      Hint = 'Save the animation to a file.'
      ShortCut = 16467
      OnClick = Save1Click
    end
    object Saveimageas1: TMenuItem
      Caption = 'Save frame...'
      Hint = 'Save the shown frame to an image file.'
      ShortCut = 16450
      OnClick = Saveimageas1Click
    end
    object Saveimagesequence1: TMenuItem
      Caption = 'Save all frames...'
      Hint = 
        'Save all frames in the animation to image files. This will creat' +
        'e as many files as there are frames in the animation.'
      OnClick = Saveimagesequence1Click
    end
  end
  object ImageList1: TImageList
    Height = 18
    Width = 18
    Left = 112
    Top = 16
    Bitmap = {
      494C010108000A00040012001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000048000000360000000100100000000000601E
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000001042FF7FFF7F00000000000000000000000000000000000000000000
      FF7FFF7F00001042FF7FFF7F0000FF7FFF7F0000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF7F
      FF7F0000FF7FFF7FFF7F00000000000000008E318E318E318E310000B57FB57F
      B57FB57F0E6F00008E318E31000000000000000010421F00FF7F000000000000
      000000000000000000000000FF7FFF7F1F00FF7F000010421F00FF7F00001042
      1F00FF7FFF7F0000000000000000000000000000000000000000000000000000
      00000000000000000000FF7FFF7F1F00FF7F000010421F00FF7F000000000000
      0000D035FF7FFF7F0000B57FB57FB57FB57FB57FB57F0E6F0000D03500000000
      0000000010421F00FF7F0000000000000000000000000000FF7FFF7F1F001F00
      1F00FF7F000010421F00FF7F000010421F001F001F00FF7FFF7F000000000000
      00000000000000000000000000000000000000000000FF7FFF7F1F001F001F00
      FF7F000010421F00FF7F0000000000000000F13DFF7F2B21B57FB57FB57FB57F
      B57FB57FB57F0E6F0000F13D000000000000000010421F00FF7F000000000000
      00000000FF7FFF7F1F001F001F001F001F00FF7F000010421F00FF7F00001042
      1F001F001F001F001F00FF7FFF7F000000000000000000000000000000000000
      0000FF7FFF7F1F001F001F001F001F00FF7F000010421F00FF7F000000000000
      00003342FF7F2B21B57F0000B57FB57FB57FB57FB57FB57F0000334200000000
      0000000010421F00FF7F000000000000FF7FFF7F1F001F001F001F001F001F00
      1F00FF7F000010421F00FF7F000010421F001F001F001F001F001F001F00FF7F
      FF7F000000000000000000000000FF7FFF7F1F001F001F001F001F001F001F00
      FF7F000010421F00FF7F0000000000000000744AFF7F2B21B57F0000B57F0000
      B57F0000B57F0000DE7B744A000000000000000010421F00FF7F00000000FF7F
      1F001F001F001F001F001F001F001F001F00FF7F000010421F00FF7F00001042
      1F001F001F001F001F001F001F001F001F00FF7FFF7F000000000000FF7F1F00
      1F001F001F001F001F001F001F001F00FF7F000010421F00FF7F000000000000
      00009552FF7FFF7F2B212B21B57F0000B57F0000B57F0000DE7B955200000000
      0000000010421F00FF7F0000104210421F001F001F001F001F001F001F001F00
      1F00FF7F000010421F00FF7F000010421F001F001F001F001F001F001F001F00
      1F0010421042FF7F0000104210421F001F001F001F001F001F001F001F001F00
      FF7F000010421F00FF7F00000000000000009552FF7FFF7FFF7F2B21B57F0000
      2B212B212B21FF7FFF7F9552000000000000000010421F00FF7F000000000000
      104210421F001F001F001F001F001F001F00FF7F000010421F00FF7F00001042
      1F001F001F001F001F001F001F00104210420000000000000000000000001042
      10421F001F001F001F001F001F001F00FF7F000010421F00FF7F000000000000
      00009552FF7FFF7FFF7F2B21B57F0000DE7BFF7FFF7FFF7FFF7F955200000000
      0000000010421F00FF7F00000000000000000000104210421F001F001F001F00
      1F00FF7F000010421F00FF7F000010421F001F001F001F001F00104210420000
      000000000000000000000000000000000000104210421F001F001F001F001F00
      FF7F000010421F00FF7F00000000000000009552FF7FFF7FFF7F2B21B57F0000
      DE7BFF7FFF7FFF7FFF7F9552000000000000000010421F00FF7F000000000000
      0000000000000000104210421F001F001F00FF7F000010421F00FF7F00001042
      1F001F001F001042104200000000000000000000000000000000000000000000
      000000000000104210421F001F001F00FF7F000010421F00FF7F000000000000
      00009552FF7FFF7FFF7F2B21B57F0000DE7BFF7FFF7FFF7FFF7F955200000000
      0000000010421F00FF7F00000000000000000000000000000000000010421042
      1F00FF7F000010421F00FF7F000010421F001042104200000000000000000000
      0000000000000000000000000000000000000000000000000000104210421F00
      FF7F000010421F00FF7F00000000000000009552FF7FFF7FFF7FF13D2B21F13D
      FF7FFF7FDE7BDE7BDE7B5446000000000000000010421042FF7F000000000000
      000000000000000000000000000000001042FF7F000010421042FF7F00001042
      1042000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000001042FF7F0000104210421042000000000000
      00009552FF7FFF7FFF7FFF7FFF7FFF7FFF7F54468E318E318E318E3100000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009552FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F9552FF7FFF7FDE7BCF350000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009552FF7FFF7FFF7FFF7FFF7FFF7FFF7F9552FF7FDE7BCF35000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009552FF7FFF7FFF7FFF7FFF7FFF7F
      FF7F9552DE7BCF35000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000955254465446544654465446544654469552CF3500000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF7F00000000000000000000000000000000000000000000
      00000000000000000000000000001042FF7FFF7FFF7F00001042FF7FFF7FFF7F
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF7F0000000000000000000000000000
      000000000000000000001042FF7FFF7F0000000000001042E003FF7FFF7F0000
      0000000000000000000000000000000000000000000000000000000000001042
      E07FE07FFF7F00001042E07FE07FFF7F00000000000000000000000000000000
      FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F0000000000001042
      1F00FF7FFF7F000000000000000000000000000000000000000010421F00FF7F
      0000000000001042E003E003E003FF7FFF7F0000000000000000000000000000
      00000000000000000000000000001042E07FE07FFF7F00001042E07FE07FFF7F
      00000000000000000000000000001042007C007C007C007C007C007C007C007C
      007C007C007CFF7F00000000000010421F001F001F00FF7FFF7F000000000000
      0000000000000000000010421F00FF7F0000000000001042E003E003E003E003
      E003FF7FFF7F0000000000000000000000000000000000000000000000001042
      E07FE07FFF7F00001042E07FE07FFF7F00000000000000000000000000001042
      007C007C007C007C007C007C007C007C007C007C007CFF7F0000000000001042
      1F001F001F001F001F00FF7FFF7F00000000000000000000000010421F00FF7F
      0000000000001042E003E003E003E003E003E003E003FF7FFF7F000000000000
      00000000000000000000000000001042E07FE07FFF7F00001042E07FE07FFF7F
      00000000000000000000000000001042007C007C007C007C007C007C007C007C
      007C007C007CFF7F00000000000010421F001F001F001F001F001F001F00FF7F
      FF7F000000000000000010421F00FF7F0000000000001042E003E003E003E003
      E003E003E003E003E003FF7FFF7F000000000000000000000000000000001042
      E07FE07FFF7F00001042E07FE07FFF7F00000000000000000000000000001042
      007C007C007C007C007C007C007C007C007C007C007CFF7F0000000000001042
      1F001F001F001F001F001F001F001F001F00FF7FFF7F0000000010421F00FF7F
      0000000000001042E003E003E003E003E003E003E003E003E00310421042FF7F
      00000000000000000000000000001042E07FE07FFF7F00001042E07FE07FFF7F
      00000000000000000000000000001042007C007C007C007C007C007C007C007C
      007C007C007CFF7F00000000000010421F001F001F001F001F001F001F001F00
      1F0010421042FF7F000010421F00FF7F0000000000001042E003E003E003E003
      E003E003E0031042104200000000000000000000000000000000000000001042
      E07FE07FFF7F00001042E07FE07FFF7F00000000000000000000000000001042
      007C007C007C007C007C007C007C007C007C007C007CFF7F0000000000001042
      1F001F001F001F001F001F001F0010421042000000000000000010421F00FF7F
      0000000000001042E003E003E003E003E0031042104200000000000000000000
      00000000000000000000000000001042E07FE07FFF7F00001042E07FE07FFF7F
      00000000000000000000000000001042007C007C007C007C007C007C007C007C
      007C007C007CFF7F00000000000010421F001F001F001F001F00104210420000
      0000000000000000000010421F00FF7F0000000000001042E003E003E0031042
      1042000000000000000000000000000000000000000000000000000000001042
      E07FE07FFF7F00001042E07FE07FFF7F00000000000000000000000000001042
      007C007C007C007C007C007C007C007C007C007C007CFF7F0000000000001042
      1F001F001F00104210420000000000000000000000000000000010421F00FF7F
      0000000000001042E00310421042000000000000000000000000000000000000
      00000000000000000000000000001042E07FE07FFF7F00001042E07FE07FFF7F
      0000000000000000000000000000104210421042104210421042104210421042
      104210421042000000000000000010421F001042104200000000000000000000
      0000000000000000000010421F00FF7F00000000000010421042000000000000
      0000000000000000000000000000000000000000000000000000000000001042
      10421042FF7F0000104210421042FF7F00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001042
      104200000000000000000000000000000000000000000000000010421042FF7F
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000048000000360000000100010000000000880200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFFFFFFFFFFF0000008FFE44FFFFFC8F0007000000
      8FF8443FFFF08F00070000008FE0440FFFC08F00070000008F804403FF008F00
      070000008E004400FC008F00070000008C00440038008F000700000088004400
      10008F00070000008E004400FC008F00070000008F804403FF008F0007000000
      8FE0440FFFC08F00070000008FF8443FFFF08F00070000008FFE44FFFFFC8F00
      07000000FFFFFFFFFFFFFF0007000000FFFFFFFFFFFFFF000F000000FFFFFFFF
      FFFFFF001F000000FFFFFFFFFFFFFF003F000000FFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFF000000EFFFFC21FFFFFEFFF1000000C3FFFC21FE001C3F
      F1000000C0FFFC21FC001C0FF1000000C03FFC21FC001C03F1000000C00FFC21
      FC001C00F1000000C003FC21FC001C0031000000C001FC21FC001C0011000000
      C00FFC21FC001C00F1000000C03FFC21FC001C03F1000000C0FFFC21FC001C0F
      F1000000C3FFFC21FC003C3FF1000000CFFFFC21FFFFFCFFF1000000FFFFFFFF
      FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF0000000000000000000000
      0000000000000000000000000000}
  end
  object MediaPlayer1: TMediaPlayerEx
    Display = Panel1
    AutoRewind = True
    OnSignal = MediaPlayer1Signal
    OnNotify = MediaPlayer1Notify
    Left = 144
    Top = 16
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = 'png'
    Filter = 
      'Windows Bitmap [*.bmp]|*.bmp|Portable Network Graphics [*.png]|*' +
      '.png|Joint Photographic Experts Group [*.jpg, *.jpeg]|*.jpg;*.jp' +
      'eg'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofNoReadOnlyReturn, ofEnableSizing, ofDontAddToRecent]
    Left = 48
    Top = 16
  end
end
