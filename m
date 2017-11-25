From: devel.fx.lebail@orange.fr (Francois-Xavier Le Bail)
Date: Sat, 25 Nov 2017 08:38:09 +0100
Subject: [Cocci] Question about a not made change
Message-ID: <d45758b3-f6cb-dc3a-0be2-c0b282aa9be9@orange.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I try the following patch:
-----
@@
u_char *p;
expression n;
@@
ND_PRINT(
...,
-p[n]
+EXTRACT_U_1(p + n)
 )
-----
on the following (minimized) code:
-----
int main()
{
        u_char *p;
        ND_PRINT(ndo, ": %02x %02x", p[1], p[2]);

        return 0;
}
-----
I got:
-----
+++ /tmp/cocci-output-1795-a34831-main.c
@@ -1,7 +1,7 @@
 int main()
 {
        u_char *p;
-       ND_PRINT(ndo, ": %02x %02x", p[1], p[2]);
+       ND_PRINT(ndo, ": %02x %02x", p[1], EXTRACT_U_1(p + 2));

        return 0;
 }
-----
Why the first p[1] is not change to EXTRACT_U_1(p + 1)?

Did I miss something obvious?

-- 
Francois-Xavier
