From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 11 Jul 2016 21:08:44 +0200
Subject: [Cocci] Configuration challenges around font "ifgeo"?
Message-ID: <850aa1dd-ce42-6c4a-9bd7-cac1a6167b83@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I stumble on the following surprise.


elfring at Sonne:~/Projekte/Coccinelle/20160205> LANG=C make docs
?
kpathsea: Running mktexpk --mfmode / --bdpi 72 --mag 1+0/72 --dpi 72 ifgeob10
mktexpk: Mismatched mode ljfour and resolution 72; ignoring mode.
mktexpk: Can't guess mode for 72 dpi devices.
mktexpk: Use a config file or option to specify the mode; see:
mktexpk: http://tug.org/texinfohtml/kpathsea.html#Unable-to-generate-fonts
kpathsea: Appending font creation commands to missfont.log.

!pdfTeX error: /usr/bin/pdflatex (file ifgeob10): Font ifgeob10 at 72 not found

 ==> Fatal error occurred, no output PDF file produced!
make[2]: *** [Makefile:36: manual.pdf] Error 1
?


The package "texlive-ifsym 2015.104.svn24868-22.2" is installed on my system.
Should this software be also sufficient in comparison to other sources?
https://packages.debian.org/jessie/texlive-fonts-extra

Regards,
Markus
