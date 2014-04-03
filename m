From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 3 Apr 2014 16:22:51 +0200 (CEST)
Subject: [Cocci] spatch issue with C struct initialization
In-Reply-To: <1396531867.24348.27.camel@localhost.localdomain>
References: <1396513844.24348.13.camel@localhost.localdomain>
 <alpine.DEB.2.10.1404031216060.2090@hadrien>
 <1396531867.24348.27.camel@localhost.localdomain>
Message-ID: <alpine.DEB.2.10.1404031621290.2090@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

For me, it worked fine with exactly the following files:

C file:

struct my_struct {
  int fld1;
  int fld2;
  int fld3;
};

static const struct my_struct m1 = {
  .fld1 = 1,
  .fld2 = 2,
  .fld3 = 3,
};

Cocci file:

@@
identifier I;
expression E;
@@
struct my_struct I = {
 ...,
- .fld1 = E,
 ...
};

I tried with fld1, fld2, and fld3, and all were fine.

julia
