Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7340CCD98F0
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2026 12:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=WnvI0yQS7I463Xl/RcV0EQ8kR9q/gC1qRj74uB9icMI=;
  b=NarbwZ2BJ0yYzRFTORtZWLjZOaK3zGpTrVmKoACbipTwdUAq22fKhI6k
   uZyLeUEA0wlfzzc2ops6o59p+e7JSY5FPwF4Sdp0N99VDVGnGwjtRoORP
   6j5DA/CDFLxjxBaUNXh3zwxnETotYauQHKKu8o+C+vOgwHzFD+doDcHvI
   w=;
X-CSE-ConnectionGUID: Zuw3BF3vQIG6DUOnV7u0eQ==
X-CSE-MsgGUID: SMxi0+PQSrm4gA0MQf83qg==
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
X-IronPort-AV: E=Sophos;i="6.24,209,1774306800"; 
   d="scan'208";a="282036505"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Jun 2026 14:36:50 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5F11F828BE; Wed, 17 Jun 2026 14:36:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7B2778049D
	for <cocci@sympa.inria.fr>; Wed, 17 Jun 2026 09:29:53 +0200 (CEST)
X-CSE-ConnectionGUID: W151Co0hT+yOLeqsd740Vg==
X-CSE-MsgGUID: /OkaeQ3NRF6oykWJFB8pUg==
X-IronPort-AV: E=Sophos;i="6.24,209,1774306800"; 
   d="scan'208";a="149666406"
Received: from ptb-5cg22835fs.irisa.fr (HELO [131.254.21.198]) ([131.254.21.198])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 09:29:53 +0200
Message-ID: <57ecbeab-69e1-4280-93e8-0bf8de707238@irisa.fr>
Date: Wed, 17 Jun 2026 09:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: fr, en-US
From: Pierrick Philippe <pierrick.philippe@irisa.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] Adding an attribute to struct pointer in function parameter
Reply-To: Pierrick Philippe <pierrick.philippe@irisa.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3580
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/EkZdCMNR21XVblmkMNjfIg>

Hi everyone,

I recently send some mail on this mailing list, and my goal was to use
Coccinelle to automatically annotate some variables or parameters for
our analyzer.

Just to recall, our attribute have an optional parameter corresponding
to a field of interest when the annotated object is a structure.
That parameter should also be a string.
There was some limitations due to character escaping with Coccinelle to
apply the following patch:

```cocci
+struct foo f = {42, 42};
-struct foo __attribute__((myattr("x"))) f = {42, 42}
```

A workaround was to go through a python script to build the string
holding the whole attribute (including the optional parameter between
quotes).
Unfortunately, I can't find a way to apply the same logic to a
function's parameter.
Here is the test code:

```C
#include <string.h>

struct foo {
    int x;
    int kdiedexko;
    int y;
};

int foo(struct foo *ptr, int y) {
    int z = memcmp(&ptr->x, &y, sizeof(int));
    return z;   
}
```

And here is my patch:

```cocci
@searching_struct_param_begin@
expression E1, E2;
identifier F, X;
type T, T1;
identifier S;
parameter list[n = { 0 ... 7 }] p;
@@
T1 F(T *S, p)
{
...
(
memcmp(&F->X, E1, E2)
|
memcmp(E1, &F->X, E2)
)
...
}

@script:python generation_struct_param_begin@
s << searching_struct_param_begin.S;
x << searching_struct_param_begin.X;
content;
@@
coccinelle.content = cocci.make_ident("__attribute__((myattr(\"" + x +
"\"))) *" + s)

@replacement_struct_param_begin@
expression searching_struct_param_begin.E1, searching_struct_param_begin.E2;
identifier searching_struct_param_begin.F,
searching_struct_param_begin.X, generation_struct_param_begin.content;
parameter list[n = { 0 ... 7 }] searching_struct_param_begin.p;
type searching_struct_param_begin.T, searching_struct_param_begin.T1;
@@
T1 F(
-T *S,
+T content,
p)
{
...
(
memcmp(&F->X, E1, E2)
|
memcmp(E1, &F->X, E2)
)
...
}
```

The semantic patch is valid, but for some reason, no patch is generated
by Coccinelle and I can't figure out why.
Anyway, thank you for reading me again.

Have a good day,

Pierrick

