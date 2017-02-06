From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 6 Feb 2017 13:22:52 +0100 (CET)
Subject: [Cocci] matching a modified identifier?
In-Reply-To: <1486380902.5430.1.camel@sipsolutions.net>
References: <1486380902.5430.1.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1702061321500.8663@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 6 Feb 2017, Johannes Berg wrote:

> Hi,
>
> In backports, we have the following spatch:
>
> @ attribute_group @
> identifier group;
> declarer name ATTRIBUTE_GROUPS;
> @@
>
> ATTRIBUTE_GROUPS(group);
>
> @ class_group depends on attribute_group @
> identifier group_class;
> identifier groups;
> fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
> @@
>
> struct class group_class = {
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
> ????????.dev_groups = groups,
> +#else
> +???????.dev_attrs = group_dev_attr,
> +#endif
> };
>
> [...]
>
>
>
> But this isn't sufficient and falls over if there are multiple
> instances of ATTRIBUTE_GROUPS, it's essentially undefined which one
> gets picked.
>
> I tried to match a modified identifier like this:
>
> @ attribute_group @
> identifier group;
> fresh identifier groups = group ## "_groups";
> declarer name ATTRIBUTE_GROUPS;
> @@
>
> ATTRIBUTE_GROUPS(group);
>
> @ class_group depends on attribute_group @
> identifier group_class;
> identifier attribute_group.groups;
> fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
> @@
>
> struct class group_class = {
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
>         .dev_groups = groups,
> +#else
> +       .dev_attrs = group_dev_attr,
> +#endif
> };
>
> [...]
>
>
> but that doesn't work at all.

Use python between the two rules to construct the identifier you want.
You can see examples in coccinelle/demos/pythontococci.cocci

julia
