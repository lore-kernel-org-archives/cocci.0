From: wagi@monom.org (Daniel Wagner)
Date: Wed, 17 Jul 2013 16:56:14 +0200
Subject: [Cocci] Formatting issues
Message-ID: <51E6B08E.9030600@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

I have found another small issue. Not a big thing. I have following rule

@@
identifier f =~ "^(__)?connman_.*" ;
@@

f(...,
(
- FALSE
+ false
|
- TRUE
+ true
)
 ,...)


And this little C example:

bool __connman_bar(bool baz);
int connman_foo(int val, bool bar);

int main(int argc, char *argv)
{
	int err;

	if (__connman_bar(FALSE) == TRUE)
		err = connman_a_rather_long_line(2434, TRUE);

	return 0;
}


Running coccinelle on this results in the not so nicely formated patch:

@@ -5,8 +5,9 @@ int main(int argc, char *argv)
 {
        int err;
 
-       if (__connman_bar(FALSE) == TRUE)
-               err = connman_a_rather_long_line(2434, TRUE);
+       if (__connman_bar(false) == TRUE)
+               err = connman_a_rather_long_line(2434,
+                                                                         true);
 
        return 0;
 }

When connman_a_rather_long_line() is not sooo long then it works as
expected, that means not additional line is introduced. Any ideas
what is going wrong?

cheers,
daniel
