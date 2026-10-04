page 50101 "Service Request List EL"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'Service Requests';
    SourceTable = "Service Request El";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(Services)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sequential number of the service request.';
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer who raised the service request.';
                }

                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a short summary of the service request.';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the details of the service request.';
                }

                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies how urgent the service request is.';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the service request is open, in progress or closed.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    Caption = 'Created At';
                    ToolTip = 'Specifies when the service request was created.';
                }
            }
        }
    }
}
