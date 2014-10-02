From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Oct 2014 08:39:05 +0200 (CEST)
Subject: [Cocci] minor issue: pretty printing for modified functions as
 arguments
In-Reply-To: <20141001184054.GM14081@wotan.suse.de>
References: <20141001184054.GM14081@wotan.suse.de>
Message-ID: <alpine.DEB.2.02.1410020835420.2068@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Is the problem that eg you get (indentation removed for readability):

-int (*unknown)(char *param, char *val, const char *doing))
+void *arg,int (*unknown)(char *param, char *val, const char *doing, void *arg))

instead of

-int (*unknown)(char *param, char *val, const char *doing))     
+void *arg,                                                     
+int (*unknown)(char *param, char *val,                         
+               const char *doing, void *arg))

I think that the problem is that Coccinelle does not try to respect 80
columns when there are nested parentheses.  But it seems like it could be
possible to at least have the declaration of unknown moved to the next
line.

julia
