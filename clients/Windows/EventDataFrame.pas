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
	cxGridTableView, cxGridDBTableView, cxGrid, dxBarBuiltInMenu, cxPC, dxNavBar;

type
	TEventData = class(TFrame)
        cxPages: TcxPageControl;
        cxTabBase: TcxTabSheet;
        cxGroupProgram: TcxGroupBox;
        cxGrid: TcxGrid;
        cxView: TcxGridDBTableView;
        cxLevel: TcxGridLevel;
        pnlLeft: TPanel;
        cxGroupInfo: TcxGroupBox;
        cxEvtData: TcxVerticalGrid;
        cxEvtDataCategoryRow1: TcxCategoryRow;
        cxEvtName: TcxEditorRow;
        cxEvtDateStart: TcxEditorRow;
        cxEvtDateEnd: TcxEditorRow;
        cxEvtInternal: TcxEditorRow;
        cxEvtAddress: TcxEditorRow;
        cxGroupDescr: TcxGroupBox;
        cxDescr: TcxMemo;
    cxTabMap: TcxTabSheet;
    dxMap: TdxMapControl;
    dxMapDataProvider: TdxMapImageTileLayer;
        procedure FrameResize(Sender: TObject);
	public
    	procedure PopulateEventData(ASession : ISession; const AId : Integer);
        procedure PopulateBaseInfo(AJson : TJSONObject);
	end;

implementation

{$R *.dfm}

{ TEventData }

procedure TEventData.FrameResize(Sender: TObject);
begin
	cxGroupDescr.Height := cxTabBase.Height - cxGroupInfo.Height - 2;
    cxDescr.Height := cxGroupDescr.Height - 25;
    cxGroupProgram.Width := cxTabBase.Width - cxGroupProgram.Left - 5;
    cxGroupProgram.Height := cxTabBase.Height - 2;
    cxGrid.Width := cxGroupProgram.Width - 14;
    cxGrid.Height := cxGroupProgram.Height - 24;
end;

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
