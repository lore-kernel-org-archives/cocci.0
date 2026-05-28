Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4338DCD6E44
	for <cocci@archiver.kernel.org>; Thu, 28 May 2026 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ZES8Qs8mRf+udC9mEWGIARMZiYU0OCmNyhwmmaQIWis=;
  b=t6IpWyzKJ1eL8tgzrU0OWg57Q6P+gIA3MHEbKRDLE0+M1kgYIXXgO2de
   Ij4TGkGOwoTbUMPYA09LDFo3vu2IsgGWCPa7/NA57o9+OZx8cKFUDjF6j
   ks5fGnv2GXk90DApGYaN0i3US1Smp0eDP6UI+MhSoqUhQ/Ao5FvGGeUrb
   c=;
X-CSE-ConnectionGUID: q2wZFR15TJaGiCeQnvewpA==
X-CSE-MsgGUID: omzMS8lIQrKNqNGqUd7+DQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208,217";a="278650536"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 May 2026 11:32:51 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6BD83816D3; Thu, 28 May 2026 11:32:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 92E4F8251A
	for <cocci@sympa.inria.fr>; Thu, 28 May 2026 07:51:07 +0200 (CEST)
X-CSE-ConnectionGUID: RppajtKHRLmBgfELPGO27w==
X-CSE-MsgGUID: LlvV2QF0SkKcCpRivY3wuA==
X-IronPort-AV: E=Sophos;i="6.24,172,1774306800"; 
   d="scan'208,217";a="147772994"
Received: from ptb-5cg22835fs.irisa.fr (HELO [131.254.21.198]) ([131.254.21.198])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 07:51:07 +0200
Content-Type: multipart/alternative;
 boundary="------------grXILLkAqmS70uEs8dVjBL0E"
Message-ID: <7670a200-249d-4156-8363-4d24c14be452@irisa.fr>
Date: Thu, 28 May 2026 07:51:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
References: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr>
 <7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr>
 <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr>
 <d2f6ff1c-b0e1-4a1a-9bfc-d609a8092e3c@web.de>
 <6c02bb11-7816-4258-b2fa-9dc63ef2a268@irisa.fr>
 <44dd7481-648f-4ae2-ad4c-10eb0609fefb@web.de>
 <bbe18a76-0100-40ed-b6e7-f053931f51eb@irisa.fr>
 <ad06211-6441-9568-e643-c39df9bf8494@inria.fr>
 <186417e3-b2d4-4f1c-9790-8fd1b836e946@irisa.fr>
 <4221c671-682-68de-9a94-1634364b6685@inria.fr>
 <363a5557-fcfc-4856-b4a9-17bbdadff8b0@irisa.fr>
 <c21e4ca-3771-192d-eb44-80837b4319e1@inria.fr>
Content-Language: fr, en-US
From: Pierrick Philippe <pierrick.philippe@irisa.fr>
In-Reply-To: <c21e4ca-3771-192d-eb44-80837b4319e1@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Pierrick Philippe <pierrick.philippe@irisa.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3539
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/Bf-eBDIUW-5ZruKy1HMOHQ>

This is a multi-part message in MIME format.
--------------grXILLkAqmS70uEs8dVjBL0E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/26 12:53, Julia Lawall wrote:
> On Wed, 27 May 2026, Pierrick Philippe wrote:
>> On 5/27/26 11:16, Julia Lawall wrote:
>>> On Wed, 27 May 2026, Pierrick Philippe wrote:
>>>> On 5/27/26 10:59, Julia Lawall wrote:
>>>>> On Wed, 27 May 2026, Pierrick Philippe wrote:
>>>>> I think that the problem is that { ... } is not actually an expression in
>>>>> C.  It's a strange thing that can only exist as part of a declaration.
>>>>>
>>>>> But you don't want to change it, so you don't need a metavariable for it.
>>>>>
>>>>> Just write:
>>>>>
>>>>> - T F =
>>>>> + T __attribute__((myattr(("X")))) F =
>>>>>   { ... };
>>>> It does work indeed, thanks a lot!
>>>> Although the metavariable X is not interpreted in the `+` context, could
>>>> it be due to the attribute or unrelated?
>>> It's due to the string quotes.
>>>
>>> It nmight be possible to get around this with a fresh identifier:
>>>
>>> fresh identifier x = "\"" # X # "\"";
>> So this work, although the output still have the escaped quote, probably
>> due to the same "issue" regarding quote.
> I'm sorry, but I don't know what you want for the output.  Could you
> provide an example?  If you don't want quotes at all, then you don't need
> quotes at all.

I apologize to both of you for the confusion, I do want quote, but I do
not want escaped quote (I haven't tried it with escaped quote, but I'm
pretty sure it won't be a valid string for GCC).
I also apologize for the lack of precision here.

The attribute I'm working with is taking an optional parameter, which,
if present, should be a string (const char *) containing the field name
of interest.
So in my example, the field of interest is `x` from the memory object
`f` of type ` struct foo` (this instance specifically, not all instance
of the same type).
And the argument to the attribute would then be the string "x".
The requirement of being a string is due to restriction for parameter of
GNU attributes (outside internal attributes), which have to be constant
literals or a declared identifier.
In my case, without the quote, the parameter would be interpreted as an
undeclared identifier, hence leading to compilation error.
> julia
>> But there also is a possible issue with the parsing/code generation
>> here, generated diff and output of spatch:
>>
>> ```
>> @attribute_struct_scalar_type_resolve@
>> expression E1, E2;
>> type T;
>> identifier F, X;
>> fresh identifier param = "\"" ## X ## "\"";
>> @@
>> T 
>> +__attribute__((myattr((param))))
>> F = { ... };
>> ...
>> memcmp(&F.X, E1, E2)
>>
>> warning: attribute_struct_scalar_type_resolve: metavariable param not
>> used in the + code
>> HANDLING: ./test.c
>> -----------------------------------------------------------------------
>> let's go
>> -----------------------------------------------------------------------
>> -----------------------------------------------------------------------
>> -----------------------------------------------------------------------
>> attribute_struct_scalar_type_resolve = 
>> -----------------------------------------------------------------------
>> dependencies for rule attribute_struct_scalar_type_resolve satisfied:
>> binding in = []
>> binding relevant in = []
>>      transformation info returned:
>>           transform state: 7
>>                with rule_elem: T
>>                                  >>> __attribute__ ((myattr((param))))
>>                                        F = {...
>>                                             ,
>>                                             };
>>                with binding: [attribute_struct_scalar_type_resolve.param
>> --> id \"x\";
>>                              attribute_struct_scalar_type_resolve.X -->
>> id x]
>>      binding out = []
>>      transform one node: 7
>> parse error 
>>  = error in /tmp/cocci_small_output-112399-acda44-test.c; set
>> verbose_parsing for more info
>> badcount: 2
>> bad: 
>> bad: 
>> bad: int main(void) {
>> -----------------------------------------------------------------------
>> Finished
>> -----------------------------------------------------------------------
>> parse error 
>>  = error in /tmp/cocci-output-112399-6b7713-test.c; set verbose_parsing
>> for more info
>> badcount: 3
>> bad: };
>> bad: 
>> bad: int main(void) {
>> BAD:!!!!!     struct foo __attribute__((myattr((\"x\")))) f = { 42, 42 };
>> diff = 
>> --- ./test.c
>> +++ /tmp/cocci-output-112399-6b7713-test.c
>> @@ -6,9 +6,9 @@ struct foo {
>>  };
>>  
>>  int main(void) {
>> -    struct foo f = { 42, 42 };
>> +    struct foo __attribute__((myattr((\"x\")))) f = { 42, 42 };
>>      int b;
>>      int *c = &b;
>>      int z = memcmp(&f.x, c, sizeof(int));
>>      return z;
>> -}
>> +}"
>> Check duplication for 1 files
>> ```
>>
>> It seems like a quote is added at the end of the main function itself.
>>
>>> I haven't tried this, though.  Another more complex solution involves
>>> passing through python code.  You can get inspiration from
>>> demos/pythontococci.cocci.  You would want to set eg coccinelle.z to a
>>> string that additionally contains the desired string quotes.
>>>
>>> julia
> >
--------------grXILLkAqmS70uEs8dVjBL0E
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 5/27/26 12:53, Julia Lawall wrote:<span
      style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
      cite="mid:c21e4ca-3771-192d-eb44-80837b4319e1@inria.fr">
      <pre wrap="" class="moz-quote-pre">On Wed, 27 May 2026, Pierrick Philippe wrote:</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On 5/27/26 11:16, Julia Lawall wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">On Wed, 27 May 2026, Pierrick Philippe wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">On 5/27/26 10:59, Julia Lawall wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">On Wed, 27 May 2026, Pierrick Philippe wrote:
I think that the problem is that { ... } is not actually an expression in
C.  It's a strange thing that can only exist as part of a declaration.

But you don't want to change it, so you don't need a metavariable for it.

Just write:

- T F =
+ T __attribute__((myattr(("X")))) F =
  { ... };
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">It does work indeed, thanks a lot!
Although the metavariable X is not interpreted in the `+` context, could
it be due to the attribute or unrelated?
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">It's due to the string quotes.

It nmight be possible to get around this with a fresh identifier:

fresh identifier x = "\"" # X # "\"";
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
So this work, although the output still have the escaped quote, probably
due to the same "issue" regarding quote.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I'm sorry, but I don't know what you want for the output.  Could you
provide an example?  If you don't want quotes at all, then you don't need
quotes at all.</pre>
    </blockquote>
    <p>I apologize to both of you for the confusion, I do want quote,
      but I do not want escaped quote (I haven't tried it with escaped
      quote, but I'm pretty sure it won't be a valid string for GCC).<br>
      I also apologize for the lack of precision here.</p>
    The attribute I'm working with is taking an optional parameter,
    which, if present, should be a string (const char *) containing the
    field name of interest.<br>
    So in my example, the field of interest is `x` from the memory
    object `f` of type ` struct foo` (this instance specifically, not
    all instance of the same type).<br>
    And the argument to the attribute would then be the string "x".<br>
    The requirement of being a string is due to restriction for
    parameter of GNU attributes (outside internal attributes), which
    have to be constant literals or a declared identifier.<br>
    In my case, without the quote, the parameter would be interpreted as
    an undeclared identifier, hence leading to compilation error.
    <blockquote type="cite"
      cite="mid:c21e4ca-3771-192d-eb44-80837b4319e1@inria.fr">
      <pre wrap="" class="moz-quote-pre">julia</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">But there also is a possible issue with the parsing/code generation
here, generated diff and output of spatch:

```
@attribute_struct_scalar_type_resolve@
expression E1, E2;
type T;
identifier F, X;
fresh identifier param = "\"" ## X ## "\"";
@@
T 
+__attribute__((myattr((param))))
F = { ... };
...
memcmp(&amp;F.X, E1, E2)

warning: attribute_struct_scalar_type_resolve: metavariable param not
used in the + code
HANDLING: ./test.c
-----------------------------------------------------------------------
let's go
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
attribute_struct_scalar_type_resolve = 
-----------------------------------------------------------------------
dependencies for rule attribute_struct_scalar_type_resolve satisfied:
binding in = []
binding relevant in = []
     transformation info returned:
          transform state: 7
               with rule_elem: T
                                 &gt;&gt;&gt; __attribute__ ((myattr((param))))
                                       F = {...
                                            ,
                                            };
               with binding: [attribute_struct_scalar_type_resolve.param
--&gt; id \"x\";
                             attribute_struct_scalar_type_resolve.X --&gt;
id x]
     binding out = []
     transform one node: 7
parse error 
 = error in /tmp/cocci_small_output-112399-acda44-test.c; set
verbose_parsing for more info
badcount: 2
bad: 
bad: 
bad: int main(void) {
-----------------------------------------------------------------------
Finished
-----------------------------------------------------------------------
parse error 
 = error in /tmp/cocci-output-112399-6b7713-test.c; set verbose_parsing
for more info
badcount: 3
bad: };
bad: 
bad: int main(void) {
BAD:!!!!!     struct foo __attribute__((myattr((\"x\")))) f = { 42, 42 };
diff = 
--- ./test.c
+++ /tmp/cocci-output-112399-6b7713-test.c
@@ -6,9 +6,9 @@ struct foo {
 };
 
 int main(void) {
-    struct foo f = { 42, 42 };
+    struct foo __attribute__((myattr((\"x\")))) f = { 42, 42 };
     int b;
     int *c = &amp;b;
     int z = memcmp(&amp;f.x, c, sizeof(int));
     return z;
-}
+}"
Check duplication for 1 files
```

It seems like a quote is added at the end of the main function itself.

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">I haven't tried this, though.  Another more complex solution involves
passing through python code.  You can get inspiration from
demos/pythontococci.cocci.  You would want to set eg coccinelle.z to a
string that additionally contains the desired string quotes.

julia
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">&gt;</pre>
    </blockquote>
  </body>
</html>

--------------grXILLkAqmS70uEs8dVjBL0E--
