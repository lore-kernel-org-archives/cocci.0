From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 12 Jun 2018 06:54:36 +0200 (CEST)
Subject: [Cocci] Weird whitespace behavior?
In-Reply-To: <CAGXu5jKybK9vJ3jaDXx8LYhdvkwy4C4UcC46Qww+tzPof1LJBQ@mail.gmail.com>
References: <CAGXu5j+XA87CBA9Xbqb4C-wLndaNW+usPgA9043m4TDeFUcxpw@mail.gmail.com>
 <CAGXu5jKybK9vJ3jaDXx8LYhdvkwy4C4UcC46Qww+tzPof1LJBQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1806120653280.2309@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 11 Jun 2018, Kees Cook wrote:

> On Mon, Jun 11, 2018 at 4:17 PM, Kees Cook <keescook@google.com> wrote:
> > Hi,
> >
> > I've been doing some large treewide changes to the allocators, and I
> > notice that Coccinelle does something odd for a specific case. I have
> > two scripts, one operating on kmalloc() and one operating on
> > devm_kmalloc(). They are identical script except for the function
> > names, however, while kmalloc produces patches like this:
> >
> > - foo = kmalloc(a * b, gfp);
> > + foo = kmalloc_array(a, b, gfp);
> >
> > the devm_kmalloc one produces:
> >
> > - foo = devm_kmalloc(handle, a * b, gfp);
> > + foo =devm_kmalloc_array(a, b, gfp);
> >
> > I can't figure out why the space after "=" is missing and have been
> > manually fixing it up...

I would need your semantic patch to see the problem.

> And while I'm at it... line breaks aren't working like I'd expect:
>
> -               collection = kmalloc(sizeof(struct hid_collection) *
> -                               parser->device->collection_size * 2,
> GFP_KERNEL);
> +               collection = kmalloc(array3_size(sizeof(struct
> hid_collection), parser->device->collection_size, 2),
> +                                    GFP_KERNEL);
>
> Why wasn't array3_size() correctly line wrapped?

I think that line breaking only works on the outermost function call.

julia
