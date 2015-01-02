From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 2 Jan 2015 12:46:15 +0100 (CET)
Subject: [Cocci] [PATCH 0/3 RFC] Coccinelle: completion API checking
In-Reply-To: <1420192752-4889-1-git-send-email-der.herr@hofr.at>
References: <1420192752-4889-1-git-send-email-der.herr@hofr.at>
Message-ID: <alpine.DEB.2.10.1501021241550.2558@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 2 Jan 2015, Nicholas Mc Guire wrote:

>
> This little set of semantic patches is for partially checking the
> completion API. It seems to be working correctly and has not yet
> produced any false-positive.
>
> The cases being detected are:
>
> 1/3 - duplicate init_completions.
> 2/3 - incorrect static initialization of completion on stack.
> 3/3 - re-initialization of completion with init_completion() rather
>       than reinit_completion().
>
> semantic patch                  findings   files  confirmed
> duplicate_init_completion.cocci    2         2        2
> false_declare_completion.cocci     6         5        3
> false_init_compltion.cocci         9         6        5
>
> Note: false_declare_completion.cocci runs extremely slow on my system
>       roughly a factor 10 slower than the other two - not clear why.

The problem is the use of <... ...>.  That is good because it allows
DECLARE_COMPLETION not to appear on some execution paths, but it is not so
good because it allows DECLARE_COMPLETION to appear on no execution paths
at all.  So the semantic patch is considered to be relevant to every file,
and every file has to be parsed, which takes a lot of time.

To fix the problem, you can first check whether the call actually exists
in each function:

@pre_e exists@
identifier f;
declarer name DECLARE_COMPLETION;
@@

f(...) {
  <+...
  DECLARE_COMPLETION(...);
  ...+>
}

Then only run the second rules on functions for which pre_e is satisfied.
That is, in the rule e, instead of putting identifier f, you can put
identifier pre_e.f.  You can do the same in the rule ep.  Ep is already
looking for the existence of an execution path, so for ep you could also
just replace the <... ...> by <+... ...+> instead of relying on pre_e.

julia
