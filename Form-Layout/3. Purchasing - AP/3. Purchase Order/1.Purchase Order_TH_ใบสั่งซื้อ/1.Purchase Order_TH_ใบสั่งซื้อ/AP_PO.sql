-- ============================================================
-- Report: 1.Purchase Order_TH_ใบสั่งซื้อ.rpt
Path:   1.Purchase Order_TH_ใบสั่งซื้อ.rpt
Extracted: 2026-06-16 17:07:12
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
    CASE WHEN split.RowKind = 2
         THEN CAST(POR1.Dscription AS nvarchar(max)) + N' (ของแถม)'
         ELSE CAST(POR1.Dscription AS nvarchar(max)) END AS 'Dscription',
    CASE WHEN split.RowKind = 2 THEN POR1.U_SLD_Free
         WHEN POR1.U_SLD_Free IS NOT NULL THEN POR1.Quantity - POR1.U_SLD_Free
         ELSE POR1.Quantity END AS Quantity,
    CASE WHEN split.RowKind = 2 THEN 0 ELSE POR1.PriceBefDi END AS PriceBefDi,
    -- โชว์ % เฉพาะบรรทัดที่มีส่วนลด, ที่เหลือ = ''
    CASE
      WHEN split.RowKind = 2 THEN ''
      WHEN POR1.DiscPrcnt = 0 THEN ''
      ELSE CONCAT(CAST(POR1.DiscPrcnt AS DECIMAL(19,2)), ' %')
    END AS DiscPrcnt,
    -- LineTotal (net, ก่อน VAT): ปกติ=ค่า SAP เดิม / เคส VAT ปลอม=ถอด VAT ออก gross*100/(100+Rate)
    CASE WHEN split.RowKind = 2 THEN 0
         WHEN OPOR.DocCur = 'THB' THEN
           CASE WHEN POR1.VatSum = 0 AND ISNULL(CAST(OVTG.Rate AS DECIMAL(19,6)), 0) > 0
                THEN POR1.LineTotal * 100 / (100 + CAST(OVTG.Rate AS DECIMAL(19,6)))
                ELSE POR1.LineTotal END
         ELSE POR1.TotalFrgn * 100 / (100 + ISNULL(CAST(OVTG.Rate AS DECIMAL(19,6)), 0))
    END AS 'LineTotal',
    CASE WHEN OPOR.DocCur = 'THB' THEN OPOR.DiscSum ELSE OPOR.DiscSumFC END AS 'DiscSum',
    -- VAT ต่อบรรทัด: ปกติ=POR1.VatSum (SAP คิดแล้ว) / เคส VAT ปลอม=ถอดออก gross*Rate/(100+Rate) -> Sum() ใน Crystal
    CASE WHEN split.RowKind = 2 THEN 0
         WHEN OPOR.DocCur = 'THB' THEN
           CASE WHEN POR1.VatSum = 0 AND ISNULL(CAST(OVTG.Rate AS DECIMAL(19,6)), 0) > 0
                THEN POR1.LineTotal * CAST(OVTG.Rate AS DECIMAL(19,6)) / (100 + CAST(OVTG.Rate AS DECIMAL(19,6)))
                ELSE POR1.VatSum END
         ELSE POR1.TotalFrgn * ISNULL(CAST(OVTG.Rate AS DECIMAL(19,6)), 0) / (100 + ISNULL(CAST(OVTG.Rate AS DECIMAL(19,6)), 0))
    END AS 'VatSum',
    OPOR.DocCur,
    -- DocTotal ต่อบรรทัด (gross = net+VAT): ปกติ=LineTotal+VatSum / เคส VAT ปลอม=ยอดเดิม (รวม VAT อยู่แล้ว)
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
    ocrd.Country,
    POR1.Project,
    CAST(por12.StreetS AS nvarchar(max)) as StreetS, CAST(por12.StreetNoS AS nvarchar(max)) as StreetNoS, CAST(por12.BlockS AS nvarchar(max)) as BlockS, CAST(por12.BuildingS AS nvarchar(max)) as BuildingS,
    CAST(por12.CityS AS nvarchar(max)) as CityS, por12.ZipCodeS, CAST(por12.CountyS AS nvarchar(max)) as CountyS, por12.StateS,
    CAST(por12.StreetB AS nvarchar(max)) as StreetB, CAST(por12.StreetNoB AS nvarchar(max)) as StreetNoB, CAST(por12.BlockB AS nvarchar(max)) as BlockB, CAST(por12.BuildingB AS nvarchar(max)) as BuildingB,
    CAST(por12.CityB AS nvarchar(max)) as CityB, por12.ZipCodeB, CAST(por12.CountyB AS nvarchar(max)) as CountyB, por12.StateB,
    OCPR.Name,
    OCPR.Tel1,
    OCPR.E_MailL,
    POR1.U_SLD_Free
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
    LEFT JOIN [dbo].[@SLDT_SET_BRANCH] BRANCH ON OPOR.U_SLD_LVatBranch = BRANCH.Code, oadm
    WHERE OPOR.DocEntry = {?Dockey@}
    ORDER BY 'No.' , 'Line No.' , split.RowKind

