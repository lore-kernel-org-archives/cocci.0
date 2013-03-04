From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 04 Mar 2013 17:05:40 +0100
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
In-Reply-To: <alpine.DEB.2.02.1303041645030.1984@hadrien>
References: <513268ED.5070703@users.sourceforge.net>
 <alpine.DEB.2.02.1303022218010.2033@localhost6.localdomain6>
 <51348708.1000005@users.sourceforge.net>
 <alpine.DEB.2.02.1303041334270.1984@hadrien>
 <5134C06D.4070906@users.sourceforge.net>
 <alpine.DEB.2.02.1303041645030.1984@hadrien>
Message-ID: <5134C654.3050706@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> https://github.com/coccinelle/coccinelle/issues/9
> 
> Maybe you have python but not the developer libraries?

The package "python-devel 2.7.3-3.6.1" is installed at the moment.

I do not get the mentioned error message if I repeat the command from within the
source directory.

elfring at Sonne:~/Projekte/Coccinelle/lokal> make distclean && ./configure
--enable-opt --enable-ocaml --enable-python --enable-release


Regards,
Markus
