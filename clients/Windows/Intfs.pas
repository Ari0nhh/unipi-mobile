unit Intfs;

interface

uses Classes, SysUtils, System.JSON;

type
	TServerData = record
		FAddress: string;
		FPort: Integer;
	end;

    TRequestKind = (rkGet=0, rkPost);

    ISession = interface
    ['{A520DD7D-65CA-43D9-AB82-407D4BE83CFC}']
    	function IsValid() : Boolean;
        function GetLastError() : string;

        function Execute(const AReqUrl : string) : TJSONValue; overload;
        function Execute(const AReqUrl : string; const APayload : string) : TJSONValue; overload;

        property Valid : Boolean read IsValid;
        property LastError : string read GetLastError;
    end;

    function _ToDate(const AVal : string) : TDateTime;
    function _ToDateTime(const AVal : string) : TDateTime;
    function _FromDateTime(const ADT : TDateTime) : string;

implementation


function _ToDate(const AVal: string): TDateTime;
var
	y, m, d : Word;
    str : string;
begin
    //"2018-05-18T19:00:00.000Z"
	str := Copy(Aval, 1, 4);
    y := StrToInt(str);

    str := Copy(AVal, 6, 2);
    m := StrToInt(str);

    str := Copy(AVal, 9, 2);
    d := StrToInt(str);

    Result := EncodeDate(y, m, d);
end;

function _ToDateTime(const AVal : string) : TDateTime;
var
	y, m, d, hh, mm : Word;
    str : string;
begin
    //"2018-05-18T19:00:00.000Z"
	str := Copy(Aval, 1, 4);
    y := StrToInt(str);

    str := Copy(AVal, 6, 2);
    m := StrToInt(str);

    str := Copy(AVal, 9, 2);
    d := StrToInt(str);

    str := Copy(AVal, 12, 2);
    hh := StrToInt(str);

    str := Copy(AVal, 15, 2);
    mm := StrToInt(str);

    Result := EncodeDate(y, m, d) + EncodeTime(hh, mm, 0, 0);
end;

function _FromDateTime(const ADT : TDateTime) : string;
var
	y, m, d, hh, mm, ss, ms : Word;
begin
	DecodeDate(ADT, y, m, d);
    DecodeTime(ADT, hh, mm, ss, ms);

    Result := Format('%d-%d-%d %d:%d:%d', [y, m, d, hh, mm, ss]);
end;

end.
