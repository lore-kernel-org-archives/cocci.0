From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 29 Jan 2013 19:38:19 +0100 (CET)
Subject: [Cocci] coccinelle and bitmask arithmetic (was: Re: [patch]
 TTY: synclink, small cleanup in dtr_rts())
In-Reply-To: <1359475998.4196.26.camel@joe-AO722>
References: <20130127194039.GA18787@elgon.mountain>
 <1359317078.14406.12.camel@joe-AO722> <20130127201947.GO16282@mwanda>
 <9561.1359474916@turing-police.cc.vt.edu>
 <1359475998.4196.26.camel@joe-AO722>
Message-ID: <alpine.DEB.2.02.1301291937250.3339@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The following rule looks promising:

@r@
constant c;
identifier i;
expression e;
@@

(
e | c at i
|
e & c at i
|
e |= c at i
|
e &= c at i
)

@@
constant r.c,c1;
identifier i1;
expression e;
@@

*c1 at i1 + c

That is, the sum of two constants where at least one of them has been used
with & or |.

julia
