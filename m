Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727E3CCF9FC
	for <cocci@archiver.kernel.org>; Thu, 30 Oct 2025 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=N5oy551G97AvWTlfPjNACgXvTrySxuVW8nynKmQcNfI=;
  b=MhERu2oRQidgPchVHu53OXHGzi7XLyotrYMVXIcEirYfshEqclXlUJxE
   f1PWLwSzHNEtahI3TgxTZLWd6pchOO1nOpS2Um0ym/28iDX/dz2WJ/WOT
   CuX1SrB3+qJ6Y9FkiUnGdd6AcHfBbFHwXMT0p6GafO3aKd5B0PU0KXSmf
   A=;
X-CSE-ConnectionGUID: ag0ioZ8lSwmCpXmVrOKtAA==
X-CSE-MsgGUID: Rl63kcCRRZqDi3Ui8k5WvA==
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
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="246874756"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Oct 2025 15:27:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C228FE0B0D; Thu, 30 Oct 2025 15:27:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 21A42E0171
	for <cocci@sympa.inria.fr>; Thu, 30 Oct 2025 14:47:43 +0100 (CET)
X-CSE-ConnectionGUID: X9WOt+V9QKCf4otmAUsACw==
X-CSE-MsgGUID: DKMvbNNnTl6p/r4lygrDfA==
IronPort-SDR: 69036c7e_d6sLr7LPmvEugdclT8FmYTDIp7XA0+dFppAr2SGmQ7zy4XE
 EDDCK/gSXLaQ1OFUHBvttQ4EQgqKSC6o1UONhEg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E0AgA0awNpgTKAVdE9HR4BKwsGDCKBUIJAgWAzBFSSN?=
 =?us-ascii?q?YFyggQgnhqBfQIPAQMBCwEBTwIEAQEDBIFMgzQCjFMCHgcBBDIHDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEiGQcOO4ZPDYJiAYEkg?=
 =?us-ascii?q?SYBAQEBAQEBAQEBAQEdAg1+AQEBAxIoBgEBNwEPCxguECMBBQEcBjWBYYMiA?=
 =?us-ascii?q?QZKAQIHo0aBBUKLPIE0gQGCDAEBBtwlgWQJCQEKgTaFbYJkAYlqeicPgVVEh?=
 =?us-ascii?q?AcHMT6LB4ImgQ6GKZI9UngcA1ksAVUTFwsHBVtFQwOBCyMPPAUtHYEkIh8YE?=
 =?us-ascii?q?WBUQINJDwwGaA8GgRIZSQICAgUCQDqBaAYcBh8SAgMBAgI6Vw2BdwICBIIbf?=
 =?us-ascii?q?oIPD4kQAwttPTcUG5R2g1SZcI8MoGA0B4QfgV4GDKA0hASNE4Y7DJMNmQapF?=
 =?us-ascii?q?gIKBwcRJIFLAjGBXE0wgypPAxkPji0WHIhVxkpANTwCBwsBAQMJhUMmE4wig?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Yl2x0Ac9SRdDn2kqSj/KxB7bSpaKivm+081
IronPort-HdrOrdr: A9a23:cVG9n6igYCwv2RZAO6rOEmkDjXBQXh8ji2hC6mlwRA09TyVXrb
 HJoB0+726JtN9xYgBcpTnkAsO9qBznhPtICOUqTNOftUzdyRSVxeJZnPHfKl/balXDH4dmvM
 8KAspD4Z/LfCNHZK7BkWqF+r0bsaC6Gc6T9IDj5kYoYgdwdal64gt1TiqdGFZnXRRLCPMCeK
 a0145oo36Pdx0sAPhTxUNrYwEAnbD2fV7dACLuziRG1DWz
X-Talos-CUID: 9a23:t97ppmxL2j86HCv/+YGDBgUkS/8Cbj7jnU7zCEHkDnpsYYCOYHSPrfY=
X-Talos-MUID: 9a23:2WCIUgke5UMWReq+1nyrdnpOF+J26YKIDnwJz41BoZWAJCNqFzm02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,266,1754949600"; 
   d="scan'208";a="129503300"
X-MGA-submission: =?us-ascii?q?MDF/znhluf/LGaUujlVwwSw9j/aAm9RPRk+FjN?=
 =?us-ascii?q?7XYkWWtTSzD7EMaue/kZyFWmt2M2BD7bINYKYqHg+cLXskTP/5djS8ox?=
 =?us-ascii?q?BDQnzoDQEEsSosBDb3CVttkjHOzllZBpufP2h0LsF4SanMBO1cKLc0Bp?=
 =?us-ascii?q?a+DnOXhkCBA6D1XVPAOlnZqQ=3D=3D?=
Received: from mail-wm1-f50.google.com ([209.85.128.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 14:47:43 +0100
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so6329325e9.3
        for <cocci@inria.fr>; Thu, 30 Oct 2025 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761832061; x=1762436861; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5oy551G97AvWTlfPjNACgXvTrySxuVW8nynKmQcNfI=;
        b=XsZiZCjdLNVx7Ca2OnKnrfgm0nye1seS2LAoBzh+DjZM4ZgaPZqGteJp6AVMfco6fU
         pFgY3g8n/oVFlZXXchlOVIjE5cxD6SYQaISwS+n3VDCsn3YPSDZCJoAWw2SdPHxgleqD
         lOrEc1P0DM8kOtnZv7xgjzQxAWYCnOi63rI3LvbbStv5gTVUNF5ZW+xTb8Z3R/HkM/pa
         qwAC19obZSN9tl3ie2tE+X4JW5FKjSW4es3PkQOnehP0OzJ2XSKKLGiTNqwCO98ta616
         ci/o+jdxMMl8X+MpRxzTS06/q2ldnOrxBj/TI/vzGM9jcXueRy0TWgHOfth8TX6ihuZX
         fG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761832061; x=1762436861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5oy551G97AvWTlfPjNACgXvTrySxuVW8nynKmQcNfI=;
        b=bZh3E5rbjDKnEAHMcYiXs2fNWkQqOrlhvuISkhCzX3TnFL+cAv/QsYd0EXrsVxIlaI
         Ab4V0QCU/JSHMWZGP4lq7aELdj0jOa23yi5BRQrkGYIxl5bQhF8R0Lr3io4W1PSp2b06
         ZLI5aH3n8PXJpYkCUJurD8eHlo6SZSXCNh7bvU0pJE8t2WHYz+dZ2ZH4cQepAXVZJtuH
         EnXg1M00w0i9bQthNTi7U+svf23VzRRapyzgL/2qNY50aQKqR9ztyisnzDKe5lBmQQPY
         emc94ZzNc4sR18Oa+0x+JmdChpMI3HYF3ayOQtHBK7tcEMeBuL8EVTtWEJvq/DVZoOsN
         U60A==
X-Forwarded-Encrypted: i=1; AJvYcCWq2+u7X+Vid1etp5lAUtggYzgejwHuhV9oP4ZeEBOrrOS9cM4bWA4xTHcVr50peWp0j0FRvQ==@inria.fr
X-Gm-Message-State: AOJu0YyzhEkNUIJuoOZOK9H/k7HocN9aCtBRGWlD7anPMcLFj92vR4mk
	sHT+2rZqsMXqEdJlR7IZKltb7C9aP54MRABzeR09Fmzkop0t7X4OzyQ3LghNRrvgYHL4U1BHdDd
	/hcTr
X-Gm-Gg: ASbGncsdhnMlVUXDEvppji4+Ny+QSfUfsJ4ki1VUJhWAh5ccLNGnhIderfaoRhEVZJ6
	ZaaDm9SrJUSIL+Jtst/fY1zuxWMOErp1Nf/XnHZ8cPYocnDsWPuvxFRte2kQROxGUlp0w9A+bFz
	MvEG0tAugDjnzv6+3Ug566HCdIl4PrRY+5vZcOE9inTcbyseUI9+J8FMVXSzlnDlzpnbYYl2+DP
	u7UR57u1EKZEBnYGNbCp6ZfRnJFgZq9uQPwj3qkALTmQF2KWl5Yz3pY9Ad8PQ87S2VCwr/b+ImE
	ILilJs/Hk39HoPEb+isgSPA46aAcGRuRSd/C8IoGZv5QQ8mil65Lw7iHXg1fkM8Cnal1N9uzl2q
	iQGSATSsqYG8svmKTr3abF0oXqYpuEFnxbH1/HmFC7cuaTdS2j7TBWdgTAPI97pd4v1/SEkXSpT
	1dvElph1TWjQi5DoYq
X-Google-Smtp-Source: AGHT+IEGjvIHlQGkUBC+PGpTEGexGfWmAsl85uVWhUANnlfdtG1SHkJVwVUXptzoK6kB191rqoImUw==
X-Received: by 2002:a05:600c:608b:b0:475:de12:d3b2 with SMTP id 5b1f17b1804b1-4771e1f1dc2mr67237905e9.36.1761832061262;
        Thu, 30 Oct 2025 06:47:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4772fabe202sm690685e9.0.2025.10.30.06.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 06:47:40 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:47:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Message-ID: <aQNsecHJSO2U68Fc@stanley.mountain>
References: <ddc8654a-9505-451f-87ad-075bfa646381@web.de>
 <e54a6e57-6bde-f489-f06f-fed9537688df@inria.fr>
 <60f881dc-979d-486b-95be-6b31e85d4041@web.de>
 <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa99eded-be51-af3b-414-7c3bbaddea4a@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [RFC] Increasing usage of direct pointer assignments
 from memcpy() calls with SmPL?
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 3127
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/aQNsecHJSO2U68Fc%40stanley.mountain>

On Thu, Oct 30, 2025 at 01:31:49PM +0100, Julia Lawall wrote:
> 
> 
> On Thu, 30 Oct 2025, Markus Elfring wrote:
> > @@ -2600,8 +2600,8 @@ static int __init init_hyp_mode(void)
> >                         goto out_err;
> >                 }
> >
> > +               memcpy(page_address(page), CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> >                 page_addr = page_address(page);
> > -               memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
> >                 kvm_nvhe_sym(kvm_arm_hyp_percpu_base)[cpu] = (unsigned long)page_addr;
> >         }
> 
> Not sure what is the point of all this.  Try:
> 
> - target = object; memcpy(target, source, size);
> + target = memcpy(target, source, size);

No one will thank you for making these changes...  :(  Please don't do
it.

regards,
dan carpenter

