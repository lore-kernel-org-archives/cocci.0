From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 2 Nov 2013 17:27:51 +0100 (CET)
Subject: [Cocci] Matching an absence of statements before the closing
 brace of a function?
In-Reply-To: <20131102155224.GX15704@leaf>
References: <20131102133648.GA4190@leaf>
 <alpine.DEB.2.02.1311021455070.2261@hadrien> <20131102145412.GT15704@leaf>
 <alpine.DEB.2.02.1311021555360.2261@hadrien> <20131102155224.GX15704@leaf>
Message-ID: <alpine.DEB.2.02.1311021724000.2261@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

In the case where there is:

l: return;

at the end of a function, are you sure that you really want to replace the
return by ;?  I'm not sure that it is really an improvement...

One could replace jumps to such labels by direct returned but perhaps the
goto was added because there might be a need for more interesting code at
the end of the function in the future.

In any case, here is my current suggestion, which does convert l: return;
to l: ;

x@
position p;
@@

return at p;

@@
position x.p;
@@

- return at p;
+ RETURN;

@exists@
identifier f;
identifier l;
@@

f(...) {
  ...
l:
- RETURN
  ;
}

@exists@
identifier f;
@@

f(...) {
  ...
- RETURN;
}

@@
@@

- RETURN;
+ return;

julia
