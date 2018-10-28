object FrmEditPeriod: TFrmEditPeriod
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 194
  ClientWidth = 289
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxGPData: TcxGroupBox
    Left = 7
    Top = 4
    Caption = 'Period data'
    TabOrder = 0
    Height = 153
    Width = 274
    object cxLabel1: TcxLabel
      Left = 6
      Top = 15
      Caption = 'Period name:'
    end
    object cxPeriodName: TcxTextEdit
      Left = 7
      Top = 32
      TabOrder = 1
      Width = 258
    end
    object cxLabel2: TcxLabel
      Left = 6
      Top = 57
      Caption = 'Period start:'
    end
    object cxDateStart: TcxDateEdit
      Left = 7
      Top = 77
      Properties.Kind = ckDateTime
      TabOrder = 3
      Width = 258
    end
  end
  object cxLabel3: TcxLabel
    Left = 13
    Top = 105
    Caption = 'Period end:'
  end
  object cxDateEnd: TcxDateEdit
    Left = 14
    Top = 125
    Properties.Kind = ckDateTime
    TabOrder = 2
    Width = 258
  end
  object cxOK: TcxButton
    Left = 125
    Top = 163
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = cxOKClick
  end
  object cxCancel: TcxButton
    Left = 206
    Top = 163
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
    OnClick = cxCancelClick
  end
end
