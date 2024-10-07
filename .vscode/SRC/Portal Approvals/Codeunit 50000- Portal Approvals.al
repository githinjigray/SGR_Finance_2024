codeunit 50050 "Portal Approvals"
{

    trigger OnRun()
    begin
        //MESSAGE(GetOpenApprovalEntriesTest('','LV_0114'));
        Message(GetOpenApprovalEntries('EMP-002', ''));
    end;

    var
        Employee: Record Employee;
        ApprovalEntry: Record "Approval Entry";
        ApprovalCommentLine: Record "Approval Comment Line";
       // HRLeaveApplication: Record "HR Leave Application";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        TestDateTime: DateTime;
        NewTime: Integer;
        ApprovalDate: Date;
        ApprovalTime: Time;
        TimeSentforApproval: Text;
        DateSentforApproval: Text;
        GLEntry: Record "G/L Entry";

    [Scope('Cloud')]
    procedure GetRejectionComments(DocumentNo: Code[20]) RejectionComments: Text
    begin
        RejectionComments := '';

        ApprovalCommentLine.Reset;
        ApprovalCommentLine.SetRange(ApprovalCommentLine."Document No.", DocumentNo);
        if ApprovalCommentLine.FindLast() then begin
            RejectionComments := ApprovalCommentLine.Comment
        end;

    end;

    [Scope('Cloud')]
    procedure GetOpenApprovalEntries(EmployeeNo: Code[20]; DocumentNo: Code[10]) Result: Text
    begin
        Result := '';

        Employee.Get(EmployeeNo);

        ApprovalEntry.Reset;
        ApprovalEntry.SetCurrentKey("Entry No.");
        ApprovalEntry.SetAscending("Entry No.", false);
       // ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        //ApprovalEntry.SetFilter(ApprovalEntry."Document Type", '%1', ApprovalEntry."Document Type"::"HR Document");
        if ApprovalEntry.FindSet then begin
            Result := '[';
            repeat
                DateSentforApproval := Format(DT2Date(ApprovalEntry."Date-Time Sent for Approval"), 0, '<Day,2>/<Month,2>/<Year>');
                TimeSentforApproval := Format(DT2Time(ApprovalEntry."Date-Time Sent for Approval") + 10800000, 0, '<Hours12,2>:<Minutes,2> <AM/PM>');

                Result += '{';
                Result += '"EntryNo":"' + Format(ApprovalEntry."Entry No.") + '",';
                Result += '"TableID":"' + Format(ApprovalEntry."Table ID") + '",';
                Result += '"DocumentType":"' + Format(ApprovalEntry."Document Type") + '",';
                Result += '"DocumentNo":"' + ApprovalEntry."Document No." + '",';
                Result += '"Description":"' + ApprovalEntry.Description + '",';
                Result += '"SequenceNo":"' + Format(ApprovalEntry."Sequence No.") + '",';
                Result += '"ApprovalCode":"' + ApprovalEntry."Approval Code" + '",';
                Result += '"SenderID":"' + ApprovalEntry."Sender ID" + '",';
                Result += '"ApproverID":"' + ApprovalEntry."Approver ID" + '",';
                Result += '"Status":"' + Format(ApprovalEntry.Status) + '",';
                Result += '"DateTimeSentforApproval":"' + DateSentforApproval + ' ' + TimeSentforApproval + '",';
                Result += '"Amount":"' + Format(ApprovalEntry.Amount) + '",';
                Result += '"CurrencyCode":"' + ApprovalEntry."Currency Code" + '",';
                Result += '"SenderEmployeeNo":"' + ApprovalEntry."Sender Employee No" + '",';
                Result += '"SenderEmployeeName":"' + ApprovalEntry."Sender Name" + '",';
                Result += '"ApproverEmployeeNo":"' + ApprovalEntry."Approver Employee No" + '",';
                Result += '"ApproverEmployeeName":"' + ApprovalEntry."Approver Name" + '"';
                Result += '},';
            until ApprovalEntry.Next = 0;
            Result := CopyStr(Result, 1, StrLen(Result) - 1);
            Result += ']';
        end else begin
            Result := '[{';
            Result += '"EntryNo":"",';
            Result += '"TableID":"",';
            Result += '"DocumentType":"",';
            Result += '"DocumentNo":"",';
            Result += '"Description":"",';
            Result += '"SequenceNo":"",';
            Result += '"ApprovalCode":"",';
            Result += '"SenderID":"",';
            Result += '"ApproverID":"",';
            Result += '"Status":"",';
            Result += '"DateTimeSentforApproval":"",';
            Result += '"Amount":"",';
            Result += '"CurrencyCode":"",';
            Result += '"SenderEmployeeNo":"",';
            Result += '"SenderEmployeeName":"",';
            Result += '"ApproverEmployeeNo":"",';
            Result += '"ApproverEmployeeName":""';
            Result += '}]';
        end;
    end;

    [Scope('Cloud')]
    procedure GetApprovedApprovalEntries(EmployeeNo: Code[20]; DocumentNo: Code[10]) Result: Text
    begin
        Result := '';

        Employee.Get(EmployeeNo);

        ApprovalEntry.Reset;
        ApprovalEntry.SetCurrentKey("Entry No.");
        ApprovalEntry.SetAscending("Entry No.", false);
        //ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Approved);
        //ApprovalEntry.SETFILTER(ApprovalEntry."Document Type",'%1',ApprovalEntry."Document Type"::"HR Document");
        if ApprovalEntry.FindSet then begin
            Result := '[';
            repeat
                DateSentforApproval := Format(DT2Date(ApprovalEntry."Date-Time Sent for Approval"), 0, '<Day,2>/<Month,2>/<Year>');
                TimeSentforApproval := Format(DT2Time(ApprovalEntry."Date-Time Sent for Approval") + 10800000, 0, '<Hours12,2>:<Minutes,2> <AM/PM>');

                Result += '{';
                Result += '"EntryNo":"' + Format(ApprovalEntry."Entry No.") + '",';
                Result += '"TableID":"' + Format(ApprovalEntry."Table ID") + '",';
                Result += '"DocumentType":"' + Format(ApprovalEntry."Document Type") + '",';
                Result += '"DocumentNo":"' + ApprovalEntry."Document No." + '",';
                Result += '"Description":"' + ApprovalEntry.Description + '",';
                Result += '"SequenceNo":"' + Format(ApprovalEntry."Sequence No.") + '",';
                Result += '"ApprovalCode":"' + ApprovalEntry."Approval Code" + '",';
                Result += '"SenderID":"' + ApprovalEntry."Sender ID" + '",';
                Result += '"ApproverID":"' + ApprovalEntry."Approver ID" + '",';
                Result += '"Status":"' + Format(ApprovalEntry.Status) + '",';
                Result += '"DateTimeSentforApproval":"' + DateSentforApproval + ' ' + TimeSentforApproval + '",';
                Result += '"Amount":"' + Format(ApprovalEntry.Amount) + '",';
                Result += '"CurrencyCode":"' + ApprovalEntry."Currency Code" + '",';
                Result += '"SenderEmployeeNo":"' + ApprovalEntry."Sender Employee No" + '",';
                Result += '"SenderEmployeeName":"' + ApprovalEntry."Sender Name" + '",';
                Result += '"ApproverEmployeeNo":"' + ApprovalEntry."Approver Employee No" + '",';
                Result += '"ApproverEmployeeName":"' + ApprovalEntry."Approver Name" + '"';
                Result += '},';
            until ApprovalEntry.Next = 0;
            Result := CopyStr(Result, 1, StrLen(Result) - 1);
            Result += ']';
        end else begin
            Result := '[{';
            Result += '"EntryNo":"",';
            Result += '"TableID":"",';
            Result += '"DocumentType":"",';
            Result += '"DocumentNo":"",';
            Result += '"Description":"",';
            Result += '"SequenceNo":"",';
            Result += '"ApprovalCode":"",';
            Result += '"SenderID":"",';
            Result += '"ApproverID":"",';
            Result += '"Status":"",';
            Result += '"DateTimeSentforApproval":"",';
            Result += '"Amount":"",';
            Result += '"CurrencyCode":"",';
            Result += '"SenderEmployeeNo":"",';
            Result += '"SenderEmployeeName":"",';
            Result += '"ApproverEmployeeNo":"",';
            Result += '"ApproverEmployeeName":""';
            Result += '}]';
        end;
    end;

    [Scope('Cloud')]
    procedure GetRejectedApprovalEntries(EmployeeNo: Code[20]; DocumentNo: Code[10]) Result: Text
    begin

        Employee.Get(EmployeeNo);

        ApprovalEntry.Reset;
        ApprovalEntry.SetCurrentKey("Entry No.");
        ApprovalEntry.SetAscending("Entry No.", false);
       // ApprovalEntry.SetRange("Approver ID", Employee."User ID");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Rejected);
        // ApprovalEntry.SetFilter(ApprovalEntry."Document Type", '%1', ApprovalEntry."Document Type"::"HR Document");
        if ApprovalEntry.FindSet then begin
            Result := '[';
            repeat
                DateSentforApproval := Format(DT2Date(ApprovalEntry."Date-Time Sent for Approval"), 0, '<Day,2>/<Month,2>/<Year>');
                TimeSentforApproval := Format(DT2Time(ApprovalEntry."Date-Time Sent for Approval") + 10800000, 0, '<Hours12,2>:<Minutes,2> <AM/PM>');

                Result += '{';
                Result += '"EntryNo":"' + Format(ApprovalEntry."Entry No.") + '",';
                Result += '"TableID":"' + Format(ApprovalEntry."Table ID") + '",';
                Result += '"DocumentType":"' + Format(ApprovalEntry."Document Type") + '",';
                Result += '"DocumentNo":"' + ApprovalEntry."Document No." + '",';
                Result += '"Description":"' + ApprovalEntry.Description + '",';
                Result += '"SequenceNo":"' + Format(ApprovalEntry."Sequence No.") + '",';
                Result += '"ApprovalCode":"' + ApprovalEntry."Approval Code" + '",';
                Result += '"SenderID":"' + ApprovalEntry."Sender ID" + '",';
                Result += '"ApproverID":"' + ApprovalEntry."Approver ID" + '",';
                Result += '"Status":"' + Format(ApprovalEntry.Status) + '",';
                Result += '"DateTimeSentforApproval":"' + DateSentforApproval + ' ' + TimeSentforApproval + '",';
                Result += '"Amount":"' + Format(ApprovalEntry.Amount) + '",';
                Result += '"CurrencyCode":"' + ApprovalEntry."Currency Code" + '",';
                Result += '"SenderEmployeeNo":"' + ApprovalEntry."Sender Employee No" + '",';
                Result += '"SenderEmployeeName":"' + ApprovalEntry."Sender Name" + '",';
                Result += '"ApproverEmployeeNo":"' + ApprovalEntry."Approver Employee No" + '",';
                Result += '"ApproverEmployeeName":"' + ApprovalEntry."Approver Name" + '"';
                Result += '},';
            until ApprovalEntry.Next = 0;
            Result := CopyStr(Result, 1, StrLen(Result) - 1);
            Result += ']';
        end else begin
            Result := '[{';
            Result += '"EntryNo":"",';
            Result += '"TableID":"",';
            Result += '"DocumentType":"",';
            Result += '"DocumentNo":"",';
            Result += '"Description":"",';
            Result += '"SequenceNo":"",';
            Result += '"ApprovalCode":"",';
            Result += '"SenderID":"",';
            Result += '"ApproverID":"",';
            Result += '"Status":"",';
            Result += '"DateTimeSentforApproval":"",';
            Result += '"Amount":"",';
            Result += '"CurrencyCode":"",';
            Result += '"SenderEmployeeNo":"",';
            Result += '"SenderEmployeeName":"",';
            Result += '"ApproverEmployeeNo":"",';
            Result += '"ApproverEmployeeName":""';
            Result += '}]';
        end;
    end;

    [Scope('Cloud')]
    procedure GetApprovalEntryByNo(DocumentNo: Code[30]) Result: Text
    begin
        Result := '';

        ApprovalEntry.Reset;
        ApprovalEntry.SetCurrentKey("Entry No.");
        ApprovalEntry.SetAscending("Entry No.", false);
        ApprovalEntry.SetRange("Document No.", DocumentNo);
        if ApprovalEntry.FindSet then begin
            Result := '[';
            repeat

                DateSentforApproval := Format(DT2Date(ApprovalEntry."Date-Time Sent for Approval"), 0, '<Day,2>/<Month,2>/<Year>');
                TimeSentforApproval := Format(DT2Time(ApprovalEntry."Date-Time Sent for Approval") + 10800000, 0, '<Hours12,2>:<Minutes,2> <AM/PM>');

                Result += '{';
                Result += '"EntryNo":"' + Format(ApprovalEntry."Entry No.") + '",';
                Result += '"TableID":"' + Format(ApprovalEntry."Table ID") + '",';
                Result += '"DocumentType":"' + Format(ApprovalEntry."Document Type") + '",';
                Result += '"DocumentNo":"' + ApprovalEntry."Document No." + '",';
                Result += '"Description":"' + ApprovalEntry.Description + '",';
                Result += '"SequenceNo":"' + Format(ApprovalEntry."Sequence No.") + '",';
                Result += '"ApprovalCode":"' + ApprovalEntry."Approval Code" + '",';
                Result += '"SenderID":"' + ApprovalEntry."Sender ID" + '",';
                Result += '"ApproverID":"' + ApprovalEntry."Approver ID" + '",';
                Result += '"Status":"' + Format(ApprovalEntry.Status) + '",';
                ;
                Result += '"DateTimeSentforApproval":"' + DateSentforApproval + ' ' + TimeSentforApproval + '",';
                Result += '"Amount":"' + Format(ApprovalEntry.Amount) + '",';
                Result += '"CurrencyCode":"' + ApprovalEntry."Currency Code" + '",';
                ;
                Result += '"SenderEmployeeNo":"' + ApprovalEntry."Sender Employee No" + '",';
                Result += '"SenderEmployeeName":"' + ApprovalEntry."Sender Name" + '",';
                ;
                Result += '"ApproverEmployeeNo":"' + ApprovalEntry."Approver Employee No" + '",';
                Result += '"ApproverEmployeeName":"' + ApprovalEntry."Approver Name" + '"';
                Result += '},';
            until ApprovalEntry.Next = 0;
            Result := CopyStr(Result, 1, StrLen(Result) - 1);
            Result += ']';
        end else begin
            Result := '[{';
            Result += '"EntryNo":"",';
            Result += '"TableID":"",';
            Result += '"DocumentType":"",';
            Result += '"DocumentNo":"",';
            Result += '"Description":"",';
            Result += '"SequenceNo":"",';
            Result += '"ApprovalCode":"",';
            Result += '"SenderID":"",';
            Result += '"ApproverID":"",';
            Result += '"Status":"",';
            Result += '"DateTimeSentforApproval":"",';
            Result += '"Amount":"",';
            Result += '"CurrencyCode":"",';
            Result += '"SenderEmployeeNo":"",';
            Result += '"SenderEmployeeName":"",';
            Result += '"ApproverEmployeeNo":"",';
            Result += '"ApproverEmployeeName":""';
            Result += '}]';
        end;
    end;

    local procedure GetLeaveStartDate(DocumentNo: Code[20]) LeaveStartDate: Date
    begin
        // LeaveStartDate := 0D;

        // HRLeaveApplication.Reset;
        // HRLeaveApplication.SetRange("No.", DocumentNo);
        // if HRLeaveApplication.FindFirst then
        //     LeaveStartDate := HRLeaveApplication."Leave Start Date";
    end;

    local procedure GetLeaveEndDate(DocumentNo: Code[20]) LeaveEndDate: Date
    begin
        // LeaveEndDate := 0D;

        // HRLeaveApplication.Reset;
        // HRLeaveApplication.SetRange("No.", DocumentNo);
        // if HRLeaveApplication.FindFirst then
        //     LeaveEndDate := HRLeaveApplication."Leave End Date";
    end;

    local procedure GetLeaveReturnDate(DocumentNo: Code[20]) LeaveReturnDate: Date
    begin
        // LeaveReturnDate := 0D;

        // HRLeaveApplication.Reset;
        // HRLeaveApplication.SetRange("No.", DocumentNo);
        // if HRLeaveApplication.FindFirst then
        //     LeaveReturnDate := HRLeaveApplication."Leave Return Date";
    end;

    [Scope('Cloud')]
    procedure Approve("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]) Approved: Boolean
    var
        "EntryNo.": Integer;
    begin
        Approved := false;
        "EntryNo." := 0;

        Employee.Reset;
        Employee.SetRange(Employee."No.", "EmployeeNo.");
        if Employee.FindFirst() then;

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin
            "EntryNo." := ApprovalEntry."Entry No.";
            ApprovalsMgmt.ApproveApprovalRequests(ApprovalEntry);
            Approved := true;
        end;

        Commit;
    end;

    [Scope('Cloud')]
    procedure Reject("EmployeeNo.": Code[20]; "DocumentNo.": Code[20]; RejectionComments: Text) Rejected: Boolean
    var
        "EntryNo.": Integer;
    begin
        Rejected := false;
        "EntryNo." := 0;

        Employee.Reset;
        Employee.Get("EmployeeNo.");

        ApprovalEntry.Reset;
        ApprovalEntry.SetRange(ApprovalEntry."Document No.", "DocumentNo.");
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        if ApprovalEntry.FindFirst then begin

            ApprovalEntry."Rejection Comments" := RejectionComments;
            ApprovalEntry.Modify();

            ApprovalsMgmt.RejectApprovalRequests(ApprovalEntry);

            ApprovalCommentLine.Init;
            ApprovalCommentLine."Entry No." := ApprovalEntry."Entry No.";
            ApprovalCommentLine."Document No." := "DocumentNo.";
            ApprovalCommentLine."User ID" := ApprovalEntry."Sender ID";
            ApprovalCommentLine."Date and Time" := CurrentDateTime;
            ApprovalCommentLine.Comment := RejectionComments;
            ApprovalCommentLine.Insert;
            Rejected := true;
        end;
    end;
}

