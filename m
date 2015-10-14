From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 14 Oct 2015 09:59:52 +0200 (CEST)
Subject: [Cocci] Compiling latest coccinelle with opensuse
In-Reply-To: <20151014071143.GA6178@pema>
References: <CAB=NE6XEE0zMpt7HBfEmxg1fDk4AqgfJ9F5oa_h0uMe4tCuzVQ@mail.gmail.com>
 <alpine.DEB.2.02.1510132225490.2189@localhost6.localdomain6>
 <CAB=NE6V1K8-dq7A8PNY95+hSDGOFGdL8N=kjed5CF=ABLFqWLA@mail.gmail.com>
 <alpine.DEB.2.02.1510132256380.2189@localhost6.localdomain6>
 <20151013211451.GD14464@wotan.suse.de>
 <alpine.DEB.2.02.1510132317080.2189@localhost6.localdomain6>
 <20151013220512.GE14464@wotan.suse.de>
 <alpine.DEB.2.02.1510140724160.2038@localhost6.localdomain6>
 <20151014071143.GA6178@pema>
Message-ID: <alpine.DEB.2.10.1510140956240.2421@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 14 Oct 2015, S?bastien Hinderer wrote:

> Hi, Luis,
>
> Normally, when Menhir is not installed, Coccinelle's buil system
> should use the one provided in the bundles directory (same for MenhirLib).
> At the moment this does not work quite wll and I am currently working on
> fixing this issue.
> Meanwhile, one other simple thing you could try is to install menhir
> either through your distribution if it is packaged, or directly from
> sources.

He built it from sources.  The problem he has with menhirLib is an
incompatability between cmi files in his lib64/ocaml directory.  That
would seem to have nothing to do with Coccinelle.  But file says that the
cmi files come from the same version of ocaml, which is really mysterious.
One of the files is Obj.mli. I assume that this comes with ocaml?  I
didn't ask whether he had reinstalled ocaml somehow after compiling
menhir.

julia

> Then start from a clean git repository and do the usual
> procedure and I believe that shold work and would appreciate to know if it
> does not.
>
> hth,
>
> S?bastien.
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
