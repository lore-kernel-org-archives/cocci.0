From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 04 Oct 2014 19:49:52 +0200
Subject: [Cocci] Searching for pass-through functions
Message-ID: <54303340.3090901@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I have retried a source code analysis approach which was discussed a while ago.
http://article.gmane.org/gmane.comp.version-control.coccinelle/1900
https://www.mail-archive.com/cocci%40diku.dk/msg01834.html


elfring at Sonne:~/Projekte/Coccinelle/lokal/demos/pass-through> spatch.opt
-sp_file list_pass-through_functions.cocci -dir /usr/src/linux-stable
--include-headers-for-types >list_pass-through_functions-Linux-3_16_3.txt
2>list_pass-through_functions-Linux-3_16_3-errors.txt


I have stopped this run after its execution took over 4,8 hours with the
software "Coccinelle 1.0.0-rc22" on my openSUSE system. A log file contains the
following information.

?
HANDLING: /usr/src/linux-stable/drivers/media/pci/ttpci/av7110_ipack.c
     C-c intercepted, will do some cleaning before exiting


Can it be that the analysis tool became stuck on this source file after 4054
files were processed before?

How are the chances to complete the desired data extraction for all 23753 C
files in a shorter time frame?

Regards,
Markus
