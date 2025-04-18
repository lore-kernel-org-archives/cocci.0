Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705B8C369CB
	for <cocci@archiver.kernel.org>; Wed, 23 Apr 2025 08:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nNA/SBMGz5nzByA9wBccTGH5/3WLOHOzBct3Skuv3xA=;
  b=ad+iQawMdo+4DA6R4NfimmZSsNX9PhOrRO2C7xKwZgkOdfwujM72wOcT
   lxsFrwHtRLZN6V4V6duAZuVyOtQxCWwDwOX99N9Clc8vTS5mit0ti79A1
   udqMAmSNWAmj+NyqBr7JdFmTehdpYGCsANWzJxK3UMKSEhtPUvzXjO7rt
   Q=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.15,233,1739833200"; 
   d="scan'208";a="219056497"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Apr 2025 10:51:38 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8FE32E0D67; Wed, 23 Apr 2025 10:51:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CCF3EE0261
	for <cocci@sympa.inria.fr>; Fri, 18 Apr 2025 19:12:06 +0200 (CEST)
IronPort-SDR: 680287e5_RYv9XFUw7f95SfhzHbT6CkeusmY1fdcCme7ryz2I1Ujjqqb
 I96Arud7YmztC+OqQO1GYTPYI+f1Z5QrBlsPm+Q==
X-IPAS-Result: =?us-ascii?q?A0EDAACqhgJofKrWVdFaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAQGCQoFXMwRTjHGHNIIEIIV6hXyGcosqgUA+D?=
 =?us-ascii?q?wEDAQsBAUICBAEBAwSFAAKLKwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABASIZBw4SKYV7DUkBEAGCBwGBJGECBQM7AQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQIsXgEBAQECARIoBgEbH?=
 =?us-ascii?q?QEDAQsGBQ4KLhASEQEFARwGEyKFEAEDDiMDpTSBBUKKRHiBFwUCFoEBgg0G2?=
 =?us-ascii?q?l0KGSgNbAOBYgIHCQEKgTUBhHUpTg6COB0BhWwbg2J6Jw+BVUSCUIFvPosHB?=
 =?us-ascii?q?IItRVKDLYElgQuBc4Q/gVWDXYJugXuCP4h+CAcxCQkTBgoCSwsKEgMEAwQEA?=
 =?us-ascii?q?QILEwkDAwIOAggDAggGGQE/DAYEHRgMHwoICAQRCigDIgQOKwoDWzUIBgICB?=
 =?us-ascii?q?AQCBAIKAgkCAggHAhEDBAEBCAICAysGAwYbCgIIAg0FEwoBBQQDBwUCGwMDA?=
 =?us-ascii?q?gIFCwIIBQIFBwMJDgECBQMEFQIQAgICCBUCAgIFHAMkAwMDAwsBAgIOCQYYD?=
 =?us-ascii?q?wQCAwMCDgECAgkBAgEDAwgDAwkIBwEKCQECCgYCCRABAgIQAwICAgIGBw4DA?=
 =?us-ascii?q?hMPBQYGAgoHDQsCEgIDCQYDBQoDBwQKDQIVAhUFHwECCAkOEQIFEgMOBQMCA?=
 =?us-ascii?q?hEEAgMDBQMBBwEVAwcIAgIMAgICAgUCBQIFFxENBAMDAwIIAQQVBgMJCCUbE?=
 =?us-ascii?q?AEBAwEJAwIDBAgDAwMCBgwLAgEHCAMDBgsICQYDAgcIGQMFBAMHBQshAgYDA?=
 =?us-ascii?q?gQFBAEFAhMNAgMZAgYDBhEJDQYIBwkDBwEBAQICAggBBgUSAgMEAgUEBAEBC?=
 =?us-ascii?q?AMDBAYCAQMCAgQJAQEBAgoCCAoBCRMEAwgDAwMDAwUCAggEEQUFAgEFChMMC?=
 =?us-ascii?q?gYDBgMEAgICCwcCAwMDBwELHAIBAwICBQICAQUDAgIGBAMCAQEJAgMCCAECA?=
 =?us-ascii?q?gECAgIEAQcBBAcGAQECBAICMgIBAwkCBQEBDgICBAICAQICAgQCBAECBgsEB?=
 =?us-ascii?q?Q0BAQIBAgIBAQEEAQgDAQECAgMDBQMFAwgPDQEBFQsdAwQFAgIBAQEBAhICA?=
 =?us-ascii?q?gEHAQIBAQMaAgEDAwQBCwIBAQQeBBYCAgICAgQDAgIDAgILEyUBAgMFAxMCA?=
 =?us-ascii?q?gQCAQICBQUFAQMEERAJAwIFBAICBgIEBgoCBwQCGgQCAgIBAwQGAwECCAICB?=
 =?us-ascii?q?wQEBgMCAgECAgcZAhkBAwEBAgICBAICAgkKBAUEBAQDAgICAQwDAQIDAgICA?=
 =?us-ascii?q?gEDAgIBAQMBBQYNAhICAQMPCAQCAgcCAiEPCwECAQECBgYCAwMDCgMBCgECA?=
 =?us-ascii?q?QECBgIBAhIFAgIBAgQBAgIDBCUBAgECAQEBBQIBAgECBAIHAgECAgsBBQIGA?=
 =?us-ascii?q?QICCQECAQICAgECAQECBgIBFQECAgICAgMBAwYCAgICAgIJAgICAgUCBQMCA?=
 =?us-ascii?q?wEGAgIFAgMDAgIDBAMJAwMIAwYEAgMBAQECAQICAgECAgECAgUCAwkBAQMCA?=
 =?us-ascii?q?QICAgIDBgIFBQEDCwUEBwEBAgEDBQMDBAMGAQwEAwICBAICAgICAgQCAgEFA?=
 =?us-ascii?q?wMCAgUBBQMIAQIEAgEDAwMEBAMBAgIKBwUCBAEBAQECAQICCgMCBQEBAwMBE?=
 =?us-ascii?q?gMEAQYFBQYCBwkDAgIEAgMCBAMJBAIGAwMCAgIBAQsCAgECAgEBAwMHBhABA?=
 =?us-ascii?q?gICAgEPAgMDAwMDDwYDBQ0dAgkDIw8DFAgTPQwHMgQ2ARQUBwYlgQCXZoQXg?=
 =?us-ascii?q?Q6DI5YUmnmUXzQHhB6BXgYMoDmXMwyTBS6YUKNWDYUnAgoHBxEjEoEyOoFcM?=
 =?us-ascii?q?xojgzdPAxkPjiEMFoNYwxInNTwCBwsBAQMJhUMmE4UkhHyBSwEB?=
IronPort-PHdr: A9a23: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
 EZetw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:LN8saK32qMRh+mFVKVgAQQqjBHckLtp133Aq2lEZdPWaSL3/qy
 mLpoVm6faUskdtZJhEo7q90ca7MBbhHPJOkO0s1PKZLXbbUQiTXftfBOnZskXd8kTFn4Y3pM
 VdmupFeabN5DBB/KXHCWKDYq8dKbe8gceVrNab4HF3UwlwZq1sqyt/AB2KC1B7SWB9aaYRJd
 6z4o5oqVObF0j/rf7VOpDGZYX+ThHw9a4OqCRnOyIa
X-Talos-CUID: 9a23:7NdpVG/FciqkNnHk4vmVvx43QPI7W22N8F3RKlCyNXtDYr++RGbFrQ==
X-Talos-MUID: 9a23:C5gccwaTq9jtbeBTmGDClC85DcVU/+f/JltVoYwJsMe6DHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,222,1739833200"; 
   d="scan'208";a="114635639"
X-MGA-submission: =?us-ascii?q?MDGk+aovQOmeXq+8Ckaq7JpmxhRTJ/c+mUHA9m?=
 =?us-ascii?q?8LWEyUr+gjE3DLjShY/LymFTrOP3X50pS+/jC4pQ0bupgSjuEAT3Y+gv?=
 =?us-ascii?q?iTqfJRJsC5Y0BZr/jxfLNbCzuJoFL5mANr9GV+HUcVC7XAwpXT7+v6bX?=
 =?us-ascii?q?Ekt5xdmMDBNMIV2PuUuwPbuA=3D=3D?=
Received: from mail-pl1-f170.google.com ([209.85.214.170])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 19:12:05 +0200
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-227cf12df27so18075245ad.0;
        Fri, 18 Apr 2025 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744996323; x=1745601123; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNA/SBMGz5nzByA9wBccTGH5/3WLOHOzBct3Skuv3xA=;
        b=VlkxLrZ6zZgXvhgb1OPNEAb4vsdHIBohrSZQOleh0H+JVTnkm2a16ZnBoflOf+mNzV
         j8lmoGplqipx2Ef7zdaGqpfjOTaqMBz+Ta6O3QMtLR3IyEuYr1SRmMvjGpnzUw+1mqgw
         kQcwS9yMItf0HUSeIharm8DaX58hR3d36k3CjebMNGNLlmXXHEsk6jBuW2qrbikHpboU
         dfUZYgegPiO3hhMXDvnd5HTBlgRa3TjmwnuZ9DrSI9qGsAYOAr/dIpVZlmXiyWMsRhYv
         w24dkkecvp0niDNfJMAoMbeA1jPxV9seqfG47fEdId4/KgyuB9TKj4p1QcZle++ds2j/
         oGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744996323; x=1745601123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNA/SBMGz5nzByA9wBccTGH5/3WLOHOzBct3Skuv3xA=;
        b=NacLU5VFbhwxUWreM89E1dPbenV3DiYmF7JgD6zvf6/nHJwjX/VdAPCInQ2qugR7GU
         T4lbM/11TGQe1DNQdNbpX5LEYarLnqqj2TGG6jGA6ZksYlF+T/DA42yNrXgUGkAjLr0x
         TB3FoneAphBozFSwYp7ZkKDk6UFCHRB0KWRoTP58oGaigCFP0lLln0GBhW08/a81HSWX
         1EHC0dt8gC+YJPnusVXlA8q7x07fxiE3Lo1YQGBnFgMkKIrLW91aWuxUBihIHpL++4qC
         TAGyx/WwPwY9lyMv/EygvtsjeznOXgiBjLkTMPsr797rnuor1N4st3l53DjG2r81quaN
         GAcg==
X-Forwarded-Encrypted: i=1; AJvYcCUVyCgVb8c2FfGnXwrzqOkOU4EDxzxjhb8oyRGF4JOtHDbXBDKh6PaDtUDUU9CdCLLiI9QjWHs=@inria.fr, AJvYcCWAcLCkAODezCFySEk1USa99pxnKKb4bhVJOw3WJ05xAfTSXaGt6dwguJhqlxNr57ijAIeUzNbJTGVJ2LQ=@inria.fr
X-Gm-Message-State: AOJu0Yy9/965OrQ1jsLZAcDhX5kpTfWZSZlhW1Too9rdoaMJF2c0LzuU
	BGfusWgjwawDgJ53o0HZoJ23LSwEX3s1UOlE8JLZiHnkGKaelT4S
X-Gm-Gg: ASbGncs8xM85HC9l7wCYzMd0RlAbbuPXnml9ts11IH51EhckGoFVD5qvAoMQVde5c/g
	R01Ph2K2lgHH3kUj61SGZZ9G4MyE9Bcb/XBtUtmG39NipBGzTdxevXVuY3dLpOZsaNruaTAndqJ
	7o8NnbPaDRix8yhEUrbwraQGvgVKm8MN7jAHeiF5FjA5eXkDlEQVOHqcncnH+JpRve04xrqBMNQ
	os0sSTEPpc+yFtwZqksD3cMF1wHODKfMC/KI5jDCXWVtiYLag6zLhnIw3kPy6NH7n3VVcSEs6T1
	iM6KINOyAoldR7WjjZVUUYChkW/xWflij1FXWMXXKX5ch1OzAzQ=
X-Google-Smtp-Source: AGHT+IHds0YrApaxned7HLyI6jwzPBZIRFd/Zv4gqZcmfhjoAsoH/dxR0Rpg18h6eruL1zhjn94uCQ==
X-Received: by 2002:a17:902:f648:b0:223:5187:a886 with SMTP id d9443c01a7336-22c53f1056amr52473725ad.22.1744996323197;
        Fri, 18 Apr 2025 10:12:03 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4925sm19191665ad.117.2025.04.18.10.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 10:12:02 -0700 (PDT)
Date: Fri, 18 Apr 2025 13:11:59 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org,
	cocci@inria.fr, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, andrew@lunn.ch, quic_kkumarcs@quicinc.com,
	quic_linchen@quicinc.com, quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com, quic_pavir@quicinc.com
Message-ID: <aAKH37xa1brIAXfs@yury>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com>
 <20250417-field_modify-v3-1-6f7992aafcb7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417-field_modify-v3-1-6f7992aafcb7@quicinc.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 1/6] bitfield: Add FIELD_MODIFY() helper
Reply-To: Yury Norov <yury.norov@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2706
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/aAKH37xa1brIAXfs%40yury>

On Thu, Apr 17, 2025 at 06:47:08PM +0800, Luo Jie wrote:
> Add a helper for replacing the contents of bitfield in memory
> with the specified value.
> 
> Even though a helper xxx_replace_bits() is available, it is not
> well documented, and only reports errors at the run time, which
> will not be helpful to catch possible overflow errors due to
> incorrect parameter types used.
> 
> Add the helper FIELD_MODIFY() to the FIELD_XXX family of bitfield
> macros. It is functionally similar as xxx_replace_bits(), and in
> addition adds the compile time type checking.

This paragraph duplicates the above. I'll drop it and take this
patch to bitmap-for-next. Regarding the rest of the series - it's up
to ARM64 and Cocci maintainers if they want them or not.

Thanks for the work!

Thanks,
Yury
 
> FIELD_MODIFY(REG_FIELD_C, &reg, c) is the wrapper of the code below.
> reg &= ~REG_FIELD_C;
> reg |= FIELD_PREP(REG_FIELD_C, c);
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  include/linux/bitfield.h | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 63928f173223..2eaefa76f759 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -8,6 +8,7 @@
>  #define _LINUX_BITFIELD_H
>  
>  #include <linux/build_bug.h>
> +#include <linux/typecheck.h>
>  #include <asm/byteorder.h>
>  
>  /*
> @@ -38,8 +39,7 @@
>   *	  FIELD_PREP(REG_FIELD_D, 0x40);
>   *
>   * Modify:
> - *  reg &= ~REG_FIELD_C;
> - *  reg |= FIELD_PREP(REG_FIELD_C, c);
> + *  FIELD_MODIFY(REG_FIELD_C, &reg, c);
>   */
>  
>  #define __bf_shf(x) (__builtin_ffsll(x) - 1)
> @@ -156,6 +156,23 @@
>  		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
>  	})
>  
> +/**
> + * FIELD_MODIFY() - modify a bitfield element
> + * @_mask: shifted mask defining the field's length and position
> + * @_reg_p: pointer to the memory that should be updated
> + * @_val: value to store in the bitfield
> + *
> + * FIELD_MODIFY() modifies the set of bits in @_reg_p specified by @_mask,
> + * by replacing them with the bitfield value passed in as @_val.
> + */
> +#define FIELD_MODIFY(_mask, _reg_p, _val)				\
> +	({								\
> +		typecheck_pointer(_reg_p);				\
> +		__BF_FIELD_CHECK(_mask, *(_reg_p), _val, "FIELD_MODIFY: ");		\
> +		*(_reg_p) &= ~(_mask);							\
> +		*(_reg_p) |= (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask));	\
> +	})
> +
>  extern void __compiletime_error("value doesn't fit into mask")
>  __field_overflow(void);
>  extern void __compiletime_error("bad bitfield mask")
> 
> -- 
> 2.34.1
