From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 2 Aug 2013 11:47:26 +0200 (CEST)
Subject: [Cocci] Question on expression meaning
In-Reply-To: <1375435947.11948.89.camel@ice-age.regit.org>
References: <1375435947.11948.89.camel@ice-age.regit.org>
Message-ID: <alpine.DEB.2.02.1308021145060.2035@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I've tried the not specific semantic patch:
>
> @@
> identifier f;
> expression E;
> @@
>
> void f(...)
> {
> ...
> - return E;
> + E;
> + return;
> ...
> }
>
> But it does not work for function (it works for "return 42;"). Any idea ?

I'm not sure what was your exact original program.  This rule is making a 
transformation, and so it requires the pattern following the ... to be 
reachable on all control-flow paths.  If I try the rule on:

void main () {
   switch(IPV6_GET_NH(p)) {
   case IPPROTO_TCP:
     IPV6_SET_L4PROTO (p, IPPROTO_TCP);
     return DecodeTCP(tv, dtv, p, pkt + IPV6_HEADER_LEN, IPV6_GET_PLEN(p), pq);
   }
}

it doesn't work, because there is not a return on all control-flow paths.
On the other hand, if I put a return 7; at the end of the function, then 
it changes both returns.

Probably what you really want is the following:

void f(...)
{
<...
- return E;
+ E;
+ return;
...>
}

This will just change the return wherever it occurs.

julia
