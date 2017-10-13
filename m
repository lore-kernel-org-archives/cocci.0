From: yangyibiao@nju.edu.cn (=?gb2312?B?0e7S0bHr?=)
Date: Fri, 13 Oct 2017 23:25:19 +0800
Subject: [Cocci] How to remove unused global variables by using
 Coccinelle?
In-Reply-To: <70B9014F-1F0A-4E14-B50A-CFBEC31C97F1@nju.edu.cn>
References: <tencent_0C53782B45D6A684021E71E3@qq.com>
 <alpine.DEB.2.20.1710131556040.3242@hadrien>
 <7E52DBF4-E12A-44DE-A393-7A8E943A79AF@nju.edu.cn>
 <70B9014F-1F0A-4E14-B50A-CFBEC31C97F1@nju.edu.cn>
Message-ID: <182930E3-8181-4334-941F-1CCB6BD9DDDB@nju.edu.cn>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> ? 2017?10?13????11:12???? <yangyibiao@nju.edu.cn> ???
> 
> 
>> ? 2017?10?13????10:09???? <yangyibiao at nju.edu.cn <mailto:yangyibiao@nju.edu.cn>> ???
>> 
>> Thank you very much. It works.
>> 
>>> ? 2017?10?13????9:59?Julia Lawall <julia.lawall at lip6.fr <mailto:julia.lawall@lip6.fr>> ???
>>> 
>>> 
>>> On Fri, 13 Oct 2017, ??? wrote:
>>> 
>>>> Hello,
>>>> 
>>>> Thanks for this awesome tool - Coccinelle.
>>>> 
>>>> Currently, I am trying to use Coccinelle to remove unused global variables in C source code. While applying the following remove.cocci to test.c , it does not work.
>>>> 
>>>> Can anyone help?
>>>> 
>>>> Thanks.
>>>> ---
>>>> Yibiao
>>>> 
>>>> $ spatch --version
>>>> spatch version 1.0.6 compiled with OCaml version 4.02.3
>>>> Flags passed to the configure script: [none]
>>>> Python scripting support: yes
>>>> Syntax of regular expresssions: PCRE
>>>> 
>>>> $ spatch ?in-place -sp-file remove.cocci small.c
>>>> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
>>>> HANDLING: small.c
>>>> 
>>>> $ cat remove.cocci
>>>> @@
>>>> type T;
>>>> identifier i;
>>>> expression E;
>>>> @@
>>>> - static T i = E;
>>>>  ... when != I
>>> 
>>> This doesn't work for various reasons.  First Coccinelle is case
>>> sensitive, so i is different than I.  Also Coccinelle works on one
>>> function at a time.  So you can't use ... to refer to the rest of the
>>> file.  You want something like:
>>> 
>>> @r@
>>> type T;
>>> identifier i;
>>> expression E;
>>> @@
>>> static T i = E;
>>> 
>>> @useful@
>>> identifier r.i;
>>> @@
>>> 
>>> i
>>> 
>>> @depends on !useful@
>>> identifier r.i;
>>> @@
>>> - static T i = E;
>>> 
>>> julia
>>> 
>>>> 
>>>> $ cat small.c
>>>> static int g = 0;
>>>> int main()
>>>> {
>>>>    return 0;
>>>> }
>>>> _______________________________________________
>>>> Cocci mailing list
>>>> Cocci at systeme.lip6.fr <mailto:Cocci@systeme.lip6.fr>
>>>> https://systeme.lip6.fr/mailman/listinfo/cocci <https://systeme.lip6.fr/mailman/listinfo/cocci>
> 
> 
> Btw, how to distinguish global and local variables? 
> In the following, the output include both global variables, functions names, and local variables. 
> 
> What if I only want to output global variables? Thanks.
> 
> @g@
> type T;
> identifier i;
> @@
> T i;
> 
> @script:python depends on g@
> i << g.i;
> @@
> print I
> 
> 
> ??
> Yibiao

Solved by using the global idexpression! Thank you all the same.

@g@
type T;
global idexpression x;
@@
x

@useful@
global idexpression g.x;
@@
x(...)


@script:python depends on g && !useful@
x << g.x;
@@
print x

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20171013/3c3c0ffe/attachment-0001.html>
