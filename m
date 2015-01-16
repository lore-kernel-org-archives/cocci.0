From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Fri, 16 Jan 2015 20:18:07 +0100
Subject: [Cocci] Find all variables/parameters of a given type.
In-Reply-To: <54B95A32.9090600@users.sourceforge.net>
References: <528DE554-4455-43F3-86D0-A4A1BE677755@gmail.com>
 <54B95A32.9090600@users.sourceforge.net>
Message-ID: <559AE227-484E-42F1-94ED-DB703D630EE3@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Ok. Rule for function definition works. Rule for function declaration doesn?t (gives parse error too).
To my particular problem at hand, I don?t need to locate declarations, so that solves my problem.
But just out of curiosity, why rule for function declaration is incorrect?

Thanks!

BTW, every time I post a message to this list, I get a message back saying my message has to be moderated since I?m not a member of the list. Can I be added to such list, or is it somehow restricted?


> On 16 Jan 2015, at 19:36, SF Markus Elfring <elfring@users.sourceforge.net> wrote:
> 
>> I?m trying to write a semantic patch to be able to find
>> all `long` variables/function parameters in my code.
> 
> Can the desired semantic filter approach be also written
> without a SmPL disjunction?
> 
> Would you like to try the following variant out?
> 
> @find_integer_variable@
> identifier var;
> @@
> *long var
> ... ;
> )
> 
> @find_integer_within_function_declaration@
> identifier func, var;
> @@
> func(...,
> *     long var,
>      ...);
> )
> 
> @find_integer_from_function_definition@
> identifier func, var;
> @@
> func(...,
> *     long var,
>      ...)
> { ... }
> 
> 
> Are you looking for more special cases in your source code?
> 
> Regards,
> Markus
