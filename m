Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2C3C433F5
	for <cocci@archiver.kernel.org>; Fri, 28 Jan 2022 00:50:48 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,322,1635199200"; 
   d="scan'208";a="18359270"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2022 01:50:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 62A1DE027C; Fri, 28 Jan 2022 01:50:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 39A6FE00CE
	for <cocci@sympa.inria.fr>; Fri, 28 Jan 2022 01:50:44 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=cocci@lists.ewheeler.net; spf=None smtp.mailfrom=cocci@lists.ewheeler.net; spf=None smtp.helo=postmaster@mx.ewheeler.net
IronPort-SDR: u5Q29L2X0MKF2I3NqUxbkPzuldoqBC2+6fwSlwHkUXi0vcmG+iQIO5ZEDme9/MJn5D5+0+Hxul
 9QmIevWzDPJ2EFnOgXYfQamYoyq7aDw8XXpODq4IDYX4HkRXFQA/AOSjCujqCJHKvZBVPN6fRN
 ljw0lNBw0cIN1VBFnBf8ACoHWOzt/L6losjS8Lw2X0MCk89Q2wBfB7+E9Ygje2+BxPi2CmhebN
 PcHV2wkvWfhFBKlQFnvZiBmR14om6c+cDZENxxyrmtgjDAzr4JRflYapBo9M9n9iYBCOIaHjFv
 aYgLWeGlhKgvp5TZawLQxnoK
X-IPAS-Result: =?us-ascii?q?A0BBBABoPfNh/0Xcza1agQmBWoIoB3dSBAEBASkECzGTN?=
 =?us-ascii?q?4IlA5xRgXwLAQMBDTcKBAEBhQUCg18CHQYGMQgOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECAwQBgQgsAWMBZwGBTgGBeQYEMA2CNSkBg2MBAQEBAQEBO?=
 =?us-ascii?q?j8QCxguVwaDFwGCdSEPrmh4gTOBAYNOARNBhVQGgTqOMyccQIFNglGBbj6CT?=
 =?us-ascii?q?BcBAQEBh1sEkhYCYBoTCyGBGC0aXpJDj2OeAYNPiwCUYC6WJpFUlkiNC5QsD?=
 =?us-ascii?q?IFBg2GBPyQBOYFZHxQaCCYKgyROAQIBAgEMAQICAQIBAgECAQgBAQIBkg2BP?=
 =?us-ascii?q?olBIAEBATACAQgtAgYLAQEDCY1MAQE?=
IronPort-PHdr: A9a23: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
 DV4flkLqLCMv3swvw==
IronPort-Data: A9a23:uH9sFKnTc4r8EKEZd2p/13/o5gy8IERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIaUWGOOv7eYTP9L4twOYy380kC75/Vm9dqTlZppChmE1tH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/0t4AbeSRWVvX4
 4ur+Z2HYTdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1jr9uBcS1uIpHxp70NeENCDCdOIZJvreqvzXiX6aR/zmXDYz3h3PVjAUU7J8se9/of7WNmr
 KNDbmpVM1bZ3brwnuPTpupE3qzPKOHgO4gUu1lkzCrFFrArXpDOTqHH/5le0StYasVmRKaFO
 ptDN2sHgBLoUxMQYXwNGq8FzfqYpl/vYTRDikOsnP9ii4TU5FctjuO8b4q9lsaxbc5SlU2Zj
 nnX+nzwRBAcLt2WjzSfmlqoj/DGmSfTSoMXHqexsP9smlyagGIJYCD6TnO+sb+0lU6zVtZSM
 QoS9zZGQbUOGFKDYMO6biWS52K4gyFFS/EKCfI82B2y4/+Bi+qGPVQsQjlEYd0gkcY5Qz02y
 1OE9+/U6SxTXK69Ei3Cq+/Fxd+mEW1Ecj9YPH5soR4tuoG7+OkOYgTzosGP+ZNZY/XwCXf93
 DCHoSwznfMVgNJjO0SHEbLv2GzESnvhFFJdCuDrsoWNtFkRWWJdT9b0gWU3FN4ZRGtZJ3HY1
 JT+p+CQ7foVEbaGnzGXTeMGEdmBvqjZa2eH2Q81RsJ7q1xBHkJPm6gKsVmSw28ybq45lcLBO
 hKN0e+vzMA70ISWgV9fON7vUJV1ncAM5PzoSfDZY95DeJl3f0rfpUlTib24hAjQfYlFuf9XB
 Kp3hu71XS9FUvw2lWTvLwrfuJdyrh0DKarobciT53yaPXC2PRZ5kJ8JbwmDaP4X9qSBrFmH+
 tpTLZLamRFeS/HlJCTI8YMeKV0Qa342Gcmu+cBQc+eCJCtgGX0gUqWNmul5JtU5xqkFxP3V+
 nydW1NDzAStj3PwKTKVNiJpZoTpUMsttnk8JyEtYAilgiBxfYa14a4DXJIrZr17pvd7xPt5Q
 qBdKcWNC/hCUBrd/DEZYcWvpYBubk371waPJDa+JjUgf5NtQwHTvNnpYlK3piUJCyO2s+o4o
 qGhj1mHGsBbGl0+VcuPMaCh1VK8u3QZidleZUqQL4kBYljo/ahrNzf10K09LfYMHgqflDGU4
 ACbXEUDru7Xro5ortSQ3fKYr52kGvdVF1ZBGzWJ9q6/MCTX8zbxwYJEV+rULznRWHmtpfend
 aNY0PHxPfkKhhBMvpYlS+Rnyqc35t3Oob5Gz10+QC6RNwnyVuptciucwM1ClqxR3bsH6wG4b
 UK45YUIM7u+Ps64QkUaIxAob7nd2KhMyCXS9/k8PG7z+DRzoOicSUxXMhTQ2jZRKqB5bNEsz
 es74ZNE7hz5hwUqP9uCgzoS8WmQdyRSX6Iiv5AcIYnqlgtykA0ZO8SBU3Ov7cHdcchIP2krP
 iSQ2vjIiYNc8VWeIXA9In7AgLhGjpMUtREXklJbfwaVmsDIj+Mc1QFK9WhlVRxcyxhK3oqf4
 ISw25GZ8UlPw9tpuCSHd2W8XQxeBBCU/kHrjV0EiAU1iqVuunPldAUA1SSlpSj1MF6wuhBf/
 aqE0yDoTjbnccX8xG00VFINRzkPizBu3lWqpS1kdvhp27E+YCH5memjemoFph/qG4U3iVGvS
 SyGOgpvQfWTCBP8aJHXx2VXOXr8hfxEyKF/rSldwZ40
IronPort-HdrOrdr: A9a23:oMu356ttTAeHo+7kQmtYkKDc7skDctV00zEX/kB9WHVpm62j5r
 mTdJZy73DJYVkqNk3I9ergBEDEewK4yXcX2/h2AV7BZniDhILAFugLhuaP/9SjIVyYygc379
 YDT0ERMr3N5IdB5/rS6gPQKadC/OW6
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,322,1635199200"; 
   d="scan'208";a="18359269"
X-MGA-submission: =?us-ascii?q?MDFniDC4YYVlAmE1qbwGmfQUR9veNJdhkw07cC?=
 =?us-ascii?q?Ayi3Lnw1/VFueNxTJ/19iDMAREfwQjpwuhc+Sz+8FyLcEydE6mxo/cVP?=
 =?us-ascii?q?lEZFg/tSldBZE2WPaFefpGG9D+n0gMo+hhMNt36Q8XhOIjgR7LXqAMcp?=
 =?us-ascii?q?7Efbh3tMSoMCJWjAgkMnB+EQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 01:50:42 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id EF8DC81;
	Thu, 27 Jan 2022 16:50:40 -0800 (PST)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DG8qS8wwlBg3; Thu, 27 Jan 2022 16:50:36 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 7A3F840;
	Thu, 27 Jan 2022 16:50:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 7A3F840
Date: Thu, 27 Jan 2022 16:50:34 -0800 (PST)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Julia Lawall <julia.lawall@inria.fr>
cc: cocci@inria.fr
In-Reply-To: <alpine.DEB.2.22.394.2201270709540.3189@hadrien>
Message-ID: <d8f5fef-dda4-124b-3dc-8847bd4a2be@ewheeler.net>
References: <d6cf70b7-84b2-5078-f9f7-81ca8acad349@ewheeler.net> <alpine.DEB.2.22.394.2201270709540.3189@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] How do you match complex double's in Coccinelle?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 117
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-01/d8f5fef-dda4-124b-3dc-8847bd4a2be%40ewheeler.net>

Hi Julia,

On Thu, 27 Jan 2022, Julia Lawall wrote:
> On Wed, 26 Jan 2022, Eric Wheeler wrote:
> > ```
> > @ rule1 @
> > double complex dst;
> > expression a1, a2, b1, b2, c1, c2;
> > @@
> > -dst += (a1)*(a2) + (b1)*(b2) + (c1)*(c2);
> > +vec_fma3(&dst, &a1, &a2, &b1, &b2, &c1, &c2);
> > ```
> >
> > It gives this error while parsing the .cocci file (not when evaluating
> > matrix.c because it doesn't get that far):
> >
> > ```
> > init_defs_builtins: /usr/lib64/coccinelle/standard.h
> > meta: parse error:
> >   File "vec_fma3.cocci", line 2, column 15, charpos = 25
> >   around = 'dst',
> >   whole content = double complex dst;
> > ```
> >
> > Strangely, it works if I change the type to just `double` instead of
> > `double complex` and it does produce the following patch from
> > matrix.c[1] even though `*cmx` and friends are all `complex double`'s.
> >
> >
> > Questions:
> >  - The Coccinelle grammar[2] says it supports `double complex` so am I
> >    missing something?
> 
> Hmm, maybe it doesn't actually support it.  I will check.
> 
> Perhaps the problem is that the C language supports it but the semantic
> patch lanuage does not.

That could be.  Notably, long double works fine, and from a type-binding 
perpective, the "complex" modifier could probably be treated the same as 
the "long" modifier.

See tests/cex_wishlist_complex1.cocci from the Coccinelle git tree:

```
// FIXME: shall NOT patch 'double complex'
@@
type T = double;
identifier I;
@@
-T
+float
I;
```

Which patches this file:

```
#include <complex.h>
int main() { 
 double d;
 float  f;
 double complex dc;
 float complex  fc;
 return 0;
}
```

And provides this (incorrect) diff:

```
]# /usr/bin/spatch --sp-file tests/cex_wishlist_complex1.cocci tests/cex_wishlist_complex1.c
--- tests/cex_wishlist_complex1.c
+++ /tmp/cocci-output-31687-68c520-cex_wishlist_complex1.c
@@ -1,8 +1,8 @@
 #include <complex.h>
 int main() { 
- double d;
+ float d;
  float  f;
- double complex dc;
+ float complex dc;
  float complex  fc;
  return 0;
 }
```

Now if I change `double d` to `long double d` then it does not replace, 
but it does replace the `double complex dc` even though it should not:

```
]# /usr/bin/spatch --sp-file tests/cex_wishlist_complex1.cocci tests/cex_wishlist_complex1-long.c
--- tests/cex_wishlist_complex1-long.c
+++ /tmp/cocci-output-17768-8782a9-cex_wishlist_complex1-long.c
@@ -2,7 +2,7 @@
 int main() { 
  long double d;      <<<<
  float  f;
- double complex dc;
+ float complex dc;
  float complex  fc;
  return 0;
 }
```


Ok, so one more test in the opposite form:

If I change tests/cex_wishlist_complex1-long.cocci to be a `long double` 
then it does replace the -long.c version:

```
]# /usr/bin/spatch --sp-file tests/cex_wishlist_complex1-long.cocci tests/cex_wishlist_complex1-long.c
--- tests/cex_wishlist_complex1-long.c
+++ /tmp/cocci-output-6513-87322a-cex_wishlist_complex1-long.c
@@ -1,6 +1,6 @@
 #include <complex.h>
 int main() { 
- long double d;
+ float d;
  float  f;
  double complex dc;
  float complex  fc;
```

And if I run the same -long.cocci patch on the original `double d` file 
then it produces no diff:

```
]# /usr/bin/spatch --sp-file tests/cex_wishlist_complex1-long.cocci tests/cex_wishlist_complex1.c
<no diff>
```


So, given the examples above, I think the easiest fix would be to treat 
`complex double` similar to how `long double` is evaluated so that 
Coccinelle sees it as two distinct types.

> 
> >
> >  - Relatedly, does it support `complex double` as well as `double complex` ?
> 
> If it supports one, it should be possible to make it support the other.
> 
> Do you expect a "double complex" metavariable to match a complex double
> variable?

Actually I've never called something a "double complex" as shown in the 
spatch code.  I've only ever seen it used as "complex double", but it 
seems that GCC will compile either---so you would want to support both and 
equate the datatype as being the same.

What do you think?

-Eric

> 
> julia
> 
> >
> > It does what I want if I specify only `double`, but I would like to be
> > more strict about the datatype being `complex double` when spatch'ing the
> > code:
> >
> > ```
> > -            cmx[k+(jl-1)*nrow] +=
> > -              dataj.exk* cabi+ dataj.eyk* sabi+ dataj.ezk* salpi;
> > -            cmx[k+jl*nrow]     +=
> > -              dataj.exs* cabi+ dataj.eys* sabi+ dataj.ezs* salpi;
> > +            vec_fma3(&cmx[k + (jl - 1) * nrow], &dataj.exk, &cabi, &dataj.eyk,
> > +                     &sabi, &dataj.ezk, &salpi);
> > +            vec_fma3(&cmx[k + jl * nrow], &dataj.exs, &cabi, &dataj.eys,
> > +                     &sabi, &dataj.ezs, &salpi);
> > ```
> >
> > Thanks for your help!
> >
> > --
> > Eric Wheeler
> >
> >
> >   [1]: https://github.com/KJ7LNW/xnec2c/blob/f7373f11551b963a78cc27b11692f41abac28615/src/matrix.c#L451
> >   [2]: https://coccinelle.gitlabpages.inria.fr/website/docs/main_grammar.pdf
> >
> 
