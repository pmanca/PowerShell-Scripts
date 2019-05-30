cls$pageCount = 1$file = "c:\test\CPLOutput3500.txt"#81k for 500 MB#162.5k for 1 GB#243.5k for 1.5 GB#325k for 2 GB#406.5k for 2.5 GB#487k for 3 GB#568k for 3.5 GBfor($i = 0; $i -lt 568000; $i++){    $string = "
CLINICAL PATHOLOGY LABS, INC                            HOUSEKEEPING REPORT                                                Page    $pageCount
ACCOUNTS RECEIVABLE                                     Effective 10/31/2015                                                        
User: JRS                                                                                                             6:20:49 PM CST

110            RESP: AUSTIN HOME HEALTH CARE        ADD1: 123 Fake St                    ADD3: 
                                                    ADD2: AUSTIN, TX  78735              ADD4: 
                                                    HOME:                                WORK: 123 456 7890
                             >CT: C             INVOICE: 123456-x   OPENED: 12/02/2014   BILLED: 12/31/2014   LAST TXN: 10/27/2015
            >>>ACCN: K9038690  NAME: Goodman,La-sha   DOB: 01/01/1990   SEX: F   REL: SE   PID: 66-REC SAME DX  LOG: TDR1
               MSG: SYS 06/23/2014 9:07 AM CST M/N - Split Accession: K9038690A     DOS: 05/27/2014
                     Ordered Unit Codes: 919,4675
               MSG: DSG 06/23/2014 9:12 AM CST Previously billed to account 876544334 (CASH billed)
               MSG: CLU 12/19/2014 3:20 PM CST Previously billed to account 12345 (C billed), invoice 123456-7
             >>SRV: 05/27/2014  CHG: C              ORDERED BY: 999          PHY: 98765432
               DIAG: 794.8                          LOG: TDR1
                  REQUISITION: X9437652ORDER/COMPONDESC                    WILD INFO
                ------------    -----------------------   --------------------------------------------------------------------------
                2739            HEPATITIS B SURF AG       Qty: 1  Loc: MAIN
            >>>ACCN: RG760615  NAME: VILLARREAL,FELICITAS   DOB: 05/18/1933   SEX: F   REL:    PID: 5482401  LOG: BEK
             >>SRV: 12/09/2014  CHG: C              ORDERED BY: 110          PHY: 
               DIAG:                                LOG: BEK
                  REQUISITION: fsd98f7sdf7sad98f/dsafdsf                    WILD INFO
                ------------    -----------------------   --------------------------------------------------------------------------
                2737            HEPATITIS B SURF AB       Qty: 1  Loc: MAIN
                2739            HEPATITIS B SURF AG       Qty: 1  Loc: MAIN
                3500            RPR                       Qty: 1  Loc: MAIN
                    350000      RPR                       Qty: 1  Loc: MAIN
                3540            HIV AB/AG COMBO RFLX CONF Qty: 1  Loc: MAIN
                4675            HEPATITIS C ANTIBODY      Qty: 1  Loc: MAIN
               SEQ TYP  CHARGE  DESCRIPTION                            PROCEDURE CODE  QTY  ACCESSION  USER   DOS        POSTED
               -------  ------  -------------------------------------  --------------  ---  ---------  ----   ---------- ----------
                25  D    0.00   ABN NOT RECEIVED                       99886           1    xxxxxxxx   AJB    12/04/2014 12/11/2014
                43  D   10.00   CULTURE,URINE                          87086           1    xxxxxxxx   DSG    12/18/2014 12/23/2014
                44  D    0.00   ABN NOT RECEIVED                       99886           1    xxxxxxxx   DSG    12/18/2014 12/23/2014
                47  D   12.00   FOLIC ACID                             82746           1    xxxxxxxx   AUTO   11/08/2014 12/26/2014
                42  D  358.00   CALPROTECTIN,FECAL                     83993-90        1    xxxxxxxx   TNO    09/09/2014 12/22/2014
                 7  D   20.85   TRIGLYCERIDES                          84478           1    xxxxxxxx   MLM    10/13/2014 12/04/2014
                 5  D   20.85   TRIGLYCERIDES                          84478           1    xxxxxxxxR  MLM    09/15/2014 12/04/2014
                41  D   20.85   TRIGLYCERIDES                          84478           1    xxxxxxxxR  CLU    08/18/2014 12/22/2014
                 8  D   20.85   TRIGLYCERIDES                          84478           1    xxxxxxxxR  MLM    08/25/2014 12/04/2014
                 6  D   20.85   TRIGLYCERIDES                          84478           1    xxxxxxxxR  MLM    10/20/2014 12/04/2014
                40  D   63.15   DIGOXIN                                80162           1    xxxxxxxx   CLU    06/12/2014 12/19/2014
                48  D   10.00   CULTURE,URINE                          87086           1    xxxxxxxx   DSG    12/19/2014 12/30/2014
                49  D    0.00   ABN NOT RECEIVED                       99886           1    xxxxxxxx   DSG    12/19/2014 12/30/2014
                45  D  249.05   VITAMIN D, 25-HYDROXY                  82306           1    xxxxxxxx   DSG    12/18/2014 12/23/2014
                46  D    0.00   ABN NOT RECEIVED                       99886           1    xxxxxxxx   DSG    12/18/2014 12/23/2014
                16  D   16.60   RPR                                    86592           1    xxxxxxxx   BEK    12/09/2014 12/11/2014
                17  D   63.95   HEPATITIS B SURF AB                    86706           1    xxxxxxxx   BEK    12/09/2014 12/11/2014
                18  D   94.45   HEPATITIS C ANTIBODY                   86803           1    xxxxxxxx   BEK    12/09/2014 12/11/2014
                19  D   63.95   HEPATITIS B SURF AG                    87340           1    xxxxxxxx   BEK    12/09/2014 12/11/2014
                20  D    9.50   HIV AB/AG COMBO RFLX CONF              87389           1    xxxxxxxx   BEK    12/09/2014 12/11/2014
                50  D    0.00   HEMOGLOBIN A1C                         83036           0    xxxxxxxx   DSG    12/11/2014 12/30/2014
                51  D    6.00   TSH REFLEX TO FREE T4                  84443           1    xxxxxxxx   DSG    12/11/2014 12/30/2014
                52  D    0.00   ABN NOT RECEIVED                       99886           1    xxxxxxxx   DSG    12/11/2014 12/30/2014
                55  C    9.35   Q9804309 (12/16/2014) REBILLED TO MCTX (Q9804               xxxxxxxx   PHC    12/16/2014 05/18/2015
                --------------------------------------------------------------------------------------------------------------------
"    Add-content -Value $string -Path $file    $pageCount++}