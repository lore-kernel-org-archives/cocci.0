From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 23 Dec 2014 19:08:16 +0100 (CET)
Subject: [Cocci] RFC - simple scanners and matching macros
In-Reply-To: <20141223173331.GA17709@opentech.at>
References: <20141223152045.GA6138@opentech.at>
 <alpine.DEB.2.10.1412231647160.2480@hadrien>
 <20141223162956.GA17482@opentech.at>
 <alpine.DEB.2.10.1412231745470.2480@hadrien>
 <20141223170255.GA29990@opentech.at>
 <alpine.DEB.2.10.1412231810140.2480@hadrien>
 <20141223173331.GA17709@opentech.at>
Message-ID: <alpine.DEB.2.10.1412231902240.2480@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Fatal error: exception Failure("meta: parse error:
>  = File "false_declare_completion.cocci", line 27, column 14,  charpos = 511
>     around = 'DECLARE_COMPLETION', whole content = declarer name DECLARE_COMPLETION;
> ")
> ...

OK, it's not super intuitive, but the problem is that it wants declarer
names, like typedefs, to be declared once and only once.  And in deciding
about this, it doesn't take into account the dependencies on virtual
rules.  So if you use -D patch, then it complains about a declaration in a
case that says depends on !patch.  And if you remove the declarer name
declaration in the latter rule, when you use eg -D report, it takes into
account the declaration in the previous, but disabled, -D patch rule.

So if you drop the second declarer name declaration, everything will be
fine.

The fact that declaring a typedef, declarer name, or iterator name once
was good enough was supposed to make things easier, but it seems to just
make things confusing.  Maybe I should get rid of this feature, or at
least not complain about redeclarations that are consistent with the
previous one.

julia
