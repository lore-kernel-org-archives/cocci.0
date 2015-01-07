From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 7 Jan 2015 16:31:34 +0100 (CET)
Subject: [Cocci] Source code analysis for header files
In-Reply-To: <54AD4FC5.3000001@users.sourceforge.net>
References: <54A3F836.7060903@users.sourceforge.net>
 <alpine.DEB.2.10.1412311439380.2559@hadrien>
 <54A40032.4070904@users.sourceforge.net>
 <alpine.DEB.2.10.1412311457130.2559@hadrien>
 <54A403EB.8080709@users.sourceforge.net>
 <54AD430E.2000507@users.sourceforge.net>
 <alpine.DEB.2.10.1501071549410.3328@hadrien>
 <54AD4FC5.3000001@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1501071630480.3328@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 7 Jan 2015, SF Markus Elfring wrote:

> >> Would you like to extend use cases for your source code
> >> analysis and transformation software in this design direction?
> >
> > There is an option --include-headers to take into account .h files.  I
> > guess there could be anoption --exclude-c-files if there is enough
> > interest to warrant the addition of yet another option.
>
> An "exclude option" does not sound promising for my feature
> request around including more possibilities, does it?

I don't see the problem - C files are included by default, so one might
perhaps want the option to exclude them.

But what else is there?

julia
