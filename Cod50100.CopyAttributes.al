/// <summary>
/// Codeunit CopyAttributes (ID 50100).
/// </summary>
codeunit 50100 CopyAttributes
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean);
    var
        ItemAttValue: Record "Item Attribute Value";
        ItemAttMapping: Record "Item Attribute Value Mapping";
        TextAttributes: Text;
    begin
        TextAttributes := '';
        ItemAttMapping.RESET;
        ItemAttMapping.SETRANGE("Table ID", Database::Item);
        ItemAttMapping.SETRANGE("No.", SalesInvLine."No.");
        IF ItemAttMapping.FINDSET then BEGIN
            repeat
                IF ItemAttValue.GET(itemAttMapping."Item Attribute ID", ItemAttMapping."Item Attribute Value ID") then Begin
                    IF TextAttributes <> '' then
                        TextAttributes += ',';
                    TextAttributes += '(' + ItemAttValue.Value + ')';
                End;
            until itemAttMapping.Next = 0;
        END;
        SalesInvLine."Attributes" := TextAttributes;
    end;
}	//