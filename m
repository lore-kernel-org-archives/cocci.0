From: arend.vanspriel@broadcom.com (Arend Van Spriel)
Date: Wed, 1 Feb 2017 10:24:57 +0100
Subject: [Cocci] matching on previous rule
Message-ID: <81590994-16fc-fb6c-0284-d9ed9ae80283@broadcom.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

In the cocci script below I want to make sure that attribute_group.group
is used for struct class::dev_groups field initializer. So in
class_group rule I specified groups_dev identifier. But running the
scripts results in failure:

Fatal error: exception Failure("45: unexpected use of a fresh identifier
groups_dev")

So I assume the identifier can only be use in the + part. I have been
digging in the SmPL grammar pages, but those are tricky to read because
it includes C-syntax definitions as well. A hint would be welcome.

Regards,
Arend

-------------------------------
@ attribute_group @
identifier group;
declarer name ATTRIBUTE_GROUPS;
@@

ATTRIBUTE_GROUPS(group);

@ class_group depends on attribute_group @
identifier group_class;
expression groups;
fresh identifier groups_dev = attribute_group.group ## "_groups";
fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
@@

struct class group_class = {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
        .dev_groups = groups_dev,
+#else
+       .dev_attrs = group_dev_attr,
+#endif
