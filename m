From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 15 Jun 2016 17:49:18 +0200
Subject: [Cocci] [PATCH 4/4] scripts/coccinelle: require coccinelle >=
 1.0.4 on device_node_continue.cocci
In-Reply-To: <alpine.DEB.2.10.1606151042080.2887@hadrien>
References: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
 <1465942217-14452-5-git-send-email-mcgrof@kernel.org>
 <alpine.DEB.2.10.1606151042080.2887@hadrien>
Message-ID: <20160615154918.GN11948@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jun 15, 2016 at 10:43:30AM +0200, Julia Lawall wrote:
> How about the following, since Coccinelle knows what its version is?
> This could of course be implemented in python as well.
> 
> julia
> 
> diff --git a/docs/Coccilib.3cocci b/docs/Coccilib.3cocci
> index 0e4fbb8..ca5b061 100644
> --- a/docs/Coccilib.3cocci
> +++ b/docs/Coccilib.3cocci
> @@ -232,6 +232,15 @@ is the empty list if spatch is not currently working on any file (eg,
>  in an initialize or finalize rule).
>  .sp
> 
> +.I val cocci_version
> +:
> +.B unit -> string
> +.sp
> +Returns the a string indicating the current version.  Note that if
> +Coccinelle has been modified since a release, the version number will be
> +postfixed with "-dirty".
> +.sp
> +
>  .I val print_main
>  :
>  .B ?color:string -> string -> pos list -> unit
> diff --git a/ocaml/coccilib.ml b/ocaml/coccilib.ml
> index f60c6b2..2f352d8 100644
> --- a/ocaml/coccilib.ml
> +++ b/ocaml/coccilib.ml
> @@ -168,6 +168,8 @@ let dir () = !Flag.dir
> 
>  let files () = !Flag.currentfiles
> 
> +let cocci_version () = Config.version
> +
>  (* ---------------------------------------------------------------------- *)
>  (* org mode *)
> 
> 

Anything to *only* get the version instead of a long list is nice, right now
spatch --version spits out:

spatch version 1.0.5 compiled with OCaml version 4.02.3
Flags passed to the configure script: [none]
Python scripting support: yes
Syntax of regular expresssions: PCRE

The Python library just parses the 3rd item at the top so it can extract
the version. But surely if spatch --version-only was available we'd use
that instead a well.

Other than this though how can we require coccinelle version checks per
SmPL file cleanly and also what should we do to make it backward compatible
with older versions of coccinelle?

  Luis
