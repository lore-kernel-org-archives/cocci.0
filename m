Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE85ACA5FEC
	for <cocci@archiver.kernel.org>; Sat,  3 Oct 2026 13:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TKTTfme1+i8nHwLt+wI+KbaMp7xmQLpDc5tMwB2+EcY=;
  b=FEIELM1zfa1JJ716jPpa0aKGYp2OtfPXVk5O+o4X/wsAf4XK6K5IXzvb
   2mPZwElVlRfSRWUv2BiV2K8GOhRQHHy+Z1n2z/BKFEgt8UP+UhWszWKcx
   aLxLLgC1h6oqXMJdApRUFMK/ejxRwNvCKEAMc6CeSSPluQ75EnLn8po7q
   k=;
X-CSE-ConnectionGUID: bzYSliKTTKS13EujkBz+Jw==
X-CSE-MsgGUID: Zh0GyVATRouzIsz2p64cuQ==
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
X-IronPort-AV: E=Sophos;i="6.27,138,1787004000"; 
   d="scan'208";a="298319168"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Oct 2026 15:00:14 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 918A981B14; Sat,  3 Oct 2026 15:00:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 58DDB8168E
	for <cocci@sympa.inria.fr>; Sat,  3 Oct 2026 14:32:38 +0200 (CEST)
X-CSE-ConnectionGUID: xHdJqtSOTKqjoIosb11L1w==
X-CSE-MsgGUID: IM9KLZNvRK+rBzFOWnwWzw==
IronPort-SDR: 6ac0f5e6_/AymirmTA2ARKxW0Sp1AKXxQmzcBgpjuiKdJmk+OKTs2YjL
 4vKj3B5NDM8iP4xQoTYJ4CLpfpUgI7b0dJHeYrA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EiAgAH9cBqiwQP49RaglmCQYELYDQEC0mEWI9SgiGEP?=
 =?us-ascii?q?plfgXwCDwEDAQ1KBAECBAEBAQIDATiBU4ItRgKOCgIeBwEEMAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBATwFDgoxhk8NjBOBL?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECD?=
 =?us-ascii?q?TpEAgEDIwQZAQERJw8LGgIYDgICVhsBAYJ+AYIiAQYQAQM3Bw0Gu21/M4EBg?=
 =?us-ascii?q?gwBAQaCa9d/HywiXYFrAwaBHy6FcoJtAYp1Jw+BVUSBPAuCSDE+gmEBAQKBX?=
 =?us-ascii?q?k2DDoJqgiaBDIRlkGFSeBwDWSwBVRMXCwcFgSNDA4EGIw88BS0dgSMhHRcRH?=
 =?us-ascii?q?lgbBgUSICpBQ12BWjwjGTZ6gQlegSspYQIOF0YuFYIHAoJUgSMCWwIBSUEOB?=
 =?us-ascii?q?0VTCSVFEkcmIggSCQETGjALgRs4PAkoBEAXDBBtPTcKCxkEPZFGHoFtMDyBQ?=
 =?us-ascii?q?SKBfSuScxSzLDQHgjmBaIFmDIowlT8GEy+XUw6TDpkIjgqbOYFoOoFcMxokg?=
 =?us-ascii?q?zYTPQMZD447g2kzgQvKXUUyAgEIMgIHAgcOAwuFRAEBjFaBTAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:AyerGKh7Ok+aJ8WJQYEMy6UXA3BQX5t13DAbv31ZSRFFG/FwWf
 rOoB19726TtN9xYgBGpTnkAsK9qBznmKKdjbN8AV7mZniEhINHRLsSkbcKgAeQZhEXz4ZmpN
 hdmtFFeaPN5AFB/LfHCWuDc+rIseP3lJxA3t2utkuFJDsCA8tdBkVCe2Sm+ytNKzWubqBJca
 Z0iPAom9OIQwVlUu2LQlcEQsnerJntko/nbg5DPhsu9QaJljfA0s+LLzGomjkfThJSyvMY/W
 DelQuR3NTYj9iLjjHdyk7O5NBslNHg09tOA9HksLlvFhzcziipeaV8UPm4sDo0ueGi70tvuN
 TAuBs7Ja1ImgbsV1Dwjxvx+hXqlAwj7HLv0jaj8APeiMH0Xi87DMJdhYRfaHLimjgdgO0=
X-Talos-CUID: =?us-ascii?q?9a23=3A7nx1dWtCjwn1Tyk6f6L7pWaV6Is1UnH/1WvrBHO?=
 =?us-ascii?q?bEGRuabqOQwbJ3Pp7xp8=3D?=
X-Talos-MUID: 9a23:S6y7xwanh9Vs+uBTlhq9pxVQEtlSwOe0IlIjtqoApPaWKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,138,1787004000"; 
   d="scan'208";a="298317892"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHgGkqXqHfjxFSIwnHv2NVyPaO+XISETVX+ot?=
 =?us-ascii?q?7//NuLnRAL1cMX7gLWpQDZXNzlnA5od7VVgGWP11cp1tpdt46b9XpQYs?=
 =?us-ascii?q?L64XY/6KDZzeG05XipzbFye0XEeibmh7CO+btEPT9hdPjgOzGovoBAom?=
 =?us-ascii?q?P1vmBBmNdlMNhnDTJT0hEBVg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 14:32:37 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjxeO-1wocRx1AAS-00duJv for
 <cocci@inria.fr>; Sat, 03 Oct 2026 14:32:37 +0200
Message-ID: <4f1e88cb-0332-4a29-85e9-373f9565752b@web.de>
Date: Sat, 3 Oct 2026 14:32:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <82ac5de1-a9d0-497e-88c2-c10793819ea2@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <82ac5de1-a9d0-497e-88c2-c10793819ea2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:veelO+vbd1FL2ablXIbG4Osd6RWoTEuEFmf8QbAxMdNALij6Zdi
 ZDpTxTFpDozjajZJSh3OtzFsDCO3NXH43pPPykbiFIfVOtYXPjO7SseSCd+6IcDBBRKp7zy
 3273xjMilIsRysnASeOx7raiYy6VykaKqPc5wMC8WMDw4xsucc9JOKfqn2ZDt+sGXk4ZW4n
 4xHMQjmJQwI/BhkvYi7bg==
UI-OutboundReport: notjunk:1;M01:P0:aHVt9EGSBRY=;Tbg3XHCoGOWRsz+0iQe8dPYv3Ow
 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
 RxFNy5ZF7vzRGnhCZArp2DHtoEOF60zvMSQ==
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Reconsidering handling of generated metavariables for
 SmPL isomorphisms
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3746
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-10/kYCA43cXRiD9HMmk0V03bg>

=E2=80=A6
> Transformed SmPL code may refer to additional metavariables which do not=
 occur
> in the input code.
> It seems that the Coccinelle software generates metavariables then with
> special identifiers.
> The isomorphism rule =E2=80=9Cptr_to_array=E2=80=9D can be a special tes=
t case.
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/2759351ca12bbf39dc7=
2c6756282294aa85d06f6/standard.iso#L557-566
>=20
> How can further technical details be determined for involved algorithms?

Can further users (of the Coccinelle software) become interested in clarif=
ications
of involved technical details?

I assume that known clarification attempts need to be repeated occasionall=
y.
https://github.com/coccinelle/coccinelle/issues/426#issuecomment-570082135=
8

Corresponding SmPL script example:
// See also:
// cec_is_switch()
// https://elixir.bootlin.com/linux/v6.16-rc3/source/include/uapi/linux/ce=
c.h#L1189-L1199
@reduced_display2@
identifier las;
@@
*! ( las -> flags & CEC_LOG_ADDRS_FL_CDC_ONLY )


Questionable test result (also according to the software combination =E2=
=80=9CCoccinelle 1.3.3=E2=80=9D):
Markus_Elfring@Sonne:~> spatch --parse-cocci /home/altes_Heim2/elfring/Pro=
jekte/Linux/show_cec_is_switch-reduced2.cocci | grep 'expression _' | wc -=
l
=E2=80=A6
236


Would you ever like to avoid duplicate data any more?
avoid duplicates in disjunctions
2025-11-23
https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/5bf4aac3af217126380=
05c0f4e225fb37c2fd70f
https://github.com/coccinelle/coccinelle/commit/5bf4aac3af21712638005c0f4e=
225fb37c2fd70f

Regards,
Markus
