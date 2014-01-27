From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Mon, 27 Jan 2014 15:11:38 +0100
Subject: [Cocci]
	=?gb2312?b?tPC4tDogtPC4tDogaG93IHRvIHdyaXRlIHN1Y2ggbWF0?=
	=?gb2312?b?Y2hpbmcgY2FzZT8=?=
In-Reply-To: <041CF35939B5534D851F16C30DD0B8CF727FD228@fzex.ruijie.com.cn>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
 <alpine.DEB.2.10.1401021418020.2088@hadrien>
 <041CF35939B5534D851F16C30DD0B8CF727F5D5A@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401030705560.2150@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F89C4@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401210433490.2092@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F8A3E@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401210730200.2002@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F8ACB@fzex.ruijie.com.cn>
 <041CF35939B5534D851F16C30DD0B8CF727F8AEF@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401210848170.2002@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F8BD2@fzex.ruijie.com.cn>
 <alpine.DEB.2.10.1401211019360.2098@hadrien>
 <041CF35939B5534D851F16C30DD0B8CF727FCF1B@fzex.ruijie.com.cn>
 <alpine.DEB.2.10.1401260318480.2217@hadrien>
 <041CF35939B5534D851F16C30DD0B8CF727FD05B@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401271332210.2139@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727FD228@fzex.ruijie.com.cn>
Message-ID: <CA+MoWDoW8bYPE=1muhQ4w7tUgPFK9xNDSQzo6idgnvZXkit-yw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

You can try:

@@
@@
* main () {
   ...
   when != Foo(...)
}

This semantic patch will match functions named main that do not
contain call to function Foo;

On Mon, Jan 27, 2014 at 2:55 PM, ??(?? ??) <linjia@ruijie.com.cn> wrote:
> Thanks for explain, but if I want to write a simple match, that is function foo must be called in main()
> e.g.
>
> int main(...)
> {
>     ...
>     Foo(...);
>     ...
> }
>
> I write it as
>
> @@
> @@
> main(...) {
>   <...
>     when != reg_process_exit_action(...)
>   ...>
> }
>
> Reports: 53 57
> Fatal error: exception Failure("minus: parse error:
>  = File "rgos.cocci", line 6, column 2,  charpos = 53
>     around = '...>', whole content =   ...>
> ")
>
> What does it mean?
>
> By the way, I still don?t know when I should use '<'and'>' and when need not?
>
> -----????-----
> ???: Julia Lawall [mailto:julia.lawall at lip6.fr]
> ????: 2014?1?27? 20:34
> ???: ??(?? ??)
> ??: cocci at systeme.lip6.fr
> ??: Re: ??: [Cocci] how to write such matching case?
>
> On Mon, 27 Jan 2014, ??(?? ??) wrote:
>
>> I wrote this
>>
>> @@
>> @@
>> cli_printf(...)
>> ... when != cli_client_execmd_fail(...)
>>
>>
>> it reports:
>> Fatal error: exception Failure("False should not be in the final
>> result.  Perhaps your rule doesn't contain any +/-/* code, or you have
>> a failed dependency.")
>>
>>
>> But i found there is not 'minus' in an example.cocci either....
>
> There is a * (indicating a line of interest).  You can use that.  If you use that, you will get an exists semantics for the ... (there exists an execution path that satisfies the property).  Otherwise, you get a foral semantics (all execution paths have to satisfy the property).
>
> julia
>
>>
>>
>> //
>> //  Add missing pci_dev_put
>> //
>> // Target: Linux
>> // Copyright:  2012 - LIP6/INRIA
>> // License:  Licensed under ISC. See LICENSE or
>> http://www.isc.org/software/license
>> // Author: Julia Lawall <Julia.Lawall@lip6.fr> // URL:
>> http://coccinelle.lip6.fr/ // URL: http://coccinellery.org/
>>
>> @@
>> local idexpression x;
>> expression e;
>> @@
>>
>> *x = pci_get_slot(...)
>> ... when != true x == NULL
>>     when != pci_dev_put(x)
>>     when != e = x
>>     when != if (x != NULL) {<+... pci_dev_put(x); ...+>} *return ...;
>>
>>
>>
>>
>>
>> -----????-----
>> ???: Julia Lawall [mailto:julia.lawall at lip6.fr]
>> ????: 2014?1?26? 19:19
>> ???: ??(?? ??)
>> ??: cocci at systeme.lip6.fr
>> ??: Re: [Cocci] how to write such matching case?
>>
>> On Sun, 26 Jan 2014, ??(?? ??) wrote:
>>
>> > In my project, it's required that if function A is called, and
>> > function B must be called following, just like this
>> >
>> > Foo(...)
>> > {
>> >    If ... {
>> >        A(....);
>> >        ...
>> >        B(....);
>> >    }
>> > }
>> >
>> > Or
>> >
>> > Foo1(...)
>> > {
>> >         A(....);
>> >         B(...);
>> >  }
>> >
>> >
>> > How to write a patch to find the missing case? Such as
>> >
>> > Foo(...)
>> > {
>> >    If ... {
>> >        A(....);
>> >        ...
>> >    }
>> > }
>> >
>> > Or
>> >
>> > Foo1(...)
>> > {
>> >        A(....);
>> >        ...
>> > }
>>
>> A(...)
>> ... When != B(...)
>>
>> julia
>>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



-- 
Peter
