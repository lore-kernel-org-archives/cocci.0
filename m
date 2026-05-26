Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B1FCD5BD1
	for <cocci@archiver.kernel.org>; Tue, 26 May 2026 08:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=uz3//laS+/XZjAC1OfUnLTr8yyVLUioP8ZYw89bd8GM=;
  b=mTBUyi5K6zJcUxaU2q56nBepitZ4rHOMogBt6JQ4QQ4EqOfsu1od3XrE
   IqSim+N1I3Y0HmhFTa4fiv7lVovQ8pgikqghQm3+5uPtpzd4a+qXWYlsz
   j2UHqWDpPtuQNItWUvZ0mh1afQbDGncKrJbd5kuX0uWqLoYjv5w9VmIbs
   Q=;
X-CSE-ConnectionGUID: uFlfWcUaSYWGSlMJ+MTrpg==
X-CSE-MsgGUID: 6T5+2YywRo2Em89ZqIfUXA==
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
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208,217";a="278194407"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 May 2026 10:57:44 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D94DF862E6; Tue, 26 May 2026 10:57:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7CAAA862D8
	for <cocci@sympa.inria.fr>; Tue, 26 May 2026 10:55:09 +0200 (CEST)
X-CSE-ConnectionGUID: fwaN2aqqROKtSofPtLC+TA==
X-CSE-MsgGUID: FESarM3+Tt2pkJZYDkLSbA==
X-IronPort-AV: E=Sophos;i="6.24,169,1774306800"; 
   d="scan'208,217";a="278193493"
Received: from unknown (HELO [192.168.1.189]) ([88.183.23.223])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 10:55:09 +0200
Content-Type: multipart/alternative;
 boundary="------------UGWj5bqg5TtLUcNFHTei4MnQ"
Message-ID: <77568700-638c-4f06-b388-b9d35a29c0a6@irisa.fr>
Date: Tue, 26 May 2026 10:55:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr>
 <7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr>
Content-Language: fr, en-US
From: Pierrick Philippe <pierrick.philippe@irisa.fr>
In-Reply-To: <7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr>
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Question regarding Coccinelle
Reply-To: Pierrick Philippe <pierrick.philippe@irisa.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3520
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/Dcyvt4g8GeuZnXiQV60I9A>

This is a multi-part message in MIME format.
--------------UGWj5bqg5TtLUcNFHTei4MnQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Julia,

First of all thanks for your answer.

On 5/26/26 10:23, Julia Lawall wrote:
> On Fri, 22 May 2026, Pierrick Philippe wrote:
>> Hi everyone,
>>
>> I am currently trying to assess if Coccinelle could be used to match my
>> use case.
>> What I am trying to do is to modify the declaration of a specific
>> variable by adding an attribute to it, if and only if it is passed to a
>> specific function (memcmp in this case).
>> i am using Coccinelle version 1.3.0 (through nix-shell:
>> https://search.nixos.org/packages?channel=25.11&query=coccinelle#show=coccinelle
>> <https://search.nixos.org/packages?channel=25.11&query=coccinelle#show=coccinelle> ).
>>
>> My input test program is the following:
>>
>> ```c
>> #include <string.h>
>> int main(void) {
>>     int a = 42; // This is the variable of interest
>>     int b = 43;
>>     int z = memcmp(&a, &b, sizeof(int));
>>     return z;
>> }
>> ```
>>
>> Which should be modify to:
>>
>> ```c
>> #include <string.h>
>> int main(void) {
>>     int __attribute__((myattr)) a = 42; // This is the variable of interest
>>     int b = 43;
>>     int z = memcmp(&a, &b, sizeof(int));
>>     return z;
>> }
>> ```
>>
>> In order to do this, I played around with Coccinelle, but I keep having
>> weird behavior from spatch (at least from where I stand).
>> Here are two attempt to cocci rules:
>>
>> ```cocci
>> @first@
>> type T;
>> T VAR;
>> expression E;
>> @@
>> -VAR = E;
>> +__attribute__((myattr)) VAR = E; // Parse error here
>> ...
>> memcmp(&VAR, ...);
>> ```
>>
>> But for some reason, I got the following parsing error for the first
>> attempt and I couldn't wrap my head around it:
>>
>> ```
>> plus: parse error: 
>>   File "test.cocci", line 7, column 25, charpos = 76
>>   around = 'VAR',
>>   whole content = +__attribute__((myattr)) VAR = E;
>> ```
> Attributes are only allowed in variable declarations, which declare
> identifiers, not arbitrary expressions.
>
> In int x = 3;
>
> x somehow doesn't yet have type int.  It's just a name.
>
> Also, Coccinelle requires you specify a complete term, not just the
> subpart of the term that is convenient for you.

I think I understand, also I do have a question regarding the
`declaration` keyword of the grammar.
Is there any way to access inner information of the declaration? Such as
the type or the presence of an initializer or not?
For example in a python or a ocaml script?

>> My second attempt is successfully parsed, but leave the input program
>> untouched:
>>
>> ```cocci
>> @second@
>> type T;
>> identifier VAR;
>> expression E;
>> @@
>> -T VAR = E;
>> +T __attribute__((myattr)) VAR = E;
>> ...
>> memcmp(&VAR, ...);
> This again fails because you have only specified part of the memcmp
> statement.  If you want to put a complete statement, you have to put the
> whole thing.  I think you can also just put a memcmp call, without the
> semicolon.

It worked with the whole `memcmp` call statement indeed, I probably
misunderstood the `...` operator then.

Pierrick

> julia
>> ```
>>
>> This is probably an easy use case, but I am completely new to Coccinelle
>> and I honestly can't understand what is going wrong here.
>> To be honest, I also do not understand the difference between the two
>> rules, and why one is successfully parsed and not the other one.
>> Although this is probably due to a lack of experience with Coccinelle
>> and of its internals.
>>
>> Cheers,
>>
>> Pierrick
>>
> >
--------------UGWj5bqg5TtLUcNFHTei4MnQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Julia,</p>
    <p>First of all thanks for your answer.</p>
    <div class="moz-cite-prefix">On 5/26/26 10:23, Julia Lawall wrote:<span
      style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
      cite="mid:7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr">
      <pre wrap="" class="moz-quote-pre">On Fri, 22 May 2026, Pierrick Philippe wrote:</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Hi everyone,

I am currently trying to assess if Coccinelle could be used to match my
use case.
What I am trying to do is to modify the declaration of a specific
variable by adding an attribute to it, if and only if it is passed to a
specific function (memcmp in this case).
i am using Coccinelle version 1.3.0 (through nix-shell:
<a class="moz-txt-link-freetext" href="https://search.nixos.org/packages?channel=25.11&amp;query=coccinelle#show=coccinelle">https://search.nixos.org/packages?channel=25.11&amp;query=coccinelle#show=coccinelle</a>
<a class="moz-txt-link-rfc2396E" href="https://search.nixos.org/packages?channel=25.11&amp;query=coccinelle#show=coccinelle">&lt;https://search.nixos.org/packages?channel=25.11&amp;query=coccinelle#show=coccinelle&gt;</a> ).

My input test program is the following:

```c
#include &lt;string.h&gt;
int main(void) {
    int a = 42; // This is the variable of interest
    int b = 43;
    int z = memcmp(&amp;a, &amp;b, sizeof(int));
    return z;
}
```

Which should be modify to:

```c
#include &lt;string.h&gt;
int main(void) {
    int __attribute__((myattr)) a = 42; // This is the variable of interest
    int b = 43;
    int z = memcmp(&amp;a, &amp;b, sizeof(int));
    return z;
}
```

In order to do this, I played around with Coccinelle, but I keep having
weird behavior from spatch (at least from where I stand).
Here are two attempt to cocci rules:

```cocci
@first@
type T;
T VAR;
expression E;
@@
-VAR = E;
+__attribute__((myattr)) VAR = E; // Parse error here
...
memcmp(&amp;VAR, ...);
```

But for some reason, I got the following parsing error for the first
attempt and I couldn't wrap my head around it:

```
plus: parse error: 
  File "test.cocci", line 7, column 25, charpos = 76
  around = 'VAR',
  whole content = +__attribute__((myattr)) VAR = E;
```
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Attributes are only allowed in variable declarations, which declare
identifiers, not arbitrary expressions.

In int x = 3;

x somehow doesn't yet have type int.  It's just a name.

Also, Coccinelle requires you specify a complete term, not just the
subpart of the term that is convenient for you.</pre>
    </blockquote>
    <p>I think I understand, also I do have a question regarding the
      `declaration` keyword of the grammar.<br>
      Is there any way to access inner information of the declaration?
      Such as the type or the presence of an initializer or not?<br>
      For example in a python or a ocaml script?</p>
    <blockquote type="cite"
      cite="mid:7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">My second attempt is successfully parsed, but leave the input program
untouched:

```cocci
@second@
type T;
identifier VAR;
expression E;
@@
-T VAR = E;
+T __attribute__((myattr)) VAR = E;
...
memcmp(&amp;VAR, ...);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This again fails because you have only specified part of the memcmp
statement.  If you want to put a complete statement, you have to put the
whole thing.  I think you can also just put a memcmp call, without the
semicolon.</pre>
    </blockquote>
    <p>It worked with the whole `memcmp` call statement indeed, I
      probably misunderstood the `...` operator then.</p>
    <p>Pierrick</p>
    <blockquote type="cite"
      cite="mid:7f5310ec-9fce-b451-2ffc-8da0b9f11127@inria.fr">
      <pre wrap="" class="moz-quote-pre">julia</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">```

This is probably an easy use case, but I am completely new to Coccinelle
and I honestly can't understand what is going wrong here.
To be honest, I also do not understand the difference between the two
rules, and why one is successfully parsed and not the other one.
Although this is probably due to a lack of experience with Coccinelle
and of its internals.

Cheers,

Pierrick

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">&gt;</pre>
    </blockquote>
  </body>
</html>

--------------UGWj5bqg5TtLUcNFHTei4MnQ--
