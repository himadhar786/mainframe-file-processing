IDENTIFICATION DIVISION.
PROGRAM-ID. FILEPROC.
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT INFILE ASSIGN TO 'input.dat'
        ORGANIZATION IS LINE SEQUENTIAL.
    SELECT OUTFILE ASSIGN TO 'output.dat'
        ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD INFILE.
01 IN-RECORD PIC X(80).

FD OUTFILE.
01 OUT-RECORD PIC X(80).

WORKING-STORAGE SECTION.
01 WS-EOF PIC X VALUE 'N'.
   88 END-OF-FILE VALUE 'Y'.
01 WS-RECORD-CNT PIC 9(5) VALUE 0.

PROCEDURE DIVISION.
MAIN-PARA.
    OPEN INPUT INFILE
    OPEN OUTPUT OUTFILE
    PERFORM UNTIL END-OF-FILE
        READ INFILE INTO IN-RECORD
            AT END
                SET END-OF-FILE TO TRUE
            NOT AT END
                ADD 1 TO WS-RECORD-CNT
                STRING 'Processed: ' DELIMITED BY SIZE,
                       IN-RECORD DELIMITED BY SIZE
                    INTO OUT-RECORD
                WRITE OUT-RECORD
        END-READ
    END-PERFORM
    CLOSE INFILE
    CLOSE OUTFILE
    DISPLAY 'Processing complete. Records processed: ' WS-RECORD-CNT
    STOP RUN.
