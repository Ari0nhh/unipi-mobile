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
	cxGridTableView, cxGridDBTableView, cxGrid, dxBarBuiltInMenu, cxPC, dxNavBar,
    Datasnap.DBClient, dxDateTimeWheelPicker;

type
	TEventData = class(TFrame)
        cxPages: TcxPageControl;
        cxTabBase: TcxTabSheet;
        cxGroupProgram: TcxGroupBox;
        cxGrid: TcxGrid;
        cxView: TcxGridDBTableView;
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
        dsPeriods: TDataSource;
        clPeriods: TClientDataSet;
        cxViewclID: TcxGridDBColumn;
        cxViewclName: TcxGridDBColumn;
        cxViewclStart: TcxGridDBColumn;
        cxViewclEnd: TcxGridDBColumn;
        dsActions: TDataSource;
        clActions: TClientDataSet;
        cxActView: TcxGridDBTableView;
        cxActIDCol: TcxGridDBColumn;
        cxActPerIdCol: TcxGridDBColumn;
        cxActNameCol: TcxGridDBColumn;
        cxActDescCol: TcxGridDBColumn;
        cxActStartCol: TcxGridDBColumn;
        cxActEndCol: TcxGridDBColumn;
        cxActLocCol: TcxGridDBColumn;
        cxPeriods: TcxGridLevel;
        cxActions: TcxGridLevel;
        procedure FrameResize(Sender: TObject);
	public
    	procedure PopulateEventData(ASession : ISession; const AId : Integer);
        procedure PrepareForNewEvent(ASession : ISession);
        procedure CleanUp();
        function  ApplyEventData() : Boolean;
    strict private
        FSession  : ISession;
        FNewEvent : Boolean;
        FCurrId   : Integer;
        procedure PopulateBaseInfo(AJson : TJSONObject);
        procedure PopulatePeriodData(AJSON : TJSONObject);
        function  ValidateInputInfo() : Boolean;
	end;

implementation

{$R *.dfm}

{ TEventData }

function TEventData.ApplyEventData() : Boolean;
var
	json : TJSONObject;
    val  : TJSONValue;
    req  : string;
    api  : string;
begin
    Result :=  ValidateInputInfo();
    if not Result then
    	Exit;

	json := TJSONObject.Create();
    try
        if (not FNewEvent) and (FCurrId > -1) then begin
            json.AddPair(TJSONString.Create('evtId'), TJSONNumber.Create(FCurrId));
            api := 'REST/edit_event';
        end else
            api := 'REST/add_event';

        json.AddPair(TJSONString.Create('evtName'), TJSONString.Create(cxEvtName.Properties.Value));
        json.AddPair(TJSONString.Create('evtStart'), TJSONString.Create(_FromDateTime(cxEvtDateStart.Properties.Value)));
        json.AddPair(TJSONString.Create('evtEnd'),   TJSONString.Create(_FromDateTime(cxEvtDateEnd.Properties.Value)));

        if cxEvtInternal.Properties.Value then
        	json.AddPair(TJSONString.Create('evtInternal'), TJSONNumber.Create(1))
    	else
        	json.AddPair(TJSONString.Create('evtInternal'), TJSONNumber.Create(0));

        json.AddPair(TJSONString.Create('evtAddress'), TJSONString.Create(cxEvtAddress.Properties.Value));
        json.AddPair(TJSONString.Create('evtDescr'), TJSONString.Create(cxDescr.Text));

        req := json.ToString();
    finally
    	json.Free();
    end;

    val := FSession.Execute(api, req);

    try

    finally
    	val.Free();
    end;
end;

procedure TEventData.CleanUp;
begin
    FSession := nil;
    FNewEvent := False;
    FCurrId := -1;
	clPeriods.EmptyDataSet();
    clActions.EmptyDataSet();
    cxEvtName.Properties.Value := '';
    cxEvtDateStart.Properties.Value := Now();
    cxEvtDateEnd.Properties.Value := Now() + 10;
    cxEvtInternal.Properties.Value := False;
    cxEvtAddress.Properties.Value := '';
    cxDescr.Lines.Clear();
end;

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

    val := AJson.GetValue('evtLattitude');
    if not Assigned(val) then
    	Exit;

    if not val.Null then
    	dxMap.CenterPoint.Latitude := val.GetValue<Double>();

    val := AJson.GetValue('evtLongitude');
    if not Assigned(val) then
    	Exit;

    if not val.Null then
    	dxMap.CenterPoint.Longitude := val.GetValue<Double>();

    if (dxMap.CenterPoint.Longitude <> 0) and (dxMap.CenterPoint.Latitude <> 0) then
    	dxMap.ZoomLevel := 18;

end;

procedure TEventData.PopulateEventData(ASession: ISession; const AId : Integer);
var
	json : TJSONValue;
    &object : TJSONObject;
begin
    FSession := ASession;
    FCurrId := AId;

	if not Assigned(ASession) then
    	Exit;

    json := ASession.Execute(Format('REST/event/%d', [AId]));
    if not Assigned(json) then
    	Exit;

    try
        if not (json is TJSONObject) then
            Exit;

        &object := json as TJSONObject;

        PopulateBaseInfo(&object as TJSONObject);
        PopulatePeriodData(&object);
    finally
    	json.Free();
    end;
end;

procedure TEventData.PopulatePeriodData(AJSON: TJSONObject);
var
	val     : TJSONValue;
    &array,
    actions : TJSONArray;
    i,j     : Integer;
    period,
    action  : TJSONObject;
    id, aid : Integer;
    name,
    desc,
    loc     : string;
    dS, dE  : TDateTime;
begin
	val := AJSON.GetValue('periods');
    if not Assigned(val) then
    	Exit;

    if not (val is TJSONArray) then
    	Exit;

    &array := val as TJSONArray;

    try
        cxView.BeginUpdate();
        cxActView.BeginUpdate();
        clPeriods.DisableControls();
        clActions.DisableControls();

        for i:=0 to &array.Count-1 do begin
            val := &array.Items[i];
            if not (val is TJSONObject) then
                continue;

            period := val as TJSONObject;

            val := period.GetValue('epId');
            if not Assigned(val) then
                continue;
            id := val.GetValue<Integer>();

            val := period.GetValue('epName');
            if not Assigned(val) then
                continue;
            name := val.GetValue<string>();

            val := period.GetValue('epStart');
            if not Assigned(val) then
                continue;
            dS := _ToDateTime(val.GetValue<string>());

            val := period.GetValue('epEnd');
            if not Assigned(val) then
                continue;
            dE := _ToDateTime(val.GetValue<string>());

            clPeriods.Append();
            clPeriods.Fields[0].Value := id;
            clPeriods.Fields[1].Value := name;
            clPeriods.Fields[2].Value := dS;
            clPeriods.Fields[3].Value := dE;
            clPeriods.Post();

            val := period.GetValue('actions');
            if not Assigned(val) then
            	continue;

            if not (val is TJSONArray) then
            	continue;

            actions := val as TJSONArray;
       		for j:=0 to actions.Count-1 do begin
            	val := actions.Items[j];
                if not (val is TJSONObject) then
                	continue;

                action := val as TJSONObject;

                val := action.GetValue('eaId');
                if not Assigned(val) then
                	continue;
                aid := val.GetValue<Integer>();

                val := action.GetValue('eaName');
                if not Assigned(val) then
                	continue;
                name := val.GetValue<string>();

                val := action.GetValue('eaDesc');
                if not Assigned(val) then
                	continue;
                desc := val.GetValue<string>();

                val := action.GetValue('eaStart');
                if not Assigned(val) then
                    continue;
                dS := _ToDateTime(val.GetValue<string>());

                val := action.GetValue('eaEnd');
                if not Assigned(val) then
                    continue;
                dE := _ToDateTime(val.GetValue<string>());

                val := action.GetValue('eaLocation');
                if not Assigned(val) then
                	continue;
                loc := val.GetValue<string>();

                clActions.Append();
                clActions.Fields[0].Value := aid;
                clActions.Fields[1].Value := id;
                clActions.Fields[2].Value := name;
                clActions.Fields[3].Value := desc;
                clActions.Fields[4].Value := dS;
                clActions.Fields[5].Value := dE;
                clActions.Fields[6].Value := loc;
                clActions.Post();
            end;
        end;
    finally
    	clPeriods.EnableControls();
        clActions.EnableControls();
        cxView.EndUpdate();
        cxActView.EndUpdate();
    end;
end;

procedure TEventData.PrepareForNewEvent(ASession: ISession);
begin
	CleanUp();

    FSession := ASession;
    FNewEvent := False;
end;

function TEventData.ValidateInputInfo: Boolean;
begin
    Result := True;
	if cxEvtName.Properties.Value = '' then
    	Exit(False);

    if cxEvtDateStart.Properties.Value > cxEvtDateEnd.Properties.Value then
    	Exit(False);
end;

end.
