From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 30 Oct 2015 15:51:11 +0100
Subject: [Cocci] Release 1.0.3: Clarification around SmPL conjunctions
In-Reply-To: <alpine.DEB.2.10.1510301535230.2364@hadrien>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <5631F344.9080804@users.sourceforge.net>
 <alpine.DEB.2.10.1510301405330.2364@hadrien>
 <56337A59.8030804@users.sourceforge.net>
 <alpine.DEB.2.10.1510301535230.2364@hadrien>
Message-ID: <563383DF.9000509@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> You would have to give an example.

Should an approach like the following which is derived from
the script "demos/conjunction.cocci" also work?


@@
identifier f;
@@
-f
+m
  (...,3,...);
 ...
 g(...,3,...);
 ...
 f(...,
-  8
+  80
   ,...);
 ...
 g(...,8,...);


Regards,
Markus
