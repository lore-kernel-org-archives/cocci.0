From: mcuddie@qnx.com (Mitchell Cuddie)
Date: Tue, 5 Aug 2014 20:05:08 +0000
Subject: [Cocci] Goto Directionality?
Message-ID: <1407269090.1507.22.camel@QNXWS8653-PC>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

I am attempting to create a patch to identify the direction of a goto
statement.(i.e. label before/after goto)

but the patch matches both?

In my eyes a should match but b should not

Cheers,

Mitchell


@r @
identifier i;
position p;
@@
* i at p:
...
* goto i;

diff = 
--- test.c
+++ /tmp/cocci-output-22798-0e39f1-test.c
@@ -7,15 +7,11 @@ main()
        int b = 0xF0F0F0F0;
        void *a = &b;
        size_t c = (size_t)a;
-a:
        printf("%"PRIxPTR"\n", (uintptr_t)a);
-goto b;
        printf("%zu\n", c);  // prints as unsigned decimal
        printf("%zx\n", c);  // prints as hex
        printf("%zd\n", c);  // prints as signed decimal
-b:
        printf("%%\n");
-goto a;
        printf("%% %s", "cat\n");
 
        return 0;
