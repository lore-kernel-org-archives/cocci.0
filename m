From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 28 Sep 2017 18:26:02 +0200
Subject: [Cocci] Further improvements for safer building of the
 Coccinelle software
In-Reply-To: <alpine.DEB.2.20.1709281417400.30797@hadrien>
References: <alpine.DEB.2.20.1709281417400.30797@hadrien>
Message-ID: <6cdc9c9c-32a8-e982-2589-1599afaf6095@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> What are you wondering about it?

Was the make script changed in the way that the native executable variant
will not be reinstalled with the suffix ?opt? any more?

https://github.com/coccinelle/coccinelle/blob/db8e301e8b28f20149d5edccc996cf6843047f7a/Makefile#L260


Do you find the following command relevant for further considerations?

Sonne:/home/elfring/Projekte/Coccinelle/20160205 # make install
?
/usr/bin/install -c -m 755 spatch.opt /usr/local/bin/spatch
?

Regards,
Markus
