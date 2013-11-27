From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 27 Nov 2013 23:46:42 +0100 (CET)
Subject: [Cocci] Incorrect skipping on custom types in type list
In-Reply-To: <52967195.9040505@redhat.com>
References: <52967195.9040505@redhat.com>
Message-ID: <alpine.DEB.2.02.1311272346160.2021@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 27 Nov 2013, Michael Stefaniuc wrote:

> Hello,
> 
> @@
> typedef VOID;
> typedef LPVOID;
> typedef PVOID;
> {void *, VOID *, LPVOID, PVOID} ppv;
> identifier QI =~ "_QueryInterface$";
> @@
> * QI(..., ppv)
> 
> executed on
> 
> int IFoo_QueryInterface(int *iface, long *riid, void **ppv)
> {
>     return IBar_QueryInterface(iface, riid, *ppv);
> }
> 
> gives:
> $ spatch QI.cocci /tmp/qi.c
> HANDLING: /tmp/qi.c
> No matches found for PVOID
> Skipping:/tmp/qi.c
> 
> Putting LPVOID or VOID* last in the type list gives:
> No matches found for LPVOID
> respectively
> No matches found for VOID
> 
> With void* in there I wouldn't have expected it to skip any files at all.

Thanks for the report.  I will look into it.  I expect to make a new 
release soon.

julia
