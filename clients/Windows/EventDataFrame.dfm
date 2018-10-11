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
            DataController.DataSource = dsPeriods
            DataController.KeyFieldNames = 'clID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            object cxViewclID: TcxGridDBColumn
              Caption = 'ID'
              DataBinding.FieldName = 'clID'
              Visible = False
            end
            object cxViewclName: TcxGridDBColumn
              Caption = 'Name'
              DataBinding.FieldName = 'clName'
              Width = 500
            end
            object cxViewclStart: TcxGridDBColumn
              Caption = 'Start'
              DataBinding.FieldName = 'clStart'
              Width = 100
            end
            object cxViewclEnd: TcxGridDBColumn
              Caption = 'End'
              DataBinding.FieldName = 'clEnd'
              Width = 100
            end
          end
          object cxActView: TcxGridDBTableView
            Navigator.Buttons.CustomButtons = <>
            Navigator.Buttons.First.Visible = True
            Navigator.Buttons.PriorPage.Visible = True
            Navigator.Buttons.Prior.Visible = True
            Navigator.Buttons.Next.Visible = True
            Navigator.Buttons.NextPage.Visible = True
            Navigator.Buttons.Last.Visible = True
            Navigator.Buttons.Insert.Visible = True
            Navigator.Buttons.Append.Visible = False
            Navigator.Buttons.Delete.Visible = True
            Navigator.Buttons.Edit.Visible = True
            Navigator.Buttons.Post.Visible = True
            Navigator.Buttons.Cancel.Visible = True
            Navigator.Buttons.Refresh.Visible = True
            Navigator.Buttons.SaveBookmark.Visible = True
            Navigator.Buttons.GotoBookmark.Visible = True
            Navigator.Buttons.Filter.Visible = True
            DataController.DataSource = dsActions
            DataController.DetailKeyFieldNames = 'clPeriodId'
            DataController.KeyFieldNames = 'clActID'
            DataController.MasterKeyFieldNames = 'clID'
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.Deleting = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            object cxActIDCol: TcxGridDBColumn
              DataBinding.FieldName = 'clActID'
              Visible = False
            end
            object cxActPerIdCol: TcxGridDBColumn
              DataBinding.FieldName = 'clPeriodId'
              Visible = False
            end
            object cxActNameCol: TcxGridDBColumn
              Caption = 'Name'
              DataBinding.FieldName = 'clName'
              Width = 200
            end
            object cxActDescCol: TcxGridDBColumn
              Caption = 'Description'
              DataBinding.FieldName = 'clDescription'
              Width = 500
            end
            object cxActStartCol: TcxGridDBColumn
              Caption = 'Start'
              DataBinding.FieldName = 'clStart'
              Width = 80
            end
            object cxActEndCol: TcxGridDBColumn
              Caption = 'End'
              DataBinding.FieldName = 'clEnd'
              Width = 80
            end
            object cxActLocCol: TcxGridDBColumn
              Caption = 'Location'
              DataBinding.FieldName = 'clLocation'
              Width = 500
            end
          end
          object cxPeriods: TcxGridLevel
            GridView = cxView
            object cxActions: TcxGridLevel
              GridView = cxActView
            end
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
      object dxMap: TdxMapControl
        Left = 0
        Top = 0
        Width = 1076
        Height = 555
        Align = alClient
        NavigationPanel.Visible = False
        TabOrder = 0
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
  object dsPeriods: TDataSource
    DataSet = clPeriods
    Left = 24
    Top = 320
  end
  object clPeriods: TClientDataSet
    PersistDataPacket.Data = {
      600000009619E0BD010000001800000004000000000003000000600004636C49
      44040001000000000006636C4E616D6502004900000001000557494454480200
      0200F40107636C5374617274080008000000000005636C456E64080008000000
      00000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'clID'
        DataType = ftInteger
      end
      item
        Name = 'clName'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'clStart'
        DataType = ftDateTime
      end
      item
        Name = 'clEnd'
        DataType = ftDateTime
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 56
    Top = 320
  end
  object dsActions: TDataSource
    DataSet = clActions
    Left = 23
    Top = 351
  end
  object clActions: TClientDataSet
    PersistDataPacket.Data = {
      B70000009619E0BD010000001800000007000000000003000000B70007636C41
      6374494404000100000000000A636C506572696F644964040001000000000006
      636C4E616D65020049000000010005574944544802000200F4010D636C446573
      6372697074696F6E020049000000010005574944544802000200F40107636C53
      74617274080008000000000005636C456E6408000800000000000A636C4C6F63
      6174696F6E020049000000010005574944544802000200F4010000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'clActID'
        DataType = ftInteger
      end
      item
        Name = 'clPeriodId'
        DataType = ftInteger
      end
      item
        Name = 'clName'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'clDescription'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'clStart'
        DataType = ftDateTime
      end
      item
        Name = 'clEnd'
        DataType = ftDateTime
      end
      item
        Name = 'clLocation'
        DataType = ftString
        Size = 500
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 55
    Top = 352
  end
end
