From: eliseomarmol@gmail.com (=?utf-8?Q?Eliseo_Mart=C3=ADnez?=)
Date: Sat, 20 Dec 2014 21:45:58 +0100
Subject: [Cocci] Change function invocations argument
In-Reply-To: <alpine.DEB.2.02.1412202131540.2098@localhost6.localdomain6>
References: <F51E5D4A-BD27-4192-95B7-2164D25A4380@gmail.com>
 <alpine.DEB.2.02.1412202131540.2098@localhost6.localdomain6>
Message-ID: <254A1CAA-2FA6-4546-91BD-5E0C449C7F94@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Great. That worked. Just one more thing, please.
Some of the replacements done by the rule before leave literals of the form ?(uintmax_t)34?.
I would like to use an unsigned constant in those cases. This is, something like ?34u?. 
So I add the following rule:

```
@@ expression e1, e3; constant c2; @@
 30 
 31 - put_bytes(e1, (uintmax_t)c2, e3)
 32 + put_bytes(e1, c2, e3)
```

That does the work, except adding the ?u?. How could I do that?
Is it possible adding something literally in the output?
Is it possible to somehow say in line 32 ?render c2 but with u suffix??

Thanks.
> On 20 Dec 2014, at 21:32, Julia Lawall <julia.lawall@lip6.fr> wrote:
> 
> On Sat, 20 Dec 2014, Eliseo Mart?nez wrote:
> 
>> Hi, 
>> 
>> For a given function, I want to change all invocations in this way:
>> Turn the second argument of the form ?(long_u)(expression)? into ?(uintmax_t)expression?.
>> I?ve done a patch for that but is failing with a not very much informative message error.
>> Here is it:
>> 
>> ```
>> eliseo at ubuntu:~/projects/os/neovim/neovim$ cat sample.cocci 
>> @@ expression e1, e2, e3; @@
>> 
>>  put_bytes(
>>    e1,
>> -   (long_u)(e2),
>> +   (uintmax_t)e2,
>>    e3)
> 
> long_u and uintmax_t are not part of the C language, and Coccinelle is not 
> always able to infer typedefs.  Just add:
> 
> typedef long_u, uintmax_t;
> 
> in your metavariable list.  This should only be done in the first rule in 
> which the typename is relevant.
> 
> julia
