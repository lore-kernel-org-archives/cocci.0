From: chrubis@suse.cz (Cyril Hrubis)
Date: Thu, 2 Oct 2014 11:35:51 +0200
Subject: [Cocci] string parameter concatenation
In-Reply-To: <alpine.DEB.2.10.1410011504340.2489@hadrien>
References: <20141001130215.GB4701@rei.suse.cz>
 <alpine.DEB.2.10.1410011504340.2489@hadrien>
Message-ID: <20141002093551.GA30575@rei.suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi!
And here is another small nit:

nit.c:
int main(void)
{
        f(param1, "Long string that fits to 80 chars .........................",
          param2, param3);
}

nit.cocci:
@@
expression list L;
@@
- f(L);
+ g(L);

output:
init_defs_builtins: /usr/local/share/coccinelle/standard.h
HANDLING: nit.c
diff = 
--- nit.c
+++ /tmp/cocci-output-30698-a2be52-nit.c
@@ -1,5 +1,4 @@
 int main(void)
 {
-       f(param1, "Long string that fits to 80 chars .........................",
-         param2, param3);
+       g(param1, "Long string that fits to 80 chars .........................", param2, param3);
 }

Here the whole list of parameters is put on single line after the substitution
which sometimes creates 150 chars long lines for printf-like functions.

Unfortunatelly I cannot think of a good solution here. Conservative one would
be keeping the parameters as they are, but that would break anyway if function
name lenght, number or lenght of parameters changes.

-- 
Cyril Hrubis
chrubis at suse.cz
