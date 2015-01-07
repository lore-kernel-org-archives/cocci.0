From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 7 Jan 2015 17:01:46 +0100 (CET)
Subject: [Cocci] Source code analysis for header files
In-Reply-To: <54AD552B.7040906@users.sourceforge.net>
References: <54A3F836.7060903@users.sourceforge.net>
 <alpine.DEB.2.10.1412311439380.2559@hadrien>
 <54A40032.4070904@users.sourceforge.net>
 <alpine.DEB.2.10.1412311457130.2559@hadrien>
 <54A403EB.8080709@users.sourceforge.net>
 <54AD430E.2000507@users.sourceforge.net>
 <alpine.DEB.2.10.1501071549410.3328@hadrien>
 <54AD4FC5.3000001@users.sourceforge.net>
 <alpine.DEB.2.10.1501071630480.3328@hadrien>
 <54AD552B.7040906@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1501071700190.3328@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 7 Jan 2015, SF Markus Elfring wrote:

> > I don't see the problem - C files are included by default, so one might
> > perhaps want the option to exclude them.
>
> Some source files can be analysed to some degree without inclusion of
> further header files. I like this functionality when it works as expected.
>
> I would like to extend checks on "header files" after an analysis
> was finished on the primary source files.
> Does it become more interesting to filter between the categories "header"
> and "source" data?

I think that all you want is the options --no-includes --include-headers.
--no-includes does not expand and #includes.  --include-headers causes .h
files to be processed as well as .c files.  I don't see the need to
control the order in which the processing is performed.

julia
