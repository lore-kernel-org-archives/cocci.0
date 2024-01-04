Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AB2C4707C
	for <cocci@archiver.kernel.org>; Thu,  4 Jan 2024 12:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OrT/5NwRDSwLYG3F8CiXTijeCbNNeUs/eoOz+llmtn0=;
  b=dx7Il31DXNIHwCPw+ItuYTdTsytxVtnAXqN934c8513EWAJLDooXK4Lf
   bxug/veI5xALBSq4+zzyH0+Ehxt+Hs6ONSxNFnwT5Q43eeQ45bYrufYJ5
   qfnEGjgFLc5EzrqcmcQvhrH+NyX7JWNoZxV7blNrLFlkwN5IV/9LjOIXn
   s=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,330,1695679200"; 
   d="scan'208";a="144849068"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Jan 2024 13:22:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D87BBE0AF1; Thu,  4 Jan 2024 13:22:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0EC27E004E
	for <cocci@sympa.inria.fr>; Thu,  4 Jan 2024 13:22:26 +0100 (CET)
IronPort-SDR: 6596a2fd_8O1Y3amXWGlVRyOWzZY3nzy0yKZ9ZbBE1aQykreOzGs5PD7
 7lPfCPaf9PNTixbLc7qI0jvAS/VjfH41Mx2Q20Q==
X-IPAS-Result: =?us-ascii?q?A0FGAACEopZl/w4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYI4B1sdUzIEC0iEU49BgXUwhDuHNYdMhGuEBIFWgUA+DwEDAQ1BA?=
 =?us-ascii?q?QIEAQEDBIILgnQChzYCHgcBBDEIDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQKBBhOFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IBB?=
 =?us-ascii?q?AEjBBkBAREmAQQLCxoCJgICVgYBFAEBgnyCKwEDDiMHrzZ/M4EBggoBAQavW?=
 =?us-ascii?q?B8sIlaBYAmBGi4BiBoBhWeDQXonD4FVRIEVJ4EUgW8+hEODW4Jogh+DQoNvi?=
 =?us-ascii?q?zpUfx8DgQUEahsPHjcREAUODQMIbh0CMTwDBQMEMgocCyEFVQNABkkLAwIaB?=
 =?us-ascii?q?QMDBIEwBQ0aAhAaBgwmAwMSSQIQFAM7AwMGAwoxAzBVQgxQA2UfMgk8DwwaA?=
 =?us-ascii?q?hseDScjAixCAxEFEAIWAyQWBDYRCQsoAywGOAISDAYGCV0mBw8JBCUDCAQDK?=
 =?us-ascii?q?ykDI3QRAwQKAxQHCwdQAxkrHUACAQttPTUGAwsbBj0Cl0koX4E6k1myGDQHg?=
 =?us-ascii?q?jSBYIFhDJ8rBhMvlyYOBpJULodQkE8gqEaBZAE7gVkzGiSDNk8DGQ+OIDiDc?=
 =?us-ascii?q?48JAT1ANTsCBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:jey94q4hDkACZvB03gPXwBzXdLJyesId70hD6qm+c20xTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkbNDSaNzhHZKjBkWuFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AzwLXeWhIMHUHtWUWgccBZxoGvzJudkPt9U3uEWW?=
 =?us-ascii?q?BVX8ySr+SV3HM2bI7jJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AtIxSSQ86C4SaAiqwcrPB+deQf9ZvuKKOUWEMq7o?=
 =?us-ascii?q?9iZGNDSp7NSywojviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,330,1695679200"; 
   d="scan'208";a="144849048"
X-MGA-submission: =?us-ascii?q?MDG2xPido677TAo9Z4GFwtZnZPwqoTxfgl4M34?=
 =?us-ascii?q?NinsqcKAjha55OI2DagYBUb9WFZLTTp+3q3Cyr+yXNRxxRcwfClC0B3E?=
 =?us-ascii?q?hqkEK2IxXrHxq9rt5YRYjhwUf21+nE99TwT/aqdJHoybsbXdXmEdukia?=
 =?us-ascii?q?D2K+AbV+OqLsgi3ZQquuxCNA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 13:22:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704370908; x=1704975708; i=markus.elfring@web.de;
	bh=CM2cef1ckyh3aeLZ3H3C8Q/8Yfvaf5jJIOf1Yk9mDyk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=wZUB/1KU+78EYC/8EnDNvkEjklcLnvniJUTGUDD4aFzGf1N9j7iiSinLs/FYS+mu
	 2LK3ACiE4XYGcnLDUxxRCLKcRNleq/3I9OHWK25fK/hNTmSLnzcMEauoraIeuQv0l
	 b16Ese/qS3BCzT6FhP/ASwrlosR0NhtTOY26otnHGAM6yhaLplMwR7l7z1wTQ4Vu0
	 whUTl+h80i1YQIaai0kU/IZxRcMpU3YXXehGVBRADu9yVSYnnE81wXKmxkGk4vIgy
	 G9RKHN8IWrAGCmWBceNarCzHVezG2u5QECnjld6jMD+76yOb0Uk/Jp1kwwRgMpwmF
	 EnxeJkg5zrV74ty6eQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5j1q-1rIdhW330c-007bL1; Thu, 04
 Jan 2024 13:21:48 +0100
Message-ID: <1ab4ea7c-731a-4b8d-8f6f-c9bf5f0f02e4@web.de>
Date: Thu, 4 Jan 2024 13:21:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Simon Ser <contact@emersion.fr>
References: <ff7ce5d0-59fa-470c-8dd6-68dbe65c18e5@web.de>
 <9b1e7330-f4f6-47f8-a568-eaea1624bb6f@web.de>
 <37647c33-7f9d-4763-8bf4-cfc5c9a811de@mailbox.org>
 <c5f1a7bf-b444-4934-a205-3c2b3a045ff7@web.de>
 <dd300771-851f-4cfb-b9a2-d87d2b4399aa@mailbox.org>
 <93cfabee-9692-491c-8d38-dec142e90252@web.de>
 <ff58a489-105c-4fdc-9af5-59efb9d05ec0@mailbox.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ff58a489-105c-4fdc-9af5-59efb9d05ec0@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZjA7m6hOg2b8XD2dDwIjNKbIX/BJ0afrZlGsqq4t3Ue5m7p2Fa2
 V7m4gj+Xi7klUcvwxAOVrLpBSjsrWkN8GgRSJzGL1Dp0nH07N9gDbcH7v/jBCb8uJIwys+a
 hcrZLKDMOfoMe0vkZXVTjLQTE5GllV7biwODL+RNsaPAGN6tinfT3Kqw5FP5YIZzDLIlAmL
 g4TJvVzeychmg1OCQWOtA==
UI-OutboundReport: notjunk:1;M01:P0:dAMZO8I92jE=;vhF3KLbYbyO37AA1WXmmtroYNT+
 /v6UKA7rNB9/QFdyhcjMEEi8gv4m32E6+zup+9VIDT+Dro24JCnFMvbdJBOy/nv2XTKhO5H9z
 0AJeBGsyF16sZgipQ57Fk8QFNC3me/suULDgpuwvG9iRUonwTOnLfXNkykxwlKw2OY9T/0XDz
 fAj8FTvyYsCK07SsdDMGO5ga+jn+zB3pYATssmTw2RRIzbhXpwgVmc4yLk5DIXzyTevEcdQKg
 8cX74pnZTdJrGITmHXeqcvIO3mHhRFgl4vVZfcBIjKeZZvtEkoLGtlpVfHpbo7BjnUp11O4Ln
 s0cscoxC/GNpElPFLQzSQPG+wClcWbr/j59DpNpKjeYc2Rv40W9IwsURCfQnSSc6W2lyotvuC
 QTcWIIhbxxDCB9J0h4o9xSNoO+ygSZHRwNQDPN/KPOe5h80luPrA4DhRy3TWeFoht6A7FNJHB
 LN7IDqYJ+AP8iTvlvZ81a19jR1tD6loIPukQm6Lv/BNmyscsrT2XvI+bXJEbB2uvldk1ofMTy
 OC7vEeJh4vmAQBfeYAngjQOpuMaVxBHF3MgAxcoGapTQ2c3wNeucs5+w02OiQPCBSHXRTUujQ
 fJQAme8l9kEwoojmDcMmXBE7uFSPTZf1yrXilsR+D/qNNbF9HF3oPG0IGqM16Uwt9ITnHdfIF
 FYVJoUsT4vaeb5gvz62SHlFr40GCtNQSrAR0MZuqJuTd/l9PlUkBPj7mh4txvJpN9aelP6Pk7
 UsSgTLoqg6Acpum/7vjJRaAu/jTXU8EIQ96kzx2xvPPwR4u2mzmgSIsOmlpY7HRtecbofZMaJ
 FFq/wY2wTA+PV8PXrxjyrPUSs7r0u4u9FjnsYS2G4Qrp8F/NYqLoP/wZ7k5V1cKg30wnXkLrj
 PMivYoYYNFIOvoQwwevbvVobFVWqeOZV2SLBKg/HeR284z5zugh5po5E6htW4scAJbzBTikMv
 0mPmId4bSJLqDYcGTVZk1fVDnPeQo1CD15WnUpYGuFe8YXWaAz/GTUATl0IoNKtAaPxsPw==
Subject: Re: [cocci] [1/3] drm: property: One function call less in
 drm_property_create() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1431
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/1ab4ea7c-731a-4b8d-8f6f-c9bf5f0f02e4%40web.de>

> The commit log says:
>
>  This issue was detected by using the Coccinelle software.
>
> Either that's inaccurate then,

No.


> or you should be able to provide the corresponding output from Coccinell=
e.

Do you find data (like the following) more helpful for the adjustment
of affected implementation details?


Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> LANG=3DC git =
status && spatch =E2=80=A6/Projekte/Coccinelle/janitor/show_jumps_to_kfree=
_with_null_pointer.cocci drivers/gpu/drm/drm_property.c
HEAD detached at next-20240104
=E2=80=A6
@@ -114,9 +114,6 @@ struct drm_property *drm_property_create
        property->dev =3D dev;

        if (num_values) {
-               property->values =3D kcalloc(num_values, sizeof(uint64_t),
-                                          GFP_KERNEL);
-               if (!property->values)
                        goto fail;
        }

@@ -133,8 +130,6 @@ struct drm_property *drm_property_create
        list_add_tail(&property->head, &dev->mode_config.property_list);

        return property;
-fail:
-       kfree(property->values);
        kfree(property);
        return NULL;
 }


How do you think about to extend the application of script variants
for the semantic patch language?

Regards,
Markus
