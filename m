Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D66C87FC5
	for <cocci@archiver.kernel.org>; Thu, 24 Jul 2025 18:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rJku6kRVS6S/pXpETRbV9FzdZ0l+OgYd7/UjlBXzA74=;
  b=Q9Xxanj5JV8ShhUCexnLYtZH4QcDwNDTX17VkIWU9Xrd8q/5yHTbQSzH
   ZaiXkWz3JoJGWIL0I4y8s5U9PoBF1qGXgE8DlbpZTdGmUdXb0uckXC+9x
   FO6xhTykQWTPMTafQoT34qBZHYLtl5C3z8SOat2cSEUKo0guPcjjk/DQF
   s=;
X-CSE-ConnectionGUID: ILkfLfb3SMqp8bu3uukMjw==
X-CSE-MsgGUID: DyMJOwD6Rg+GSDOA6nmQeA==
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
   d="scan'208";a="233034781"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2025 20:37:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 125D6E0C55; Thu, 24 Jul 2025 20:37:12 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 83713E0171
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 20:37:10 +0200 (CEST)
X-CSE-ConnectionGUID: lIG1T5JuT76HQsk9hhE6Rg==
X-CSE-MsgGUID: ff+Gj1MVRg+6A7m4B9r93A==
IronPort-SDR: 68827d56_jtdWnUGlwvmmf6hSo/7fTzZ5EL1JyazhyjM9nPI0M1Rl7+y
 EP+pbzDr19JkV3pgn+7YzOvmNXmx83RxkIFcyPw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GFAQDPfIJogAwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UIEAQELAYJDgQAGVDMEC0kIhE2PUIIkhDuPEYxLAg8BAwENRAoBAgQBAQMEg?=
 =?us-ascii?q?gyCdAKMFwIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABATsHDgoxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDTpEAQEBAgEjB?=
 =?us-ascii?q?BkBAREmAQQLCxoCJgICVhsBAYJ+AYIhAQYQAQMOJAcNBrYffzOBAYIMAQEGg?=
 =?us-ascii?q?mnXdR8sIlmBZAMGgRsuAYVsgmQBimMnD4FVRIE8gwM+gmEEgV5Ngw6CaYImg?=
 =?us-ascii?q?RaDZYZzhhOINlJ4HANZLAFVExcLBwWBIEMDgQ8jSwUtHYEnfYMNgQ6EKCtPg?=
 =?us-ascii?q?iJ1gXlBGT+DUx4GbQ8GgRgaSgICAgUCQ0WBVEACAQttPTcJCxsGPZMegjSCL?=
 =?us-ascii?q?YFabpZGrmKBCjQHgjiBZ4FkDIoulT0GEy+XUg4GkwWZBo4ImzmBfiSBXDMaJ?=
 =?us-ascii?q?IM2TwMZD44hhAAzvytBNQIBOQIHAQoBAQMJhUYBAYoxgUsBAQ?=
IronPort-PHdr: A9a23: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
 chXIle+fEM4HLUWBxY9dOE=
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:hpzv7Kk0Q/26/hw00g7p2zmqc7TpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE7wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQiVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:VY7amWz39SKz96HCXYpGBgUQO+98TiD/0UuPfW+BEmU4SL24F2WfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3A9oerCg0mZZ1rbwIsdv8+nsB+5zUj7artJ0JUtKs?=
 =?us-ascii?q?8tIraHHN1Zx3MlmXsa9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,337,1744063200"; 
   d="scan'208";a="122141329"
X-MGA-submission: =?us-ascii?q?MDE0C8Olj2fr6KQ2TuKkQuPG+lFvmI6kUP1hmP?=
 =?us-ascii?q?yeRDd/Yiy04bIFngri7RIw50n9NNgFxGIfQqj3AfBZgZ6Oboue3AB+DC?=
 =?us-ascii?q?14IeNej+4AOG2TSRGbj+n2UrKNGVL0i0FL+F3865pEAvLHnZh641fQ56?=
 =?us-ascii?q?XpuctURcvoO+N3hVWk8l4GVA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 20:37:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753382227; x=1753987027; i=markus.elfring@web.de;
	bh=rJku6kRVS6S/pXpETRbV9FzdZ0l+OgYd7/UjlBXzA74=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tOoVim+L1J5XTWE3IYJAibevEhlMu40YD7ZGfOqRtolXZQh2mYEK+d0XrMn1Ltub
	 l3kc6PpcOb3c6ku1uCX88amyuqX4bjGjsU0z4Bmn/kPGW6w8HsunAQnp51bhgw9KV
	 QbD5BxOp3ZHqD/IG+yzGRzC6uOJZMgbCzTg6hDLRY0yu8k0EwZ3NGh89xciIbb3pD
	 a07dU86iuops9Rn+Np7AAkGDN0ABqTYI8IlpaX4iUrDOdOhFuQid7mOlaj+nlnMjk
	 X/u5MZSophhvWcNbYNxbrXlH6xXZqH8Rlv5bRJ5PyCZp9d/ZcWsC86v+K5pjPjWSe
	 AeNO94x9Y37gHxoTzQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9LIc-1ubj312gtA-00wAyW; Thu, 24
 Jul 2025 20:37:07 +0200
Message-ID: <44adb87d-dbcd-4ae1-88fe-9c5c948a6404@web.de>
Date: Thu, 24 Jul 2025 20:37:06 +0200
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
X-Provags-ID: V03:K1:CsGo5YzIj4UTp0IbpYmOc9AvILZCptMuJxqzl1gV65OgdaFwyMn
 PaZSJa5GyQxLOP4PNcVBWGisE5NZFvGwGDqpqw9Ao8oU+eukilWbOkisgOcRXOHQIbw08z2
 br0hvuJ1CewhUL7xHsfjfgUs2Hl3rttKSGYwT6b7UihoszJZNleYm3HfKEDZy+TmFCjCCD9
 q2OG80eYeXmP0LSnoDVKw==
UI-OutboundReport: notjunk:1;M01:P0:f098h6SSDaA=;nzA6G/O+9bwt5kqPCryBc0weeg8
 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
 9iHXGKIMFmCwpYSlMkfPuk0=
Subject: Re: [cocci] Searching for questionable call pairs (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2915
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/44adb87d-dbcd-4ae1-88fe-9c5c948a6404%40web.de>

> Will another clarification become more interesting?

Another source code search approach can eventually help to provide further
insights into presented software development concerns.


// handle_uaudio_stream_req()
// https://elixir.bootlin.com/linux/v6.16-rc7/source/sound/usb/qcom/qc_aud=
io_offload.c#L1508
@display@
expression x, y;
@@
 if (!svc->client_connected)
 {
    ...
 }

*mutex_lock(x);
 ...
*mutex_lock(y);
 <+...
*mutex_unlock(x);
 ...
*mutex_unlock(y);
 ...+>


Another test result (by the software combination =E2=80=9CCoccinelle 1.3.0=
=E2=80=9D for example):
Markus_Elfring@Sonne:=E2=80=A6/Projekte/Coccinelle/Probe> time /usr/bin/sp=
atch --no-loops ../janitor/show_questionable_unlock_call_order5.cocci qc_a=
udio_offload-handle_uaudio_stream_req-excerpt-20250722.c
[no diff output]
=E2=80=A6
real    0m0,103s
user    0m0,085s
sys     0m0,018s



Does the specification of additional context from the beginning of the dis=
cussed
function implementation influence the exclusion of a false positive?

Regards,
Markus
