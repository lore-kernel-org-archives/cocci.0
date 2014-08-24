From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 24 Aug 2014 08:19:56 -0500 (CDT)
Subject: [Cocci] Clarification for dependencies in SmPL rules
In-Reply-To: <53F9E1EE.10002@users.sourceforge.net>
References: <1408772085-28818-1-git-send-email-Julia.Lawall@lip6.fr>
 <53F9DD5D.50807@users.sourceforge.net>
 <alpine.DEB.2.10.1408240751210.2460@hadrien>
 <53F9E1EE.10002@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1408240817040.2460@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 24 Aug 2014, SF Markus Elfring wrote:

> > Maybe it would be more efficient.  But conceptually it is redundant.
>
> Thanks for your feedback.
>
> I would find it a bit clearer or safer to use a SmPL variable like "r.i" only if
> a corresponding dependency was specified on the rule beginning.

You are most welcome to do whatever you want.

On the other hand, the dependency is not always necessary, for example in
the following case:

@@
expression r.e;
@@

(
- f(e);
|
- f(0);
)

Then the rule can do something without the dependency being satisfied.

julia
