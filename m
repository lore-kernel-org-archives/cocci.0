Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F812EA853D
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2026 18:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=j3ZRCLG52pyNn22Jawu7Zz/E94ZZ06Ofb8tK70EvRKs=;
  b=FF+xu6KNRNMFz/sIyNHXFUcS5E4MIvxsHRPPkeo+cS5LXOcKrMzCzvwa
   uPCwtjm8JibbaQofhn6CoFF3SYda1uScizkCdxWw8UoeP7+N1RFJFMFvc
   CwCQ0Zi2qkawrEwMIZCVsG6bA1UMkFsE7rD1etWInTc1VZKIlENUkE7+k
   U=;
X-CSE-ConnectionGUID: 1rmtnd3SRHejkLxll6T0nA==
X-CSE-MsgGUID: Yxp2cyYuT1G2PKVw9/NLRA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
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
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266754545"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Mar 2026 19:11:30 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 16C5981624; Sun,  8 Mar 2026 19:11:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 89F518144D
	for <cocci@sympa.inria.fr>; Sun,  8 Mar 2026 19:11:21 +0100 (CET)
X-CSE-ConnectionGUID: 5EYjKGolQimfgU4UdYn7Lw==
X-CSE-MsgGUID: rNmP/RQgS1K5klW6oy/qFg==
IronPort-SDR: 69adbbcb_PNbLZTYme1QElSOz0fOeEggxfCUwJDJRGxub0UftkCAwz23
 3UVvk1e5ZK+0gn+CbLZsWCGP7p25tBBoUivFubg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HCAQAzu61pgAQP49RagQmBUIJBaB9eNAQLSYRYj1OGX?=
 =?us-ascii?q?48Rik6BfQIPAQMBDUQKAQIEAQEDAwGFAAKNIQIeBwEEMAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgoxhk8NgmIBgSSBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAg06RAIBA?=
 =?us-ascii?q?yMdAQERJgEPCxoCGA4CAlYGEwIBAYJ+AYIiAQYQAQM2Bw0Gq1GBMhNuggwBA?=
 =?us-ascii?q?QaBRgIMAkPYSx8sIlmBZwMGgR8uhW+CZQGJdHonD4FVRIE8glIxPoJhA4Ffg?=
 =?us-ascii?q?1uCaYImgQ6MXYZOUngcA1ksAVUTFwsHBYEjQwOBBiMPPAUtHYEjIR0XFB9YG?=
 =?us-ascii?q?wcFEiEqgWl4ggEPhmh5Ay5eGg4iAjpcSj4KAVoFgiUCAQttPTcJCxsEPY5yP?=
 =?us-ascii?q?oNsAsh6NAeCOIFngWQMii6VPwYTL4Nxk2EOkwuZBowPgXqbOIFoOoFcMxokT?=
 =?us-ascii?q?4JnTwMZD44tFhyDdYELg1XENUUyAjoCBwEKAQEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 t3SRDNKNBgRlgiovfkxDBoPk+tf6iEz1g/FGwEU
IronPort-HdrOrdr: A9a23:1x5RP6sxVhRCJyMPchag5Klq7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:rLXKtmMGKSq/4O5DBQRW9m07HcQcc3jTw0qMHkOJDzlNV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3ABE8vDA7+Q/SCyb8FLGMBglWaxoxyxaGWT3o0nq5?=
 =?us-ascii?q?fmJSHMRMuPCbalRq4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266754533"
X-MGA-submission: =?us-ascii?q?MDEf1nFZRUzmJn1j0IMmrHOb4R1Fd+VJMEUfIU?=
 =?us-ascii?q?cOTgbEgNUzQSHmfzzpyU6YnRsFIPLrylt2+Myw4KrhZfrKQC/ColvMvn?=
 =?us-ascii?q?J88u8YNFs6GSWrfQ+UENH0sZN2Y2AC6nRdW1x8p6QuvoAivUqQMZNKG/?=
 =?us-ascii?q?4UbJ0dyAM6F/OE1+9i2iSdUA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 19:11:22 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaS7-1vfh4t1WLz-013dBU; Sun, 08
 Mar 2026 19:11:20 +0100
Message-ID: <f12f438e-a89f-462a-b166-d6af025cdc28@web.de>
Date: Sun, 8 Mar 2026 19:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <349a12a9-f70d-4c8f-a730-9f8ec90b593f@web.de>
 <f25025ab-4500-4315-b41c-53cd5775c69f@web.de>
 <20a815aa-5fa9-4b34-ab81-d6985ed193c0@web.de>
 <bc3eaab-b09e-4e67-054-b522d723c6a@inria.fr>
 <576f0704-7ceb-4e0d-ae1d-1beb1eb1efc3@web.de>
 <92db939d-8643-3bd5-ab3b-29605d36d29a@inria.fr>
 <0a740db5-eaae-43c9-9b73-d9317a1a92c6@web.de>
 <be59dbcf-c9b-745d-e15c-e8fcefaf40e2@inria.fr>
 <cd1bbe8e-ef35-408f-8754-173678bf3204@web.de>
 <f715289c-54d3-2c0-43fd-e6669973c5e1@inria.fr>
 <8ceb30ad-1143-4086-afeb-45b639c87e49@web.de>
 <1265ed1c-65e4-318e-8186-618346a4802d@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1265ed1c-65e4-318e-8186-618346a4802d@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sCxzyWsMf8wpTsiaK7uPa2pYOoMEMVK2JyBP814P2rTsGTnJEze
 5WPSPy7eErmMZrkXYFpMvqpMf1VbG3nBMjVJ7IuLya/9+OTWA+8dksKuXY0yPSo1Nt+PJ+i
 alxK2rxfjO4D7oU7LouSFd81J+mUrr4m67kJmt/gxjDB36R8qRWArwc+gxKiMrkpwCn7A/e
 KsdwE8oJaZTlw8T0bQEUQ==
UI-OutboundReport: notjunk:1;M01:P0:qJbK2qa+nHg=;N3/rPC16PaO2u/XeC6fh32zotC8
 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
 xyGZFHLWhIIWNrIa6XSWaQCjm4JsG
Subject: Re: [cocci] Reconsidering source code search challenges for nested
 compound statements
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3339
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/btdhSudDkIbLtIEg6bKvQw>

>> @display2@
>> declaration d;
>> statement list sl;
>> @@
>>  {
>>  d
>> *sl
>>  }
>>
>>
>> Another questionable test result:
>> Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> /usr/bin/spat=
ch test-item_assignments.c ../janitor/show_compound_statements2.cocci
>=20
> And I should know what test-item_assignments.c is?

Reminder:
This can be possible.
https://lore.kernel.org/cocci/f25025ab-4500-4315-b41c-53cd5775c69f@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2026-03/msg00014.html


void my_test(void)
{
 int item;

 if (1)
 {
    item =3D 1;
 }

 item =3D 2;
}


Regards,
Markus
