From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 9 May 2015 18:47:57 +0200 (CEST)
Subject: [Cocci] Question about the use of "...when !=" in SmPL
In-Reply-To: <20150509140941.GA13643@opentech.at>
References: <BAY181-W739E92CD2131317A21ED42B8DF0@phx.gbl>
 <20150509140941.GA13643@opentech.at>
Message-ID: <alpine.DEB.2.02.1505091845390.2077@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @ifonly@
> function f;
> statement S1;
> position p;
> @@
> f (...){
> <...
> *if at p (...) S1
> ...>
> }

This is OK, but unnecessarily complicated.  A position variable has a field
current_element, which is the name ofthe containing function.  So from just
the match if at p (...) S1 one can get everything that is needed.

julia
