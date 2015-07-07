From: jh1009.sung@samsung.com (Junghak Sung)
Date: Tue, 07 Jul 2015 17:30:23 +0900
Subject: [Cocci] [cocci] Ask for help
Message-ID: <559B8E1F.2090803@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi~

I'm a newbie for coccinelle.
I would like to make a cocci file to patch like :

struct type_b *foo(void);

int some_function(...)
{
-struct type_a *v1, *v2;
+struct type_b *v1, *v2;
...
v1 = foo();
v2 = foo();
...
}

Return value of foo() was changed from struct type_a to struct type_b.
So, I want to find out the locations where a function use it in and 
modify the type of local variables.

If the number of local variable is just one, this cocci could make the 
patch well.

@@
identifier i;
@@
{
...
-struct type_a *i;
+struct type_b *i;
...
i = foo();
...
}

But, assuming that the number of local variables is two or more, I have 
failed again and again.
How can I make cocci file?
Thank you in advance for your consideration.

Best regards,
Junghak
