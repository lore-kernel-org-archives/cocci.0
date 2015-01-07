From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 07 Jan 2015 16:47:55 +0100
Subject: [Cocci] Source code analysis for header files
In-Reply-To: <alpine.DEB.2.10.1501071630480.3328@hadrien>
References: <54A3F836.7060903@users.sourceforge.net>
 <alpine.DEB.2.10.1412311439380.2559@hadrien>
 <54A40032.4070904@users.sourceforge.net>
 <alpine.DEB.2.10.1412311457130.2559@hadrien>
 <54A403EB.8080709@users.sourceforge.net>
 <54AD430E.2000507@users.sourceforge.net>
 <alpine.DEB.2.10.1501071549410.3328@hadrien>
 <54AD4FC5.3000001@users.sourceforge.net>
 <alpine.DEB.2.10.1501071630480.3328@hadrien>
Message-ID: <54AD552B.7040906@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I don't see the problem - C files are included by default, so one might
> perhaps want the option to exclude them.

Some source files can be analysed to some degree without inclusion of
further header files. I like this functionality when it works as expected.

I would like to extend checks on "header files" after an analysis
was finished on the primary source files.
Does it become more interesting to filter between the categories "header"
and "source" data?


> But what else is there?

Header files can also contain function implementations which lead to
further considerations around software designs.

Regards,
Markus
