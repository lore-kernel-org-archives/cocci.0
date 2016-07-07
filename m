From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 7 Jul 2016 22:40:55 +0200
Subject: [Cocci] Checking build dependencies for "pyml"
Message-ID: <64de7df6-acd6-7ddf-efc7-b4055203211c@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I have tried to generate the current software also on my openSUSE Tumbleweed system.


elfring at Sonne:~/Projekte/Coccinelle/20160205> ./configure --enable-release --enable-ocaml && LANG=C make
?
make[2]: *** @MAKE_pyml@: No such file or directory.  Stop.
?


Unfortunately, I stumble on an error message.

How is the development status after the commit "Fixed: Bundles compilation
and pyml update" on 2016-06-26?
https://github.com/coccinelle/coccinelle/commit/62f2df8c7d35967a1eca4dcd487d59a9918dd5aa

Regards,
Markus
