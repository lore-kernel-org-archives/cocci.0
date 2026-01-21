Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B672CC44536
	for <cocci@archiver.kernel.org>; Wed, 21 Jan 2026 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=y5E0E2sFb9tE9mfVH26vzStR1RYWk4Iyks8lp1P7KgQ=;
  b=Hj7AoUKWtRHbdFbV/3EeuhODOXI5APzrDnOq/lna9dMEHjecmPwh1Lfx
   dg74G97ic5fdGDCgI7Dr5prOY0DqnCHz91me6e1Gm50UxoNCmUc4Id3ar
   MQ97weMA1MGC4OFu/pjNJ9koRlAMVnYWGvMtRmet26KPX5A3WmUkxu8NE
   o=;
X-CSE-ConnectionGUID: /bNp0urNTVCsL3hIxqwBhQ==
X-CSE-MsgGUID: jMZv/PlWSHOBe9uHSelT/A==
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
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="259705566"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2026 17:55:13 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2857781A0E; Wed, 21 Jan 2026 17:55:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 0F13081A0E
	for <cocci@sympa.inria.fr>; Wed, 21 Jan 2026 17:55:11 +0100 (CET)
X-CSE-ConnectionGUID: xPGzJrZRRmGY2ELRFd7kfg==
X-CSE-MsgGUID: kMSLopr7Q5qXYs1nnrD7Fw==
IronPort-SDR: 697104ee_syful30/1wxb85sr/eEIQjC5CAzIL9Go84dbBqW967q4oPM
 kB8qZSAj8ZYUpEF5HGvtMw5JAUjMRUXxHBHllSw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H9BQC9A3FpeAQP49RagQmBUIJBaB8GWTMEC0mEWI9Tg?=
 =?us-ascii?q?iEDhDuPEYpOgX0CDwEDAQ1ECgECBAEBAwMBggyCLkYCjQQCHgcBBDIHDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAUMOCjGGTw2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECD?=
 =?us-ascii?q?TpEAQEBAgEjHQEBESYBDwsaAiYCAlYGARQBAYJ+AYIiAQYQAQMPJwcNsg2BM?=
 =?us-ascii?q?oEBggwBAQbaZB8sIlmBZwMGFYEKLoVugmUBiW16Jw+BVUSBPAuCRzE+gmECg?=
 =?us-ascii?q?WCDW4JpgiaBDpQIUngcA1ksAVUTFwsHBYEjQwMqLy0jSwUtHYEjIR0XEx9YG?=
 =?us-ascii?q?wcFEyNTBhsGHBICAwECAjpTDIF1AgIEghB7ggEPhwWBAAUubxoOIgJBbgIBC?=
 =?us-ascii?q?209NwkLGwQ9j3dFgi2BECsgAi6BCliTH7MpNAeCOIFngWQMii6VPwYTL4QEj?=
 =?us-ascii?q?ROGOw4GkHKCE5kGIoI2ikZrlV2FW4FvAjGBXDMaJIMCATNPAxkPkiEzgQuDV?=
 =?us-ascii?q?cIWQjULMQIHAQoBAQMJhUYBAYxWgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HHEK2axamddt8sRRFViDKrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:TqKnCm+j/tar/vlpuqaVv14sNdIHaE/n9nL/EhWVLVxHROKWR1DFrQ==
X-Talos-MUID: 9a23:egwIqQrZUVoiIQTdeOkezzJHD+Nv+77xMR0UoaQd4s+CLwAvFSjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,242,1763420400"; 
   d="scan'208";a="259705553"
X-MGA-submission: =?us-ascii?q?MDGc35/TCUVuIFYB8uW3KLSHbWRZ0JqVK0EHy3?=
 =?us-ascii?q?Ll8dDXu2ELs5ZuAEOpXL//Ns3EtM/BJKFmUWW1m7f1TPFvAL0Z2xJ6Fe?=
 =?us-ascii?q?vyBaKEtYu3+QAH8O3Numg3prloKCkXX60CVI8I8tl8ziHdByUmL4N7jC?=
 =?us-ascii?q?E2w4HuRqp8I3N0amL7k5rfHw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 17:55:10 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.226]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1aIB-1vl5eg3XVT-0034LI; Wed, 21
 Jan 2026 17:55:09 +0100
Message-ID: <74a51618-f257-4da7-9056-ba22f3a5870a@web.de>
Date: Wed, 21 Jan 2026 17:55:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 Victor Gambier <victor.gambier@inria.fr>
Cc: cocci@inria.fr
References: <87v7i7g615.fsf@mmap.at>
 <af6a88ac-fe87-47d9-8e55-b570f205afc4@inria.fr>
 <c393376f-a5b7-4e7c-b593-052528b9fcb0@inria.fr>
 <f222ef51-388a-441d-b9e3-c7abebc0a2d7@web.de>
 <258386cb-4f80-64a-4340-ec9b7c4d336@inria.fr>
 <421aee9d-5483-4c74-a149-778d439e33ff@web.de>
 <95d08195-7fa3-4d56-9947-ae5714a5a37b@inria.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <95d08195-7fa3-4d56-9947-ae5714a5a37b@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1YIHK9SYw9UZ6fci7CQc8Jk+ikaurc4wX9ILgYHRyMrp0OFJwfE
 4WMHTUETS+1ZhuLPOC3rP2L6YGgjd22jyIEj81mcyt0knTPGHtc7A2vyRD8WuU7hpdO5Sos
 9sbuucgKtSiV6jvWyroYrFKZUJ7jIu6MQAYa7JXlyRCwQcDd3LlCI9xQPukGynatDByaZtU
 X8Ctiil1LggQisXdSnXWQ==
UI-OutboundReport: notjunk:1;M01:P0:9EnbUp6tlD4=;juNrN4pY77vEAyJGSTNJ0KqUezf
 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
Subject: Re: [cocci] Evolution for the software build system?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3300
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-01/NP7YuH8Ehj4X_yyj-y9Y6g>

>>>> Unfortunately, I would miss further improvements for the software bui=
ld system so far.
>>>> https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/b231de0db3f951=
3f6ea936caea5428fe627af1b9
>>>>
>>>> I tried also to influence corresponding adjustments somehow.
>>>> Will development interests grow accordingly?
>>>
>>> If you want something to change, could you please explain what should
>>> change, or better yet provide a patch?
>>
>> I pointed remaining update candidates out.
>=20
> Where?  You sent to a link to a commit by Victor.  What should we do wit=
h
> that information?

The information =E2=80=9Cconfigure.ac: use pcre2-ocaml/lib folder to refle=
ct new bundle structure=E2=80=9D
is provided there.
A desirable change description was omitted (or overlooked) once more.

Some files were adjusted recently.



>> I presented some patches before.
>=20
> Where?  Why don't you send a link to that?

You know corresponding issue tracking interfaces.

* https://github.com/coccinelle/coccinelle/issues

* https://lore.kernel.org/cocci/
  https://sympa.inria.fr/sympa/arc/cocci/


Would you find any technical details from the previously discussed topic
=E2=80=9CData processing challenges by build requirements=E2=80=9D still r=
elevant?

Regards,
Markus
