From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 4 Mar 2013 13:48:56 +0100 (CET)
Subject: [Cocci] 1.0.0-rc16: Further fine-tuning for the build system?
In-Reply-To: <513496F5.1070309@users.sourceforge.net>
References: <513268ED.5070703@users.sourceforge.net>
 <alpine.DEB.2.02.1303022218010.2033@localhost6.localdomain6>
 <51348708.1000005@users.sourceforge.net>
 <alpine.DEB.2.02.1303041334270.1984@hadrien>
 <513496F5.1070309@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1303041346370.1984@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 4 Mar 2013, SF Markus Elfring wrote:

> > I'm not sure to understand the relevance of the fact that we bundle the
> > library.  The problem is that ocamlfind is not finding what you expect it
> > to find.
>
> Is the OCaml package "menhirLib" generally found in your configuration even if
> you try out a different build directory?

I have one machine where it is not installed and one machine where it is
installed in the standard place.

I'm not sure to understand "try different build directory".  You mean you
want to put the executable in a place that is different than the source
code?

julia
