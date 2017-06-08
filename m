From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 8 Jun 2017 13:02:09 +0200 (CEST)
Subject: [Cocci] "bad" macros in struct definitions
In-Reply-To: <CAKwiHFjkufqumwhStrpsqwJb8x8OGc989XhQY_YWbc=rkCXabw@mail.gmail.com>
References: <CAKwiHFjkufqumwhStrpsqwJb8x8OGc989XhQY_YWbc=rkCXabw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1706081300350.3005@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 8 Jun 2017, Rasmus Villemoes wrote:

> I'm trying to apply spatch to libnl
> (https://github.com/thom311/libnl), but I'm having problems with
> spatch's parsing of the header files. libnl has a macro
>
> #define NLHDR_COMMON                            \
>         int                     ce_refcnt;      \
>         struct nl_object_ops *  ce_ops;         \
>         struct nl_cache *       ce_cache;       \
>         struct nl_list_head     ce_list;        \
>         int                     ce_msgtype;     \
>         int                     ce_flags;       \
>         uint64_t                ce_mask;
>
>
> and many data structures are defined like
>
> struct rtnl_link
> {
>     NLHDR_COMMON
>
>     char                l_name[IFNAMSIZ];
>     uint32_t            l_family;
>     uint32_t            l_arptype;
> ...
>
> I tried adding a cocci.h file containing just
>
> #define NLHDR_COMMON
>
> and giving that as a --macro-file argument, but spatch still fails to
> parse the structure. If I manually remove the NLHDR_COMMON from
> rtnl_link above, everything works (that is, coccinelle now knows the
> types of the various rtnl_link members and my .cocci works as
> expected). Am I doing something wrong, or is this a bug in the "bad
> macro" handling?
>
> Related feature request: For now, I'm not really interested in the
> members defined by the NLHDR_COMMON macro, so being able to just stub
> it out would be fine. But I could imagine it would be nice to have it
> expand to its actual definition. I suppose that could be done by
> copying its definition to one's local --macro-file, but it would be
> nicer to have a way to say "please always expand this macro to
> whatever its current definition is".

Could you send a concrete semantic patch and .c file that is not givig the
desired result?  Coccinelle does parsing in multiple passes.  It may fail
on an earlier pass (and emit error messages if you use --verbose-parsing)
but still succeed on a later one.

julia


>
>
> $ spatch --version
> spatch version 1.0.6-00153-g36e91e8 compiled with OCaml version 4.02.3
>
