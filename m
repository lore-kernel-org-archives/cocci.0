From: wagi@monom.org (Daniel Wagner)
Date: Thu, 11 Jul 2013 11:58:36 +0200
Subject: [Cocci] gboolean -> bool conversion
In-Reply-To: <51DE75BF.3060207@monom.org>
References: <51DE6A05.9050008@monom.org>
 <alpine.DEB.2.02.1307111026390.2253@hadrien> <51DE75BF.3060207@monom.org>
Message-ID: <51DE81CC.3010805@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Just for the record, I played a bit more around.

@@
@@

- gboolean
+ bool

@@
gboolean x;
@@

x =
(
- TRUE
+ true
|
- FALSE
+ false
)

applied on

static gboolean is_enabled(gboolean var)
{
	return var;
}

int main(int argc, char *argv[])
{
	gboolean b = TRUE;
	gboolean c, d;
	gboolean e = FALSE, g, f = TRUE;
	gboolean h = is_ensbled(b);

	return 0;
}

results in

+++ /tmp/cocci-output-20339-560145-test.c
@@ -5,9 +5,9 @@ static gboolean is_enabled(gboolean var)

  int main(int argc, char *argv[])
  {
-       gboolean b = TRUE;
+       gboolean b = true;
         gboolean c, d;
-       gboolean e = FALSE, g, f = TRUE;
+       gboolean e = false, g, f = true;
         gboolean h = is_ensbled(b);

         return 0;
