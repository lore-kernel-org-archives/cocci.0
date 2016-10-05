From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 5 Oct 2016 07:45:27 +0200 (CEST)
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <87r37vzd8j.fsf@vostro.rath.org>
References: <87r37vzd8j.fsf@vostro.rath.org>
Message-ID: <alpine.DEB.2.10.1610050744460.3061@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 4 Oct 2016, Nikolaus Rath wrote:

> Hello,
>
> In a set of C files, I would like to replace each instance of one type
> (struct fasel_foo) with another type (struct fasel_bar). For instance,
>
> char* fasel_foo_print(struct fasel_foo *ptr) {
>     // ...
>    return "this struct fasel_foo string should not change";
> }
>
> should become
>
> char* fasel_foo_print(struct fasel_bar *ptr) {
>     // ...
>    return "this struct fasel_foo string should not change";
> }
>
>
> Based on the LWN articles that I've read, this seems like the perfect
> use-case for coccinelle. However, somehow I'm struggling to write a
> patch for this. All the documentation that I could get my hands on seems
> to describe more abstract changes that require the use of variables -
> but as far as I can tell, I need something much simpler:
>
> @@
> "struct fasel_foo must be a type name!"
> @@
> - struct fasel_foo
> + struct fasel_bar
>
>
> ...if only I knew what to put between the @@.

Put nothing :)  From the word struct it should figure out that it is
working on a type.

julia

>
> Can someone point me in the right direction?
>
>
> Best,
> -Nikolaus
>
> --
> GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
> Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F
>
>              ?Time flies like an arrow, fruit flies like a Banana.?
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
