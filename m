From: derek@knosof.co.uk (Derek M Jones)
Date: Tue, 22 Aug 2017 22:39:55 +0100
Subject: [Cocci] parsing of C code
In-Reply-To: <alpine.DEB.2.20.1708222304510.2050@hadrien>
References: <alpine.DEB.2.20.1708222304510.2050@hadrien>
Message-ID: <34573683-9485-cc29-ee00-f9f1855d03f9@knosof.co.uk>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia,

> 1.  More aggressive inclusion of header files, combined with caching of
> header files.  Now if there is only one occurrence of a header file with a

Caching can be dangerous because macros may be defined differently
for different includes of the same header.  An option to switch off
caching could come in handy.

> given name in the provided include paths, it will take that one, even if
> there is no obvious connection between the location of the .c file and the
> location of the header file.  This compensates for the lact of parsing of
> Makefiles to extract -I options.  More header files will likely now be

There is no need to parse Makefiles.  Simply create a script, say coc99,
and configure it as the compiler that make uses.  coc99 parses its
arguments to extract whatever information cocci needs and passes
everything to the 'real' C compiler as-is.

How is the O'Reilly book coming along ;-)

-- 
Derek M. Jones           Software analysis
tel: +44 (0)1252 520667  blog:shape-of-code.coding-guidelines.com
