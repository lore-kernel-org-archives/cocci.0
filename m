From: mstefani@redhat.com (Michael Stefaniuc)
Date: Tue, 03 Mar 2015 09:36:49 +0100
Subject: [Cocci] "WEIRD: weird #pragma" and not recovering
Message-ID: <54F572A1.8050501@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

spatch --parse-c on
https://source.winehq.org/git/wine.git/blob_plain/HEAD:/include/windows.h
gives:

WEIRD: weird #pragma
WEIRD: weird #pragma
ERROR-RECOV: end of file while in recovery mode
parsing pass2: try again
ERROR-RECOV: end of file while in recovery mode
parse error
 = File "include/windows.h", line 24, column 2
4,  charpos = 1006
    around = ':', whole content = # pragma warning(disable:4116)

spatch never recovers from that error.

A description of that MSVC #pragma can be found at
https://msdn.microsoft.com/en-us/library/2c8f766e.aspx

thanks
bye
	michael
