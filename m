From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 18 Jul 2015 22:09:36 +0200 (CEST)
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <55AA5667.5010009@users.sourceforge.net>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55AA476F.7020907@users.sourceforge.net>
 <alpine.DEB.2.02.1507181451340.2016@localhost6.localdomain6>
 <55AA5667.5010009@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1507182206090.2086@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinelle does type inference, including the return types of functions 
when the return types are available.  The simple solution is thus just:

@@
type T;
T x;
identifier f;
void v;
@@

(
f(...)@v;
|
*f(...)@x;
)

This would need to be run with arguments like --recursive-includes, to 
include files included from other include files, --relax-include-path, to 
find uniquely named include files even when they are not in the provided 
include path, and --include-headers-for-types, to improve performance only 
collecting type information from the include files.

julia
