object EventData: TEventData
  Left = 0
  Top = 0
  Width = 1193
  Height = 576
  TabOrder = 0
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 361
    Height = 576
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object cxGroupBox1: TcxGroupBox
      Left = 4
      Top = 175
      Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
      TabOrder = 0
      Height = 394
      Width = 354
      object cxDescr: TcxMemo
        Left = 7
        Top = 17
        TabOrder = 0
        Height = 367
        Width = 342
      end
    end
    object cxGroupBox2: TcxGroupBox
      Left = 4
      Top = 1
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1080
      TabOrder = 1
      Height = 168
      Width = 354
      object cxEvtData: TcxVerticalGrid
        Left = 7
        Top = 16
        Width = 342
        Height = 145
        OptionsView.RowHeaderWidth = 178
        TabOrder = 0
        Version = 1
        object cxEvtDataCategoryRow1: TcxCategoryRow
          Properties.Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
          ID = 0
          ParentID = -1
          Index = 0
          Version = 1
        end
        object cxEvtName: TcxEditorRow
          Properties.Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 1
          ParentID = 0
          Index = 0
          Version = 1
        end
        object cxEvtDateStart: TcxEditorRow
          Properties.Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
          Properties.EditPropertiesClassName = 'TcxDateEditProperties'
          Properties.DataBinding.ValueType = 'DateTime'
          Properties.Value = 0d
          ID = 2
          ParentID = 0
          Index = 1
          Version = 1
        end
        object cxEvtDateEnd: TcxEditorRow
          Properties.Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
          Properties.EditPropertiesClassName = 'TcxDateEditProperties'
          Properties.DataBinding.ValueType = 'DateTime'
          Properties.Value = 0d
          ID = 3
          ParentID = 0
          Index = 2
          Version = 1
        end
        object cxEvtInternal: TcxEditorRow
          Properties.Caption = #1058#1086#1083#1100#1082#1086' '#1076#1083#1103' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1086#1074
          Properties.EditPropertiesClassName = 'TcxCheckBoxProperties'
          Properties.DataBinding.ValueType = 'Boolean'
          Properties.Value = False
          ID = 4
          ParentID = 0
          Index = 3
          Version = 1
        end
        object cxEvtAddress: TcxEditorRow
          Properties.Caption = #1040#1076#1088#1077#1089' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103
          Properties.DataBinding.ValueType = 'String'
          Properties.Value = Null
          ID = 5
          ParentID = 0
          Index = 4
          Version = 1
        end
      end
    end
  end
  object pnlHost: TPanel
    Left = 361
    Top = 0
    Width = 832
    Height = 576
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      832
      576)
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 832
      Height = 305
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      DesignSize = (
        832
        305)
      object cxGroupBox3: TcxGroupBox
        Left = 6
        Top = 1
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
        TabOrder = 0
        DesignSize = (
          820
          296)
        Height = 296
        Width = 820
        object cxGrid: TcxGrid
          Left = 7
          Top = 16
          Width = 806
          Height = 272
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          object cxView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
          end
          object cxLevel: TcxGridLevel
            GridView = cxView
          end
        end
      end
    end
    object dxMapControl1: TdxMapControl
      Left = 6
      Top = 305
      Width = 819
      Height = 264
      Anchors = [akLeft, akTop, akRight, akBottom]
      CenterPoint.Longitude = 54.980000000000000000
      CenterPoint.Latitude = 55.970000000000000000
      NavigationPanel.Visible = False
      TabOrder = 1
      ZoomLevel = 18.000000000000000000
      object dxMapLayer: TdxMapImageTileLayer
        ProviderClassName = 'TdxMapControlOpenStreetMapImageryDataProvider'
        Provider.Subdomains.Strings = (
          'a'
          'b'
          'c')
        Provider.UrlTemplate = 'http://[subdomain].tile.openstreetmap.org/[z]/[x]/[y].png'
      end
    end
  end
end
