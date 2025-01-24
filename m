Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E993CC02198
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Vo3fTWya9tHycVPx5tFin/qFgljd4EcPY6jTqMY9tdU=;
  b=S5STZFBwZ2UyhZacBwWAhsHdp83+0R7pVEa1Px87PLqdJGqqpRV5EzzN
   ky9BTmarFNaDiPWduXt3L0I7ZNTAtCEHNxePHnvw8UK/L7dScYjI/bRNK
   kJATyJFFFIZmStp4hwmtBwnEnwt0lVFdIawdbECldozvp7/7Opt2F3/dK
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205324944"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 55218E0D22; Tue, 28 Jan 2025 10:13:05 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DF13BE007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 14:01:00 +0100 (CET)
IronPort-SDR: 67938f0c_pGKtP/gG56hVKFBBP+TWYb5e+5oWeRDV7OneVe1D5vBO8VE
 AFLGb0UdB72WWnBZGNmD8UfceoBHgkG1Ll0jdQQ==
X-IPAS-Result: =?us-ascii?q?A0EUAACYjZNng3yFCqpaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDYoEoBFOEVogdhzGCJIQ7mV2Bfg8BAwELAQFEBAEBAwSCDIJ0A?=
 =?us-ascii?q?op1Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBA?=
 =?us-ascii?q?QE5Bw47hXsNgmIBgSSBJgEBAQEBAQEBAQEBAQEBAQEBARcCDX4BAQEDEhEdA?=
 =?us-ascii?q?QERJgEPCxgCAiYCAjMBBQEcBgEUAQEQDoJfgmUDBKs1AW6BBUKKQwEBAXiBM?=
 =?us-ascii?q?oEBggwBAQbcHIFkCQkBCoEGLgGFaoJjAYVrg316Jw+BVUSBPIMDPoFSgwaDR?=
 =?us-ascii?q?oJpgjOBdII0gQyLEYE9hEGEZz6KBVJ7HANZLAFVExcLBwWBKRA4Ays2MSOBJ?=
 =?us-ascii?q?gU1Cjc6gg1pSTcCDQI1gh58gitrBAWBK4I7hEWEU4JDgxiCFHprAwMWEAGCN?=
 =?us-ascii?q?XJ7H4EoHUACAQttPTcGAwsbBj2dVoZIgQ4YkwCDT44ToTo0B4QegWMMn1wGD?=
 =?us-ascii?q?wQvhASNBoY6FJJ7mHwiqGECCgcGESOBRDqBXHCDN08DGQ+OIRkfg0LFZkI0P?=
 =?us-ascii?q?AIHCwEBAwmQI4FLAQE?=
IronPort-PHdr: A9a23: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
 4L9Z4klcZr/DXPoCzSC
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:lDPwgqihYARrVhSBb98lP09pYXBQXnsji2hC6mlwRA09TyVXrb
 HQoB1p726BtN93YgBXpTngAtj2fZq4z/VICOYqTM+ftWXdyRqVxcRZnPvfKl7balbDH4xmpN
 5dmsFFYbWbYikdsS+52njHLz9J+qjhzEnCv5ai854Cd3AXV0gt1XYCNi+rVmJxXxdPHpc0Gd
 6x4cBdtyO8dXl/VKWGL0hAceyGidOjruOEXffEPX4aAcu14w9AJISKdiRxc3wlPg9n8PMH8W
 zImQTi++GGnNv+4jHzk0//hq47pPLRjv9CAMCHgtIJbhHCoEKQX6JKH52u1QpF0t1Gbz0R4a
 zxS8NKBbUB15oZRBDW0H/Q5zU=
X-Talos-CUID: 9a23:qFoqGWAUiK1otvr6Ezg4y0s5IMYLSXr2lkj/O0ayLlxbGJTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3At6dHzg62ZjQq30DZU+JeNRPCxox1+Y+VM1kEqqw?=
 =?us-ascii?q?GqsutMh5VOWiWhyq4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="scan'208";a="107277722"
X-MGA-submission: =?us-ascii?q?MDFJahxlh2eTZRb0gtuMI2prDjhawVqEey2ngJ?=
 =?us-ascii?q?3go9et+kAGH0F6Rw74z95NLtLvfGXHuoEr13RNr/X1N1vgIUMJBnV/AF?=
 =?us-ascii?q?109hHlVcC2uhkLHXuEFToxlv/budo9mD+LopVaQvjyHlgRxYIFPP26Ql?=
 =?us-ascii?q?CwVCYu2sVZ5EHzkVndsqp+Sg=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 14:01:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737723658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vo3fTWya9tHycVPx5tFin/qFgljd4EcPY6jTqMY9tdU=;
	b=fDiQCtfn/cE/O1V81wnMjXQ8/TspnpIANUctmOqOb7xQsz/3SN7OVk26NWuRfibiqU74iq
	NkVRs5GnbBO+Za/teUyPQl4Kab/yye4+lkgw8E1h027ymfhmJyJHEwM+snacG0L2sg0swx
	4rpqBkqP0QP16CgLad3ArvA4g+cO1Gs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Zl9fEny7NV27CVt7N_czmw-1; Fri, 24 Jan 2025 08:00:56 -0500
X-MC-Unique: Zl9fEny7NV27CVt7N_czmw-1
X-Mimecast-MFC-AGG-ID: Zl9fEny7NV27CVt7N_czmw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361d4e8359so14634265e9.3
        for <cocci@inria.fr>; Fri, 24 Jan 2025 05:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737723655; x=1738328455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vo3fTWya9tHycVPx5tFin/qFgljd4EcPY6jTqMY9tdU=;
        b=E0Jv7ef9RZo1tIgToEB0NtapBGM+0IpaDT0AbNfkgMuuP8uYWGIEi3GWpOP4aV/5u8
         pv7mRJE5sRygmtjo9awbOPG/dl1wuXvw7hOxif2JE8ua/EsP4kRxWnbsOb+jpjNPPfvi
         xpY+u+1r/FeXQi1pwuAHigqs6E/PW2KCVO7n5YbAAghu9KUdgYiPPlO86xAsgo1iLKy3
         dUSD4DCf/V3fq+hy6nCNsjhbJHfj9ew0XaNyXg1tnHANcGuXc8EemXIbg10PmNeylao0
         gVv5s4OFr8jXxEdNCF6v56SbPetJ3NynquOV/ddSo9FT0XAXVxP/HsCG/Wv5tU7SzBcs
         PUqA==
X-Forwarded-Encrypted: i=1; AJvYcCX4Ee1fIm8YxiJfRb4JrF1r841i2lAvDQpAM4MUIRhIlADxIc6jveYIWxiVpJ64WvQEBA9IHw==@inria.fr
X-Gm-Message-State: AOJu0YypA8KwqYjICvl5aIsG8JvWJV8SzWOEOVuiIWorEjmlbU8z8uzy
	F5Q8WWkZCau+HHfu3kUq0TC0coAbokvu8ES7ASoOvy49sbLh0fUjAcfShEhVUFist/w2szAJ+Ro
	s8T4s5KzkUuLeI9HCu5R6dieuwBfROZiiErbLz67Rwa0=
X-Gm-Gg: ASbGncvmXwJ2zunTOpBoUWqVoaExODDSMYslJoyLKkrhNtjBD+5MOkSgbOzT96PW3WU
	K2T3ngPzGNrf8+nt+opE8qupxWfV/10Z+WxURylLJ/2pq45mWVFNheXFwVLweCLNvY+g5EEXXPE
	kyT3048yq9JzwxCLa8gZoj4v3yL9/UDLilaim9iY5VwGUCCGSo+Oh7+OD9zZ0PjHje3zlGlU5Mw
	4pzFsxBVIEr41MmsAZp0LaSAF0jpavWWOCsClJGwmwd6dbHf4fuAyc6HKmabsRJ/n2t92GS4nBD
	bYmnubRX2ad9wA2l8TSzlrOIFI7v4yEuOcX6d9FIdoRxTQ==
X-Received: by 2002:a5d:5f54:0:b0:385:fa33:29ed with SMTP id ffacd0b85a97d-38bf57d2cc4mr26674286f8f.47.1737723655024;
        Fri, 24 Jan 2025 05:00:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7O6kDxKgj8QXof6pkh0HnABdfU01AfCfVNwm0lMd0ZfNC4JqKT86eG7V6rVx2a63lUIXoHw==
X-Received: by 2002:a5d:5f54:0:b0:385:fa33:29ed with SMTP id ffacd0b85a97d-38bf57d2cc4mr26674235f8f.47.1737723654623;
        Fri, 24 Jan 2025 05:00:54 -0800 (PST)
Received: from [192.168.0.167] (h-185-57-5-149.na.cust.bahnhof.fi. [185.57.5.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4857cesm25657015e9.13.2025.01.24.05.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 05:00:54 -0800 (PST)
Message-ID: <298675d0-ba19-4c87-b00d-57a5e31b05b6@redhat.com>
Date: Fri, 24 Jan 2025 15:00:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 =?UTF-8?Q?Leonardo_Br=C3=A1s?= <leobras.c@gmail.com>
Cc: Vignesh Raman <vignesh.raman@collabora.com>, kernelci@lists.linux.dev,
 linuxtv-ci@linuxtv.org, dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
 pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com,
 workflows@vger.kernel.org, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 kernel@collabora.com, torvalds@linuxfoundation.org,
 gregkh@linuxfoundation.org, daniels@collabora.com,
 helen.koike@collabora.com, shreeya.patel@collabora.com,
 denys.f@collabora.com, nicolas.dufresne@collabora.com,
 louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, Tim.Bird@sony.com, broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
 <20250124081250.GA24731@pendragon.ideasonboard.com>
 <D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <D7AAOSNDJV11.AXVF80Z934BK@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -fwH3Co40k1AB6kgsddjLxKCghjsCnviURswcEfeGKM_1737723655
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 2249
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/298675d0-ba19-4c87-b00d-57a5e31b05b6%40redhat.com>

On 1/24/25 2:16 PM, Jarkko Sakkinen wrote:
> On Fri Jan 24, 2025 at 10:12 AM EET, Laurent Pinchart wrote:
>> Gitlab as an open-source software project (the community edition) is one
>> thing, but can we please avoid advertising specific proprietary services
>> in the kernel documentation ?
> 
> I don't think we should have any of this in the mainline kernel.
> 
> One angle is that "no regressions rule" applies also to the shenanigans.
> 
> Do we really spend energy on this proprietary crap to the eternity?

This is not getting included into the kernel itself, the contributed code is,
of course, open-source. And yes it would execute just fine on the fully
open-source community-edition GitLab. I don't think "no regressions rule"
should apply here. This is for developers only, and is a template for making
your own pipeline mostly, with pieces which can be reused.

Nick

