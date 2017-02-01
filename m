From: arend.vanspriel@broadcom.com (Arend Van Spriel)
Date: Wed, 1 Feb 2017 10:59:39 +0100
Subject: [Cocci] matching on previous rule
In-Reply-To: <alpine.DEB.2.20.1702011038040.3110@hadrien>
References: <81590994-16fc-fb6c-0284-d9ed9ae80283@broadcom.com>
 <alpine.DEB.2.20.1702011038040.3110@hadrien>
Message-ID: <91b687c3-fa3c-b482-ca28-798c516f0caf@broadcom.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 1-2-2017 10:39, Julia Lawall wrote:
> 
> 
> On Wed, 1 Feb 2017, Arend Van Spriel wrote:
> 
>> In the cocci script below I want to make sure that attribute_group.group
>> is used for struct class::dev_groups field initializer. So in
>> class_group rule I specified groups_dev identifier. But running the
>> scripts results in failure:
>>
>> Fatal error: exception Failure("45: unexpected use of a fresh identifier
>> groups_dev")
>>
>> So I assume the identifier can only be use in the + part. I have been
>> digging in the SmPL grammar pages, but those are tricky to read because
>> it includes C-syntax definitions as well. A hint would be welcome.
>>
>> Regards,
>> Arend
>>
>> -------------------------------
>> @ attribute_group @
>> identifier group;
>> declarer name ATTRIBUTE_GROUPS;
>> @@
>>
>> ATTRIBUTE_GROUPS(group);
>>
>> @ class_group depends on attribute_group @
>> identifier group_class;
>> expression groups;
>> fresh identifier groups_dev = attribute_group.group ## "_groups";
>> fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
>> @@
>>
>> struct class group_class = {
>> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
>>         .dev_groups = groups_dev,
>> +#else
>> +       .dev_attrs = group_dev_attr,
>> +#endif
> 
> Fresh identifiers can indeed only be used in constructed code (+).  Could
> you send an example of the before and after code you expect, so that I can
> be sure to understand what you are trying to do?

Attached is the existing script we have in backports. It finds a
ATTRIBUTE_GROUPS macro and will make change in the struct class
accordingly. This works fine as long as the ATTRIBUTE_GROUPS in the file
is indeed used for setting struct class::dev_groups.

Consider example below:

ATTRIBUTE_GROUPS(foo);

struct class bar = {
	.dev_groups = foo_groups,
};

The above is properly transformed by the script. However, recent change
in struct class introduced a new field .class_groups. So there is
another example that does:

ATTRIBUTE_GROUPS(foo_class);

struct class another_bar = {
	.class_groups = foo_class_groups,
};

The attached script will also transform this example. I only want it to
do that when .dev_groups is initialized with the given attribute group.
Below the ATTRIBUTE_GROUPS macro definition for reference.

Regards,
Arend

#define __ATTRIBUTE_GROUPS(_name)				\
static const struct attribute_group *_name##_groups[] = {	\
	&_name##_group,						\
	NULL,							\
}

#define ATTRIBUTE_GROUPS(_name)					\
static const struct attribute_group _name##_group = {		\
	.attrs = _name##_attrs,					\
};								\
__ATTRIBUTE_GROUPS(_name)

> thanks,
> julia
> 
-------------- next part --------------
/*
The new attribute sysfs group was added onto struct class via
commit d05a6f96c

mcgrof at ergon ~/linux (git::master)$ git describe --contains d05a6f96c
v3.11-rc2~18^2~3

This backpoort makes use of the helpers to backport this more efficiently.
Refer to the INFO file for documentation there on that.

commit d05a6f96c76062b5f25858ac02cf677602076f7e
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Sun Jul 14 16:05:58 2013 -0700

    driver core: add default groups to struct class

    We should be using groups, not attribute lists, for classes to allow
    subdirectories, and soon, binary files.  Groups are just more flexible
    overall, so add them.

    The dev_attrs list will go away after all in-kernel users are converted
    to use dev_groups.

    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Tested-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
*/

@ attribute_group @
identifier group;
declarer name ATTRIBUTE_GROUPS;
@@

ATTRIBUTE_GROUPS(group);

@ class_group depends on attribute_group @
identifier group_class;
expression groups;
fresh identifier group_dev_attr = attribute_group.group ## "_dev_attrs";
@@

struct class group_class = {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
	.dev_groups = groups,
+#else
+	.dev_attrs = group_dev_attr,
+#endif
};

@ attribute_group_mod depends on attribute_group && class_group @
declarer name ATTRIBUTE_GROUPS_BACKPORT;
identifier group;
@@

+#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
ATTRIBUTE_GROUPS(group);
+#else
+#define BP_ATTR_GRP_STRUCT device_attribute
+ATTRIBUTE_GROUPS_BACKPORT(group);
+#endif

@ class_registering depends on class_group && attribute_group_mod @
identifier class_register, ret;
identifier class_group.group_class;
fresh identifier group_class_init = "init_" ## attribute_group_mod.group ## "_attrs";
@@

(
+	group_class_init();
	return class_register(&group_class);
|
+	group_class_init();
	ret = class_register(&group_class);
)
