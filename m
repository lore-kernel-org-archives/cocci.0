From: wagi@monom.org (Daniel Wagner)
Date: Thu, 11 Jul 2013 13:17:35 +0200
Subject: [Cocci] gboolean -> bool conversion
In-Reply-To: <alpine.DEB.2.02.1307111221320.2253@hadrien>
References: <51DE6A05.9050008@monom.org>
 <alpine.DEB.2.02.1307111026390.2253@hadrien> <51DE75BF.3060207@monom.org>
 <51DE81CC.3010805@monom.org> <alpine.DEB.2.02.1307111221320.2253@hadrien>
Message-ID: <51DE944F.1000903@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 07/11/2013 12:24 PM, Julia Lawall wrote:
> How is the following:
>
> @@
> gboolean x;
> @@
>
> x =
> (
> - TRUE
> + true
> |
> - FALSE
> + false
> )
>
> @@
> typedef bool;
> @@
>
> - gboolean
> + bool
>
> Note that the order of the rules is important.

Yeah, I should have noted that.

> In your rules, you
> converted gboolean to bool first, so the second rule would not find any
> gbooleans.

Yep, that works better, though now I hit the 'already tagged' problem.
Changing the second rule to

-gboolean
++ bool

Let's coccinelle run but the result is not perfect.

> Another problem with your rules was that it thought that gboolean and bool
> were expressions.  So the first rule needed typedef declaration. In my
> rule, I use gboolean as the type of a metavariable in the first rule, so
> Coccinelle considers it to be a type thereafter.  But I need the typedef
> on bool in the second rule.

Thanks for the explanation. It really helps!

> Is that good enough for your purpose, or are too many values and
> declarations being converted?

I have updated my sample program, which contains all our usage pattern 
of gboolean.

struct info {
	gboolean data;
};

static gboolean timer_cb(gpointer user_data)
{
	struct info *info = user_data;

	info->data = FALSE;

	return FALSE;
}

static gboolean is_enabled(gboolean flag)
{
	return flag != TRUE;
}

int main(int argc, char *argv[])
{
	gboolean b = TRUE;
	gboolean c, d;
	gboolean e = FALSE, g, f = TRUE;
	gboolean h = is_ensbled(b);
	struct info *info;

	info = g_new0(struct info, 1);
	info->data = TRUE;

	g_timeout(delay, timer_cb, &info);

	return 0;
}


The resulting patch (with the ++bool version) is:

--- test.c
+++ /tmp/cocci-output-21088-1cd7bc-test.c
@@ -1,31 +1,31 @@
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
+       bool bool c, d;
+       bool bool bool e = false, g, f = true;
+       bool h = is_ensbled(b);
         struct info *info;

         info = g_new0(struct info, 1);
-       info->data = TRUE;
+       info->data = true;

         g_timeout(delay, timer_cb, &info);


Obviously, the 'bool bool bool' stuff is not correct, but I can catch 
that via the compiler.

timer_cb() should not be changed. Is there maybe a way of blacklisting 
certain matches? I see there are some 'when' examples but I do not 
really growk them right now. Sorry for beeing so noobish...

cheers,
daniel
