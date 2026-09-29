page 50100 "Service Request EL"
{
    PageType = API;
    EntityName = 'ServiceRequest';
    EntitySetName = 'ServiceRequests';
    APIPublisher = 'Elomary';
    APIGroup = 'Service';
    DelayedInsert = true;
    SourceTable = "Service Request El";
    APIVersion = 'v1.0';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            field(CustomerNo; Rec."Customer No.")
            {
                ApplicationArea = All;
                ToolTip = 'Customer No. Specifies the value of the customer no.';
            }

            field(Title; Rec.Title)
            {
                ApplicationArea = All;
                ToolTip = 'Title Specifies the value of the title field.';
            }

            field(Description; Rec.Description)
            {
                ApplicationArea = All;
                ToolTip = 'Description Specifies the value of the Description field.';
            }

            field(Priority; Rec.Priority)
            {
                ApplicationArea = All;
                ToolTip = 'Prioriry value Specifies the value of the Priority Field.';
            }

            field(Status; Rec.Status)
            {
                ApplicationArea = All;
                ToolTip = 'Status value Specifies the value of the Status field.';
            }
        }
    }
}