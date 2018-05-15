unit EventDataFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit, cxCalendar,
  cxCheckBox, cxVGrid, cxInplaceContainer, cxContainer, cxTextEdit, cxMemo,
  cxRichEdit, cxGroupBox, Vcl.ExtCtrls, dxMapControlTypes,
  dxMapControlOpenStreetMapImageryDataProvider, dxBingMapLocationDataService,
  dxBingMapRouteDataService, dxMapLayer, dxMapImageTileLayer, cxClasses,
  dxMapControlInformationProvider, dxMapControlBingMapInformationProviders,
  dxMapControl, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  Data.DB, cxDBData, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid;

type
  TEventData = class(TFrame)
    cxEvtData: TcxVerticalGrid;
    cxEvtDataCategoryRow1: TcxCategoryRow;
    cxEvtName: TcxEditorRow;
    cxEvtDateStart: TcxEditorRow;
    cxEvtDateEnd: TcxEditorRow;
    cxEvtAddress: TcxEditorRow;
    cxEvtDataEditorRow1: TcxEditorRow;
    pnlLeft: TPanel;
    cxGroupBox1: TcxGroupBox;
    cxGroupBox2: TcxGroupBox;
    pnlHost: TPanel;
    Panel1: TPanel;
    cxGroupBox3: TcxGroupBox;
    dxMapControl1: TdxMapControl;
    dxMapControl1BingMapGeoCodingDataProvider1: TdxMapControlBingMapGeoCodingDataProvider;
    dxMapLayer: TdxMapImageTileLayer;
    cxView: TcxGridDBTableView;
    cxLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    cxDescr: TcxMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
