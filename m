Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E18C87FCE
	for <cocci@archiver.kernel.org>; Thu, 24 Jul 2025 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6uL52KbS/oQEmT1IwLXi27TWArWqylFIrJ3LzLnZyPQ=;
  b=HzV1pm0TfdmBL8+Th2fcSvPCoDcd7jPZg6ghwI+5gzyaLp8Im11dtnUN
   HcnVVcQL1QZpfDW7SeKZ/AfqyGWVBjhpIkoQlC9zgH4quHNGhj1F/SYeB
   3cCEf3F+A1r+6i/5N256jKvUWl39Q68o/vnAZUNmEuxjYYeKTnJjPD2J+
   k=;
X-CSE-ConnectionGUID: VTsYbjY9Q8GZGaUOm+zOUQ==
X-CSE-MsgGUID: Z0RR711eSuCO58xxgh+b+w==
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
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="233005436"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2025 16:19:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 31F6AE0BE9; Thu, 24 Jul 2025 16:19:39 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D3499E0172
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 16:15:24 +0200 (CEST)
X-CSE-ConnectionGUID: Fs+huta2Tf+9uopBfpZ8mg==
X-CSE-MsgGUID: pHvURPOpQzK6GQYnWNAUhA==
IronPort-SDR: 68823ffc_6f21uDkRlC/BUl0kvziDVjwq7gIifY0g8XU5a8dfYl6YWxk
 UCSGsbmW5SSSu0ENjZ5hmZ5r5t3etX8luOQBrCw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GmEgBnP4JogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VMCgkKBAAZUMwQLSQiETY9QgiSEO48Rik+BfAIPAQMBDUQKAQIEAQEDBDiES?=
 =?us-ascii?q?AKMFgIeBwEENgQNAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDTpEAQEBAgEjBBkBA?=
 =?us-ascii?q?REmAQQLCxoCJgICVhsBAYJ+AYIhAQYQAQMOJAcNBrYHfzOBAYIMAQEGgmnXd?=
 =?us-ascii?q?R8sIlmBZAMGgRsuAYVsgmQBimMnD4FVRIE8C4EJgW8+gmEEgV5Ngw6CaYImg?=
 =?us-ascii?q?RaDZY0GiC9SeBwDWSwBVRMXCwcFgSBDA4EPI0sFLR2BJ32DDYEOhCgrT4Iid?=
 =?us-ascii?q?YF5QRk/g1MeBm0PBoEYGkoCAgIFAkNFgUVAAgELbT03CQsbBj2TFYRhmQ6vb?=
 =?us-ascii?q?DQHgjiBZ4FkDIoulT0GEy+XUg4GkwWZBo4ImzmCAgQcgVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?QwWg14zvy5BNQIBOQIHAQoBAQMJhUYBAYoxgUsBAQ?=
IronPort-PHdr: A9a23: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
 twCR+0DPLTQPuwXAAJpEY5aSKo=
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:pUAz4a22e5pp/bpCu/TF6AqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV96faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:mMaM9WHUD69DkrUGqmJJ7w0UB9wsKEHTjybNJFeSB35bGLiaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AsTasGgyzJvRs67Fvd6qiQ+O5zzGaqLyOFn03qbI?=
 =?us-ascii?q?egtunawNJCjGiqh2KQqZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="122125055"
X-MGA-submission: =?us-ascii?q?MDF7ss7to2XvQNlUwvZN5820ebLb6HJZCkMg8i?=
 =?us-ascii?q?tz1nTxqH74ndwtOlz2Kax/vv8AJSIm+x0pKSXOo01iuL7WAlKL6Y+rxO?=
 =?us-ascii?q?J4gbPuTkZnH4vYpQMCSIa1PGO7yOVDDM1Whex/4MT7C11w3c6dzfgFyM?=
 =?us-ascii?q?vSgiQH3XSHRSwQ+zruoWeQRg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 16:15:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753366523; x=1753971323; i=markus.elfring@web.de;
	bh=6uL52KbS/oQEmT1IwLXi27TWArWqylFIrJ3LzLnZyPQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mzfWu5fq7JH3EeoelJgWbohZspoCdYE0Lz1dqOaznc7bUO69yr97FI1Fi+asfEQl
	 PZoOgtI99PTvoOm5VBX99v/QbqcOAOBa2m6RmA+pNRaHNu8YIpKFUc09DzHT+fD18
	 nA11vVVXg/EmnTa2E/bvMgSkF1OGEZfx3OW6XR7QWdfCgJvPWT0syxxDCgREC/nsF
	 BahcDtkcqSn7bHMqFGw52ERmjKg1KgHmPtdO75hPJ45C7rXKONZ7kUfC4j+scvC7T
	 HPZHjxEcV+wn3z1lu+YDIju0LSha4nEAe+6nRrfNWIKEviBY5mWmwB8Wtv58WvdbW
	 Ye8i3smjVQwEs8vzbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4NDQ-1uWrSW2v0I-00rD6Q; Thu, 24
 Jul 2025 16:15:22 +0200
Message-ID: <15d7ce10-8598-475d-86ac-ae0df3f2abdf@web.de>
Date: Thu, 24 Jul 2025 16:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WCBhWVs7Tpy/Mm6hkqF7OZ8hXvYBsIlzu4uSaBd3Ii1Z36+x9Kv
 l7qXJZM5lJMe+9PydDx9Csa2GKcoAKNnWpSYCe/KDG8RfH8GdFVo7wiN3Km4Dk3YnNDVO5N
 HCEcxxt0w6EbtBLn41J9KbNbtdTuqjsWhxmEQZrnsjkEJQ9Bf1ff6uouVZvzIEVTDd3GZhV
 OknZMNrwKQKk9EAzjxTLg==
UI-OutboundReport: notjunk:1;M01:P0:5TUYGkA/Fbo=;ZRrJH0hHjEI91mn+TNX637t9zOz
 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
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2907
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/15d7ce10-8598-475d-86ac-ae0df3f2abdf%40web.de>

> Now I wonder how these diff hunks fit to my source code search approach
> for finding call pairs of known functions (or macros).
> Will another clarification become more interesting?

=E2=80=A6
@@ -1613,9 +1608,7 @@ static void handle_uaudio_stream_req(str
                        ret =3D prepare_qmi_response(subs, req_msg, &resp,
                                                   info_idx);
                if (ret < 0) {
-                       mutex_lock(&chip->mutex);
                        subs->opened =3D 0;
-                       mutex_unlock(&chip->mutex);
                }
        } else {
                info =3D &uadev[pcm_card_num].info[info_idx];
=E2=80=A6

* How can such a difference display happen at all when it is expected
  that the macro calls =E2=80=9Cmutex_lock(&qdev_mutex)=E2=80=9D and =E2=
=80=9Cmutex_lock(&chip->mutex)=E2=80=9D
  should be presented before?
  https://elixir.bootlin.com/linux/v6.16-rc7/source/sound/usb/qcom/qc_audi=
o_offload.c#L1542-L1583

* The source code search pattern indicates an other unlock call order,
  doesn't it?


Regards,
Markus
