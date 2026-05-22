Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE24CD5BC8
	for <cocci@archiver.kernel.org>; Tue, 26 May 2026 08:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=vIXD4juJVLqiHvHAN6Kn7rqV529I0ohyws5lHtyYRjg=;
  b=kW6lmecVorqlXAvbZ0OEJ2XOif75ZMSoUJWksPC8IyyFjcrYDaNVbnyX
   hVKhb5H2EG27V3U4EG/Xj7BRQ0hE4ZAovQjAMku86pV2pC00f7con2do9
   pJZBYtxSWYJ0PMKeviZA45EF1ObgPPGLA8i3qCrPzU96Ayp4vx8mrZeeS
   o=;
X-CSE-ConnectionGUID: uGFWO5KKR1e+ug2SaFotbA==
X-CSE-MsgGUID: Iyg83ksgRj+AC4fVqIxu3A==
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
   d="scan'208";a="278176234"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 May 2026 10:16:28 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CAE3081567; Tue, 26 May 2026 10:16:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2AA0A805F6
	for <cocci@sympa.inria.fr>; Fri, 22 May 2026 09:38:35 +0200 (CEST)
X-CSE-ConnectionGUID: msPaBySzQeKpOF4uDS31Sw==
X-CSE-MsgGUID: Q47nBAgYSjOHbprR7VSZLQ==
X-IronPort-AV: E=Sophos;i="6.24,161,1774306800"; 
   d="scan'208";a="147271342"
Received: from ptb-5cg22835fs.irisa.fr (HELO [131.254.21.198]) ([131.254.21.198])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 09:38:35 +0200
Message-ID: <3b5a0202-0064-47cd-a4a7-a84653a7a315@irisa.fr>
Date: Fri, 22 May 2026 09:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: fr, en-US
To: cocci@inria.fr
From: Pierrick Philippe <pierrick.philippe@irisa.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] Question regarding Coccinelle
Reply-To: Pierrick Philippe <pierrick.philippe@irisa.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3516
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-05/k18Wt0ku6F0ueSeLNS0GYQ>

Hi everyone,

I am currently trying to assess if Coccinelle could be used to match my
use case.
What I am trying to do is to modify the declaration of a specific
variable by adding an attribute to it, if and only if it is passed to a
specific function (memcmp in this case).
i am using Coccinelle version 1.3.0 (through nix-shell:
https://search.nixos.org/packages?channel=25.11&query=coccinelle#show=coccinelle
<https://search.nixos.org/packages?channel=25.11&query=coccinelle#show=coccinelle> ).

My input test program is the following:

```c
#include <string.h>
int main(void) {
    int a = 42; // This is the variable of interest
    int b = 43;
    int z = memcmp(&a, &b, sizeof(int));
    return z;
}
```

Which should be modify to:

```c
#include <string.h>
int main(void) {
    int __attribute__((myattr)) a = 42; // This is the variable of interest
    int b = 43;
    int z = memcmp(&a, &b, sizeof(int));
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
memcmp(&VAR, ...);
```

But for some reason, I got the following parsing error for the first
attempt and I couldn't wrap my head around it:

```
plus: parse error: 
  File "test.cocci", line 7, column 25, charpos = 76
  around = 'VAR',
  whole content = +__attribute__((myattr)) VAR = E;
```

My second attempt is successfully parsed, but leave the input program
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
memcmp(&VAR, ...);
```

This is probably an easy use case, but I am completely new to Coccinelle
and I honestly can't understand what is going wrong here.
To be honest, I also do not understand the difference between the two
rules, and why one is successfully parsed and not the other one.
Although this is probably due to a lack of experience with Coccinelle
and of its internals.

Cheers,

Pierrick

