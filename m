From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 7 Jan 2015 15:50:27 +0100 (CET)
Subject: [Cocci] Source code analysis for header files
In-Reply-To: <54AD430E.2000507@users.sourceforge.net>
References: <54A3F836.7060903@users.sourceforge.net>
 <alpine.DEB.2.10.1412311439380.2559@hadrien>
 <54A40032.4070904@users.sourceforge.net>
 <alpine.DEB.2.10.1412311457130.2559@hadrien>
 <54A403EB.8080709@users.sourceforge.net>
 <54AD430E.2000507@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1501071549410.3328@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 7 Jan 2015, SF Markus Elfring wrote:

> > How do you think about an approach just to change the file
> > name extension from ".c" to ".h" occasionally?
> > Are there any more use cases around where
> > it makes also sense to search for source files
> > with other suffixes?
>
> How easy (or challenging) is it to treat more files
> as source files from the C programming language?
>
> Would you like to extend use cases for your source code
> analysis and transformation software in this design direction?

There is an option --include-headers to take into account .h files.  I
guess there could be anoption --exclude-c-files if there is enough
interest to warrant the addition of yet another option.

julia
