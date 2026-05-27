Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE07CD6E45
	for <cocci@archiver.kernel.org>; Wed, 27 May 2026 09:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1pzfvV6OOHfDlcKzNH4RZ/TFvuAFBn8uHABw7OdYKA8=;
  b=Z7a7VDG9kkSnPSMClRCACdxDweXFnpqz1CI44a89EpMlXdJZkbbDQcxV
   oHi4gR5LXcfFsHyuYtN0JOrttFwNhCJ475rkV5SBxtF9vrJ36JQXAE8VF
   q3D18Xhw8WESInQIzZK+RHDYAizoGrIB4W8j+GIx/3auRivbGRe5cQahL
   U=;
X-CSE-ConnectionGUID: galGV5YvTVy4YZo3BlHm+g==
X-CSE-MsgGUID: YIYtPqskSbyR/WRKAUfG+w==
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
X-IronPort-AV: E=Sophos;i="6.24,171,1774306800"; 
   d="scan'208";a="278449854"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 May 2026 11:45:23 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C19B28162D; Wed, 27 May 2026 11:45:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 17B9E812BF
	for <cocci@sympa.inria.fr>; Wed, 27 May 2026 11:44:35 +0200 (CEST)
X-CSE-ConnectionGUID: O8sZ8GRfT/2DUo1h230LKA==
X-CSE-MsgGUID: c2zJ9u3TSlebKfagX8PMQA==
X-IronPort-AV: E=Sophos;i="6.24,171,1774306800"; 
   d="scan'208";a="147692603"
Received: from ptb-5cg22835fs.irisa.fr (HELO [131.254.21.198]) ([131.254.21.198])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 11:44:34 +0200
Message-ID: <363a5557-fcfc-4856-b4a9-17bbdadff8b0@irisa.fr>
Date: Wed, 27 May 2026 11:44:34 +0200
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
Content-Language: fr, en-US
From: Pierrick Philippe <pierrick.philippe@irisa.fr>
In-Reply-To: <4221c671-682-68de-9a94-1634364b6685@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Pierrick Philippe <pierrick.philippe@irisa.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3533
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/kQd0GAU5F4YuDWSLPy_IjA>

On 5/27/26 11:16, Julia Lawall wrote:
> On Wed, 27 May 2026, Pierrick Philippe wrote:
>> On 5/27/26 10:59, Julia Lawall wrote:
>>> On Wed, 27 May 2026, Pierrick Philippe wrote:
>>> I think that the problem is that { ... } is not actually an expression in
>>> C.  It's a strange thing that can only exist as part of a declaration.
>>>
>>> But you don't want to change it, so you don't need a metavariable for it.
>>>
>>> Just write:
>>>
>>> - T F =
>>> + T __attribute__((myattr(("X")))) F =
>>>   { ... };
>> It does work indeed, thanks a lot!
>> Although the metavariable X is not interpreted in the `+` context, could
>> it be due to the attribute or unrelated?
> It's due to the string quotes.
>
> It nmight be possible to get around this with a fresh identifier:
>
> fresh identifier x = "\"" # X # "\"";

So this work, although the output still have the escaped quote, probably
due to the same "issue" regarding quote.

But there also is a possible issue with the parsing/code generation
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
memcmp(&F.X, E1, E2)

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
                                 >>> __attribute__ ((myattr((param))))
                                       F = {...
                                            ,
                                            };
               with binding: [attribute_struct_scalar_type_resolve.param
--> id \"x\";
                             attribute_struct_scalar_type_resolve.X -->
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
     int *c = &b;
     int z = memcmp(&f.x, c, sizeof(int));
     return z;
-}
+}"
Check duplication for 1 files
```

It seems like a quote is added at the end of the main function itself.

> I haven't tried this, though.  Another more complex solution involves
> passing through python code.  You can get inspiration from
> demos/pythontococci.cocci.  You would want to set eg coccinelle.z to a
> string that additionally contains the desired string quotes.
>
> julia
