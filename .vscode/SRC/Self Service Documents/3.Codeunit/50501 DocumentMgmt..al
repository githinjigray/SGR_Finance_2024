codeunit 50501 "Document Mgmt."
 {
//     trigger OnRun()
//     begin
//     end;

//     var
//         DocumentsTbl: Record "Portal Documents";
//         DocumentsTbl2: Record "Portal Documents";
//         DocumentsTbl3: Record "Portal Documents";
//         HRLeaveTypes: Record "HR Leave Types";
//         FileManagement: Codeunit "File Management";
//         Error001: Label 'Attach supporting document';

//     [Scope('Cloud')]
//     procedure GetNextLineNo(DocumentNo: Code[20]) LineNo: Integer
//     var
//         PortalDoc: Record "Portal Documents";
//     begin
//         PortalDoc.RESET;
//         PortalDoc.SETRANGE(PortalDoc."DocumentNo.", DocumentNo);
//         IF PortalDoc.FINDLAST THEN
//             LineNo := PortalDoc."LineNo." + 1
//         else
//             LineNo := 1;
//         EXIT(LineNo);
//     end;


//     [Scope('Cloud')]
//     procedure GetPortalDocuments(DocumentNo: Code[20]) Result: Text
//     begin
//         Result := '[]';

//         DocumentsTbl.RESET;
//         DocumentsTbl.SETRANGE("DocumentNo.", DocumentNo);
//         IF DocumentsTbl.FINDSET THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"LineNo":' + FORMAT(DocumentsTbl."LineNo.") + ',';
//                 Result += '"DocumentNo":"' + FORMAT(DocumentsTbl."DocumentNo.") + '",';
//                 Result += '"DocumentCode":"' + FORMAT(DocumentsTbl."Document Code") + '",';
//                 Result += '"DocumentDescription":"' + FORMAT(DocumentsTbl."Document Description") + '",';
//                 if Format(DocumentsTbl."Document Attached") = 'Yes' then begin
//                     Result += '"DocumentAttached":true,';
//                     Result += '"ConfirmAttachment":"Document Attached.",';
//                 end else begin
//                     Result += '"DocumentAttached":false,';
//                     Result += '"ConfirmAttachment":"No Document Attached.",';
//                 end;
//                 Result += '"LocalURL":"' + FORMAT(DocumentsTbl."Local File URL") + '",';
//                 Result += '"SharePointURL":"' + DocumentsTbl."SharePoint URL" + '"';
//                 Result += '},';
//             UNTIL DocumentsTbl.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END;
//     end;

//     [Scope('Cloud')]
//     procedure GetPortalDocumentByDocCode(DocumentNo: Code[20]; DocumentCode: Code[20]) Result: Text
//     begin
//         Result := '[]';

//         DocumentsTbl.RESET;
//         DocumentsTbl.SETRANGE("DocumentNo.", DocumentNo);
//         DocumentsTbl.SETRANGE("Document Code", DocumentCode);
//         IF DocumentsTbl.FindSet() THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"LineNo":' + FORMAT(DocumentsTbl."LineNo.") + ',';
//                 Result += '"DocumentNo":"' + FORMAT(DocumentsTbl."DocumentNo.") + '",';
//                 Result += '"DocumentCode":"' + FORMAT(DocumentsTbl."Document Code") + '",';
//                 Result += '"DocumentDescription":"' + FORMAT(DocumentsTbl."Document Description") + '",';
//                 if Format(DocumentsTbl."Document Attached") = 'Yes' then
//                     Result += '"DocumentAttached":true,'
//                 else
//                     Result += '"DocumentAttached":false,';
//                 Result += '"LocalURL":"' + FORMAT(DocumentsTbl."Local File URL") + '",';
//                 Result += '"SharePointURL":"' + DocumentsTbl."SharePoint URL" + '"';
//                 Result += '},';
//             UNTIL DocumentsTbl.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END;
//     end;

//     [Scope('Cloud')]
//     procedure GetPortalDocumentByLineNo(LineNo: Integer; DocumentNo: Code[50]) Result: Text
//     begin
//         Result := '';

//         DocumentsTbl.Reset;
//         DocumentsTbl.SetRange("LineNo.", LineNo);
//         DocumentsTbl.SetRange("DocumentNo.", DocumentNo);
//         if DocumentsTbl.FindFirst then begin
//             Result += '{';
//             Result += '"LineNo":' + FORMAT(DocumentsTbl."LineNo.") + ',';
//             Result += '"DocumentNo":"' + FORMAT(DocumentsTbl."DocumentNo.") + '",';
//             Result += '"DocumentCode":"' + FORMAT(DocumentsTbl."Document Code") + '",';
//             Result += '"DocumentDescription":"' + FORMAT(DocumentsTbl."Document Description") + '",';
//             if Format(DocumentsTbl."Document Attached") = 'Yes' then begin
//                 Result += '"DocumentAttached":true,';
//                 Result += '"ConfirmAttachment":"Document Attached.",';
//             end else begin
//                 Result += '"DocumentAttached":false,';
//                 Result += '"ConfirmAttachment":"No Document Attached.",';
//             end;
//             Result += '"LocalURL":"' + FORMAT(DocumentsTbl."Local File URL") + '",';
//             Result += '"SharePointURL":"' + DocumentsTbl."SharePoint URL" + '"';
//             Result += '}';
//         end else begin
//             Result += '{';
//             Result += '"LineNo":0,';
//             Result += '"DocumentNo":"",';
//             Result += '"DocumentCode":"",';
//             Result += '"DocumentDescription":"",';
//             Result += '"ConfirmAttachment":"No Document Attached.",';
//             Result += '"DocumentAttached":false,';
//             Result += '"LocalURL":"",';
//             Result += '"SharePointURL":""';
//             Result += '}';
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure InsertSalaryAdvanceDocuments(DocumentNo: Code[20]) DocumentsInserted: Boolean
//     var
//         PortalDocuments: Record "Portal Documents";
//         SelfserviceDocuments: record "Selfservice Documents";
//     begin

//         SelfserviceDocuments.Reset();
//         SelfserviceDocuments.SetFilter("Document Type", '=%1', SelfserviceDocuments."Document Type"::"Salary Advance");
//         if SelfserviceDocuments.FindSet() then begin
//             repeat
//                 PortalDocuments.Reset();
//                 PortalDocuments."LineNo." := GetNextLineNo(DocumentNo);
//                 PortalDocuments."DocumentNo." := DocumentNo;
//                 PortalDocuments."Document Code" := SelfserviceDocuments."Document Code";
//                 PortalDocuments."Document Description" := SelfserviceDocuments."Document Description";
//                 PortalDocuments.insert;
//             until SelfserviceDocuments.Next() = 0;
//         end;
//     end;


//     [Scope('Cloud')]
//     procedure InsertTrainingNeedDocuments(DocumentNo: Code[20]) DocumentsInserted: Boolean
//     var
//         PortalDocuments: Record "Portal Documents";
//         SelfserviceDocuments: record "Selfservice Documents";
//     begin

//         SelfserviceDocuments.Reset();
//         SelfserviceDocuments.SetFilter("Document Type", '=%1', SelfserviceDocuments."Document Type"::"Training Need");
//         if SelfserviceDocuments.FindSet() then begin
//             repeat
//                 PortalDocuments.Reset();
//                 PortalDocuments."LineNo." := GetNextLineNo(DocumentNo);
//                 PortalDocuments."DocumentNo." := DocumentNo;
//                 PortalDocuments."Document Code" := SelfserviceDocuments."Document Code";
//                 PortalDocuments."Document Description" := SelfserviceDocuments."Document Description";
//                 PortalDocuments.insert;
//             until SelfserviceDocuments.Next() = 0;
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure InsertTrainingApplicationDocuments(DocumentNo: Code[20]) DocumentsInserted: Boolean
//     var
//         PortalDocuments: Record "Portal Documents";
//         SelfserviceDocuments: record "Selfservice Documents";
//     begin

//         SelfserviceDocuments.Reset();
//         SelfserviceDocuments.SetFilter("Document Type", '=%1', SelfserviceDocuments."Document Type"::"Training Application");
//         if SelfserviceDocuments.FindSet() then begin
//             repeat
//                 PortalDocuments.Reset();
//                 PortalDocuments."LineNo." := GetNextLineNo(DocumentNo);
//                 PortalDocuments."DocumentNo." := DocumentNo;
//                 PortalDocuments."Document Code" := SelfserviceDocuments."Document Code";
//                 PortalDocuments."Document Description" := SelfserviceDocuments."Document Description";
//                 PortalDocuments.insert;
//             until SelfserviceDocuments.Next() = 0;
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure InsertTrainingEvaluationDocuments(DocumentNo: Code[20]) DocumentsInserted: Boolean
//     var
//         PortalDocuments: Record "Portal Documents";
//         SelfserviceDocuments: record "Selfservice Documents";
//     begin

//         SelfserviceDocuments.Reset();
//         SelfserviceDocuments.SetFilter("Document Type", '=%1', SelfserviceDocuments."Document Type"::"Training Evaluation");
//         if SelfserviceDocuments.FindSet() then begin
//             repeat
//                 PortalDocuments.Reset();
//                 PortalDocuments."LineNo." := GetNextLineNo(DocumentNo);
//                 PortalDocuments."DocumentNo." := DocumentNo;
//                 PortalDocuments."Document Code" := SelfserviceDocuments."Document Code";
//                 PortalDocuments."Document Description" := SelfserviceDocuments."Document Description";
//                 PortalDocuments.insert;
//             until SelfserviceDocuments.Next() = 0;
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure InsertEmployeeRequisitionDocuments(DocumentNo: Code[20]) DocumentsInserted: Boolean
//     var
//         PortalDocuments: Record "Portal Documents";
//         SelfserviceDocuments: record "Selfservice Documents";
//     begin

//         SelfserviceDocuments.Reset();
//         SelfserviceDocuments.SetFilter("Document Type", '=%1', SelfserviceDocuments."Document Type"::"Employee Requisition");
//         if SelfserviceDocuments.FindSet() then begin
//             repeat
//                 PortalDocuments.Reset();
//                 PortalDocuments."LineNo." := GetNextLineNo(DocumentNo);
//                 PortalDocuments."DocumentNo." := DocumentNo;
//                 PortalDocuments."Document Code" := SelfserviceDocuments."Document Code";
//                 PortalDocuments."Document Description" := SelfserviceDocuments."Document Description";
//                 PortalDocuments.insert;
//             until SelfserviceDocuments.Next() = 0;
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure InsertLeaveApplicationDocumentEntry("DocumentNo.": Code[20]; LeaveType: Code[50]) DocumentEntryInserted: Boolean
//     begin
//         DocumentEntryInserted := false;

//         HRLeaveTypes.Reset;
//         HRLeaveTypes.SetRange(HRLeaveTypes.Code, LeaveType);
//         HRLeaveTypes.SetRange(HRLeaveTypes."Attach Leave Application Doc.", true);
//         if HRLeaveTypes.FindFirst() then begin

//             //delete existing documents
//             DocumentsTbl.Reset;
//             DocumentsTbl.SetRange(DocumentsTbl."DocumentNo.", "DocumentNo.");
//             if DocumentsTbl.FindSet then begin
//                 DocumentsTbl.DeleteAll;
//             end;
//             //end delete existing documents

//             //Create document link
//             DocumentsTbl2.Reset();
//             DocumentsTbl2."DocumentNo." := "DocumentNo.";
//             DocumentsTbl2.Validate("DocumentNo.");
//             DocumentsTbl2."Document Code" := HRLeaveTypes.Code;
//             DocumentsTbl2."Document Description" := UpperCase(HRLeaveTypes.Description);
//             DocumentsTbl2."Document Attached" := false;
//             DocumentsTbl2."Local File URL" := '';
//             if DocumentsTbl2.Insert then
//                 DocumentEntryInserted := true;
//             //Create document link

//         end else begin
//             DocumentsTbl3.Reset;
//             DocumentsTbl3.SetRange(DocumentsTbl3."DocumentNo.", "DocumentNo.");
//             if DocumentsTbl3.FindSet then begin
//                 DocumentsTbl3.DeleteAll;
//             end;
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure InsertAppraisalTargetDocuments(DocumentNo: Code[20]) DocumentsInserted: Boolean
//     var
//         PortalDocuments: Record "Portal Documents";
//         SelfserviceDocuments: record "Selfservice Documents";
//     begin

//         SelfserviceDocuments.Reset();
//         SelfserviceDocuments.SetFilter("Document Type", '=%1', SelfserviceDocuments."Document Type"::"Appraisal Target");
//         if SelfserviceDocuments.FindSet() then begin
//             repeat
//                 PortalDocuments.Reset();
//                 PortalDocuments."LineNo." := GetNextLineNo(DocumentNo);
//                 PortalDocuments."DocumentNo." := DocumentNo;
//                 PortalDocuments."Document Code" := SelfserviceDocuments."Document Code";
//                 PortalDocuments."Document Description" := SelfserviceDocuments."Document Description";
//                 PortalDocuments.insert;
//             until SelfserviceDocuments.Next() = 0;
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure InsertAppraisalEvaluationDocuments(DocumentNo: Code[20]) DocumentsInserted: Boolean
//     var
//         PortalDocuments: Record "Portal Documents";
//         SelfserviceDocuments: record "Selfservice Documents";
//     begin

//         SelfserviceDocuments.Reset();
//         SelfserviceDocuments.SetFilter("Document Type", '=%1', SelfserviceDocuments."Document Type"::"Appraisal Evaluation");
//         if SelfserviceDocuments.FindSet() then begin
//             repeat
//                 PortalDocuments.Reset();
//                 PortalDocuments."LineNo." := GetNextLineNo(DocumentNo);
//                 PortalDocuments."DocumentNo." := DocumentNo;
//                 PortalDocuments."Document Code" := SelfserviceDocuments."Document Code";
//                 PortalDocuments."Document Description" := SelfserviceDocuments."Document Description";
//                 PortalDocuments.insert;
//             until SelfserviceDocuments.Next() = 0;
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure UploadDocument(LineNo: integer; DocumentNo: Code[20]; DocumentCode: Code[50]; LocalUrl: Text[250]; SharePointUrl: Text[250])
//     var
//         PortalDocuments: Record "Portal Documents";
//         FromString: Text;
//         ToString: Text;
//         Path1: Text;
//         Path2: Text;
//         CompanyInformation: Record "Company Information";
//         Txt001: Label '%1';
//     begin
//         PortalDocuments.Reset;
//         PortalDocuments.SetRange(PortalDocuments."LineNo.", LineNo);
//         PortalDocuments.SetRange(PortalDocuments."DocumentNo.", DocumentNo);
//         PortalDocuments.SetRange(PortalDocuments."Document Code", DocumentCode);
//         if PortalDocuments.FindFirst then begin
//             PortalDocuments."Local File URL" := FileManagement.GetFileName(LocalUrl);
//             PortalDocuments."SharePoint URL" := SharePointUrl;
//             PortalDocuments."Document Attached" := true;
//             PortalDocuments.Modify;
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure CheckDocumentAttached("DocumentNo.": Code[20])
//     var
//         Txt001: Label 'Please attach %1.';
//         PortalDocuments: Record "Portal Documents";
//         SelfServiceAttachments: Record "Selfservice Documents";
//     begin

//         PortalDocuments.Reset;
//         PortalDocuments.SetRange(PortalDocuments."DocumentNo.", "DocumentNo.");
//         if PortalDocuments.FindSet() then begin
//             repeat
//                 SelfServiceAttachments.Reset();
//                 SelfServiceAttachments.SetRange("Document Code", PortalDocuments."Document Code");
//                 SelfServiceAttachments.SetRange(Mandatory, true);
//                 IF SelfServiceAttachments.FindFirst() THEN begin
//                     if PortalDocuments."SharePoint URL" = '' then
//                         Error(Error001, PortalDocuments."Document Description");
//                 end;
//             until PortalDocuments.next() = 0;
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure CheckLeaveApplicationDocumentAttached("DocumentNo.": Code[20]; LeaveType: Code[50])
//     var
//         Txt001: Label 'Please attach the supporting document for the %1';
//         PortalDocuments: Record "Portal Documents";
//         SelfServiceAttachments: Record "Selfservice Documents";
//     begin

//         HRLeaveTypes.Reset();
//         HRLeaveTypes.SetRange(Code, LeaveType);
//         HRLeaveTypes.SetRange("Attach Leave Application Doc.", true);
//         if HRLeaveTypes.FindFirst() then begin
//             //check doc attached.
//             PortalDocuments.Reset;
//             PortalDocuments.SetRange(PortalDocuments."DocumentNo.", "DocumentNo.");
//             PortalDocuments.SetFilter("SharePoint URL", '%1', '');
//             if PortalDocuments.FindFirst() then
//                 Error(Txt001, LeaveType);
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure GetSharePointLink(DocumentNo: Code[20]) SharePointUrl: Text
//     var
//         PortalDocuments: Record "Portal Documents";
//     begin
//         PortalDocuments.Reset();
//         PortalDocuments.SetRange("DocumentNo.", DocumentNo);
//         if PortalDocuments.FindFirst() then
//             SharePointUrl := PortalDocuments."SharePoint URL";
//     end;

//     [Scope('Cloud')]
//     procedure GetDocumentsFromFinanceDepartment() Result: Text
//     var
//         HRandAdminDocument: Record "Documents & Links";
//     begin
//         HRandAdminDocument.RESET;
//         HRandAdminDocument.SetRange(Shared, true);
//         HRandAdminDocument.SetRange("Department Code", HRandAdminDocument."Department Code"::FINANCE);
//         IF HRandAdminDocument.FINDSET THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"DocumentCode":' + FORMAT(HRandAdminDocument.Code) + ',';
//                 Result += '"DocumentDescription":"' + FORMAT(HRandAdminDocument."Document Description") + '",';
//                 Result += '"DocumentLink":"' + HRandAdminDocument."Document Link" + '"';
//                 Result += '},';
//             UNTIL HRandAdminDocument.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END ELSE BEGIN
//             Result := '[{';
//             Result += '"DocumentCode":0,';
//             Result += '"DocumentDescription":"Sorry, there is no document shared so far.",';
//             Result += '"DocumentLink":""';
//             Result += '}]';
//         END;
//     end;

//     [Scope('Cloud')]
//     procedure GetDocumentsFromProcurementDepartment() Result: Text
//     var
//         HRandAdminDocument: Record "Documents & Links";
//     begin
//         HRandAdminDocument.RESET;
//         HRandAdminDocument.SetRange(Shared, true);
//         HRandAdminDocument.SetRange("Department Code", HRandAdminDocument."Department Code"::PROCUREMENT);
//         IF HRandAdminDocument.FINDSET THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"DocumentCode":' + FORMAT(HRandAdminDocument.Code) + ',';
//                 Result += '"DocumentDescription":"' + FORMAT(HRandAdminDocument."Document Description") + '",';
//                 Result += '"DocumentLink":"' + HRandAdminDocument."Document Link" + '"';
//                 Result += '},';
//             UNTIL HRandAdminDocument.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END ELSE BEGIN
//             Result := '[{';
//             Result += '"DocumentCode":0,';
//             Result += '"DocumentDescription":"Sorry, there is no document shared so far.",';
//             Result += '"DocumentLink":""';
//             Result += '}]';
//         END;
//     end;

//     [Scope('Cloud')]
//     procedure GetDocumentsFromHRDepartment() Result: Text
//     var
//         HRandAdminDocument: Record "Documents & Links";
//     begin
//         HRandAdminDocument.RESET;
//         HRandAdminDocument.SetRange(Shared, true);
//         HRandAdminDocument.SetRange("Department Code", HRandAdminDocument."Department Code"::HR);
//         IF HRandAdminDocument.FINDSET THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"DocumentCode":' + FORMAT(HRandAdminDocument.Code) + ',';
//                 Result += '"DocumentDescription":"' + FORMAT(HRandAdminDocument."Document Description") + '",';
//                 Result += '"DocumentLink":"' + HRandAdminDocument."Document Link" + '"';
//                 Result += '},';
//             UNTIL HRandAdminDocument.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END ELSE BEGIN
//             Result := '[{';
//             Result += '"DocumentCode":0,';
//             Result += '"DocumentDescription":"Sorry, there is no document shared so far.",';
//             Result += '"DocumentLink":""';
//             Result += '}]';
//         END;
//     end;

//     [Scope('Cloud')]
//     procedure GetDocumentsFromICTDepartment() Result: Text
//     var
//         HRandAdminDocument: Record "Documents & Links";
//     begin
//         HRandAdminDocument.RESET;
//         HRandAdminDocument.SetRange(Shared, true);
//         HRandAdminDocument.SetRange("Department Code", HRandAdminDocument."Department Code"::ICT);
//         IF HRandAdminDocument.FINDSET THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"DocumentCode":' + FORMAT(HRandAdminDocument.Code) + ',';
//                 Result += '"DocumentDescription":"' + FORMAT(HRandAdminDocument."Document Description") + '",';
//                 Result += '"DocumentLink":"' + HRandAdminDocument."Document Link" + '"';
//                 Result += '},';
//             UNTIL HRandAdminDocument.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END ELSE BEGIN
//             Result := '[{';
//             Result += '"DocumentCode":0,';
//             Result += '"DocumentDescription":"Sorry, there is no document shared so far.",';
//             Result += '"DocumentLink":""';
//             Result += '}]';
//         END;
//     end;


//     [Scope('Cloud')]
//     procedure GetGrantsKnowledgeMgtLinks() Result: Text
//     var
//         HRandAdminDocument: Record "Documents & Links";
//     begin
//         HRandAdminDocument.RESET;
//         HRandAdminDocument.SetRange(Shared, true);
//         HRandAdminDocument.SetRange("Department Code", HRandAdminDocument."Department Code"::"Grants Knowledge Mgt.");
//         IF HRandAdminDocument.FINDSET THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"DocumentCode":' + FORMAT(HRandAdminDocument.Code) + ',';
//                 Result += '"DocumentDescription":"' + FORMAT(HRandAdminDocument."Document Description") + '",';
//                 Result += '"DocumentLink":"' + HRandAdminDocument."Document Link" + '"';
//                 Result += '},';
//             UNTIL HRandAdminDocument.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END ELSE BEGIN
//             Result := '[{';
//             Result += '"DocumentCode":0,';
//             Result += '"DocumentDescription":"Sorry, there is no document shared so far.",';
//             Result += '"DocumentLink":""';
//             Result += '}]';
//         END;
//     end;


//     [Scope('Cloud')]
//     procedure GetDocumentsFromCommunicationDepartment() Result: Text
//     var
//         HRandAdminDocument: Record "Documents & Links";
//     begin
//         HRandAdminDocument.RESET;
//         HRandAdminDocument.SetRange(Shared, true);
//         HRandAdminDocument.SetRange("Department Code", HRandAdminDocument."Department Code"::COMMUNICATION);
//         IF HRandAdminDocument.FINDSET THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"DocumentCode":' + FORMAT(HRandAdminDocument.Code) + ',';
//                 Result += '"DocumentDescription":"' + FORMAT(HRandAdminDocument."Document Description") + '",';
//                 Result += '"DocumentLink":"' + HRandAdminDocument."Document Link" + '"';
//                 Result += '},';
//             UNTIL HRandAdminDocument.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END ELSE BEGIN
//             Result := '[{';
//             Result += '"DocumentCode":0,';
//             Result += '"DocumentDescription":"Sorry, there is no document shared so far.",';
//             Result += '"DocumentLink":""';
//             Result += '}]';
//         END;
//     end;

//     [Scope('Cloud')]
//     procedure GetDocumentsFromResearchDepartment() Result: Text
//     var
//         HRandAdminDocument: Record "Documents & Links";
//     begin
//         HRandAdminDocument.RESET;
//         HRandAdminDocument.SetRange(Shared, true);
//         HRandAdminDocument.SetRange("Department Code", HRandAdminDocument."Department Code"::RESEARCH);
//         IF HRandAdminDocument.FINDSET THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"DocumentCode":' + FORMAT(HRandAdminDocument.Code) + ',';
//                 Result += '"DocumentDescription":"' + FORMAT(HRandAdminDocument."Document Description") + '",';
//                 Result += '"DocumentLink":"' + HRandAdminDocument."Document Link" + '"';
//                 Result += '},';
//             UNTIL HRandAdminDocument.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END ELSE BEGIN
//             Result := '[{';
//             Result += '"DocumentCode":0,';
//             Result += '"DocumentDescription":"Sorry, there is no document shared so far.",';
//             Result += '"DocumentLink":""';
//             Result += '}]';
//         END;
//     end;

//     [Scope('Cloud')]
//     procedure GetDocumentsFromLegalDepartment() Result: Text
//     var
//         HRandAdminDocument: Record "Documents & Links";
//     begin
//         HRandAdminDocument.RESET;
//         HRandAdminDocument.SetRange(Shared, true);
//         HRandAdminDocument.SetRange("Department Code", HRandAdminDocument."Department Code"::LEGAL);
//         IF HRandAdminDocument.FINDSET THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"DocumentCode":' + FORMAT(HRandAdminDocument.Code) + ',';
//                 Result += '"DocumentDescription":"' + FORMAT(HRandAdminDocument."Document Description") + '",';
//                 Result += '"DocumentLink":"' + HRandAdminDocument."Document Link" + '"';
//                 Result += '},';
//             UNTIL HRandAdminDocument.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END ELSE BEGIN
//             Result := '[{';
//             Result += '"DocumentCode":0,';
//             Result += '"DocumentDescription":"Sorry, there is no document shared so far.",';
//             Result += '"DocumentLink":""';
//             Result += '}]';
//         END;
//     end;

//     [Scope('Cloud')]
//     procedure GetDocumentsFromLogisticsDepartment() Result: Text
//     var
//         HRandAdminDocument: Record "Documents & Links";
//     begin
//         HRandAdminDocument.RESET;
//         HRandAdminDocument.SetRange(Shared, true);
//         HRandAdminDocument.SetRange("Department Code", HRandAdminDocument."Department Code"::LOGISTICS);
//         IF HRandAdminDocument.FINDSET THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"DocumentCode":' + FORMAT(HRandAdminDocument.Code) + ',';
//                 Result += '"DocumentDescription":"' + FORMAT(HRandAdminDocument."Document Description") + '",';
//                 Result += '"DocumentLink":"' + HRandAdminDocument."Document Link" + '"';
//                 Result += '},';
//             UNTIL HRandAdminDocument.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END ELSE BEGIN
//             Result := '[{';
//             Result += '"DocumentCode":0,';
//             Result += '"DocumentDescription":"Sorry, there is no document shared so far.",';
//             Result += '"DocumentLink":""';
//             Result += '}]';
//         END;
//     end;

//     [Scope('Cloud')]
//     procedure GetQuickLinks() Result: Text
//     var
//         HRandAdminDocument: Record "Documents & Links";
//     begin
//         HRandAdminDocument.RESET;
//         HRandAdminDocument.SetRange(Shared, true);
//         HRandAdminDocument.SetRange("Department Code", HRandAdminDocument."Department Code"::"QUICK LINK");
//         IF HRandAdminDocument.FINDSET THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"DocumentCode":' + FORMAT(HRandAdminDocument.Code) + ',';
//                 Result += '"DocumentDescription":"' + FORMAT(HRandAdminDocument."Document Description") + '",';
//                 Result += '"DocumentLink":"' + HRandAdminDocument."Document Link" + '"';
//                 Result += '},';
//             UNTIL HRandAdminDocument.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END ELSE BEGIN
//             Result := '[{';
//             Result += '"DocumentCode":0,';
//             Result += '"DocumentDescription":"Sorry, there is no document shared so far.",';
//             Result += '"DocumentLink":""';
//             Result += '}]';
//         END;
//     end;

//     [Scope('Cloud')]
//     procedure GetPolicyLinks() Result: Text
//     var
//         HRandAdminDocument: Record "Documents & Links";
//     begin
//         HRandAdminDocument.RESET;
//         HRandAdminDocument.SetRange(Shared, true);
//         HRandAdminDocument.SetRange("Department Code", HRandAdminDocument."Department Code"::POLICIES);
//         IF HRandAdminDocument.FINDSET THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"DocumentCode":' + FORMAT(HRandAdminDocument.Code) + ',';
//                 Result += '"DocumentDescription":"' + FORMAT(HRandAdminDocument."Document Description") + '",';
//                 Result += '"DocumentLink":"' + HRandAdminDocument."Document Link" + '"';
//                 Result += '},';
//             UNTIL HRandAdminDocument.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END ELSE BEGIN
//             Result := '[{';
//             Result += '"DocumentCode":0,';
//             Result += '"DocumentDescription":"Sorry, there is no document shared so far.",';
//             Result += '"DocumentLink":""';
//             Result += '}]';
//         END;
//     end;

//     [Scope('Cloud')]
//     procedure GetTemplateLinks() Result: Text
//     var
//         HRandAdminDocument: Record "Documents & Links";
//     begin
//         HRandAdminDocument.RESET;
//         HRandAdminDocument.SetRange(Shared, true);
//         HRandAdminDocument.SetRange("Department Code", HRandAdminDocument."Department Code"::TEMPLATES);
//         IF HRandAdminDocument.FINDSET THEN BEGIN
//             Result := '[';
//             REPEAT
//                 Result += '{';
//                 Result += '"DocumentCode":' + FORMAT(HRandAdminDocument.Code) + ',';
//                 Result += '"DocumentDescription":"' + FORMAT(HRandAdminDocument."Document Description") + '",';
//                 Result += '"DocumentLink":"' + HRandAdminDocument."Document Link" + '"';
//                 Result += '},';
//             UNTIL HRandAdminDocument.NEXT = 0;
//             Result := COPYSTR(Result, 1, STRLEN(Result) - 1);
//             Result += ']';
//         END ELSE BEGIN
//             Result := '[{';
//             Result += '"DocumentCode":0,';
//             Result += '"DocumentDescription":"Sorry, there is no document shared so far.",';
//             Result += '"DocumentLink":""';
//             Result += '}]';
//         END;
//     end;

//     [Scope('Cloud')]
//     procedure InsertImprestApplicationDocuments(DocumentNo: Code[20]) ImprestDocuments: Boolean
//     var
//         PortalDocuments: Record "Portal Documents";
//         SelfserviceDocuments: record "Selfservice Documents";
//     begin

//         SelfserviceDocuments.Reset();
//         SelfserviceDocuments.SetFilter("Document Type", '=%1', SelfserviceDocuments."Document Type"::Imprest);
//         SelfserviceDocuments.SetRange(Mandatory, true);
//         if SelfserviceDocuments.FindSet() then begin
//             repeat
//                 PortalDocuments.Reset();
//                 PortalDocuments."LineNo." := GetNextLineNo(DocumentNo);
//                 PortalDocuments."DocumentNo." := DocumentNo;
//                 PortalDocuments."Document Code" := SelfserviceDocuments."Document Code";
//                 PortalDocuments."Document Description" := SelfserviceDocuments."Document Description";
//                 PortalDocuments.insert;
//             until SelfserviceDocuments.Next() = 0;
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure InsertFundsClaimDocuments(DocumentNo: Code[20]) DocumentsInserted: Boolean
//     var
//         PortalDocuments: Record "Portal Documents";
//         SelfserviceDocuments: record "Selfservice Documents";
//     begin

//         SelfserviceDocuments.Reset();
//         SelfserviceDocuments.SetFilter("Document Type", '=%1', SelfserviceDocuments."Document Type"::"Funds Claim");
//         if SelfserviceDocuments.FindSet() then begin
//             repeat
//                 PortalDocuments.Reset();
//                 PortalDocuments."LineNo." := GetNextLineNo(DocumentNo);
//                 PortalDocuments."DocumentNo." := DocumentNo;
//                 PortalDocuments."Document Code" := SelfserviceDocuments."Document Code";
//                 PortalDocuments."Document Description" := SelfserviceDocuments."Document Description";
//                 PortalDocuments.insert;
//             until SelfserviceDocuments.Next() = 0;
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure InsertImprestSurrenderDocuments(DocumentNo: Code[20]) DocumentsInserted: Boolean
//     var
//         PortalDocuments: Record "Portal Documents";
//         SelfserviceDocuments: record "Selfservice Documents";
//     begin

//         SelfserviceDocuments.Reset();
//         SelfserviceDocuments.SetFilter("Document Type", '=%1', SelfserviceDocuments."Document Type"::"Imprest Surrender");
//         if SelfserviceDocuments.FindSet() then begin
//             repeat
//                 PortalDocuments.Reset();
//                 PortalDocuments."LineNo." := GetNextLineNo(DocumentNo);
//                 PortalDocuments."DocumentNo." := DocumentNo;
//                 PortalDocuments."Document Code" := SelfserviceDocuments."Document Code";
//                 PortalDocuments."Document Description" := SelfserviceDocuments."Document Description";
//                 PortalDocuments.insert;
//             until SelfserviceDocuments.Next() = 0;
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure InsertStoreRequisitionDocuments(DocumentNo: Code[20]) DocumentsInserted: Boolean
//     var
//         PortalDocuments: Record "Portal Documents";
//         SelfserviceDocuments: record "Selfservice Documents";
//     begin

//         SelfserviceDocuments.Reset();
//         SelfserviceDocuments.SetFilter("Document Type", '=%1', SelfserviceDocuments."Document Type"::"Store Requisition");
//         if SelfserviceDocuments.FindSet() then begin
//             repeat
//                 PortalDocuments.Reset();
//                 PortalDocuments."LineNo." := GetNextLineNo(DocumentNo);
//                 PortalDocuments."DocumentNo." := DocumentNo;
//                 PortalDocuments."Document Code" := SelfserviceDocuments."Document Code";
//                 PortalDocuments."Document Description" := SelfserviceDocuments."Document Description";
//                 PortalDocuments.insert;
//             until SelfserviceDocuments.Next() = 0;
//         end;
//     end;

//     [Scope('Cloud')]
//     procedure InsertPurchaseRequisitionDocuments(DocumentNo: Code[20]) ImprestDocuments: Boolean
//     var
//         PortalDocuments: Record "Portal Documents";
//         SelfserviceDocuments: record "Selfservice Documents";
//     begin

//         SelfserviceDocuments.Reset();
//         SelfserviceDocuments.SetFilter("Document Type", '=%1', SelfserviceDocuments."Document Type"::"Purchase Requisition");
//         if SelfserviceDocuments.FindSet() then begin
//             repeat
//                 PortalDocuments.Reset();
//                 PortalDocuments."LineNo." := GetNextLineNo(DocumentNo);
//                 PortalDocuments."DocumentNo." := DocumentNo;
//                 PortalDocuments."Document Code" := SelfserviceDocuments."Document Code";
//                 PortalDocuments."Document Description" := SelfserviceDocuments."Document Description";
//                 PortalDocuments.insert;
//             until SelfserviceDocuments.Next() = 0;
//         end;
//     end;

//     procedure InsertActivityRequestDocuments(DocumentNo: Code[20]) DocumentsInserted: Boolean
//     var
//         PortalDocuments: Record "Portal Documents";
//         SelfserviceDocuments: record "Selfservice Documents";
//     begin

//         SelfserviceDocuments.Reset();
//         SelfserviceDocuments.SetFilter("Document Type", '=%1', SelfserviceDocuments."Document Type"::"Activity Request");
//         if SelfserviceDocuments.FindSet() then begin
//             repeat
//                 PortalDocuments.Reset();
//                 PortalDocuments."LineNo." := GetNextLineNo(DocumentNo);
//                 PortalDocuments."DocumentNo." := DocumentNo;
//                 PortalDocuments."Document Code" := SelfserviceDocuments."Document Code";
//                 PortalDocuments."Document Description" := SelfserviceDocuments."Document Description";
//                 PortalDocuments.insert;
//             until SelfserviceDocuments.Next() = 0;
//         end;
//     end;
}

