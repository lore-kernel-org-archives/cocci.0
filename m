From: johannes@sipsolutions.net (Johannes Berg)
Date: Mon, 06 Feb 2017 12:35:02 +0100
Subject: [Cocci] matching a modified identifier?
Message-ID: <1486380902.5430.1.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

In backports, we have the following spatch:

@ attribute_group @
identifier group;
declarer name ATTRIBUTE_GROUPS;
@@

ATTRIBUTE_GROUPS(group);

@ class_group depends on attribute_group @
identifier group_class;
identifier groups;
fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
@@

struct class group_class = {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
????????.dev_groups = groups,
+#else
+???????.dev_attrs = group_dev_attr,
+#endif
};

[...]



But this isn't sufficient and falls over if there are multiple
instances of ATTRIBUTE_GROUPS, it's essentially undefined which one
gets picked.

I tried to match a modified identifier like this:

@ attribute_group @
identifier group;
fresh identifier groups = group ## "_groups";
declarer name ATTRIBUTE_GROUPS;
@@

ATTRIBUTE_GROUPS(group);

@ class_group depends on attribute_group @
identifier group_class;
identifier attribute_group.groups;
fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
@@

struct class group_class = {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
        .dev_groups = groups,
+#else
+       .dev_attrs = group_dev_attr,
+#endif
};

[...]


but that doesn't work at all.

Any thoughts?

johannes
