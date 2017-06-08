From: linux@rasmusvillemoes.dk (Rasmus Villemoes)
Date: Thu, 8 Jun 2017 13:19:31 +0200
Subject: [Cocci] "bad" macros in struct definitions
In-Reply-To: <alpine.DEB.2.20.1706081300350.3005@hadrien>
References: <CAKwiHFjkufqumwhStrpsqwJb8x8OGc989XhQY_YWbc=rkCXabw@mail.gmail.com>
 <alpine.DEB.2.20.1706081300350.3005@hadrien>
Message-ID: <CAKwiHFjTA1grGYjjhq=i0-o0D1bjZbgiDBc1q5=RW+i-8styKA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 8 June 2017 at 13:02, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> Could you send a concrete semantic patch and .c file that is not givig the
> desired result?  Coccinelle does parsing in multiple passes.  It may fail
> on an earlier pass (and emit error messages if you use --verbose-parsing)
> but still succeed on a later one.

Something like the attached. As is, I get

$ spatch --macro-file test.h --sp-file ./test.cocci ./test.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
init_defs: test.h
HANDLING: ./test.c

but if I comment out the OBJHEAD I get the expected match in f2:

$ spatch --macro-file test.h --sp-file ./test.cocci ./test.c
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
init_defs: test.h
HANDLING: ./test.c
diff =
--- ./test.c
+++ /tmp/cocci-output-22044-346b6b-test.c
@@ -21,5 +21,4 @@ void f1(struct s *s)

 void f2(struct s *s)
 {
-       s->foo = malloc(sizeof(struct bar));
 }
-------------- next part --------------
A non-text attachment was scrubbed...
Name: test.cocci
Type: application/octet-stream
Size: 101 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170608/7197dc52/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: test.h
Type: text/x-chdr
Size: 16 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170608/7197dc52/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: test.c
Type: text/x-csrc
Size: 272 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170608/7197dc52/attachment-0001.bin>
