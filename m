From: volanschi@metaware.fr (Nic Volanschi (R&D))
Date: Thu, 29 Aug 2013 14:54:34 +0200
Subject: [Cocci] already tagged fake token
In-Reply-To: <alpine.DEB.2.02.1308291351450.2249@hadrien>
References: <1377773643.3212.47.camel@zamolxis.metaware.tm.fr>
 <alpine.DEB.2.02.1308291351450.2249@hadrien>
Message-ID: <1377780874.3212.63.camel@zamolxis.metaware.tm.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2013-08-29 at 13:53 +0200, Julia Lawall wrote:
> Perhaps to solve all of the problems, you could just put braces around all
> if branches first?  It seems likely that this will nto work in a generic
> way, with a metavariable S, but you can make rules like
> 
> @@
> statement S;
> @@
> 
> if (...)
> +{
>   return ...;
> +}
> else S
> 
> To get all of the possibilities.

I see what you mean. In fact, to solve the problem it would suffice to
add braces only around "else" branches, so your rule would be rather:

@@ statement S; expression E; @@
 if (...) S else
+{
  \(return ...; \| E; \| <other-simple-stmt-patterns...> \)
+}

But the problematic case is exactly the one causing the problem, in
which the "else" branch is an unbraced "if-then-else" statement. If we
write the rule for that case:

@@ statement s1, s2, s3; expression e; @@
 if(...)
  s1
 else
+{
  if(...) s2 else s3
+}

It applies well when you have just one "else if", but not when there are
more of them:

--- test.c:
void GetInfoDestTV(short sNoFo)
{
  if(sNoFo == 1)
    printf("one");
  else if(sNoFo == 2)
    printf("two");
  else if(sNoFo == 3)
    printf("two");
  else
    printf("other");
}

In this case, I'll get the same error as in my initial rule:

Fatal error: exception Failure("rule starting on line 1: already tagged
fake token
")

Nic.
