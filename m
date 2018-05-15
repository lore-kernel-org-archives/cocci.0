From: jglisse@redhat.com (Jerome Glisse)
Date: Tue, 15 May 2018 16:36:07 -0400
Subject: [Cocci] Matching function pointer typedef
Message-ID: <20180515203606.GA3687@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I am trying to modify an function pointer typedef something like:

@@
@@
- typedef void (*toto_t)(int a, int b);
+ typedef void (*toto_t)(int a, int b, int c);

But it seems spatch or the semantic does not handle function pointer.
Or simply that typedef is not well handled in the first place. Thing
like:

@@
@@
- typedef int nombre;
+ typedef unsigned nombre;

also fails to work. But if typedef is use with struct then it works.
For instance:

@@
@@
- typedef struct {int a;} nombre;
+ typedef struct {unsigned a;} nombre;

Do work. Looking at declaration grammar i do not see why the former
does not work. I am using fedora 27 coccinelle 1.0.6 if that matters.

Is this a known limitation or am i writting it wrong ?

Thank you for any input on this,
J?r?me
