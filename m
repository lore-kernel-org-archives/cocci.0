From: volanschi@metaware.fr (Nic Volanschi (R&D))
Date: Thu, 29 Aug 2013 12:54:03 +0200
Subject: [Cocci] already tagged fake token
Message-ID: <1377773643.3212.47.camel@zamolxis.metaware.tm.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I stumbled against another issue when trying to apply the following rule
on nested if/else if/.../else structures:

--- trace.cocci:
@@ statement s1, s2; @@
 if(...)
  s1
 else
+{trace("ifelel");
  s2
+}

--- test.c:
void GetInfoDestTV(short sNoFo)
{
  if(sNoFo == 1)
    printf("one");
  else if(sNoFo == 2)
    printf("two");
  else
    printf("other");
}


Applying the patch results in:
faketoken/$ spatch -c trace.cocci test.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: test.c     
previous modification:
CONTEXT
  >>> }
According to environment 0:
current modification:
CONTEXT
  >>> }
According to environment 0:
Fatal error: exception Failure("rule starting on line 1: already tagged
fake token
")

I can see that the problem comes from the fact that the rule tries to
add several "}" after the last ";" which is the ending token for both
the inside and the outside if.
Indeed, if I add braces around the inside if, the problem disappears, as
there are now different tokens ending the inside and the outside if.

I tried to change the "+" markers to "++" in the patch, but this doesn't
help.
So is there a known way to get around this error?

Nic.
