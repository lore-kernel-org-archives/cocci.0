From: wagi@monom.org (Daniel Wagner)
Date: Wed, 17 Jul 2013 17:40:31 +0200
Subject: [Cocci] gboolean -> bool conversion
In-Reply-To: <alpine.DEB.2.02.1307171709540.2113@hadrien>
References: <51DE6A05.9050008@monom.org>
 <alpine.DEB.2.02.1307111026390.2253@hadrien> <51DE75BF.3060207@monom.org>
 <51DE81CC.3010805@monom.org> <alpine.DEB.2.02.1307111221320.2253@hadrien>
 <51DE944F.1000903@monom.org> <alpine.DEB.2.02.1307111417120.2253@hadrien>
 <51DEA75C.10309@monom.org> <alpine.DEB.2.02.1307111451080.2253@hadrien>
 <51DFA84A.4050805@monom.org>
 <alpine.DEB.2.02.1307120858060.2013@localhost6.localdomain6>
 <51E556E8.2040701@monom.org> <alpine.DEB.2.02.1307161818580.2264@hadrien>
 <51E65A19.6010903@monom.org> <alpine.DEB.2.02.1307171100000.2247@hadrien>
 <51E6B10E.20103@monom.org> <alpine.DEB.2.02.1307171709540.2113@hadrien>
Message-ID: <51E6BAEF.6030400@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 07/17/2013 05:11 PM, Julia Lawall wrote:
> On Wed, 17 Jul 2013, Daniel Wagner wrote:
>
>> On 07/17/2013 11:01 AM, Julia Lawall wrote:
>>>> I am still struggling with creating a rule for a prototype.
>>>> Rereading examples
>>>> and documentation.
>>>>
>>>> So I am only allowed to write a prototype (funproto, right?) in the
>>>> declaration section (common_decl)? How do I write the rule?
>>>>
>>>> (I am really bad not getting this done by myself.)
>>>
>>> Could you send your attempt?  It should be possible to write a function
>>> prototype pattern just like any other pattern, but it is true that I
>>> haven't done that very much, so it might be deficient in some way.
>>
>> So my approach was to try this here:
>>
>>
>> @r@
>> identifier f;
>> parameter list[n] ps;
>> identifier i;
>> @@
>>
>> f(ps, gboolean i, ...);
>
> Just add the metavariable declaration
>
> type T;
>
> and T to the left of f in the prototype.  For function definitions, it
> is OK with the return type being absent, but apparently not for
> prototypes. Leaving it out probably causes conflicts for the parser,
> because a prototype looks like a function call.

Yes, that did the trick. Thanks again!

cheers,
daniel
