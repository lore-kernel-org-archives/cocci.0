Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD6BC6FD18
	for <cocci@archiver.kernel.org>; Wed, 29 Mar 2023 06:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9asFzOkyKOa3D3/FrUr7yeMDoUnslmQ3qOFsv7vgRv0=;
  b=nmYRqGfa84GQL5CliZH26Pbwbhu6HHfzE1FWrh227kvmZvHBw85E6kLw
   hT/XnSgmXvlLQXvkgVVFTf8eBJpzjKBMQqNVw4rmwT3/2ugXJ2gQtETcS
   4kdRYTZyt8+Zz2qWnHxgM1i3cfIr3y02gJU6ZTes9Fi1u9DnS7uTnOAOV
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,300,1673910000"; 
   d="scan'208";a="99619643"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2023 08:18:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E468E0B4F; Wed, 29 Mar 2023 08:18:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6C90AE0B2D
	for <cocci@sympa.inria.fr>; Wed, 29 Mar 2023 08:18:39 +0200 (CEST)
IronPort-SDR: 6423d83e_r7J2mupd+BpfFCDeO7ISaeAtF2FLZmX1yfrAp99Xw527VcY
 LXsT0lj3wYAQTA2L+TnQ/kjcwl9/3JcGoIaZsLw==
X-IPAS-Result: =?us-ascii?q?A0FCAAAz1yNkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItdVYvBAtGhFORAS4DgRODHIcskCOBVoFAPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wSEfgKFOQIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBA?=
 =?us-ascii?q?QIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgJHUz0BAgIBIx0BAREnBAsLDgwCJgICVwYBDAgBAYJ6AYInAQMOIweuH?=
 =?us-ascii?q?oEygQGCCAEBBpwKHywiU4FeAwaBFC0BjQSEMCcPgVVEgRUnDIJANz6ELhaDW?=
 =?us-ascii?q?IJniX6EIYsvgTRzgSAOgT2BBAIJAhFrgRIIa4F8QAINZAsOcYFKAmRMgSElB?=
 =?us-ascii?q?A4DGSsdQAIBC3U/NQYDCyAGWGsCCSMREwUDCxUqRwQIOQYbNBECCA8SDwYmR?=
 =?us-ascii?q?A5CNzQTBoEGCw4RA1CBRwQvXnwKBkudaAF6P0ZaXVGSS7BXNAeCKIFVgVkMn?=
 =?us-ascii?q?wwGEy6XCA4GkiOXaiCneoFqBS6BXDMaJIM2TwMZD44gGYQMj0g/NDsCBwEKA?=
 =?us-ascii?q?QEDCYVGAQGDI4JYAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:ApHyJK67R4rAHvz4QQPXwBbXdLJyesId70hD6qkDc203TiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ856U
 4KSchD4bPLfDpHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,300,1673910000"; 
   d="scan'208";a="51544163"
X-MGA-submission: =?us-ascii?q?MDHE+fMHYwjPdfRG+bfXa3h2D+tlg3PZeittNX?=
 =?us-ascii?q?OpPE+UGeFJHfwcqgHoDrPFTMZqc8A1YP9TDi0lGv878ZpckVgzAm4Oyv?=
 =?us-ascii?q?Q9Nuv+qQIuRfi12IyC0NLC5P9NqBrfdJ2oo2UrHRt8pHNE4SylmSbANS?=
 =?us-ascii?q?jo0rggmqsa0w+nsX2Cbsb7kw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 08:18:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680070717; i=markus.elfring@web.de;
	bh=rEQYt15jXqHYAPYaAtoXy9ac+oDl6vKWZ6KRESLDv6M=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=VpB6YTvUVbAag9kgE/0/15peVZ6D3Wl2xAfd49hBgzpTzfFvOG36GkuTv64hRJLY5
	 X+1N9E7z6wvfzvL7TuvHwR+FDeZsNh4mpaOq4zt5fRF53S5y25daKxAyCTK6MnE+oD
	 TRufuCnCJshRra8qakHxURhenF7Vwev7rgxb2sDLBMohnqzif8aFgg8uoboRKOX/Mj
	 3qLuJNrkcUiTzVMUEUmQiOCh9Kjdj4ZxXSXwJbgDdPjJDhojTMWDMeY4i4eUPNsLTn
	 +XnVGX8cgifgh+kUo3KdKnxU9yqjTpy/ajgnpMeMFHKHqX+rpahUD73sUQdFiH+aaM
	 ByxPOEL8/u32A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mw9x2-1qZ6Fs3rCW-00s5mz; Wed, 29
 Mar 2023 08:18:36 +0200
Message-ID: <e4ba5b28-77b6-8013-ed76-e22e090496cb@web.de>
Date: Wed, 29 Mar 2023 08:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: Vlastimil Babka <vbabka@suse.cz>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <4a7d08d1-7328-047c-52f3-dc62755cdbaf@suse.cz>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4a7d08d1-7328-047c-52f3-dc62755cdbaf@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UN9EilL6lQWktYxZ/474QQrn5bWDM/3seHROVbYbTU4IrmDIrsW
 ta85bHkYhRQAMlETyHsG+vrScAoPHhjHzjEXCasl57kCgO/nosmD9pXxhRAJZvbp2unBYPo
 zDTEPXNOe4jey9iDyK0EMtvHuXqvCcWojro4GLHLHa7buekLFoPQAjpTmmy/ItM/oC5Wlka
 hUco5lguP7NR8VhJG974w==
UI-OutboundReport: notjunk:1;M01:P0:I6K5yT2A6F0=;HY4FZvEobP2b/4eYIVlw6A8a7xN
 2Vpg8FsB1OJ3do1MUkuJoRoiwpBHK7mBC4IybZHDx5JIOiN6kLuf1FpajsKQ+TR+xnc0UVnxz
 28WaeDW7Qjh67tGp0BOqlU/AiSXu9JaE5XfQkVib0oZfMWRNkJuVpXYaHrKxmcwhv3ZAztsWF
 z+KVojxc5B0N9gj7XTMbLRh3OQWn4EoV+p0zsuJfe920ZUULHk6KAyOMerFNkrEQA2GxsKrTD
 034uo/VLxOlrXNKe2kpeUaKsCitvkg9vRSQXriZZE5/vm5Bu+XNYdbPGXZaZVSUAVbUB2ArBM
 OCPs4Cd7AHIdYW1gUDT7TQ38zQLUDaYk84iRaZHJlF8SXbfE4DnHABZTeFOovYWLRK+Uiz1Jc
 2aYmJJ1NNaxsGcGWkp8E0yusS7Wvjub/02B3dzfcqdtDxHy95PJ2SL5HX1UEdDEJpPsmD+Ic7
 TeOfhEJDDALuyBOG3BXzQ8dz4LGwD1iCelTLskyDgTkegh1aqOsy/yS5rj1EwkUWJH6rMLODX
 aP5+ekUvJLd2AqbLlUzDGYggIBLq0t/eKoy24k6AQW3UlxCpnlq2OwF+M0BHVRlHu6NYkbxGc
 pWZjVGmy27h1XplmMQK3NvkZEfkyNbWK1rZw4XT/k2A7QgxsGL7s482Mk2f1CHTqSXlqGXY2h
 DsZ3XOdXr9LjFygJveD4Am4Bs8DHLk0rv2rZpwv+9WEFQzRKSxC0JcoIhZ+4J67y7Fpg6GThO
 5mXVgAENVB7EmTsdh28A9LwkIazv4nXRRAv0Wds9e/bWS9j09HwviA0AffaKzIXCUP759/IiP
 ALbncQ5eeRs0etvcf4Pr9CXPg+8I/j9imvezGij+fL9bmCBll0eeAc/8McBIuk2XAqyVmxmUT
 NPufkRMhkaR3l07YYQd3ARR0PiPSCTC8ThmOL09CrkrRP+yBXye29e1zy
Subject: Re: [cocci] Reconsidering kfree() calls for null pointers (with
 SmPL)
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 980
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/e4ba5b28-77b6-8013-ed76-e22e090496cb%40web.de>

> It is valid to pass a NULL pointer to kfree(), it checks for that.
>
>> I imagine that such code should be reconsidered once more and improved =
accordingly.
>
> The only potential downside in the scenario is checking storage =3D=3D N=
ULL twice.

Will programming concerns evolve any further?


> But this is an error handling path, not a fast path.

I hope that also exception handling code can become efficient in more use =
cases.


> On the other hand, the code may look like this:
>
> storage =3D call(...);
> if (!storage)
>     goto target;
>
> if (some_other_condition)
>     goto target;
>
> target:
> kfree(storage)
>
>
> For some_other_condition, we want the kfree().

Allocated resources should be properly released.


> If you changed the code, to remove the extra NULL pointer check, you wou=
ld have:
>
> storage =3D call(...);
> if (!storage)
>     goto target1;
>
> if (some_other_condition)
>     goto target2;
>
> target2:
> kfree(storage)

A label like =E2=80=9Cfree_this_resource=E2=80=9D can be nicer, can't it?


> target1:
>
> The extra goto label and larger code is not worth saving the NULL pointe=
r check,
> because this is error handling path.

Some code reviewers and programmers represent other development views.


>> How do you think about to achieve any adjustments in this design direct=
ion?
>
> Only in cases where it would not make the code more complex, i.e. if the=
re
> are no "some_other_condition" that jumps to the same target after alloca=
tion
> to storage is successful.

Do you find any implementation details worth for another look also accordi=
ng to
a special information source?
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es#MEM12C.Considerusingagotochainwhenleavingafunctiononerrorwhenusingandre=
leasingresources-CompliantSolution%28POSIX,GotoChain%29


Will circumstances evolve in ways so that you would adjust a desire to sti=
ck
to only a single jump label?

Regards,
Markus
