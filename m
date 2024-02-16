Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC779C48260
	for <cocci@archiver.kernel.org>; Fri, 16 Feb 2024 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=sIyQNn9jm9C7/g1aDgWMD5YGX99ilwZ/3AdtEREs3Yc=;
  b=bvjgm//lxWXSmWB0QbS2qWOwY2s2qkK8gPaq2N1CH3LFADeWahudvTp6
   /UGrsdco/njfLLEaAkEjxa1sl0jnfNDkJM/EBSH9gP079cizuWi3pfpwK
   h05q1u9+IYo5D5Wcc0Cv0/AJbwd0bHWjGS1c9xU9NX5Hqgp5DdYWPRhtM
   E=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linbit-com.20230601.gappssmtp.com
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152311211"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2024 13:20:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BC3D3E0CD7; Fri, 16 Feb 2024 13:20:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4E1B8E008A
	for <cocci@sympa.inria.fr>; Fri, 16 Feb 2024 13:20:13 +0100 (CET)
IronPort-SDR: 65cf52fc_OnY/4ejMl7Kzn640i0mhAba0ecJUU3pDfCzigUkry2hZ/Uw
 nyUbbx9VqSleaXXD2HcY/qjZ5uBxMe7A3iqeAxw==
X-IPAS-Result: =?us-ascii?q?A0H2AgCJUc9lhi3dVdFagQmBT4I5gVIyBFOEU49EgXUwh?=
 =?us-ascii?q?DuZS4ElA1YPAQMBCwEBRAQBAQMEgguCdAKHXgIeBwEEMgcOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEBIBkHDhAnhWwNglwBgR6BJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CJmMBAQECARIRDwENAQE3AQ8LGgImAgIzAQUBHAYVAQEeg?=
 =?us-ascii?q?l6CPSMDBKRdgQVCizuBMoEBggoBAQaxYIEfCQkBCoEGLogmAYkxeieCKIE8g?=
 =?us-ascii?q?wM+hC0rg0aCaIIWgzuKLI9HVH8dA4EFBFoNGxAeNxEQEw0DCG4dAhEiOgMFA?=
 =?us-ascii?q?wQyChIMCx8FVANABkkLAwIaBQMDBIEwBQ0aAhAaBgwmAwMSSQIQFAM4AwMGA?=
 =?us-ascii?q?woxMFVBDFADTRofMgk8DwwaAhsbDSQjAixAAwkKEAIWAx0WBDIRCQsmAyoGN?=
 =?us-ascii?q?gISDAYGBl0jBw8JBCUDCAQDKykDIXQRAwQKAxMHCwd4ggmBPQQTRxCBNIU4h?=
 =?us-ascii?q?G8MgTYDGSsdQAIBC209NQkLGwYiAR0Coi+BA2BFCMZOB4QUoSUGDwQvlzAUk?=
 =?us-ascii?q?l+YWKhOAgoHBhAjgUgCMYFccIM3TwMZD445g2GPekI1AjkCBwEKAQEDCYI5h?=
 =?us-ascii?q?jYzgUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 b0biodND62rNqQvhJYU
IronPort-HdrOrdr: A9a23:10xKKq5p0G1UxQo/TgPXwBHXdLJyesId70hD6qm+c20sTiXqrb
 HJoB19726KtN9xYgBdpTnkAsO9qBznhPxICOUqTM2ftUzdyRaVxeJZnO7fKl/bak7DH4dmvM
 8KE5SWSueAdmSS5fya3ODSKadG/DDoytHQuQ6T9QYIceioUc1dBsVCZzpz3ncYeOCOP/QEKK
 Y=
X-Talos-CUID: 9a23:VTWopmM6SWDdeu5DSQpt1lQrEZofU17wkCbOG1S4DFZEV+jA
X-Talos-MUID: 9a23:1GSWzwrCMWrJIgLY3sYezxU5DdZ6uOO3MkIqnMVFu9XYCy9MeB7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="79835180"
X-MGA-submission: =?us-ascii?q?MDGKRwEZxKafl+cXD0K8mCuy1ghH26wAY4u0eK?=
 =?us-ascii?q?hQjHAQt32DNC0iqDAV0lCCobFPZvhokBrYJlFZ78+T+zE0m/FcoXidbk?=
 =?us-ascii?q?0HPfl9x7FZhON1ER+tXR504RBHuEpuriA08C/K8lQ5IY0A91q6tbwmYK?=
 =?us-ascii?q?vaQqdDh/tlFOuH3KE2m95JVg=3D=3D?=
Received: from mail-wr1-f45.google.com ([209.85.221.45])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:20:13 +0100
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33d0a7f2424so1084276f8f.0
        for <cocci@inria.fr>; Fri, 16 Feb 2024 04:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1708086011; x=1708690811; darn=inria.fr;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIyQNn9jm9C7/g1aDgWMD5YGX99ilwZ/3AdtEREs3Yc=;
        b=VhvGiJVuUY39DkGKYdihsBWgN20fTcOnPoFW6SW6DLO0fHI3KeA/TY4bLl5NRIhyI8
         uE9oUbFvh2AF1lXEm6ACDFnSh4eHxYOZJTATZR9Pr1qBxtu7oo4OfjQoKZ9cfCvoggYP
         ZNYnI3b0XkgGDpXmPPKmLWZeGF3n0JA6T9vOPYokOTSXtu6bFIxujhHdyb3bbAc9P+3R
         ozcEzozZ3sUonTSWRAaz93/I23cBmEhmObukPIGPi4naGBNDfue9aijvOZjVwnPhfKIZ
         WmZydFUoQ1zi0tv87a+c4It9/xUFcgbr7YCKXwaNtGkxnOLLRdN8/ziAsyVjnvbk3vnz
         PhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708086011; x=1708690811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIyQNn9jm9C7/g1aDgWMD5YGX99ilwZ/3AdtEREs3Yc=;
        b=JFPo00rupwN3lj3UitBseXLtECt7I3YrneI1n4WmIyOF17lEagDv2chtTZfLImvuiX
         qYi+5sSGcw7/ah61wumx/ZstEKPA5rltEcEDDlg/IeQdjiEurR3SzTx8MtD8vX2Lxm5e
         rkc7X52cG+A/Q9VA/pcTOOWvACHGah/X6jkPTLVQTH3iTIJ5xKEvnZuej6BzkgoG3zJL
         l4DAPFTS4v8eRkoaqQZmoYO0l7soTMA7hCrxEZnP5SHDYiNzoktnmHHAigfogxemebQM
         1USoyxGqAgSR5GOZo91Z3TxHzyQUZ1sSYFcr5urlVjWKxQ2KrA0mP0JDU9nCu6QCnCdl
         8XVQ==
X-Gm-Message-State: AOJu0YyKhP73/Wsx2d1pF4b70M9u8/7EUBvUGBX9/FNQGoc2Dxo5g0bG
	uNYWFiQAYuWiD1tXop2tITZHpuw1or9IFxqo47kaQ6SgkJ5HC63ItKy34/z1FKw=
X-Google-Smtp-Source: AGHT+IFE/p2o47mtG1R41lGXiqUrXgeqHxh4PdWBeVyc4KzpTkTdU9yTAcD+OixJRU2bxYMve73fiA==
X-Received: by 2002:a5d:6a42:0:b0:33b:2b45:9618 with SMTP id t2-20020a5d6a42000000b0033b2b459618mr2963861wrw.58.1708086011299;
        Fri, 16 Feb 2024 04:20:11 -0800 (PST)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d6ac7000000b0033d1500b639sm2079697wrw.30.2024.02.16.04.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 04:20:10 -0800 (PST)
Message-ID: <86f82a44-129a-4a84-be4d-4b230c2c018e@linbit.com>
Date: Fri, 16 Feb 2024 13:20:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <162c5e8c-54c2-4b86-9735-887b8ba26f89@linbit.com>
 <654c2ee-755b-d245-d1c9-371b314d9efb@inria.fr>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <654c2ee-755b-d245-d1c9-371b314d9efb@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Spatch 1.1.1 backward incompatibility
Reply-To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
X-Loop: cocci@inria.fr
X-Sequence: 1567
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/86f82a44-129a-4a84-be4d-4b230c2c018e%40linbit.com>

Am 16.02.24 um 10:51 schrieb Julia Lawall:
> 
> Thanks for the report.  If convenient you could try the github version.

The latest GitHub version (0df3efff) has the same problem. It also seems
to have some other issue, because it took 1385.5s (instead of the usual
~25) to process the patch.

I also noticed that Fedora used OCaml 5.0, so I tried with the same
commit the Fedora version is based on (0afff7f), but compiled with OCaml
4.14. It didn't make a difference, so it's not an issue with OCaml 5.

I'm trying to bisect this now, will report if I find anything.

> 
> I really need to make a new release...

I was going to ask about that... :)

> 
> julia
-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
