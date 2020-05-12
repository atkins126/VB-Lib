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
      TabOrder = 2
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
      TabOrder = 3
    end
    object lblSubTitle: TcxDBLabel [3]
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
    inherited layMainGroup_Root: TdxLayoutGroup
      ItemIndex = 3
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
      Index = 1
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
      Index = 2
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
      CaptionOptions.Glyph.SourceDPI = 96
      CaptionOptions.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000001974455874536F6674776172650041646F626520496D616765526561
        647971C9653C0000000D744558745469746C65005265636F72643B61F05A1A00
        00021A49444154785EAD915F4853711CC5675CDA2A2246180549905BD94379E3
        A220D532D4ACB9B0F225A23F4241116E456F116668596B08455820482E2A2828
        58841425F4074DCD87B9BA45D3D9823518222151912FA7DFF932F2765F6B70B8
        87733EDF03F7CE01E09FF47F06745D771886217AD47CDA3970F1FC89C170FBD0
        50F8C2378A9E19BB3CC79BD9018FC723CF672DCD45FDE75A4793376F20D71BC3
        74DF634A3C337664C87ABDDED901B7DBEDE80936B95EB59C191DEFE9C6D7FBB7
        3115BD8EC9AECB14BD64EC1493B8753C348F377F06D4AFA037183A695EBD82C9
        EE4E6423AD180E1DC393C6468A9E997464C8F2C63AA0DDDBD5F06622D28E2FAD
        A730DC7404FD9D5D30DF7D8269A6C58F048F4A47862C6FAC03CE3BB58199F1C3
        FB903AB4174F0F1E402A994126374DD133938E8C627FF1C63AE08AFA6A663E34
        F8F13E5085079B37213D91456EEA87289DCA3293CEDCED47D457FD9D377F0D5C
        3336C407AB2BF176AB0FCFEBFD18084790F99CA3C4BFDC59271D19B2F60167DB
        AAD2B3B1B20AC42B2B90D8518B17F57578B8C547894F046AA42343D6FE0ADA9A
        F90B9775AC5C978CE90646369623BEBD0AE6FE3D14BD64EC143346D6FE110B94
        5CDB16159687979724EF96AC45DFFA52BC2ED329F1CC54374686ACFD6FA4E628
        2D58AACD2D0EB98B3ADA0A8B3F5E5AE2FD49D133634726CF3AAC03F264915F5F
        ACB442693545CF8C1D19B2F601ABF83A9A92530E44E235765690B7BF01D76404
        F64F3219EB0000000049454E44AE426082}
      CaptionOptions.Text = 'Required fields'
      ControlOptions.OriginalHeight = 17
      ControlOptions.OriginalWidth = 89
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
    Left = 295
    Top = 320
    PixelsPerInch = 96
  end
  inherited actList: TActionList
    Left = 210
    Top = 320
  end
  inherited lafLayoutList: TdxLayoutLookAndFeelList
    Left = 235
    Top = 210
    inherited lafCustomSkin: TdxLayoutSkinLookAndFeel
      PixelsPerInch = 96
    end
  end
  inherited img16: TcxImageList
    FormatVersion = 1
    DesignInfo = 20971595
  end
  inherited img32: TcxImageList
    FormatVersion = 1
    DesignInfo = 20971665
  end
  object styHintController: TcxHintStyleController
    Global = False
    HintStyleClassName = 'TdxScreenTipStyle'
    HintStyle.ScreenTipLinks = <>
    HintStyle.ScreenTipActionLinks = <>
    HintShortPause = 0
    HintPause = 0
    HintHidePause = 3000
    Left = 160
    Top = 264
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
    Left = 75
    Top = 265
    PixelsPerInch = 96
  end
  object stySubTitle: TcxEditStyleController
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -11
    Style.Font.Name = 'Verdana'
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Left = 160
    Top = 210
    PixelsPerInch = 96
  end
  object styHeaderFont: TcxEditStyleController
    Style.Font.Charset = ANSI_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Verdana'
    Style.Font.Style = [fsBold]
    Style.IsFontAssigned = True
    Left = 80
    Top = 210
    PixelsPerInch = 96
  end
end
