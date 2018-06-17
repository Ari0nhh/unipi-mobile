unit EventDataFrame;

interface

uses
	Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
	System.Classes, Intfs, System.JSON,
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
    cxEvtInternal: TcxEditorRow;
		pnlLeft: TPanel;
		cxGroupBox1: TcxGroupBox;
		cxGroupBox2: TcxGroupBox;
		pnlHost: TPanel;
		Panel1: TPanel;
		cxGroupBox3: TcxGroupBox;
		dxMapControl1: TdxMapControl;
		dxMapLayer: TdxMapImageTileLayer;
		cxView: TcxGridDBTableView;
		cxLevel: TcxGridLevel;
		cxGrid: TcxGrid;
		cxDescr: TcxMemo;
	public
    	procedure PopulateEventData(ASession : ISession; const AId : Integer);
        procedure PopulateBaseInfo(AJson : TJSONObject);
	end;

implementation

{$R *.dfm}

{ TEventData }

procedure TEventData.PopulateBaseInfo(AJson: TJSONObject);
var
	val : TJSONValue;
begin
	val := AJson.GetValue('evtName');
    if not Assigned(val) then
    	Exit;
    cxEvtName.Properties.Value := val.GetValue<string>();

    val := AJson.GetValue('evtDateStart');
    if not Assigned(val) then
    	Exit;
    cxEvtDateStart.Properties.Value := _ToDate(val.GetValue<string>());

    val := AJson.GetValue('evtDateEnd');
    if not Assigned(val) then
    	Exit;
    cxEvtDateEnd.Properties.Value := _ToDate(val.GetValue<string>());

    val := AJson.GetValue('evtInternal');
    if not Assigned(val) then
    	Exit;
    cxEvtInternal.Properties.Value := (val.GetValue<Integer>() <> 0);

    val := AJson.GetValue('evtAddress');
    if not Assigned(val) then
    	Exit;
    cxEvtAddress.Properties.Value := val.GetValue<string>();

    val := AJson.GetValue('evtDescr');
    if not Assigned(val) then
    	Exit;
    cxDescr.Lines.Text := val.GetValue<string>();
end;

procedure TEventData.PopulateEventData(ASession: ISession; const AId : Integer);
var
	json : TJSONValue;
begin
	if not Assigned(ASession) then
    	Exit;

    json := ASession.Execute(Format('REST/event/%d', [AId]));
    if not Assigned(json) then
    	Exit;

    if not (json is TJSONObject) then
    	Exit;

    PopulateBaseInfo(json as TJSONObject);
end;

end.
