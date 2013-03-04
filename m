From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 4 Mar 2013 14:09:46 +0100 (CET)
Subject: [Cocci] Addition of source code documentation generation to the
 build system?
In-Reply-To: <51349A2C.609@users.sourceforge.net>
References: <5133B0BF.8000608@users.sourceforge.net>
 <alpine.DEB.2.02.1303041106480.1984@hadrien>
 <5134918E.7090304@users.sourceforge.net>
 <alpine.DEB.2.02.1303041338350.1984@hadrien>
 <51349A2C.609@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1303041408220.1984@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 4 Mar 2013, SF Markus Elfring wrote:

> > On the other hand, I'm not sure what the purpose of all of this is.
>
> I hope to achieve a better understanding for your software by the presentation
> style from the tool "ocamldoc". (It supports also to generate Graphviz files.)
>
>
> > If it is only to be able to write ocaml code that processes the C abstract
> > syntax tree, then it should be enough to consider the files in the
> > parser_c directory.  These are however the ones where there is a risk of a
> > missing mli file.
>
> I guess that it is still a configuration challenge to set some variables in a
> way so that all dependencies like needed modules can be resolved for the
> documentation.

It seems like a separate issue.  With the proper -I arguments, which you
can get from the makefile of the parser_c directory, ocamldoc should be
able to figure things out for itself, assuming make depend has been run
first.

julia
