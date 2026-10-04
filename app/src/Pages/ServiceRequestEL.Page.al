page 50100 "Service Request EL"
{
    PageType = API;
    Caption = 'Service Request';
    APIPublisher = 'elomary';
    APIGroup = 'service';
    APIVersion = 'v1.0';
    EntityName = 'serviceRequest';
    EntitySetName = 'serviceRequests';
    SourceTable = "Service Request El";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    DeleteAllowed = false;
    Extensible = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }

                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                    Editable = false;
                }

                field(customerNo; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                }

                field(title; Rec.Title)
                {
                    Caption = 'Title';
                }

                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }

                field(priority; Rec.Priority)
                {
                    Caption = 'Priority';
                }

                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }

                field(createdAt; Rec.SystemCreatedAt)
                {
                    Caption = 'Created At';
                    Editable = false;
                }
            }
        }
    }
}
