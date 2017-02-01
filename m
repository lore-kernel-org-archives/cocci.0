From: arend.vanspriel@broadcom.com (Arend Van Spriel)
Date: Wed, 1 Feb 2017 11:25:37 +0100
Subject: [Cocci] matching on previous rule
In-Reply-To: <alpine.DEB.2.20.1702011101060.3110@hadrien>
References: <81590994-16fc-fb6c-0284-d9ed9ae80283@broadcom.com>
 <alpine.DEB.2.20.1702011038040.3110@hadrien>
 <91b687c3-fa3c-b482-ca28-798c516f0caf@broadcom.com>
 <alpine.DEB.2.20.1702011101060.3110@hadrien>
Message-ID: <39d52953-343f-8f7e-3208-3bd717deb6e6@broadcom.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 1-2-2017 11:08, Julia Lawall wrote:
>> Attached is the existing script we have in backports. It finds a
>> ATTRIBUTE_GROUPS macro and will make change in the struct class
>> accordingly. This works fine as long as the ATTRIBUTE_GROUPS in the file
>> is indeed used for setting struct class::dev_groups.
>>
>> Consider example below:
>>
>> ATTRIBUTE_GROUPS(foo);
>>
>> struct class bar = {
>> 	.dev_groups = foo_groups,
>> };
>>
>> The above is properly transformed by the script. However, recent change
>> in struct class introduced a new field .class_groups. So there is
>> another example that does:
>>
>> ATTRIBUTE_GROUPS(foo_class);
>>
>> struct class another_bar = {
>> 	.class_groups = foo_class_groups,
>> };
>>
>> The attached script will also transform this example. I only want it to
>> do that when .dev_groups is initialized with the given attribute group.
>> Below the ATTRIBUTE_GROUPS macro definition for reference.
> 
> OK, now I see a bit better what is going on.  Actually, fresh identifier
> is intended for when you bind a metavariable in the same rule, and then
> want to create something new for it in the generated code.  In your case,
> you can do the following instead:
> 
> @ attribute_group @
> identifier group;
> declarer name ATTRIBUTE_GROUPS;
> @@
> 
> ATTRIBUTE_GROUPS(group);
> 
> @script:python n@
> g << attribute_group.group;
> groups_var;
> dev_attrs_var;
> @@
> 
> coccinelle.groups_var = concat(g,"_groups")
> coccinelle.dev_attrs_var = concat(g,"_dev_attrs")
> 
> @ class_group depends on attribute_group @
> identifier group_class, n.groups_var, n.dev_attrs_var;
> @@
> 
> struct class group_class = {
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0)
>         .dev_groups = groups_var,
> +#else
> +       .dev_attrs = dev_attrs_var,
> +#endif
> };
> 
> Replace concat by whatever does string concatenation in python.
> 
> Feel free to change the metavariable names.

Thanks. One happy customer over here ;-)

Regards,
Arend
