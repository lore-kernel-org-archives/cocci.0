From: wagi@monom.org (Daniel Wagner)
Date: Thu, 11 Jul 2013 14:38:52 +0200
Subject: [Cocci] gboolean -> bool conversion
In-Reply-To: <alpine.DEB.2.02.1307111417120.2253@hadrien>
References: <51DE6A05.9050008@monom.org>
 <alpine.DEB.2.02.1307111026390.2253@hadrien> <51DE75BF.3060207@monom.org>
 <51DE81CC.3010805@monom.org> <alpine.DEB.2.02.1307111221320.2253@hadrien>
 <51DE944F.1000903@monom.org> <alpine.DEB.2.02.1307111417120.2253@hadrien>
Message-ID: <51DEA75C.10309@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On 07/11/2013 02:17 PM, Julia Lawall wrote:
> Maybe the patch below will get rid of the already tagged token problem and
> allow you to get rid of the ++..

Thanks for the quick fix. Indeed, this fixes the 'already tagged' 
problem. The result is now:

  struct info {
-       gboolean data;
+       bool data;
  };

-static gboolean timer_cb(gpointer user_data)
+static bool timer_cb(gpointer user_data)
  {
         struct info *info = user_data;

-       info->data = FALSE;
+       info->data = false;

         return FALSE;
  }

-static gboolean is_enabled(gboolean flag)
+static bool is_enabled(bool flag)
  {
         return !flag;
  }

  int main(int argc, char *argv[])
  {
-       gboolean b = TRUE;
-       gboolean c, d;
-       gboolean e = FALSE, g, f = TRUE;
-       gboolean h = is_ensbled(b);
+       bool b = true;
+       bool c, d;
+       bool e = false, g, f = true;
+       bool h = is_ensbled(b);
         struct info *info;

         info = g_new0(struct info, 1);
-       info->data = TRUE;
+       info->data = true;

         g_timeout(delay, timer_cb, &info);


I am pondering if it would be possible to say

- gboolean
	when != 'static gboolean func(gpointer)'
+ bool


cheers,
daniel

ps: I the install step didn't work for me:

$ make install
cp: cannot create regular file ?ocaml/coccilib/coccilib.cmi?: No such 
file or directory
make: *** [ocaml/coccilib/coccilib.cmi] Error 1

Doing a mkdir before the install step fixed it for me.

$ mkdir ocaml/coccili
$ make install
