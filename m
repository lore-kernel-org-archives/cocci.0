From: keescook@chromium.org (Kees Cook)
Date: Thu, 23 Aug 2018 15:27:52 -0700
Subject: [Cocci] [Fwd: Re: [PATCH] rtc: sun6i: Use struct_size() in
	kzalloc()]
In-Reply-To: <4a992fbb6ae172baf3c76ed979bf6804914b089e.camel@perches.com>
References: <CAGXu5jKPOVRk5DbFMKu0BV_K-ES+j+6_aApjyo0X8zXBfTYDnw@mail.gmail.com>
 <700bfdf296aa112799b6a6f091162cc34f6fef10.camel@perches.com>
 <CAGXu5jL3C78vkVL968HtBdLZgRYYQp4_pTKMT=BTJnk5z6CH3w@mail.gmail.com>
 <alpine.DEB.2.21.1808231759050.2376@hadrien>
 <CAGXu5jLjOtG0jTt2ZVyZe7ivBfZhRTyOKai0fHMzPFxUCr3LRg@mail.gmail.com>
 <alpine.DEB.2.21.1808231811110.2376@hadrien>
 <4a992fbb6ae172baf3c76ed979bf6804914b089e.camel@perches.com>
Message-ID: <CAGXu5jKdbGCLdSQFTdGnhgN+tNKHFV=XEkapgtYmx+hK79NMbw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Aug 23, 2018 at 3:21 PM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2018-08-23 at 18:13 -0400, Julia Lawall wrote:
>>
>> On Thu, 23 Aug 2018, Kees Cook wrote:
>>
>> (a + b) * c
>>
>> It will consider a pattern with the parentheses removed, but that pattern
>> won't match anything, because real trees that consist of a + b * c are
>> parsed in a different way.
>
> spatch 1.0.4 doesn't seem to:
>
> $ spatch --version
> spatch version 1.0.4 with Python support and with PCRE support
> $ cat match_mul.cocci
> @@
> expression a, b, c;
> int d;
> @@
>
> *       d = a * b + c;

But "(a * b) + c" for the rule does:


$ cat isomorphisms.c
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
        int a, b, c;

        a = atoi(argv[1]);
        b = atoi(argv[2]);
        c = atoi(argv[3]);

        printf("%d\n", a + b * c);
        printf("%d\n", (a + b) * c);
        printf("%d\n", a + (b * c));
        printf("%d\n", b * c + a);
        printf("%d\n", b * (c + a));
        printf("%d\n", (b * c) + a);

        return 0;
}
$ cat match.cocci
@@
identifier A, B, C;
@@

* (A * B) + C

$ spatch -sp-file match.cocci isomorphisms.c
init_defs_builtins: /usr/lib/coccinelle/standard.h
HANDLING: isomorphisms.c
diff =
--- isomorphisms.c
+++ /tmp/cocci-output-8402-870fd6-isomorphisms.c
@@ -9,12 +9,8 @@ int main(int argc, char *argv[])
        b = atoi(argv[2]);
        c = atoi(argv[3]);

-       printf("%d\n", a + b * c);
        printf("%d\n", (a + b) * c);
-       printf("%d\n", a + (b * c));
-       printf("%d\n", b * c + a);
        printf("%d\n", b * (c + a));
-       printf("%d\n", (b * c) + a);

        return 0;
 }


So it sounds like I should put parens around all kinds of things in my rules...

-Kees

-- 
Kees Cook
Pixel Security
