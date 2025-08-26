Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9FBCA0EFA
	for <cocci@archiver.kernel.org>; Tue, 26 Aug 2025 07:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gUz2UNny8CRb9FjWqKSsSistC+xIL9A8tJaC39E5Afo=;
  b=UTCY7dSVh24vJCpQlb3nkk9/1JvVMIuiEc73TLAIChZy+jCmgyvoxdai
   EzGAWdLlwULROynNmKYbSdZKXzXUk0mwap7AHJ0F8hI10FLRT8evnZdvo
   cjqtjkSwbC9JcytNv1Dq7fCJjzKC+TSdBA0j8nL6KzCFSLuOTKdw6eSDG
   c=;
X-CSE-ConnectionGUID: IzT4g1XJQMmGt8VPFIiSqA==
X-CSE-MsgGUID: B5XKr3Q3R++6659s9u7WGQ==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
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
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="236090901"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Aug 2025 09:30:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 836C4E0C55; Tue, 26 Aug 2025 09:30:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 98AB4E0172
	for <cocci@sympa.inria.fr>; Tue, 26 Aug 2025 09:30:25 +0200 (CEST)
X-CSE-ConnectionGUID: sn3xkoL3RGClvV7SYW0tZA==
X-CSE-MsgGUID: WnH0Z+98T1KwwZBrAQME7Q==
IronPort-SDR: 68ad6292_RI3e3JzmkFlAQmBf3wklzoNhb5RJWjX9nCgzJIaiJpmxCG7
 EjaWXv2HKWsLky5H1bmK0UvweO9Jo/mMsUISrVQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EGAAAQYq1ofgwR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAYI/gQEGVDMEC0mEVYgchzSCJIQ7jxGIeYFVg?=
 =?us-ascii?q?UA9Ag8BAwENPREBAgQBAQMEggyCdAKMJgIeBwEEMAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgkBMYZPDYJiAYEkZQk4AQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARYCPQpEAQEBAgEjHQEBESYBBAsLGgImAgJLCwYBF?=
 =?us-ascii?q?AEBgn4BgiIBBhABAw8mBw25VoEygQGCDAEBBtpeHywiWYFkAwaBGy4BhWuCZ?=
 =?us-ascii?q?AGFXEuDQnonD4FVRIE8gwM+gmECA4Fdg1uCaYImgRaDWJcDUngcA1ksAVUTF?=
 =?us-ascii?q?wsHBYEgQwMqNDEjSwUtHYEneYMHgQ6DWkUrT4IbcoF1QRk/g1MeBmsPBoEVG?=
 =?us-ascii?q?UkCAgIFAkM+gXEGHgYfEgIDAQICgRAQAmtAAgELbT03CQsbBj2UaoRoyHo0B?=
 =?us-ascii?q?4I4gWeBZAyKLpU+BhMvl1IOBpMFhiKSZCKNZps5NoEyOoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iGEM4RgtSNBNTwCBwEKAQEDCQGBVYNwAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 xRwhgYsOYzFER/z7l1xKleY/EMN
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nw3WKKAYY/JU03PlHeiLsceALOsnbusQ8zAXPhhKOGFom6yj/P
 xG785rqSMc6QxhEE3I9urwQZVoLUmsl6KdpLNhR4tKPzOW81dATrsSlbcKqgeIc0eSmoEytM
 cQEJSWSueAdmSS5vyKhDVQZuxQpuVvh5rY4ts2oU0dKD2CIJsQkDuRQjzrbHFedU1+Hpw+G4
 Ob5s1b4xSdWVl/VLX3OlA1G9HZodvFjZTnZgNDISUGxk2hsROEgYSKXySw71MmSDVIzq4l8W
 /Z1zbh7qHmnv2nwh/YzSv+6J4+oqqq9vJzQPeXk8AQJ3HFgBupYoMJYczMgBkF5Nq08V4vnZ
 31vxs9M4BS5hrqDyCIiCqo4BP42DIir0Xv0kCVmhLY0ILEbQN/MdNIgY8cSRfC90881esMkJ
 6j8Vjpxqa+V3777VTAD/ukbWAYqqL1zEBS5NL6wRFkIP8jgPE6l/1XwKvmfa1wbh7S+cQ7FO
 F1AIXG6OxLdE7yVQGvgkB/hMGpVm4+WgiLWVIDvMv96UkhoExE
X-Talos-CUID: 9a23:lD7aTWMVaEEjcu5DQy885E0TPpsfXVbZ0kmPGH6HUXpbYejA
X-Talos-MUID: 9a23:wYTTxQSIaGdP32IGRXTTghE6BoQ5s5j3K18So78ckvChGHNJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="236090874"
X-MGA-submission: =?us-ascii?q?MDHnaSlYJKmwU0dsVg/l8B/AO1zM9gA32tX+IS?=
 =?us-ascii?q?4+CwSa211aPdnzTY0WAFcvHc8NiQ7J1W3umwCYvMcVOBkSnuiACoC4sv?=
 =?us-ascii?q?zzeQCe4W+VmJ082Nwatm/AqXS2U3sAAL2iPPFpGILBPegEtQDYstbNmX?=
 =?us-ascii?q?SwSIO4GSgJFNgTuCoROCIZEQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 09:30:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756193418; x=1756798218; i=markus.elfring@web.de;
	bh=gUz2UNny8CRb9FjWqKSsSistC+xIL9A8tJaC39E5Afo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AzYzVGaaEXw+WyKb3Wmg5UL2BQXmLalWHeiFT/myqlUBu+EAIduZ78lqjvP9fgIE
	 yY/JtJ0qZ7BHixkVX5NzOYEf4Cww/GObKzEhmJToc6uBVktAS1FB3pzfYsvZop4C1
	 nWwLWTucRZo606B8v8BgvHLOF1WL22ZfpzIQ6CyDMaXaPniLSOc2/0f7z8mZQSQRJ
	 Aroe8ED7E87U4IFIXUuxCSeRqeSd7BhpuxItFgb+BFtchrdE29K/F0QGr0opgqo0U
	 yMTBXYlAm5SXdXNP5jvk+CpYDxPgUnX6TOw7pUDodvAkEL9MpwoZh9CoCaVnnd8ea
	 UtfScRbbNMf8NFaGCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.219]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mi53D-1uLtEZ1djN-00mKI2; Tue, 26
 Aug 2025 09:30:18 +0200
Message-ID: <f24b6e34-a9ae-4bfa-97f3-95503a732a88@web.de>
Date: Tue, 26 Aug 2025 09:30:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <574a6fa0-00a0-43c2-8e66-cc6443f5cfd4@web.de>
 <eb3e0445-39fa-4f4a-aeed-96eadc94657d@web.de>
 <alpine.DEB.2.22.394.2508251521570.3563@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508251521570.3563@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uiTJj3M/UJOp3I+pqk4oCQE5TXqwBqOcS6PbYOsgP3NgBa/NZOh
 oQFXlRrT2mGmo0L1JfgYP9rQZZ/qpCOmNaAYkY3vDyJjzFtFRDyzyournqjVtC6diVfUclS
 Lxqr9Y5M9LwYDnlVUgsR7dNsw07Yc7eOOAqxVmDcITzkiwKboW6d1kP8UX8AQkxZAtHDr38
 yML8IdGVNW7UdJm/HUPGg==
UI-OutboundReport: notjunk:1;M01:P0:8LYUcq8mQO4=;GBU0CG0fXpyUCGgV864gQlmkFVr
 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
 HW/UaY24gWp5WYhQGQUTP4fEIqte
Subject: Re: [cocci] [RFC] Choosing =?UTF-8?Q?=E2=80=9Csemantics=E2=80=9D?=
 better for SmPL script parts?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2984
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/f24b6e34-a9ae-4bfa-97f3-95503a732a88%40web.de>

> The default is exists for use with * and forall with transformation, wit=
h
> the reasoning for the latter being that when transformation occurs the
> trasformed code should be consistent.

Will corresponding development concerns be reconsidered in more detail?

Would you understand the source code search parameter =E2=80=9Cforall=E2=
=80=9D in the way
that it expresses a stronger data processing requirement (than the setting
alternative =E2=80=9Cexists=E2=80=9D)?
https://en.wikipedia.org/wiki/Universal_quantification

Is it known if such a quantification difference would influence software
run time characteristics in significant ways?

Regards,
Markus
