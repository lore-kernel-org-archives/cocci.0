From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 4 Mar 2013 13:37:36 +0100 (CET)
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
In-Reply-To: <alpine.DEB.2.02.1303041334270.1984@hadrien>
References: <513268ED.5070703@users.sourceforge.net>
 <alpine.DEB.2.02.1303022218010.2033@localhost6.localdomain6>
 <51348708.1000005@users.sourceforge.net>
 <alpine.DEB.2.02.1303041334270.1984@hadrien>
Message-ID: <alpine.DEB.2.02.1303041336480.1984@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 4 Mar 2013, Julia Lawall wrote:

> On Mon, 4 Mar 2013, SF Markus Elfring wrote:
>
> > > I'm not completely sure what you are proposing.
> >
> > Have you got any idea why I get a result like the following?
> >
> > elfring at Sonne:~/Projekte/Coccinelle/Bau> ocamlfind query camlp4 && ocamlfind
> > query menhirLib
> > /usr/lib64/ocaml/camlp4
> > ocamlfind: Package `menhirLib' not found
> >
> >
> > Are there any configuration challenges to consider with the use of a locally
> > installed variant in comparison to the version for this library which you also
> > bundle with your software?
>
> I don't know what strategy ocamlfind follows, in detail.  Perhaps it would
> be more reasonable to take up the problem with them, since it is a general
> problem?

If they say that it is not their problem, then I guess we could do
something.  But it seems strange for every piece of software that uses
ocamlfind to have to repeat the same piece of code.

julia
