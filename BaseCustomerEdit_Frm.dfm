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
    Left = 0
    Top = 0
    Width = 621
    Height = 426
    ExplicitLeft = 0
    ExplicitTop = 0
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
        6100000044744558745469746C6500436F6E646974696F6E616C466F726D6174
        74696E7349636F6E536574526564546F426C61636B343B436F6E646974696F6E
        616C466F726D617474696E673B98A0D4C8000002D249444154785E4D904D685C
        5518869F7373D330C9CC346D8DC224216A37D5858A228822940856A9687ECD4C
        4B25585D68144A8A15244A37AE224840574550680B75E1602A81800846D4855D
        B8C8A2D4D8665A4D9BA449E6CE4C66EEBD73EEF99CCB3D48CFE1E17DCFE17BBF
        8F73902F67620014D076757C64E8467EECDCCD63AF5F593B3E11940AE357AE4F
        8C9E5B1E191A065C40C9DC19626E4D8CF17F78FEC5177A57F363F3EB6F9D90FA
        D9F7447FF681C8DC872D3D2DF54FA6E4F664415646872E5F3AFC7C1FE0C8EC34
        ABA3C300A85F8EBEF468293FBA519E3E2966F694C8C79322670A22D3E322A7F3
        221F9D10F3E9946CBF3F292BC3AFAE5F7CEED9070167E5B5575047FB7A53734F
        3FF57BCFC1FB1FCFA6814A192203825D0262C000D92C5E0D56AF6D2C3CB1B838
        0284EA8F2347DECCF564BFCA0D7442C54B02912401654004B0670C7465289502
        AEAF974F0EFEBAF48DDB81E4D3FBDA61671B8C80DC8B4930582FE06FB237DB4D
        E71D8E01175C9AD19329F1210C40489A609267401232366C7D574795B6307A0C
        687325D007DCDD2A441AB0C546126F9B8808AA8518137B5C1DA1B5E9069413F8
        CD6D5D6B40D08430408216CDB0A521E8F82E44B520C6FA60D727F49B1E805B0B
        FD3FBD5AC7E0FE94C651A0A2640A765A0CB11A00414542B9EE50F5F53220EE46
        3D28AEADABC103398D510206C4181050242A221069C4FA7FB6DAB9DDF0BF059A
        EECCADBFCF7FA11F9ADABFC73994DB2B104560042199AEAC62042258AB4069CB
        FCF8F6E68DF380765742BFF65BD57BC3D1E985A06EEE1BD86750F6D789C56EA3
        E1A6A7B876D7D95AAC7BA780C60FDD03D206C8CF8DEA467B24C554C37DA4E2F1
        B0AB22DA89708D21080D772BB07C07AEEEF053B1E18D7FED97FF02A2BC9B8166
        E1190005B840E6F3AE07DEB998EE5B2A667A77E6D3FDF25D3AB773A133B7349B
        EA7917C8DA3A15BE7C90622A87FA3EDD0F806018AAFDAB803D16D73616400361
        4C2B24DCB3FE03F304B94D918F11270000000049454E44AE426082}
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
