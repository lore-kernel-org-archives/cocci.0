Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5401C28B2F
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 13:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EIvZ3Wp+90RhosIdCp8kn3gSMcgQFE9Tp7I7nCfwJ0E=;
  b=nNAsJNBZG5JSVrHayYUgB5tpTzO+pct1Lsn935atDeZAXg8kVdOJTmVr
   Kd4TC+oyTncew+leHMiMx4YHGT0RxtF7Yg8qXehMXXAJZo3eLpolcEcUk
   t07huKxPlYhVajQDNqIsxRxu7YUiaYEf6sORkw7JhKurqIGF/MAp4cCJI
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213497942"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 14:45:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D3921E0D20; Tue, 18 Mar 2025 14:45:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A0DB2E0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 13:03:41 +0100 (CET)
IronPort-SDR: 67d9611e_BwhT7XPCkncQDtc4A2oogT7js7qIUFV9WJ5xOWCW2Di8RYk
 D07ELZ9+tqa2HH+JSrjbTSjP9fDa6VMpq6neWlQ==
X-IPAS-Result: =?us-ascii?q?A0FBAACoYNlnfDDdVdE9HRwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE/BwEBCwGCQ4FXMwRThFaIHYVBgXKBdDCYOIVcgX4PAQMBCwEBQgIEAQEDB?=
 =?us-ascii?q?IIMgnQCix8CHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAQEiGQcOEimFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQINfQEBAQEDEhEPA?=
 =?us-ascii?q?Q0BATcBDwsUAQMCAiYCAjMBBQEcBhMigWF/gmUBAgegXYEFQopEeoEygQGCD?=
 =?us-ascii?q?AEBBtwggWUJCQEKgQYuAYVsgmMBhWyEdycPgVVEgTyDAz6IHoJpgjOBaQGDQ?=
 =?us-ascii?q?Jl7kBxSexwDWSwBVRMXCwcFYUhDA4EPI4EiBTQKKg44KYFjaUk6Ag0CNYIbf?=
 =?us-ascii?q?IIoagQFgSSCN4Q+hEGFUIIRgV0DAyIBgjBvdRyEPj6EZC1QgU0dQAIBC209N?=
 =?us-ascii?q?wkLG6NSOoRFUoEHJoIEkw2SMIE7nx00B4QegV0GDJ9eBhMvl0YMkwUuh2U1k?=
 =?us-ascii?q?DapCQIKBwYRI4FEOoFcTTCDKk8DGQ+OITiIVbFjQDU8AgcBCgEBAwmFQyYTi?=
 =?us-ascii?q?iCBSwEB?=
IronPort-PHdr: A9a23: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
 Edetw==
IronPort-Data: A9a23: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
 E4bjFdhL4xbNrL/dEfpVx8UbXdINM+2
IronPort-HdrOrdr: A9a23:D1uUEKg7lILvHEc+vdMtpilZm3BQXiEji2hC6mlwRA09TyVXrb
 HJoB0+726JtN93YgBepTngAtj8fZq4z/RICOYqTNKftWXdyQ+VxcRZnPXfKl7balfDH4xmpN
 9dmsFFYbWafDpHZITBkXKF+r4bsbq6GcuT9J7jJhlWPGZXQpAlwAFjFA6BH0F6ACVAD4EoDY
 eR66N8ywaISDA4aoCUCBA+MdQrZOelqHslW3M77tIciTVmRAnJ1ILH
X-Talos-CUID: 9a23:/XcAF23xBnJB1A5I57q5rrxfQP8DeCSN4GzsCEa5O0dOdZuwUlO69/Yx
X-Talos-MUID: 9a23:dH7Z8QpbWt9/0bfr0OgezyBTF+pBsvv3MW8AibEapNm6CX1CAh7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213469461"
X-MGA-submission: =?us-ascii?q?MDFhv3gPWKm0DpxpQVtDsJq0WFPRwp2DL7yzMy?=
 =?us-ascii?q?7cssmIhmOlAUl/H42sVtu6I7H50/LNL0+egPlFe/oz+8pJChBtQEqSvw?=
 =?us-ascii?q?Vuiy/euhI+hXN2Ufi29xxV7TqrBEm4vW8TixgDZRxCE6fTeFgZG3FRvZ?=
 =?us-ascii?q?/8jAgGap1fXNOrhf7S+z3Qqw=3D=3D?=
Received: from mail-wr1-f48.google.com ([209.85.221.48])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:03:41 +0100
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913958ebf2so4462206f8f.3
        for <cocci@inria.fr>; Tue, 18 Mar 2025 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742299421; x=1742904221; darn=inria.fr;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EIvZ3Wp+90RhosIdCp8kn3gSMcgQFE9Tp7I7nCfwJ0E=;
        b=vqxCCtavWHcPPybl5undk7y46xT90oYfydEs3lnwMEhWzdClbsAmLN73gU6+2LKJOM
         1cSU5fOpzumOF3m525CXqenRjyxz+JZYhKg4Hh4atkegoET2Ri2MlN2gH9UTvO4dSXFM
         PNkQjAB7mxjTAf/gh6z/UdgQpEzQcl2a8TLhpHTi7jnMSJDiWOG6HyYRi9ftq4KSKPKQ
         gaoebfHYGoanCURp48K2oct/9PW7VgtELn+y8dx5Qs11o6ijuuCkPMEs/EexpKYDTeTW
         jrgW/jVByKYimRBqikOen+HASoMAoVga586QWbrhjchGi7TaU3slZEdNxpiRFh9g8918
         13NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299421; x=1742904221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIvZ3Wp+90RhosIdCp8kn3gSMcgQFE9Tp7I7nCfwJ0E=;
        b=Estc+loHv+NENVfdD/pXFkeFt5R9drYIfFQWQLLn5xyBmG/noY7OZKBZq6xCn4GvBa
         aHXoyrS4AmSiCNw0UzL2y8a30bLfBZiRfzFMicOL5mQwLwxtEjzVDKj2vq5PwNGRN0M8
         6E7vi4lvMDkogWgbLZ+n5Kb8QDPfRdqtNciOxbdppb+VgGK3tj9uSshLcv/6qFDc7yx1
         O4XZ6kUazW+VcnVyWuGwYCV047l+w30MWlgD5sDd+z46c7XMam4ET/jBdt4QwxNmBapn
         ht9lt16T8Cw6bbQOFixXnweK8KvRO2X6xqKBJVk7jGwzdZ+C9DyW1HlumkN4FMmvGEeV
         IuTw==
X-Forwarded-Encrypted: i=1; AJvYcCUt+E+w5dCORmueVEYo1dKO9P6fdRZL1b9AiSAlTyP/Owbipidl2iVkVZOxEjpWtjOlGZn2JA==@inria.fr
X-Gm-Message-State: AOJu0Yx+7IoUR7AbA63ePFreKRaQsy3O6GQ4PRlvU7rUE5ySs46RGcVE
	o1K5keST6NTCXcHGFA4mjtEXES6SKEa1Muu7rELt0RmjmO/b2d9Uy2bkG8CMGvM=
X-Gm-Gg: ASbGnctVu01HsT/9kNzte2qRHSF1MYOhUsUao21z5YcN2iJ6JzWUEV26E+/UuL3SGPI
	aWHhmNHzLNc0uVcULaTXi6r1wbfzydmFR9H+cXdDX0gG92kU8bhVkfcPfnwDBabkgCNizoK7Ni2
	loWgyqO82/2r1r5t9ermVtHS2ccIw0zpO5qVElhz17JA7R4ysz6Lhvt/Gy6z/9CR3ClKGTuac1E
	eMCZUiSJ0vW4QGMhO4Eo8htoyl9U0oVfVw1whPQmEZhhMDCK5ys1ovj3UNXXmjdu2d99fTA27C8
	kV7QFR4+5gtrG0VPQ2t+8FQZO9ZqWjWw1cUsVhSKLkgCg7gXZA==
X-Google-Smtp-Source: AGHT+IFpsBv5twsMP6fmrTzI785OG9MT2p6MsEQHUu8xAsUGZO1uS02mqQn/S4PSHW3veon64U20Lw==
X-Received: by 2002:a5d:588c:0:b0:390:fbdd:994d with SMTP id ffacd0b85a97d-3996b47cab3mr2750146f8f.27.1742299420841;
        Tue, 18 Mar 2025 05:03:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395c8e43244sm18330917f8f.60.2025.03.18.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 05:03:40 -0700 (PDT)
Date: Tue, 18 Mar 2025 15:03:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <7eee35fe-0d88-4f38-b381-1ea2ee4a4715@stanley.mountain>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <3675f707-bff0-3caf-29a2-b99e5b9c6554@web.de>
 <d7b2c8ac-e052-4b93-964b-4cc58a459ba0@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7b2c8ac-e052-4b93-964b-4cc58a459ba0@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] mtd: cfi_cmdset_0001: Fix exception
 handling in cfi_intelext_setup()
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2621
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/7eee35fe-0d88-4f38-b381-1ea2ee4a4715%40stanley.mountain>

On Tue, Mar 04, 2025 at 08:21:53PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 21 Mar 2023 20:13:51 +0100
> 
> The label “setup_err” was used to jump to another pointer check despite of
> the detail in the implementation of the function “cfi_intelext_setup”
> that it was determined already that a corresponding variable contained
> a null pointer because of a failed memory allocation.
> 
> * Thus use more appropriate labels instead.
> 
> * Delete a redundant check.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Don't use a Fixes tag for cleanups.

regards,
dan carpenter

