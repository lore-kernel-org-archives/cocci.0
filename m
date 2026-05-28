Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34615CD5BD1
	for <cocci@archiver.kernel.org>; Thu, 28 May 2026 10:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Iq/++dRO8tITrbN+HfXQMnQa5UE0++HCCRS+wyKXVPo=;
  b=MRM8ob1BUjiJTuBss32gBnKMcTtjY5dPKYfaTtu/x3ve6Rf5fsSWBbPm
   7jfBv31Ry+v89VgUKCuJxsY8Ka26CgnKG1N8TnEyZ8gu6LxxVPsjaXNzd
   D69krcMzn7NudK7hj2RYiqLuB/gIPAo7d3OAqnKV/S4SU2Osm9MwolTn4
   M=;
X-CSE-ConnectionGUID: YpTSxK7VRxWdsF9xbPnxyw==
X-CSE-MsgGUID: gZ3uROS7QsiUEzCKbzt4bQ==
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
   d="scan'208";a="278663752"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 May 2026 12:14:38 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 21ACC805FA; Thu, 28 May 2026 12:14:38 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 6648D805FA
	for <cocci@sympa.inria.fr>; Thu, 28 May 2026 12:09:06 +0200 (CEST)
X-CSE-ConnectionGUID: k54sKgW6T3asOKW+BLZaag==
X-CSE-MsgGUID: rQqAs81+Q42AUhATd0t1+g==
X-IronPort-AV: E=Sophos;i="6.24,173,1774306800"; 
   d="scan'208";a="147808759"
Received: from ptb-5cg22835fs.irisa.fr (HELO [131.254.21.198]) ([131.254.21.198])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 12:09:06 +0200
Message-ID: <43e1b679-ed16-4fd0-8a73-7b5159bff321@irisa.fr>
Date: Thu, 28 May 2026 12:09:05 +0200
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
 <55aadd6c-42a5-4403-8978-87fb579b0df6@web.de>
 <e919c230-4996-43af-9a2c-ce025399d35e@irisa.fr>
 <041a14c-d1ee-7181-a617-82b4b294b6fa@inria.fr>
 <f3b5783f-34cd-430d-be81-a23ff30f4a86@irisa.fr>
 <5a7e76-418c-6b3c-41a8-6156589441e@inria.fr>
Content-Language: fr, en-US
From: Pierrick Philippe <pierrick.philippe@irisa.fr>
In-Reply-To: <5a7e76-418c-6b3c-41a8-6156589441e@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] Adjusting attributes for variables with SmPL?
Reply-To: Pierrick Philippe <pierrick.philippe@irisa.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3545
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/skJgoz0yPAgubzhCJ2yWWw>

On 5/28/26 10:21, Julia Lawall wrote:
> On Thu, 28 May 2026, Pierrick Philippe wrote:
>> On 5/28/26 09:48, Julia Lawall wrote:
>> I have tried it, and spatch was complaining for some reason.
>> Though it might be to my lack of experience with SmPL.
>> I can provide the output if needed.
> Please provide the semantic patch used and the resulting output.

Sure, here is the output of `spatch --sp-file ./test-python.cocci
./test-struct.c -debug`:

```
init_defs_builtins:
/nix/store/40c99rw6w18kbf89qjqampp7m672a773-coccinelle-1.3.0/lib/coccinelle/standard.h
-----------------------------------------------------------------------
processing semantic patch file: ./test-python.cocci
with isos from:
/nix/store/40c99rw6w18kbf89qjqampp7m672a773-coccinelle-1.3.0/lib/coccinelle/standard.iso
-----------------------------------------------------------------------
@searching_struct_scalar@
expression E1, E2;
identifier F, X;
initialiser I;
type T;
@@
T F = I;
...
(
memcmp(&F.X, E1, E2)
|
memcmp(E1, &F.X, E2)
)

@script:python generation_struct_scalar@
f << searching_struct_scalar.F;
x << searching_struct_scalar.X;
content;
@@
coccinelle.content = cocci.make_ident("__attribute__((myattr(\"" + x +
"\"))) ")

@replacement_struct_scalar@
expression searching_struct_scalar.E1, searching_struct_scalar.E2;
identifier searching_struct_scalar.F, searching_struct_scalar.X,
generation_struct_scalar.content;
initialiser searching_struct_scalar.I;
type searching_struct_scalar.T;
@@
T
+content
 F = I;
...
(
memcmp(&F.X, E1, E2)
|
memcmp(E1, &F.X, E2)
)

plus: parse error: 
  File "./test-python.cocci", line 30, column 1, charpos = 629
  around = 'F',
  whole content =  F = I;
```

Seems like the issue is in the rule `replacement_struct_scalar`.

>
> thanks,
> julia
