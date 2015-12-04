From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 4 Dec 2015 06:54:50 -0500
Subject: [Cocci] how to find missing initializer
In-Reply-To: <56608E06.9060003@metafoo.de>
References: <56603DC3.8040609@hurleysoftware.com> <56608E06.9060003@metafoo.de>
Message-ID: <56617F0A.50000@hurleysoftware.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 12/03/2015 01:46 PM, Lars-Peter Clausen wrote:
> On 12/03/2015 02:04 PM, Peter Hurley wrote:
>> Hi all,
>>
>> I'm struggling with the grammar necessary to find struct definitions
>> missing an initializer.
>>
>> The background is that many tty interfaces include a method/operations
>> table (named fields of function ptrs). For example, given a declaration
>> like,
>>
>>     struct tty_operations {
>>             int (*install)( /* ... */ );
>>             int (*remove)( /* ... */ );
>>             void (*cleanup)( /* ... * );
>>     ...
>>     };
>>
>> a tty driver might define its method table like,
>>
>>     static const struct tty_operations ops = {
>>             .install = uart_install,
>> 	    .remove = uart_remove,
>>             .cleanup = uart_cleanup,
>>     ...
>>     };
>>
>>
>> (actually, this is a common pattern throughout the kernel)
>>
>> Many operations are optional; a NULL method is simply not executed.
>> For example,
>>
>>     if (tty->ops->cleanup)
>>             tty->ops->cleanup(tty);
>>
>> So trying to find those in-tree drivers which _do not_ define a cleanup
>> method with coccinelle, led to this fragment which has a parse error.
>>
>> Apologies if my question is obvious or trivial; I'm still learning
>> coccinelle.
> 
> Usually you'd do something like first find all that have the initializer and
> then match all that where not matched before using a position metavariable. E.g.
> 
> @r1@
> identifier fops;
> identifier fn;
> position p;
> @@
> struct tty_operations fops at p = {
>     ...,
>     .cleanup = fn,
>     ...
> };
> 
> @@
> identifier fops;
> identifier fn;
> position p != r1.p;
> @@
> *struct tty_operations fops at p = {
>     ...
> };
> 

I appreciate the quick response. Thanks all.

Regards,
Peter Hurley
