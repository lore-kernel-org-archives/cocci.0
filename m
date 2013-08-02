From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 2 Aug 2013 12:09:57 +0200 (CEST)
Subject: [Cocci] Question on expression meaning
In-Reply-To: <CAAxaTiPhKqVhTLwvRvPJSk5qXBgR3Nw8pwpaLdw2fBnY3Tox6A@mail.gmail.com>
References: <1375435947.11948.89.camel@ice-age.regit.org>
 <alpine.DEB.2.02.1308021134400.2035@hadrien>
 <CAAxaTiPhKqVhTLwvRvPJSk5qXBgR3Nw8pwpaLdw2fBnY3Tox6A@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1308021209430.2035@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2 Aug 2013, Nicolas Palix wrote:

> Hi,
>
> If you don't need f anywhere else, the following should be enough.
>
> @@
> identifier f;
> @@
>
> - return
>    f(...);
> + return;

He needs to be sure that the return type is void.

julia

> On Fri, Aug 2, 2013 at 11:37 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> On Fri, 2 Aug 2013, Eric Leblond wrote:
>>
>>> Hello,
>>>
>>> I'm trying to achieve the following:
>>>
>>> void DecodeIPV6(ThreadVars *tv, DecodeThreadVars *dtv, Packet *p, uint8_t
>>> *pkt, uint16_t len, PacketQueue *pq)
>>> {
>>> ...
>>>    /* now process the Ext headers and/or the L4 Layer */
>>>    switch(IPV6_GET_NH(p)) {
>>>        case IPPROTO_TCP:
>>>            IPV6_SET_L4PROTO (p, IPPROTO_TCP);
>>> -            return DecodeTCP(tv, dtv, p, pkt + IPV6_HEADER_LEN,
>>> IPV6_GET_PLEN(p), pq);
>>> +             DecodeTCP(tv, dtv, p, pkt + IPV6_HEADER_LEN,
>>> IPV6_GET_PLEN(p), pq);
>>> +            return;
>>>
>>> DecodeTCP being a function returning void too. In fact Solaris compiler
>>> does not accept void function to return a void function.
>>>
>>> My first try was:
>>>
>>> @@
>>> identifier f;
>>> identifier g;
>>> @@
>>>
>>> void f(...)
>>> {
>>> ...
>>> - return g(...);
>>> + g(...);
>>> + return;
>>> ...
>>> }
>>>
>>> But this does not work because the ... can not be put on - + lines.
>>>
>>> I've tried the not specific semantic patch:
>>>
>>> @@
>>> identifier f;
>>> expression E;
>>> @@
>>>
>>> void f(...)
>>> {
>>> ...
>>> - return E;
>>> + E;
>>> + return;
>>> ...
>>> }
>>>
>>> But it does not work for function (it works for "return 42;"). Any idea ?
>>
>>
>> It is quite strange that it does not work for a function call.  I will look
>> into it.
>>
>> But if you want to focus on function calls, what could be best is the
>> following (not tested):
>>
>> - return
>>     g(...);
>> + return;
>>
>> That way you preserve the spacing and newlines in the function call. There
>> could be some other formatting problems in the result, though.
>>
>> The other solution would be to make the argument of g be a metavariable
>> declared as:
>>
>> expression list es;
>>
>> Then you can remove it and add it back.  But you will probably lose any
>> newlines within es.
>>
>> julia
>> _______________________________________________
>> Cocci mailing list
>> Cocci at systeme.lip6.fr
>> https://systeme.lip6.fr/mailman/listinfo/cocci
>
>
>
> -- 
> Nicolas Palix
> Tel: +33 4 76 51 46 27
> http://membres-liglab.imag.fr/palix/
>
