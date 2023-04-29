unit OlgNode;

interface

uses
  SysUtils, Classes, Types,

  OlgLogger;

type

  TOlgRect = record
    X, Y: Integer;
    W, H: Integer;

    class function ToRect(AX, AY, AW, AH: Integer): TOlgRect; static;
    function FitsIn(ARect: TOlgRect): Boolean;
    function SameSizeAs(ARect: TOlgRect): Boolean;
  end;

  TOlgNode = class;

  TOlgNode = class
  private
    public
      FNodeL: TOlgNode;
      FNodeR: TOlgNode;
      FRect: TOlgRect;
      FFiled: Boolean;

      function Insert(ARect: TOlgRect): TOlgNode;
      constructor Create;
      destructor Destroy; override;

  end;

implementation

{ TOlgNode }

constructor TOlgNode.Create;
begin
  FNodeL := nil;
  FNodeR := nil;
  FRect := TOlgRect.ToRect(0, 0, 0, 0);
  FFiled := False;
end;

destructor TOlgNode.Destroy;
begin

  if FNodeL <> nil then
    FreeAndNil(FNodeL);

  if FNodeR <> nil then
    FreeAndNil(FNodeR);

  inherited;
end;

function TOlgNode.Insert(ARect: TOlgRect): TOlgNode;
var DW, DH: Integer;
begin

  if FNodeL <> nil then
    begin
      Result := FNodeL.Insert(ARect);
      if Result <> nil then
        Exit;

      Result := FNodeR.Insert(ARect);
      Exit;
    end;

//  else if FNodeR <> nil then
//    begin
//      Result := FNodeR.Insert(ARect);
//      Exit;
//    end;

  if FFiled then
    begin
      Result := nil;
      Exit;
    end;

  if not ARect.FitsIn(FRect) then
    begin
      Result := nil;
      Exit;
    end;

  if ARect.SameSizeAs(FRect) then
    begin
      FFiled := True;
      Result := Self;
      Exit;
    end;

  FNodeL := TOlgNode.Create;
  FNodeR := TOlgNode.Create;

  DW := FRect.W - ARect.W;
  DH := FRect.H - ARect.H;

  if DW > DH then
    begin
      FNodeL.FRect := TOlgRect.ToRect(FRect.X, FRect.Y, ARect.W, FRect.H);
      FNodeR.FRect := TOlgRect.ToRect(FRect.X + ARect.W, FRect.Y, FRect.W - ARect.W, FRect.H);
    end

  else
    begin
      FNodeL.FRect := TOlgRect.ToRect(FRect.X, FRect.Y, FRect.W, ARect.H);
      FNodeR.FRect := TOlgRect.ToRect(FRect.X, FRect.Y + ARect.H, FRect.W, FRect.H - ARect.H);
    end;

  Result := FNodeL.Insert(ARect);

end;

{ TOlgRect }

function TOlgRect.FitsIn(ARect: TOlgRect): Boolean;
begin
  Result := (W <= ARect.W) and (H <= ARect.H);
end;

function TOlgRect.SameSizeAs(ARect: TOlgRect): Boolean;
begin
  Result := (W = ARect.W) and (H = ARect.H);
end;

class function TOlgRect.ToRect(AX, AY, AW, AH: Integer): TOlgRect;
begin
  Result.X := AX;
  Result.Y := AY;
  Result.W := AW;
  Result.H := AH;
end;

end.
