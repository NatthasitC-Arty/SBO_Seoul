-- ============================================================
-- Report: Purchase Order_Vat_Show.rpt
Path:   Purchase Order_Vat_Show.rpt
Extracted: 2026-07-28 00:21:44
-- Source: Main Report
-- Table:  AP_PO
-- ============================================================

SELECT
    OPOR.DocEntry,
    OCRD.U_SLD_Title,
    CAST(OCRD.U_SLD_FullName AS nvarchar(max)) AS 'U_SLD_FullName',
    CASE WHEN OCRD.Phone2 IS NULL THEN ''
      WHEN OCRD.Phone2 IS NOT NULL THEN ', ' + OCRD.Phone2
      END 'Phone2',
    OCRD.Phone1,
    ISNULL(OCRD.Fax,'') AS 'Fax',
    OCRD.LicTradNum,
    NNM1.BeginStr,
    OPOR.DocNum,
    OPOR.CardCode,
    OPOR.DocDate,
    OPOR.DocDueDate,
    OCTG.PymntGroup,
    CAST(POR1.VisOrder AS FLOAT) AS 'No.',
    POR1.LineNum as 'Line No.',
    POR1.ItemCode,
    CASE 
        WHEN split.RowKind = 2 THEN 0 
        WHEN ISNULL(POR1.U_SLD_Dis_Amount, 0) = 0 THEN 0 
        ELSE 
            (POR1.U_SLD_Dis_Amount / 
            NULLIF(
                (CASE 
                    WHEN OPOR.DocCur = 'THB' THEN
                        CASE WHEN POR1.VatSum = 0 AND ISNULL(CAST(OVTG.Rate AS DECIMAL(19,6)), 0) > 0
                             THEN POR1.LineTotal
                             ELSE POR1.LineTotal + POR1.VatSum 
                        END
                    ELSE POR1.TotalFrgn
                 END) + POR1.U_SLD_Dis_Amount
            , 0) 
            ) * 100 
    END AS '% Dis line',
    OPOR.DiscPrcnt AS N'% ส่วนลดท้ายบิล',
    CASE 
        WHEN split.RowKind = 2 AND ISNULL(CAST(POR1.U_SLD_Cat_Name AS nvarchar(max)), '') <> ''
        THEN CAST(POR1.U_SLD_Cat_Name AS nvarchar(max)) + N' (ของแถม)'
        WHEN split.RowKind = 2 
        THEN CAST(POR1.Dscription AS nvarchar(max)) + N' (ของแถม)'
        WHEN ISNULL(CAST(POR1.U_SLD_Cat_Name AS nvarchar(max)), '') <> ''
        THEN CAST(POR1.U_SLD_Cat_Name AS nvarchar(max))
        ELSE CAST(POR1.Dscription AS nvarchar(max))
    END AS 'Dscription',
    CAST(por12.StreetB AS nvarchar(max)) as StreetB, CAST(por12.StreetNoB AS nvarchar(max)) as StreetNoB, CAST(por12.BlockB AS nvarchar(max)) as BlockB, CAST(por12.BuildingB AS nvarchar(max)) as BuildingB,
    CAST(por12.CityB AS nvarchar(max)) as CityB, por12.ZipCodeB, CAST(por12.CountyB AS nvarchar(max)) as CountyB, por12.StateB,
    CASE WHEN split.RowKind = 2 THEN POR1.U_SLD_Free
         WHEN POR1.U_SLD_Free IS NOT NULL THEN POR1.Quantity - POR1.U_SLD_Free
         ELSE POR1.Quantity END AS Quantity,
    CASE WHEN split.RowKind = 2 THEN 0 ELSE POR1.U_SLD_Unitprice END AS 'ราคาต่อหน่วย',
    CASE
      WHEN split.RowKind = 2 THEN ''
      WHEN POR1.DiscPrcnt = 0 THEN ''
      ELSE CONCAT(CAST(POR1.DiscPrcnt AS DECIMAL(19,2)), ' %')
    END AS DiscPrcnt,
    CASE WHEN split.RowKind = 2 THEN 0
         WHEN OPOR.DocCur = 'THB' THEN
           CASE WHEN POR1.VatSum = 0 AND ISNULL(CAST(OVTG.Rate AS DECIMAL(19,6)), 0) > 0
                THEN POR1.LineTotal * 100 / (100 + CAST(OVTG.Rate AS DECIMAL(19,6)))
                ELSE POR1.LineTotal END
         ELSE POR1.TotalFrgn * 100 / (100 + ISNULL(CAST(OVTG.Rate AS DECIMAL(19,6)), 0))
    END AS 'LineTotal',
    CASE WHEN OPOR.DocCur = 'THB' THEN OPOR.DiscSum ELSE OPOR.DiscSumFC END AS 'DiscSum',
    CASE WHEN split.RowKind = 2 THEN 0
         WHEN OPOR.DocCur = 'THB' THEN
           CASE WHEN POR1.VatSum = 0 AND ISNULL(CAST(OVTG.Rate AS DECIMAL(19,6)), 0) > 0
                THEN POR1.LineTotal * CAST(OVTG.Rate AS DECIMAL(19,6)) / (100 + CAST(OVTG.Rate AS DECIMAL(19,6)))
                ELSE POR1.VatSum END
         ELSE POR1.TotalFrgn * ISNULL(CAST(OVTG.Rate AS DECIMAL(19,6)), 0) / (100 + ISNULL(CAST(OVTG.Rate AS DECIMAL(19,6)), 0))
    END AS 'VatSum',
    OPOR.DocCur,
    CASE WHEN split.RowKind = 2 THEN 0
         WHEN OPOR.DocCur = 'THB' THEN
           CASE WHEN POR1.VatSum = 0 AND ISNULL(CAST(OVTG.Rate AS DECIMAL(19,6)), 0) > 0
                THEN POR1.LineTotal
                ELSE POR1.LineTotal + POR1.VatSum END
         ELSE POR1.TotalFrgn
    END AS 'DocTotal',
    POR1.unitmsr,
    CAST(OPOR.Comments AS nvarchar(max)) AS 'Comments',
    POR1.LineType,
    CONCAT(OCPR.FirstName,' ',OCPR.LastName) AS 'Coontact',
    OCRD.cntctPrsn,
    OCRD.E_mail,
    CASE
      WHEN split.RowKind = 2 THEN ''
      WHEN POR1.U_SLD_Dis_Amount = 0 THEN ''
      ELSE CONVERT(varchar, CAST(POR1.U_SLD_Dis_Amount AS money), 1)
    END AS U_SLD_Dis_Amount,
    CAST(ocrd.MailAddres AS nvarchar(max)) AS 'MailAddres',
    OPOR.DocTotal AS 'ไม่มีเงื่อนไข',
    POR1.Project,
    OCPR.Name,
    OCPR.Tel1,
    OCPR.E_MailL,
    POR1.U_SLD_Free,
    POR1.OcrCode2, 
    CAST(D1.BuildingS AS NVARCHAR(MAX))  AS N'บริษัท รวยมั่งคั่ง 69 จำกัด',
    CAST(D1.Address2S AS NVARCHAR(MAX)) AS N'คุณปลา /คุณไข่',
    CAST(D1.Address3S AS NVARCHAR(MAX)) AS '061-910-2595 / 062-327-7494',
    CAST(D1.StreetS AS NVARCHAR(MAX))   AS N'99/64 หมู่ที่ 5',
    CAST(D1.BlockS AS NVARCHAR(MAX))    AS N'บางระกำ',
    CAST(D1.CityS AS NVARCHAR(MAX))     AS N'บางเลน',
    CAST(D1.CountyS AS NVARCHAR(MAX))   AS N'นครปฐม',
    CAST(D1.ZipCodeS AS NVARCHAR(MAX))  AS 'Zipcode 73130',
    ISNULL(
    CAST(OPRC.PrcName AS nvarchar(max)),
    CAST(MAX(OPRC.PrcName) OVER (PARTITION BY OPOR.DocEntry) AS nvarchar(max))
  ) AS 'BranchName'
FROM OPOR
    INNER JOIN POR1 ON OPOR.DocEntry = POR1.DocEntry
    CROSS APPLY (
        SELECT 1 AS RowKind
        UNION ALL
        SELECT 2 WHERE POR1.U_SLD_Free IS NOT NULL AND POR1.U_SLD_Free <> 0
    ) AS split
    LEFT JOIN OVTG ON POR1.U_SLD_Tax_Form = OVTG.Code
    LEFT JOIN OITM ON POR1.ItemCode = OITM.ItemCode
    LEFT JOIN OCRD ON OPOR.CardCode = OCRD.CardCode
    LEFT JOIN CRD1 ON (OPOR.[PaytoCode] = CRD1.[Address] AND OPOR.CardCode = CRD1.CardCode and CRD1.AdresType = 'B')
    LEFT JOIN OCPR ON OPOR.CntctCode = OCPR.CntctCode
    LEFT JOIN NNM1 ON OPOR.Series = NNM1.Series
    LEFT JOIN OCTG ON OPOR.GroupNum = OCTG.GroupNum
    LEFT JOIN OHEM ON OPOR.OwnerCode = OHEM.empID
    LEFT JOIN OSLP ON OPOR.SlpCode = OSLP.SlpCode
    LEFT JOIN POR12 ON OPOR.DocEntry = POR12.DocEntry
    LEFT JOIN OUSR ON OPOR.UserSign = OUSR.USERID
    LEFT JOIN OPRJ ON POR1.Project = OPRJ.PrjCode
    LEFT JOIN OPRC ON POR1.OcrCode2 = OPRC.PrcCode  
    LEFT JOIN POR12 D1 ON OPOR.DocEntry = D1.DocEntry 
    LEFT JOIN [dbo].[@SLDT_SET_BRANCH] BRANCH ON OPOR.U_SLD_LVatBranch = BRANCH.Code
    CROSS JOIN OADM
WHERE OPOR.DocEntry = {?Dockey@}
ORDER BY 'No.' , 'Line No.' , split.RowKind




