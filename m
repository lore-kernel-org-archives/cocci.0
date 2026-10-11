Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC37ACC6B1A
	for <cocci@archiver.kernel.org>; Wed, 14 Oct 2026 14:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KKHjvAionpRnh537vE64rAPf/zZKwgVi1HI9ARBHrww=;
  b=VPWgv/nRQXqYXt6q8ZrkKKqwwrHR1cF1AI0e1vG/G9Ol6f+n86a35iXg
   0e8zLgm2cQCieB5TlSiq7mxVPum6FAVlJi1Wzq/uKYl8i33drbWtr6mov
   d1319avtyY2PjMJwdULSXETULKUMML+2ty8RcJJ0aR4wwz3PIDd22hjum
   A=;
X-CSE-ConnectionGUID: Ku46qhtvT9yhyGGPSIUlHQ==
X-CSE-MsgGUID: KO/e8DFHSXKdD5L3s8VHyQ==
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
X-IronPort-AV: E=Sophos;i="6.27,158,1787004000"; 
   d="scan'208";a="300198198"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Oct 2026 16:19:06 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 5082080E5A; Wed, 14 Oct 2026 16:19:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 97580812FE
	for <cocci@sympa.inria.fr>; Sun, 11 Oct 2026 19:28:42 +0200 (CEST)
X-CSE-ConnectionGUID: 5OijCWJLQMWR4ue7gO50AQ==
X-CSE-MsgGUID: p24Wt2xrT++MwQXlt4vJUQ==
IronPort-SDR: 6acbc749_2wa2cKp9/jzS/fM4CzhrdOI4w2AC27QOg3w5umhsEsu0zwl
 r0yDsh5OA17Rh3c2UGgEB+e8MXX18P/qylEYEUQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EDAQBUxstqfDPdVdFaHQEBAQEJARIBBQUBgXwIAQsBA?=
 =?us-ascii?q?YFsU4ELYTMEVASMb4c3giSLeYdShHGECYFVgT89Ag8BAwELAQFECwIEAQEBA?=
 =?us-ascii?q?gQ4gRIBgzMCjhMCHgcBBDAJDgECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECA?=
 =?us-ascii?q?QECBAMBAQEBAhABATsHDhIphk8NSQEBAYk7AQYBCAGCAgGBJGECBQM7AQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINH18BAQECAToGA?=
 =?us-ascii?q?RsdAQMBCwYFRiACEQEFARwGARKDA4IiAQYQAQMQJwMBELJJi3CBFwUCFoEBg?=
 =?us-ascii?q?g0G2msKGSgNcgOBaAIBBgkBCwGBNwGEeCpPDoI/AR8BhXk7g0d6J4IohEA+g?=
 =?us-ascii?q?h8rghKGLASCIoEMlhgBBwcxCAEJEwYIAgJICwoSAwQDBAQBAgsTCQMDAg4CC?=
 =?us-ascii?q?AMCCAYZAT8MBgQTAggDBgQLBwUfCgIIBBQKKCIEDisKAyoLEg8DGBUBCAYCA?=
 =?us-ascii?q?gQEAgQCCgIJAgIFAwQCBA0DBAEBCAICAyoDAQMGEwgJCAILBREWAgwEBwcxA?=
 =?us-ascii?q?xAJAwIdAxQRBQgRNAUCAQYWARoGBQYLASARBRQBBQwRAQIbAh8EHQEQCAMBF?=
 =?us-ascii?q?AQCAQcCAwQWBAIUCh8CAwMGAgEKCQIFAxsYBAECAgMCAQIIAwcIAwgFAwQCA?=
 =?us-ascii?q?wMDBAECAgEBAQIDAQMDBAQDAgEDBwICAwMDCwECAwMFAwMFBQICBQUDBQICC?=
 =?us-ascii?q?gIDAwMCAQMCGggDBgMSARADAwYBAwcDBwIEAwkCCAMDCAgDFwMDBQECAgQDA?=
 =?us-ascii?q?wgIBAMDBAICAwwFAwIDAwUDAwcCBAIEAwMBBQECBwIDBwIBGAMCBAgHBwUCC?=
 =?us-ascii?q?wQCCAQNBwIEAgQCAg8EBgMDBwEBAgEHBQYDAgIQAQgKBQYCAgIcAx0BAgENB?=
 =?us-ascii?q?gEJBQIBBQ4HBQICGAMGAQEDBgUBAwEKCwEBAgECCgECBAIFAwMBAwIDAgYDA?=
 =?us-ascii?q?wIFBQUDCQcFDgkBAwMGBQICAwIDAQIIBAYFAwICAwUBAwMEAwoDAggDAwgDD?=
 =?us-ascii?q?AIaAgUDAwMGCQMHBwIDBwMCBQIHBQMDBQMGAQMCAQMDCAsVIgMBBQMDAgEDA?=
 =?us-ascii?q?gUDAxgCAgQFAwMDAwMIBAICAQcGBAICAgEFBQUEBQYCBAMIAQEFAwMKDQECB?=
 =?us-ascii?q?wwDDAYDBwMDBAQDAgUKAgQBBwMDBAMHCQcDAgMHAQELBAEDAwoDAwUCAQEHB?=
 =?us-ascii?q?QMGAwcCAwMDBQQFAwILAwcCAgMDAwInAQEBAwMDAwMEAwEDAQMDBwMFAwIOA?=
 =?us-ascii?q?ggBCgMCBgMHBgMFAwMCAQIDAwURAwYEBQYXAgYRMgEIAgMDARQEBAUCBRUCC?=
 =?us-ascii?q?AEDBQMDAwMCBQMBBQEBAwMFAwMDAwMDBAEDBAIDBwYIAQEBAggDAwIFAwMDB?=
 =?us-ascii?q?AMDAgENBAIFAwYCAgQCBAEHAwECAgMDAwMBAgQEAgcEBQIMAwQCAwMFAgMCA?=
 =?us-ascii?q?wsGAgsEAgMDAwMDDQECCwYDFAUJBAgFAw8FAQUHBwkBAwgFAwYDCwMUAwMGA?=
 =?us-ascii?q?wMDCgQCBQEGEAwNAQQBAgQJAwICBAIPFQQEAwcBAQ0LAQEEDwkIBwwBPAwHC?=
 =?us-ascii?q?iQEBAwqARUUBSkZZwcHkRIeg28sLyGBLTWBHAGjaIxjlCY0MwoGAYJJgQpOg?=
 =?us-ascii?q?WaKPIhhhl2FfE0TA5c9kxwuh2aQdCOLbYF6hAmSR4Q+AgoHBxEkEoEyOoFcM?=
 =?us-ascii?q?xojgW6BSRIBPQMZD44iPoNEhRPHCEI1AgEBOQIHAgcOAwuFZ4E6YYJRhVWBd?=
 =?us-ascii?q?IFMAQE?=
IronPort-PHdr: A9a23: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
 JV7G3c=
IronPort-Data: A9a23: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
 J8ve1aw3g==
IronPort-HdrOrdr: A9a23:lrRpKK3D9YLofWzTT+7S2wqjBFckLtp133Aq2lEZdPUMSL3jqy
 iv9M5rsSMc+wxhJU3I+OrwSZVoLkmsjaKdjbNhX4tKPzOWyFdATrsSlrcKqgeIc0aVm4Izu8
 YBAstD4bbLfD9HZLPBkXCF+qEbsb+6Gc6T9ILjJjxWPH1XgulbnnhE49GgYz5LbRgDDZQwD5
 rZ7tZbpjamZHQcZtm6AH5AROTYu9jXjvvdEGw7Lg9i7BORyTCl7LO/FBSHxBITTi5C2t4ZgB
 34eiLCl9uej80=
X-Talos-CUID: 9a23:XHBFcmNvU88/2e5DBQ5m9mUrOOQcV0LnkGrdfECfVD5AcejA
X-Talos-MUID: 9a23:i37TvgkpS77y7zYjyMP0dnp6bptX//6+EnxO0rAZgvmAKXBuGQqk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,152,1787004000"; 
   d="scan'208";a="159477418"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEl6PHxAoM8W8GfO1rUd3kaH4rBGEe9qt5jQA?=
 =?us-ascii?q?ZhsAMtIkfvlucyNtg/PAGyOyWayIxHY6Ky0ulkEhae99jT0hNnZ7pIIP?=
 =?us-ascii?q?0cueRcQr4NxlsQuiukCGwF/MtY7b3MlKLofehGfmm4BhL052s0uvniyt?=
 =?us-ascii?q?K2NXWmeP4Wmf2Q+F9V08n1cA=3D=3D?=
Received: from mail-wr1-f51.google.com ([209.85.221.51])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 19:28:42 +0200
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48b001cd92bso666488f8f.2
        for <cocci@inria.fr>; Sun, 11 Oct 2026 10:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791739721; x=1792344521;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KKHjvAionpRnh537vE64rAPf/zZKwgVi1HI9ARBHrww=;
        b=PqFdwARXAO5QFdQAwmLWhi/NdN+dyW3a74zZ7XTJGXazIsHTvObvXQ+K1X2iHfCpep
         L1R/UGFQsTVHQQehDh0xzljef9GeH4knFyYu87SfLGePIfKU0OHjF3Lhdz7Sw7/tdITM
         iluuIF6KhcZ1BllSK2na8Gw2o9DkzRAd4i6YDAPENvjgFKbFMXWFBHmTyU7S9pYEXm5w
         J8Z6oXd9frCFoI5KsvFZTD4nVh1uU7BcExSNZa1NvaZnhxLMrTFt/53wi2Boid2SQul7
         cFRiDY5sqDLXL2CJSzwidPJ3AyZ+vWaegs9270sa+QDPFmkF1jyNCDUf/9nP/5+ihO7Z
         lBpg==
X-Forwarded-Encrypted: i=1; AKwUvBx10YEPlK+nbODkvVWH8tG7RoFsA+j8dVpzqWXd/RohvnsoS5ZDLb7Fpn4aWoQs8m8gfL1Xhw==@inria.fr
X-Gm-Message-State: AFq9FYLw8Rzt+pJRXN0wyVpVzpun2B13QkJY/5dI+Za1lxgNAMRlroFP
	oFq0jTRYGg9PpqmdNi3Xg+34uf+ZLblpbkuwD/YGJJSlpFKP6cP1XbY15OPoVA==
X-Gm-Gg: AYBFou0U2SDq7dsxZi2coAlCv33XVL7BQX+HOzWQ5KJXwPTRbBQxhi9GSMugGhDCfam
	cukyVF30so2zOfdwVRxMwAAPI49HWhLAed2o1kY61+/gVWKEwKQbFkpzWeUDhtxRzl/9S43IHqA
	21dBF61JAKDzz1EtEnNGcXWJ5hZ3ORzC37tCBpKd9fm5rUAVCMPy3A/mBl7Ef76JMZrN4H5Xkep
	vHFf8/JjFqcrDWWu3Ukkl/a/bNpyD6eVe5cLMi8bJINQMN0opBeYu4Ao2r06RGA1MQcTBPv4VGc
	bHJ6lVW0GdOaez9HW+EMoaBdcLAV2FI5iWjvTV8e5vUQXrJd88AIfBKbzMUHORZhBzj+z0bOgQ8
	q/0df0I8oVp50U+bgUD8Pv+ZWX/i/hHGXLd+bYTgc92K75LyqE1rp7gzOQq7YSDd+rxRwCspUT6
	n5jrBHzy2LEZ56O2YhllZeHGYTPtqxUIO5StZRt3JbdevXcd58aWXz6fRE43BPOpoAOx4AsKBdT
	CaFNOVAtK7oFwMzJ9OxWqZsSP4df0yGsoW0VIM4tBAeaAa1hjMxOzQK2FNtY2hXxUmcEWkSFwHc
	850Q0Y+5hXWTiSCndCjMPKuQu7ivaGcqAnaRP08ymMG2CB/Z7mbmp1HzXt3B+b4R5zVomzDFk1x
	WnoUzP0jyawxNy0jFOp5Y0Fe8q1SBM3M=
X-Received: by 2002:a05:6000:2c05:b0:48b:118e:7454 with SMTP id ffacd0b85a97d-48dbaaed0fbmr12464725f8f.31.1791739720893;
        Sun, 11 Oct 2026 10:28:40 -0700 (PDT)
Received: from systembl0wer ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db99b800asm14739092f8f.22.2026.10.11.10.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 10:28:40 -0700 (PDT)
Date: Sun, 11 Oct 2026 19:28:38 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>
Cc: linux-kernel@vger.kernel.org, cocci@inria.fr
Message-ID: <20261011192838.4f9a8b44@systembl0wer>
In-Reply-To: <20260916095616.1394-1-joshua.crofts1@gmail.com>
References: <20260916095616.1394-1-joshua.crofts1@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3] coccinelle: api: add a checker for
 pm_runtime_use_autosuspend() usage
Reply-To: Joshua Crofts <joshua.crofts1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3750
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-10/sobzks1c11pSI5_8VA0MzQ>

On Wed, 16 Sep 2026 09:56:16 +0000
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Add a checker for ensuring that pm_runtime_dont_use_autosuspend() is
> called in a file if pm_runtime_use_autosuspend() is called and its
> devm_* counterpart isn't present.
> 
> Assisted-by: LLM
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
> Running this in drivers/ yields 195 results, due to
> pm_runtime_dont_use_autosuspend() not being documented well enough.
> 
> Changes in v3:
> - Remove note about resource leak from commit message
> - Link to v2: https://lore.kernel.org/lkml/20260915064327.1377-1-joshua.crofts1@gmail.com/
> 
> Changes in v2:
> - Send correct version
> - Remove unnecessary position variable
> - Remove metavariable
> - Link to v1: https://lore.kernel.org/lkml/20260914151145.1328-1-joshua.crofts1@gmail.com/

Hi, you can drop this patch. I have a patch merged that removes the
need for calling dont_use_autosuspend() on unbind.

https://lore.kernel.org/all/20260919-move-dont-use-autosuspend-v1-1-f6e2d1315c23@gmail.com/

Thanks.

-- 
Kind regards,
Joshua Crofts
