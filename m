From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 04 Mar 2013 14:14:22 +0100
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
In-Reply-To: <alpine.DEB.2.02.1303041346370.1984@hadrien>
References: <513268ED.5070703@users.sourceforge.net>
 <alpine.DEB.2.02.1303022218010.2033@localhost6.localdomain6>
 <51348708.1000005@users.sourceforge.net>
 <alpine.DEB.2.02.1303041334270.1984@hadrien>
 <513496F5.1070309@users.sourceforge.net>
 <alpine.DEB.2.02.1303041346370.1984@hadrien>
Message-ID: <51349E2E.90705@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I'm not sure to understand "try different build directory".  You mean you
> want to put the executable in a place that is different than the source
> code?

Yes. - It is the purpose to store such generated files by an "out-of-source-tree
build" separately.
http://programmers.stackexchange.com/questions/88792/automake-how-to-keep-the-source-tree-clean
http://stackoverflow.com/questions/1783111/fix-source-file-search-path-when-doing-out-of-source-autotools-build-within-emac

Regards,
Markus
