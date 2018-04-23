unit Intfs;

interface

uses Classes, SysUtils;

type
	TServerData = record
		FAddress: string;
		FPort: Integer;
	end;

    ISession = interface
    ['{A520DD7D-65CA-43D9-AB82-407D4BE83CFC}']
    	function IsValid() : Boolean;
        function GetLastError() : string;

        property Valid : Boolean read IsValid;
        property LastError : string read GetLastError;
    end;

implementation

end.
