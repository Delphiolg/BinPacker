unit OlgSlotNode;

interface

uses
  SysUtils, Classes, Types,

  OlgLogger, OlgSlot;

type

  TOlgSlotNode = class;

  TOlgSlotNode = class
    private
      FNodeL: TOlgSlotNode;
      FNodeR: TOlgSlotNode;
      FSlot: TOlgSlot;
      FFiled: Boolean;
    public
      constructor Create;
      destructor Destroy; override;

      function Insert(ASlot: TOlgSlot): TOlgSlotNode;

      procedure SetRect(ALeft, ATop, AWidth, AHeight: Integer);

      property Slot: TOlgSlot read FSlot;

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

//  if FFiled then
//    begin
//      Result := nil;
//      Exit;
//    end;

  if FFiled or not ASlot.FitsIn(FSlot) then
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
    end

  else
    begin
      FNodeL.SetRect(FSlot.Left, FSlot.Top, FSlot.Width, ASlot.Height);
      FNodeR.SetRect(FSlot.Left, FSlot.Top + ASlot.Height, FSlot.Width, FSlot.Height - ASlot.Height)
    end;

  Result := FNodeL.Insert(ASlot);

end;

{=========================================================================================================================================}
procedure TOlgSlotNode.SetRect(ALeft, ATop, AWidth, AHeight: Integer);
begin
  FSlot.SetRect(ALeft, ATop, AWidth, AHeight);
end;

{=========================================================================================================================================}
end.
