From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 14 Jun 2016 15:08:46 +0200 (CEST)
Subject: [Cocci] Help
In-Reply-To: <1465909147.3712.11.camel@shyam-Lenovo-G50-70>
References: <1465909147.3712.11.camel@shyam-Lenovo-G50-70>
Message-ID: <alpine.DEB.2.10.1606141506570.2950@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 14 Jun 2016, shyam saini wrote:

> hi,
>
> I'm Shyam, an Computer Science undergraduate student.
>
> I'm trying to use coccinelle in linux kernel and for that I read many
>
> articles and Now, I come to this point,
>
> to use coccinelle we *.cocci  file containing rules
>
> and we can run coccinelle test with this command
>
> `spatch -sp-file AnyName.cocci --dir /path > patch`
>
> The patch file stores the diff output.
>
> So, my question is,  Can I change the kernel files, if I really want to
>
> apply that cocinelle defined rules? Because above mentioned command only
>
> shows the possible change. How can I turn that into a kernel patch.

patch -p1 < path_to_your_patch typically work.

If you prefer to have Coccinelle make the change directly, you can use te
command line argument --in-place.  In this case, Coccinelle will
still produce the patch output, but it will also change the source files.

julia
