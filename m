From: johannes@sipsolutions.net (Johannes Berg)
Date: Mon, 06 Feb 2017 12:55:19 +0100
Subject: [Cocci] matching a modified identifier?
In-Reply-To: <1486380902.5430.1.camel@sipsolutions.net>
 (sfid-20170206_123508_512386_8466ADBF)
References: <1486380902.5430.1.camel@sipsolutions.net>
 (sfid-20170206_123508_512386_8466ADBF)
Message-ID: <1486382119.5430.2.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> @ attribute_group @
> identifier group;
> fresh identifier groups = group ## "_groups";
> declarer name ATTRIBUTE_GROUPS;
> @@
> 
> ATTRIBUTE_GROUPS(group);

If I add a dummy here:
+ATTRIBUTE_GROUPS_NAME(groups);

> @ class_group depends on attribute_group @
> identifier group_class;
> identifier attribute_group.groups;
> fresh identifier group_dev_attr = attribute_group.group ##
> "_dev_attrs";
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

Then the whole thing works - I guess I can live with that.

johannes
