unit OlgSlotNode;

interface

uses
  SysUtils, Classes, Types,

  OlgLogger, OlgSlot;

type

//  TOlgRect = record
//    X, Y: Integer;
//    W, H: Integer;
//
//    class function ToRect(AX, AY, AW, AH: Integer): TOlgRect; static;
//    function FitsIn(ARect: TOlgRect): Boolean;
//    function SameSizeAs(ARect: TOlgRect): Boolean;
//  end;

  TOlgSlotNode = class;

  TOlgSlotNode = class
  private
    public
      FNodeL: TOlgSlotNode;
      FNodeR: TOlgSlotNode;
      FSlot: TOlgSlot;
      FFiled: Boolean;

      function Insert(ASlot: TOlgSlot): TOlgSlotNode;
      constructor Create;
      destructor Destroy; override;

      procedure SetRect(ALeft, ATop, AWidth, AHeight: Integer);

  end;

implementation

{=========================================================================================================================================}
{ TOlgNode }
{=========================================================================================================================================}
constructor TOlgSlotNode.Create;
begin
  FNodeL := nil;
  FNodeR := nil;
  FSlot := TOlgSlot.Create(0, 0, 0, 0);
  FFiled := False;
end;

{=========================================================================================================================================}
destructor TOlgSlotNode.Destroy;
begin

  if FNodeL <> nil then
    FreeAndNil(FNodeL);

  if FNodeR <> nil then
    FreeAndNil(FNodeR);

  FreeAndNil(FSlot);

  inherited;
end;

{=========================================================================================================================================}
function TOlgSlotNode.Insert(ASlot: TOlgSlot): TOlgSlotNode;
var DW, DH: Integer;
begin

  if FNodeL <> nil then
    begin
      Result := FNodeL.Insert(ASlot);
      if Result <> nil then
        Exit;

      Result := FNodeR.Insert(ASlot);
      Exit;
    end;


  if FFiled then
    begin
      Result := nil;
      Exit;
    end;

  if not ASlot.FitsIn(FSlot) then
    begin
      Result := nil;
      Exit;
    end;

  if ASlot.SameSizeAs(FSlot) then
    begin
      FFiled := True;
      Result := Self;
      Exit;
    end;

  FNodeL := TOlgSlotNode.Create;
  FNodeR := TOlgSlotNode.Create;

  DW := FSlot.Width - ASlot.Width;
  DH := FSlot.Height - ASlot.Height;

  if DW > DH then
    begin
      FNodeL.SetRect(FSlot.Left, FSlot.Top, ASlot.Width, FSlot.Height);
      FNodeR.SetRect(FSlot.Left + ASlot.Width, FSlot.Top, FSlot.Width - ASlot.Width, FSlot.Height)
//
//      FNodeL.FRect := TOlgRect.ToRect(FRect.X, FRect.Y, ARect.W, FRect.H);
//      FNodeR.FRect := TOlgRect.ToRect(FRect.X + ARect.W, FRect.Y, FRect.W - ARect.W, FRect.H);
    end

  else
    begin

      FNodeL.SetRect(FSlot.Left, FSlot.Top, FSlot.Width, ASlot.Height);
      FNodeR.SetRect(FSlot.Left, FSlot.Top + ASlot.Height, FSlot.Width, FSlot.Height - ASlot.Height)


//      FNodeL.FRect := TOlgRect.ToRect(FRect.X, FRect.Y, FRect.W, ARect.H);
//      FNodeR.FRect := TOlgRect.ToRect(FRect.X, FRect.Y + ARect.H, FRect.W, FRect.H - ARect.H);
    end;

  Result := FNodeL.Insert(ASlot);

end;

{=========================================================================================================================================}
procedure TOlgSlotNode.SetRect(ALeft, ATop, AWidth, AHeight: Integer);
begin
  FSlot.SetRect(ALeft, ATop, AWidth, AHeight);
end;

//{=========================================================================================================================================}
//{ TOlgRect }
//{=========================================================================================================================================}
//function TOlgRect.FitsIn(ARect: TOlgRect): Boolean;
//begin
//  Result := (W <= ARect.W) and (H <= ARect.H);
//end;
//
//{=========================================================================================================================================}
//function TOlgRect.SameSizeAs(ARect: TOlgRect): Boolean;
//begin
//  Result := (W = ARect.W) and (H = ARect.H);
//end;
//
//{=========================================================================================================================================}
//class function TOlgRect.ToRect(AX, AY, AW, AH: Integer): TOlgRect;
//begin
//  Result.X := AX;
//  Result.Y := AY;
//  Result.W := AW;
//  Result.H := AH;
//end;

{=========================================================================================================================================}
end.
