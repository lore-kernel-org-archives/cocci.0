Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F1DC0218A
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 16:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5c1ACikcoZvFxPEfQa5a/N07yqND3XkMMWgBnWWCeno=;
  b=URHplBKYUeC1sduWd2lU4h8IU8+zpIv+hJCCvsgOMqGgE/TEbh1rMlVM
   QXlykYqgGna3LaL31XBKGFmiApyBpnwikWmeQgoOSoJP53GZptXs7g3s/
   /+2VHWIAzI3YUREHtSmh41/KkFBAU4q2UEvPf1NNNR4c+hmI0verrYEMK
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linuxfoundation.org
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="205238431"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2025 17:17:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 02744E00A5; Mon, 27 Jan 2025 17:17:18 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BF106E0077
	for <cocci@sympa.inria.fr>; Thu, 23 Jan 2025 16:47:12 +0100 (CET)
IronPort-SDR: 67926480_52Y38yNHTVpLLDV4LoCcDfUaUT8qhBgbNBECZEWLOKrouz2
 Jr2R3T1gYcuS93O4unAoZ5YGbI3vVj8bGXn6pDg==
X-IPAS-Result: =?us-ascii?q?A0EsAgCeY5JnfCnQVdFagQmBU4JEgVczBFOEVoh8hlKCJ?=
 =?us-ascii?q?J4YgX4PAQMBDAFEBAEBAwSFAAKKdAIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?RABAQUBAQECAQECBAYBAhABASIZBw4SKYV7DYJiAYEkgSYBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEdAg1+AQEBAxIRBBkBATcBDwsLDQICJgICIRIBBQEcBhMIGoJfgmUDqnuBB?=
 =?us-ascii?q?UKLPn8zgQGCDAEBBt4DCQkBCoEGLohOAYFsg3+DfXonG4INgUqCdT6IHoJHI?=
 =?us-ascii?q?oIzgXSCNIEMjE2EQYRniW4mCR0DBwcODR5JDwUcA1ksAVUTFwsHBWFISAECA?=
 =?us-ascii?q?YETI4EmBTUKNzqCDWlJOgINAjWCHnyCK4Ihgj2CGIItR4QKhVuCFIFoAwMWE?=
 =?us-ascii?q?AGBc4E0eR+BAh1AAwtiCz03FBtMnQQ8hFiZX45+i3KVEYQlhG+ccTOXRJMPm?=
 =?us-ascii?q?HypAwIKBwYRI4FFATiBXE0wCGwGgjBPAxkPjioZiGy8EyI1PAIHCwEBAwmQF?=
 =?us-ascii?q?oFLAQE?=
IronPort-PHdr: A9a23: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
 EI4bXHLQLVei7Ymfmdu2le0hA==
IronPort-Data: A9a23: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
 vSRD6ACOXm4
IronPort-HdrOrdr: A9a23:d6TTFKl2QapyecwauRE+VPfW8WvpDfKl3DAbv31ZSRFFG/FwWf
 re7MjztCWE+wr5PUtLpTnuAtj7fZqxz+8P3WBVB8bbYOCEghrPEGgB1/qc/9SIIUSXnZ8+pM
 JdmupFeaTN5DBB/KXHCWKDYqgdKbe8gdGVrNab4HF3UwlwZq1sqyt/AB2KC1B7SWB9aetcKL
 OsouRC4xWtcWkKdcigb0N1I9TrlpnkkNbJb3c9aSLPKzPgsRqYrJD/GxicmjEEUz1Oxr8mtU
 zIiRbw6Knmk9zT8G6g64YQ1flrcRfaq+erzfbt+68oFgk=
X-Talos-CUID: =?us-ascii?q?9a23=3ANIhiEGg5JC3C9Cf5sq0uBR1+cDJuKXHj1U+KPF2?=
 =?us-ascii?q?BGE1tTbe/SgKz/PJonJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AnYAiOgw2C/dQdgkdaAI0ZLpTh6CaqIGQEG5RnYs?=
 =?us-ascii?q?DgtuVNSJJBg+TzzaNa7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="204698946"
X-MGA-submission: =?us-ascii?q?MDG7m92guDTIJLKd2mvprNdNkxFCfvUY4Jsaqw?=
 =?us-ascii?q?481rag+zxRNqUs7KN2xLrP/zv8x3iryroLkj8STU7nF0wj4PZwRLe+o7?=
 =?us-ascii?q?Xe0XFdKCbGyVW+y3TDlOTYC4IFn8mEnjdEu1UH5iOqoIS5Z98INDT0RW?=
 =?us-ascii?q?cRsnpCmhD0EsEKfHqa/7xdCg=3D=3D?=
Received: from mail-ed1-f41.google.com ([209.85.208.41])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 16:47:12 +0100
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so1567373a12.2
        for <cocci@inria.fr>; Thu, 23 Jan 2025 07:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737647232; x=1738252032; darn=inria.fr;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5c1ACikcoZvFxPEfQa5a/N07yqND3XkMMWgBnWWCeno=;
        b=Kq4Bh1pHPPl/qRB0Mayd1zM+ZO3h/eoGqs5yrCr6KqPvdkKtuBTyf3vSjlELhtkZZi
         DiKnndyHeqqh9JxtsvzAIt2xfMOGiJQUyq+4DqeY999lWpbfdaG8CDdurZzcy8/5MHTA
         11zCDqbQNymxxCj6KbQqgbGOo+auuRbbq6NjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737647232; x=1738252032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5c1ACikcoZvFxPEfQa5a/N07yqND3XkMMWgBnWWCeno=;
        b=CqqzB+Jzg2JyLMEx7o+wVed4PPFlFJ3IjEKc38r4vl8S78+4YPRYCoiBRUzh1ybM6i
         qS2m7LVAWb9IOn355w/4cGH2fqlpOjpw+cKSyVVTgk6gBRvszkTwUqG0HQ9fcq3Cxmg5
         M9bzLbQsACIyp+nnGfFTLhYdj7LBTSzD7zUNKUB0rvgF3nATX3AnN6AuTDFl6Vxnwhlz
         VCfT24KTij+6d/EpB6j27NxQOptG72KzcMhstDBf1p/fMmk3GPg2T6iQzSO1oksw8pro
         RbBzJ6eHUGthbzBHL4IdNvG9ySPXUZ+lR5EbMTSGDUBBN8VlsMy9QHt68j8w6nIy7m6D
         9lDg==
X-Forwarded-Encrypted: i=1; AJvYcCXVbMlHRc5V7fDsrLXbKujHHv8w2+AU+D1VShP74OPK50UCm6ErOz0ZOjcfCwhQSoqVSGqc5w==@inria.fr
X-Gm-Message-State: AOJu0YxSLErUB6kw+zsAvlBcSyc0kSJvtvz/k0vwbM+epijXxryIcwE0
	IfTw/RaGQ8toeJ1uBaIx5+/aHshFK9O/UdOmW7pSyEDcAIYEsWCMXFknUXCKBvZWI2M4lAzX6MW
	pb8o=
X-Gm-Gg: ASbGncuhwQ07ld7EVv6ZrCAq5DuTcLVL9mf13nhoxPuYgjxxtw1qSN1m4EaElb+UB2r
	l6Lk38QcyVoT8As/TKA+iAsc2IO+SXj30/AKOkwHVO2DpckZk7RRC5mT6b8fJKgPVaMqtQkqa/s
	iiK2fuNpFizSWwCg97o1XXac5mtGy+lBuW9TrgiMt6hFpmeluM4w/2SF18eJ7vjK0vDR9WsXxui
	kH2SXeRvKVo2jAOn+5HbNzyTAbDZqIPGCHqpTjMj9cuIdSELHmvC/B4X4xBtt4kIcbWzy1GC5l9
	gM5dj/H0pfNFziB/BeBrTNlMvyLWz/dampGT4JJZuT5ibPnbOhJnQg==
X-Google-Smtp-Source: AGHT+IE2Ji9xSFsMCPmK8hNmGCfFyD3AmLa9dxbSkuopoXKjr+sEfn8w6Z9CpAtOVfRJxLzLvpDjYA==
X-Received: by 2002:a05:6402:3595:b0:5db:f4fc:8a08 with SMTP id 4fb4d7f45d1cf-5dbf4fc8bf6mr18353821a12.6.1737647231571;
        Thu, 23 Jan 2025 07:47:11 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f224e0sm1086441466b.112.2025.01.23.07.47.11
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 07:47:11 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaef00ab172so178012766b.3
        for <cocci@inria.fr>; Thu, 23 Jan 2025 07:47:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1UFuyUTFf1q7L6wfWeJSi0fX6i+8d2TUaKsRl5AM0V0kFctsUeaMIp5fVuZuktkWYn8q+1Q==@inria.fr
X-Received: by 2002:a05:6402:3595:b0:5db:f4fc:8a08 with SMTP id
 4fb4d7f45d1cf-5dbf4fc8bf6mr18353711a12.6.1737647230858; Thu, 23 Jan 2025
 07:47:10 -0800 (PST)
MIME-Version: 1.0
References: <20250123135342.1468787-1-vignesh.raman@collabora.com> <20250123135342.1468787-6-vignesh.raman@collabora.com>
In-Reply-To: <20250123135342.1468787-6-vignesh.raman@collabora.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 23 Jan 2025 07:46:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWcw-aPcMvWYqJDqxopPYXnPnVgFYAUSkvkRPTjO83uQ@mail.gmail.com>
X-Gm-Features: AWEUYZkvzfVO2hileHLKdeINWEzbU9zhoxsfXAWcm9kmxXjIcn6s0um9krEKyaE
Message-ID: <CAHk-=wiWcw-aPcMvWYqJDqxopPYXnPnVgFYAUSkvkRPTjO83uQ@mail.gmail.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org, 
	dave.pigott@collabora.com, mripard@kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, 
	gustavo.padovan@collabora.com, pawiecz@collabora.com, spbnick@gmail.com, 
	tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	skhan@linuxfoundation.org, kunit-dev@googlegroups.com, 
	nfraprado@collabora.com, davidgow@google.com, cocci@inria.fr, 
	Julia.Lawall@inria.fr, laura.nao@collabora.com, kernel@collabora.com, 
	gregkh@linuxfoundation.org, daniels@collabora.com, helen.koike@collabora.com, 
	shreeya.patel@collabora.com, denys.f@collabora.com, 
	nicolas.dufresne@collabora.com, louis.chauvet@bootlin.com, 
	hamohammed.sa@gmail.com, melissa.srw@gmail.com, simona@ffwll.ch, 
	airlied@gmail.com, Tim.Bird@sony.com, laurent.pinchart@ideasonboard.com, 
	broonie@kernel.org, leobras.c@gmail.com, groeck@google.com, 
	rdunlap@infradead.org, geert@linux-m68k.org, michel.daenzer@mailbox.org, 
	sakari.ailus@iki.fi, jarkko@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 5/5] kci-gitlab: docs: Add images
Reply-To: Linus Torvalds <torvalds@linuxfoundation.org>
X-Loop: cocci@inria.fr
X-Sequence: 2232
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/CAHk-%3DwiWcw-aPcMvWYqJDqxopPYXnPnVgFYAUSkvkRPTjO83uQ%40mail.gmail.com>

On Thu, 23 Jan 2025 at 05:56, Vignesh Raman <vignesh.raman@collabora.com> wrote:
>
>  Documentation/ci/gitlab-ci/images/drm-vkms.png | Bin 0 -> 73810 bytes
>  .../ci/gitlab-ci/images/job-matrix.png         | Bin 0 -> 20000 bytes
>  .../ci/gitlab-ci/images/new-project-runner.png | Bin 0 -> 607737 bytes
>  .../ci/gitlab-ci/images/pipelines-on-push.png  | Bin 0 -> 532143 bytes
>  .../ci/gitlab-ci/images/the-pipeline.png       | Bin 0 -> 62464 bytes
>  .../ci/gitlab-ci/images/variables.png          | Bin 0 -> 277518 bytes


This seems excessive.

We have a few images in the tree, but they tend to be either the
penguin logo or various source SVGs.

Not a set of random screenshots or whatever.

         Linus
