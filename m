From: wagi@monom.org (Daniel Wagner)
Date: Wed, 17 Jul 2013 10:47:21 +0200
Subject: [Cocci] gboolean -> bool conversion
In-Reply-To: <alpine.DEB.2.02.1307161818580.2264@hadrien>
References: <51DE6A05.9050008@monom.org>
 <alpine.DEB.2.02.1307111026390.2253@hadrien> <51DE75BF.3060207@monom.org>
 <51DE81CC.3010805@monom.org> <alpine.DEB.2.02.1307111221320.2253@hadrien>
 <51DE944F.1000903@monom.org> <alpine.DEB.2.02.1307111417120.2253@hadrien>
 <51DEA75C.10309@monom.org> <alpine.DEB.2.02.1307111451080.2253@hadrien>
 <51DFA84A.4050805@monom.org>
 <alpine.DEB.2.02.1307120858060.2013@localhost6.localdomain6>
 <51E556E8.2040701@monom.org> <alpine.DEB.2.02.1307161818580.2264@hadrien>
Message-ID: <51E65A19.6010903@monom.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Julia,

On 07/16/2013 06:22 PM, Julia Lawall wrote:
> On Tue, 16 Jul 2013, Daniel Wagner wrote:
>
>> Hi Julia,
>>
>> On 07/12/2013 09:00 AM, Julia Lawall wrote:
>>> @r@
>>> identifier f;
>>> parameter list[n] ps;
>>> identifier i;
>>> @@
>>>
>>> f(ps, gboolean i, ...) { ... }
>>>
>>> @@
>>> identifier r.f;
>>> expression list [r.n] es;
>>> @@
>>>
>>> f(es,
>>> (
>>> - FALSE
>>> + false
>>> |
>>> - TRUE
>>> + true
>>> )
>>>    ,...)
>>>
>>>
>>> I have not tested this, but it should work.  Write back if you have
>>> problems.
>>
>> This rule is a half success. The main problem stems from the fact, that a
>> function is declared in a header, e.g.
>>
>> 	void connman_foo(gboolean foo);
>>
>> and the caller just sees that and not the definition. If I understood
>> this correctly the 'f(ps, gboolean i, ...) { ... }' will not match.
>
> OK, you can make a rule that matches a prototype as well.

I am still struggling with creating a rule for a prototype. Rereading 
examples and documentation.

So I am only allowed to write a prototype (funproto, right?) in the 
declaration section (common_decl)? How do I write the rule?

(I am really bad not getting this done by myself.)

>> Another boolean transformation I do is with connman_bool_t to bool. Coccinelle
>> is kind of unhappy with this function:
>>
>> https://git.kernel.org/cgit/network/connman/connman.git/tree/vpn/vpn-agent.c#n38
>>
>> parse error
>>   = error in vpn/vpn-agent.c; set verbose_parsing for more info
>> badcount: 20
>> bad: #include "vpn.h"
>> bad:
>> bad: connman_bool_t vpn_agent_check_reply_has_dict(DBusMessage *reply)
>> bad: {
>> bad:    const char *signature = DBUS_TYPE_ARRAY_AS_STRING
>> BAD:!!!!!               DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
>> bad:            DBUS_TYPE_STRING_AS_STRING
>> bad:            DBUS_TYPE_VARIANT_AS_STRING
>> bad:            DBUS_DICT_ENTRY_END_CHAR_AS_STRING;
>> bad:
>> bad:    if (dbus_message_has_signature(reply, signature) == TRUE)
>> bad:            return TRUE;
>> bad:
>> bad:    connman_warn("Reply %s to %s from %s has wrong signature %s",
>> bad:                    signature,
>> bad:                    dbus_message_get_interface(reply),
>> bad:                    dbus_message_get_sender(reply),
>> bad:                    dbus_message_get_signature(reply));
>> bad:
>> bad:    return FALSE;
>> bad: }
>>
>> Is there a way to make the parser happy?
>
> Yes, you need to give some macro definitions.  Make a copy of standard.h,
> add what you need and give the name of the file with the option
> --macro-file-builtins.
>
> Concretely, you want to put the following definitions:
>
> #define DBUS_TYPE_ARRAY_AS_STRING 0
> #define DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
> #define DBUS_TYPE_STRING_AS_STRING
> #define DBUS_TYPE_VARIANT_AS_STRING
> #define DBUS_DICT_ENTRY_END_CHAR_AS_STRING

That would work in the example but it would not do it for

https://git.kernel.org/cgit/network/connman/connman.git/tree/plugins/vpn.c#n666

	const char *signature = DBUS_TYPE_ARRAY_AS_STRING
		DBUS_STRUCT_BEGIN_CHAR_AS_STRING
		DBUS_TYPE_OBJECT_PATH_AS_STRING
		DBUS_TYPE_ARRAY_AS_STRING
		DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
		DBUS_TYPE_STRING_AS_STRING
		DBUS_TYPE_VARIANT_AS_STRING
		DBUS_DICT_ENTRY_END_CHAR_AS_STRING
		DBUS_STRUCT_END_CHAR_AS_STRING;

So my solution was to pull in the dbus-protocol.h header which defines 
them as strings and everyting works fine.

cheers,
daniel
