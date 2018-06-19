object EventData: TEventData
  Left = 0
  Top = 0
  Width = 1084
  Height = 583
  TabOrder = 0
  OnResize = FrameResize
  object cxPages: TcxPageControl
    Left = 0
    Top = 0
    Width = 1084
    Height = 583
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = cxTabBase
    Properties.CustomButtons.Buttons = <>
    Properties.TabPosition = tpBottom
    ClientRectBottom = 559
    ClientRectLeft = 4
    ClientRectRight = 1080
    ClientRectTop = 4
    object cxTabBase: TcxTabSheet
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1080
      ImageIndex = 0
      object cxGroupProgram: TcxGroupBox
        Left = 362
        Top = -3
        Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
        TabOrder = 0
        Height = 322
        Width = 445
        object cxGrid: TcxGrid
          Left = 7
          Top = 16
          Width = 431
          Height = 295
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
      object pnlLeft: TPanel
        Left = 0
        Top = 0
        Width = 361
        Height = 555
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
        object cxGroupInfo: TcxGroupBox
          Left = 0
          Top = -3
          Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1080
          TabOrder = 0
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
        object cxGroupDescr: TcxGroupBox
          Left = 0
          Top = 164
          Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
          TabOrder = 1
          Height = 144
          Width = 354
          object cxDescr: TcxMemo
            Left = 7
            Top = 18
            Properties.ScrollBars = ssVertical
            TabOrder = 0
            Height = 119
            Width = 342
          end
        end
      end
    end
    object cxTabMap: TcxTabSheet
      Caption = #1050#1072#1088#1090#1072
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object dxMap: TdxMapControl
        Left = 0
        Top = 0
        Width = 1076
        Height = 555
        Align = alClient
        NavigationPanel.Visible = False
        TabOrder = 0
        ExplicitLeft = 256
        ExplicitTop = 304
        ExplicitWidth = 400
        ExplicitHeight = 200
        object dxMapDataProvider: TdxMapImageTileLayer
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
end
