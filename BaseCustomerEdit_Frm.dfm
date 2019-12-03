inherited BaseCustomerEditFrm: TBaseCustomerEditFrm
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'mydbl'
  ClientHeight = 509
  ClientWidth = 820
  ExplicitWidth = 826
  ExplicitHeight = 538
  PixelsPerInch = 96
  TextHeight = 13
  inherited layMain: TdxLayoutControl
    Width = 621
    Height = 426
    ExplicitWidth = 621
    ExplicitHeight = 426
    object lblHeaderTitle: TcxLabel [0]
      Left = 11
      Top = 11
      Caption = 'Banking Details'
      ParentFont = False
      Style.HotTrack = False
      Style.StyleController = styHeaderFont
      Transparent = True
    end
    object btnOK: TcxButton [1]
      Left = 454
      Top = 390
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object btnCancel: TcxButton [2]
      Left = 535
      Top = 390
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
    object lblLegend: TcxLabel [3]
      Left = 31
      Top = 394
      Caption = 'Required fields'
      Style.HotTrack = False
      Transparent = True
    end
    object lblRequired: TcxLabel [4]
      Left = 11
      Top = 391
      Caption = '*'
      ParentFont = False
      Style.HotTrack = False
      Style.StyleController = styMandatory
      Properties.Alignment.Vert = taVCenter
      Transparent = True
      AnchorY = 403
    end
    object lblSubTitle: TcxDBLabel [5]
      Left = 21
      Top = 37
      DataBinding.DataField = 'NAME'
      DataBinding.DataSource = MTDM.dtsCustomer
      ParentFont = False
      Style.HotTrack = False
      Style.StyleController = stySubTitle
      Transparent = True
      Height = 21
      Width = 589
    end
    object grpHeader: TdxLayoutGroup
      Parent = layMainGroup_Root
      CaptionOptions.Text = 'New Group'
      ButtonOptions.Buttons = <>
      ItemIndex = 2
      ShowBorder = False
      Index = 0
    end
    object grpData: TdxLayoutGroup
      Parent = layMainGroup_Root
      CaptionOptions.Text = 'New Group'
      ButtonOptions.Buttons = <>
      ShowBorder = False
      Index = 1
    end
    object grpButtons: TdxLayoutGroup
      Parent = layMainGroup_Root
      AlignVert = avBottom
      CaptionOptions.Text = 'New Group'
      ButtonOptions.Buttons = <>
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 3
    end
    object sep01: TdxLayoutSeparatorItem
      Parent = layMainGroup_Root
      AlignVert = avBottom
      CaptionOptions.Text = 'Separator'
      Index = 2
    end
    object litSave: TdxLayoutItem
      Parent = grpButtons
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnOK
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object litCancel: TdxLayoutItem
      Parent = grpButtons
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnCancel
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object litHeaderTitle: TdxLayoutItem
      Parent = grpHeader
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = lblHeaderTitle
      ControlOptions.OriginalHeight = 20
      ControlOptions.OriginalWidth = 116
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object litSubTitle: TdxLayoutItem
      Parent = grpHeader
      Offsets.Left = 10
      Control = lblSubTitle
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object litLegend: TdxLayoutItem
      Parent = grpButtons
      AlignVert = avCenter
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = lblLegend
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 89
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object litRequired: TdxLayoutItem
      Parent = grpButtons
      AlignVert = avCenter
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = lblRequired
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 14
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object sep2: TdxLayoutSeparatorItem
      Parent = grpHeader
      CaptionOptions.Text = 'Separator'
      Index = 2
    end
  end
  inherited styRepository: TcxStyleRepository
    PixelsPerInch = 96
  end
  inherited lafLayoutList: TdxLayoutLookAndFeelList
    inherited lafCustomSkin: TdxLayoutSkinLookAndFeel
      PixelsPerInch = 96
    end
  end
  inherited img16: TcxImageList
    FormatVersion = 1
  end
  inherited img32: TcxImageList
    FormatVersion = 1
  end
  object styHintController: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TdxScreenTipStyle'
    HintStyle.ScreenTipLinks = <>
    HintStyle.ScreenTipActionLinks = <>
    HintShortPause = 0
    HintPause = 0
    HintHidePause = 3000
    Left = 575
    Top = 329
  end
  object repScreenTip: TdxScreenTipRepository
    AssignedFonts = [stbHeader, stbDescription, stbFooter]
    DescriptionFont.Charset = ANSI_CHARSET
    DescriptionFont.Color = 5000268
    DescriptionFont.Height = -11
    DescriptionFont.Name = 'Verdana'
    DescriptionFont.Style = []
    FooterFont.Charset = ANSI_CHARSET
    FooterFont.Color = 5000268
    FooterFont.Height = -12
    FooterFont.Name = 'Verdana'
    FooterFont.Style = [fsBold]
    HeaderFont.Charset = ANSI_CHARSET
    HeaderFont.Color = 5000268
    HeaderFont.Height = -12
    HeaderFont.Name = 'Verdana'
    HeaderFont.Style = [fsBold]
    Left = 485
    Top = 330
    PixelsPerInch = 96
  end
  object stySubTitle: TcxEditStyleController
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -11
    Style.Font.Name = 'Verdana'
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Left = 450
    Top = 260
    PixelsPerInch = 96
  end
  object styHeaderFont: TcxEditStyleController
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Verdana'
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Left = 450
    Top = 205
    PixelsPerInch = 96
  end
  object styMandatory: TcxEditStyleController
    Style.Color = clRed
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clRed
    Style.Font.Height = -16
    Style.Font.Name = 'Tahoma'
    Style.Font.Style = [fsBold]
    Style.TextColor = clRed
    Style.IsFontAssigned = True
    Left = 524
    Top = 204
    PixelsPerInch = 96
  end
end
