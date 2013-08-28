From: volanschi@metaware.fr (Nic Volanschi (R&D))
Date: Wed, 28 Aug 2013 15:19:32 +0200
Subject: [Cocci] problem with the order of added statements
Message-ID: <1377695972.3192.26.camel@zamolxis.metaware.tm.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I'm trying to instrument a program with traces, by adding calls to
trace() at the beginning of each block. In particular, at the beginning
of an "if" branch and after the "if". So my rule is very simple:

--- trace.cocci:
@@ statement s1; @@
 if(...)
+{trace("ifth");
  s1
+}
+trace("endif");

The rule works as expected except when the "then" branch contains a
control flow statement such as return or break. For example, on the
following file:

--- trace.c:
short VerDate(char *pcDate)
{
  short sRetour = 0;
  if ( pcDate == 0 ) {
    sRetour = 1;
  }
  if ( pcDate == 0 )
    sRetour = 1;
  if ( pcDate == 0 ) {
    sRetour = 1;
    return sRetour;
  }
  return sRetour;
}

the rule generates the following instrumented program:

--- trace.c.cocci-res:
short VerDate(char *pcDate)
{
  short sRetour = 0;
  if ( pcDate == 0 ) { trace("ifth");
  {
    sRetour = 1;
  }
}
trace("endif");
  if ( pcDate == 0 ) { trace("ifth");
  sRetour = 1;
}
trace("endif");
  if ( pcDate == 0 ) { trace("ifth");
  {
}
trace("endif");
    sRetour = 1;
    return sRetour;
  }
  return sRetour;
}

That is:
- the trace("ifth") is correctly added in all three cases at the
beginning of the "if-then" branch
- the trace("endif") is correcty added in the first two cases after the
"if", BUT in the middle of the third "if"!

Is the problem in my rule or is in its application?

Cheers,
Nic.

PS. I sort of turned around the problem by splitting my rule in two:

--- trace2.cocci:
@@ statement s1; @@
 if(...)
+{trace("ifth");
  s1
+}

@@ statement s1; @@
 if(...) s1
+trace("endif");

In this case, the third trace("endif") is correctly added after the
"if", but the produced code is still a bit strange, as it contains an
emtpy block:

  if ( pcDate == 0 ) { trace("ifth");
  {
}
    sRetour = 1;
    return sRetour;
  }
  trace("endif");
