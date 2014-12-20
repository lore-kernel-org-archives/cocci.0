From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 20 Dec 2014 21:32:59 +0100 (CET)
Subject: [Cocci] Change function invocations argument
In-Reply-To: <F51E5D4A-BD27-4192-95B7-2164D25A4380@gmail.com>
References: <F51E5D4A-BD27-4192-95B7-2164D25A4380@gmail.com>
Message-ID: <alpine.DEB.2.02.1412202131540.2098@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 20 Dec 2014, Eliseo Mart?nez wrote:

> Hi, 
> 
> For a given function, I want to change all invocations in this way:
> Turn the second argument of the form ?(long_u)(expression)? into ?(uintmax_t)expression?.
> I?ve done a patch for that but is failing with a not very much informative message error.
> Here is it:
> 
> ```
> eliseo at ubuntu:~/projects/os/neovim/neovim$ cat sample.cocci 
> @@ expression e1, e2, e3; @@
> 
>   put_bytes(
>     e1,
> -   (long_u)(e2),
> +   (uintmax_t)e2,
>     e3)

long_u and uintmax_t are not part of the C language, and Coccinelle is not 
always able to infer typedefs.  Just add:

typedef long_u, uintmax_t;

in your metavariable list.  This should only be done in the first rule in 
which the typename is relevant.

julia
