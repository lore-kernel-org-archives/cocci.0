From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 29 Oct 2014 11:26:47 +0100 (CET)
Subject: [Cocci] Parsing errors in several headers
In-Reply-To: <5450A6EB.6050803@dumbbell.fr>
References: <544FDF5C.6040009@dumbbell.fr>
 <alpine.DEB.2.10.1410281930130.2567@hadrien> <544FE5AD.60208@dumbbell.fr>
 <544FEA20.4030400@users.sourceforge.net> <544FED2B.2030305@dumbbell.fr>
 <5450A587.1080709@users.sourceforge.net>
 <5450A6EB.6050803@dumbbell.fr>
Message-ID: <alpine.DEB.2.10.1410291123540.26234@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I wanted to be able to re-run spatch on an already patched content. The
> use case is to add new function prototypes manually and run spatch to
> handle the associated #define automatically.

I think that you could do the following:

@r@
identifier func;
@@
#define        func    BAR(func)

@s@
identifier r.func;
position p;
@@

func at p(...) {...}

@@
identifier func;
position p != s.p;
@@

+#define        func    BAR(func)
func(...) { ... }

julia
