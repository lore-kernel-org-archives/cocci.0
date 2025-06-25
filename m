Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2F4C7EE30
	for <cocci@archiver.kernel.org>; Sun, 29 Jun 2025 17:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=B67rHsFr19xU9s8nReIrueUnM5/Uc47BkGn2WCCBaFg=;
  b=CPr9w9/u/SoXz3Oy+B4pZ04AA7v5bW9F5zcCJ9BGdx/WbUdJyH9BkMLm
   aX9r3uIubhjLv61qQ1w2FkfGNHbcW+41PAPgIAkaztsQnJ1NcCoFz4u7h
   Weuhz/Nbvi2k7Zk2PUTgcIZiT3p1L6bXR4eVALUTcmObFLHwxhweBQ0gj
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@suse.com
X-IronPort-AV: E=Sophos;i="6.16,275,1744063200"; 
   d="scan'208";a="229472163"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2025 19:23:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 337C6E0131; Sun, 29 Jun 2025 19:23:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B952DE0131
	for <cocci@sympa.inria.fr>; Wed, 25 Jun 2025 14:46:06 +0200 (CEST)
IronPort-SDR: 685bef8d_xDAPYcusloiSHft/gD+2Hh7Uf7tDMaxeG+dgc+2ckXYLUTp
 432oe2VmvBur75YhEwUJgRztWOvW/6D4L+ptj5Q==
X-IPAS-Result: =?us-ascii?q?A0HtAwAc7ltogSqAVdFagQmDRVKBAFozBFSIJIUshlWeZ?=
 =?us-ascii?q?YNSAg8BAwEMATEgBAEBAwEDkHACHgcBBDQTAQIEAQEBAQMCAwEBAQEBARABA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABASIZBw47hXsNgluBLIElAQEBAQEBAQEBAQEBAR0CD?=
 =?us-ascii?q?YEWKAYBATiBEwEFAVeCYAGCIQEGRgMBpBSBBUKLPIE0gQGCDAEBBoEI2xuBZ?=
 =?us-ascii?q?QkJAQqBNYg3GgEFbYh3eicbgUlEgUqCRIF0AYFbBYIqhVUigiaBFoodgnWMC?=
 =?us-ascii?q?0iBAhwDWSwBVRMNCgsHBYFjAzUMCy4VMjwyHYEnhyaERStPhSKBJoNeJG0PB?=
 =?us-ascii?q?oEhLUADCxgNSBEsNxQbRG4HkXWEIwkKAYMikmEfkTKCIJ9WhCWKd4EmlTZNh?=
 =?us-ascii?q?VuRcJEEghEBmQSRV5IKCGiEPgIKBwcRJIFbI4FcMxoIGxU7gmcJRgMZD444J?=
 =?us-ascii?q?4NCh1CyOEE1PAIHCwEBAwmQBYFLAQE?=
IronPort-PHdr: A9a23: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
 fDUibn+bjxF9oCNlSP5L9PJM8/BO30kY0KBJQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:uAUHB68xKkYR6BjN/GJuk+D2I+orL9Y04lQ7vn2ZLiYlCPBw9v
 re58jzsCWftN9/YgBDpTntAtjkfZq+z+8M3WByB8bFYOCOggLBR/AA0WKL+V3d8kbFh4lgPM
 lbAsxDIey1I1w/o8iS2maF+hUbrOVvMprEuQ4T9RlQpHlRGthdBs5CazqmLg==
X-Talos-CUID: 9a23:K1A8m2CwmPQHI3P6EyRqy28yGpE1SD767HiKD0PlI0dgZ4TAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AmnqhKwwhIxAN0HYvhgM+mPnvURiaqKeEMHE0waw?=
 =?us-ascii?q?Dgs+/CwVRBxmcgj/wWoByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,264,1744063200"; 
   d="scan'208";a="119954191"
X-MGA-submission: =?us-ascii?q?MDEbz+9oace3Rx75iRNmwe2rhJTLBmUuFwQEq9?=
 =?us-ascii?q?Ze3Ye0jNZshQAfshBiB8mdxLvgpfU3Gea283eP8+8xzEU8IauN0JI7eO?=
 =?us-ascii?q?g2sT0G7jQXPNlRM583/NhFFUs4UE2nwtE4lh/1Ks5kvm6n24BVZyWcmh?=
 =?us-ascii?q?3v48sptzPrgRslM47UuTVDIg=3D=3D?=
Received: from mail-wm1-f42.google.com ([209.85.128.42])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 14:46:05 +0200
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4530e6f4db4so2812175e9.2
        for <cocci@inria.fr>; Wed, 25 Jun 2025 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750855564; x=1751460364; darn=inria.fr;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B67rHsFr19xU9s8nReIrueUnM5/Uc47BkGn2WCCBaFg=;
        b=aQAPceFOtFhxFP/dsa/RkfeIl9rAacHKYLkdruact8NgpTG4AtVuVnFYg7fgPk7Y4X
         19NOhL/6yMyZRrr2oh+8geRpWoQBHscJsX11xIcQSR0apf9Gtw3DWOuPKhcWfhNT2954
         l43LBsMvZIGVaaD6PuhVcaZRGAtdn8uontr1HPr3U6le/XaVDstXp05LuXEvxh85bMEx
         yBmQS0el2ySMnZoalm3RDiVWd97NG/2112lETQGl9FLPo5pvIbguybm7FZPhB5oV27C2
         kkPMjmZUXTh0xKv9Mjv0YtupnjB3l4fnD8wUVJcKIeZ5fV9Av34GMDlC6iUdM2Ny/QuN
         kImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855564; x=1751460364;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B67rHsFr19xU9s8nReIrueUnM5/Uc47BkGn2WCCBaFg=;
        b=Sj9XPGPG8Y1nSrckGNr9J9YR4JTIV9sa+tikacEM1rYlJ6l9v1DYInvdTUaEZXoZR7
         zeE7b0gqovoeg8NzM5TrKo5fCkP6LnsN/++4JOEFUfSd1HR4khbJxWEWkMDo8xH0KZ2q
         BK4Otx6gLDL2NKbDzyLwVSvmds8fhTlitT28guK49r8JRRFB83N618uHQOiI04Xftubs
         2PQatHhHToG9ek2iWFHv2usgzWWuwyO11MsULu8IggL6vpI7dFlr6NCmDzI9JYyfijRY
         ZSU54TL209OwQ7PpiSf00EgUKGrsPXzqB+0XF/HU1Vcds37KF9oGhiGR69xRn+n7KKJb
         K7Tg==
X-Gm-Message-State: AOJu0Yw3jNhlMSXwTyLop0MWubwSY0ojCPWACTCkwOqQ8V5g83P8caXL
	pScuFkeaYF26z0N9aVHi+fGps1qiu/rETzV2koGmWWc7y6VO0EAtMg99PrbV+SRbm2P7U3IceeW
	lPif1
X-Gm-Gg: ASbGncuTAtZPZufcJ6yKDlSykkVzI/gJB58QGMIgxj/owQT+SUakppVtKlKcg3JkqPA
	K9n8GxhCt4QuBc3RII1vbDEAjk4HfyoAFtMbArclToc9E2yADrneD78heAAgFSfzNCn+Z4Lnqzh
	IOxppa3Xk8xSB1S1rEEbsr9fQjGc71ey8vuYSTfulSYK76UsNAqxlLjXSfzTo+dIRlof+hV6lhh
	dOSW2JNOSZmjksWoTFuIOdKBqNVJDXFtPHR2E31SiDGhhwMjrlQnESHhVGEL1nzLvGdcu/nOitN
	BrrqZX9zlvzimnHwt+g8hcfGOuIii9i0VjyelTL2QjVuqIPDA5KRW7yG5dCsqjfywOQuzvLnsJh
	/VI4BDrNOPp8QAaG8EdyRFfIxfXhkwDs1up8pKK4vC7HASbR5qrol6m6hRQaBuKUrJ20jqRGDk1
	5ZMw==
X-Google-Smtp-Source: AGHT+IEkCZYbSSXKmQfjT0Z7uLDf3yRcxqV4VAVO3xTXYpv+fcq7klP+x7WSiZu3xCrVi1PNza8JDw==
X-Received: by 2002:a05:600c:1d87:b0:451:df07:f41e with SMTP id 5b1f17b1804b1-45381ac3e2fmr11016995e9.1.1750855563460;
        Wed, 25 Jun 2025 05:46:03 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e810b140sm4512668f8f.80.2025.06.25.05.46.02
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:46:03 -0700 (PDT)
Date: Wed, 25 Jun 2025 14:45:59 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: cocci@inria.fr
Message-ID: <20250625144559.11c4ad02@mordecai.tesarici.cz>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [BUG] Failed assertion triggered by Linux kernel file
 include/trace/events/mmflags.h
Reply-To: Petr Tesarik <ptesarik@suse.com>
X-Loop: cocci@inria.fr
X-Sequence: 2816
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/20250625144559.11c4ad02%40mordecai.tesarici.cz>

Hello,

using coccinelle 1.3.0, I've run into a parser failure on linux master
branch:

EXN: File "parsing_c/parse_c.ml", line 523, characters 6-12: Assertion
failed in include/trace/events/mmflags.h
An error occurred when attempting to transform some files.

That's a failed assert() in lexer_function here:

      let x = List.hd tr.rest_clean  in
      tr.rest_clean <- List.tl tr.rest_clean;
      assert (x = v);

And it is somehow triggered by this macro:

#define ZONE_TYPE                                               \
        IFDEF_ZONE_DMA(         EM (ZONE_DMA,    "DMA"))        \
        IFDEF_ZONE_DMA32(       EM (ZONE_DMA32,  "DMA32"))      \
                                EM (ZONE_NORMAL, "Normal")      \
        IFDEF_ZONE_HIGHMEM(     EM (ZONE_HIGHMEM,"HighMem"))    \
                                EMe(ZONE_MOVABLE,"Movable")

It works fine if I reduce it to this:

#define ZONE_TYPE						\
				EM (ZONE_DMA, "DMA")		\
				EM (ZONE_DMA32, "DMA32")	\
				EM (ZONE_NORMAL, "Normal")	\
				EM (ZONE_HIGHMEM, "HighMem")	\
				EMe(ZONE_MOVABLE,"Movable")

But it doesn't work if I break the indentation, e.g. like this:

#define ZONE_TYPE						\
			EM (ZONE_DMA,	 "DMA")	\
		EM (ZONE_DMA32,	 "DMA32")	\
				EM (ZONE_NORMAL, "Normal")	\
		EM (ZONE_HIGHMEM,"HighMem")	\
				EMe(ZONE_MOVABLE,"Movable")

I'm willing to help with further debugging, but keep in mind that my
OCaml-foo is nil.

Petr T
