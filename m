From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 4 Mar 2013 13:42:31 +0100 (CET)
Subject: [Cocci] Addition of source code documentation generation to the
 build system?
In-Reply-To: <5134918E.7090304@users.sourceforge.net>
References: <5133B0BF.8000608@users.sourceforge.net>
 <alpine.DEB.2.02.1303041106480.1984@hadrien>
 <5134918E.7090304@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1303041338350.1984@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 4 Mar 2013, SF Markus Elfring wrote:

> > Maybe you could use find with the -exec argument, if it is acceptable to
> > work on only one file at a time?
>
> I do not see that this suggestion works here because I understand the tool
> "ocamldoc" in the way that it wants to get all relevant parameters (including
> the source file names) passed at once.

Actually, I am not sure what is the point for you to pick up all of the ml
files.  The things listed in the mli files are the only things that you
should use.  Unless there is an ML file that has no mli file, which is
unfortunately occasionally the case.  Perhaps the approach would be to
look for the compiled files, then see if the mli variant exists, and if
not see if the ml variant exists.

On the other hand, I'm not sure what the purpose of all of this is.  If it
is only to be able to write ocaml code that processes the C abstract
syntax tree, then it should be enough to consider the files in the
parser_c directory.  These are however the ones where there is a risk of a
missing mli file.

julia
