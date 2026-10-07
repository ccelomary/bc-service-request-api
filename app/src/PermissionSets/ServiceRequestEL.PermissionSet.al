permissionset 50100 "Service Request EL"
{
    Assignable = true;
    Caption = 'Service Request';

    Permissions =
        table "Service Request El" = X,
        tabledata "Service Request El" = RIMD,
        page "Service Request EL" = X,
        page "Service Request List EL" = X;
}
