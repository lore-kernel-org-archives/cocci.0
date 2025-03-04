Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ED2C282DE
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+5afpL/Rx5asY41RO6sskHmYoXFs+D81rSZQlM92czo=;
  b=RFr2+o/d/2Fm+WJZkJvEzLg24NhG2avP6gQjY3P9vfsnh0gFpBqKBEdw
   64W1zufsJqG+IkVBT+5z7KqskKWzPXymZucOAahM1a0kG93vZjmuM+dMS
   MiGOh06MjJFVo6ONyPP+ysRFXxhE4Sxj3ABZm4yOsVpaf3mlcK2ILgCq/
   g=;
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
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211070182"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 38214E17D7; Tue,  4 Mar 2025 10:58:47 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7D3D2E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Mar 2025 07:38:38 +0100 (CET)
IronPort-SDR: 67c69fed_JnXzrtiiOjIDJxe9HLV2QjVg3bxcfRMtl2/vkMq0OKEHkAb
 4E51s8zHs7t4UKrTIolD6r8z06tQhqamnYUxAAw==
X-IPAS-Result: =?us-ascii?q?A0FXBgB0n8ZnfDHaVdE9HR4BAQsSDECBSAuCRIFXMwRTh?=
 =?us-ascii?q?FaNXYFygXQtA5g4hVyBfg8BAwELAQFCAgQBAQMEggyCdAKLFQIeBwEEMAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABASIZBw4SKYV7DYJiA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAg19AQEBAQMSEQ8BDQEBNwEPCxQBAwICJgICM?=
 =?us-ascii?q?wEFARwGEyKBYX+CZQECB6IcgQVCikR6gTKBAYIMAQEG3CCBZQkJAQqBBi6Fb?=
 =?us-ascii?q?IJjAYpiJw+BVUSBPAuCeD6IHoJpgjOBaQGDPZoFjlZSexwDWSwBVRMXCwcFY?=
 =?us-ascii?q?UhIA4EPIw+BFAU0QTqCC2lJOgINAjWCHnyCK2oEBYEkgjeEPYRAhVSCEYFdA?=
 =?us-ascii?q?wMWDwGCMG95HIR5hGsdQAIBC209NwkLG6I0OoQhIVIxViaBTjaTDIM0jnqBO?=
 =?us-ascii?q?58dNAeEHoFdBgyfXgYTL5dFDJMFLodlkGqpBwIKBwYRI4FEOoFcTTCDKk8DG?=
 =?us-ascii?q?Q+OIYkNw1dANTwCBwEKAQEDCYVDJhOKIIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 b8biodDD616GpDehEfxh+8UvA==
IronPort-HdrOrdr: A9a23:35Z70KzS31l26KwR0YRJKrPw171zdoMgy1knxilNoNJuA6qlfu
 SV7YgmPHjP+UkssRAb6K290cy7K080mqQFhLX5UY3SODUO/VHYUr2KjrGSuQEIeReOjtK1vJ
 0IG8MOauEYT2IK9voSiDPIcOrIq+P3iZxA692uqEtFfEVEbbp/5xx1BgvePkp9XxleGJY1fa
 Dx2uN34xSlPVoYB/7UOpDHZYf+Th/w+a4OrSRmO/fv0mmzsQ8=
X-Talos-CUID: =?us-ascii?q?9a23=3ABbuobGmjY60jBM+u1DCvCEgNaq7XOWeN11CXAGW?=
 =?us-ascii?q?FNUUzV7ypcFqP2pl4kPM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A8k/4iQw5T+aITH5OX56uNLTsNOKaqLiJNVtQqZs?=
 =?us-ascii?q?cgdCvZDVyHQeboHOUU7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="110565057"
X-MGA-submission: =?us-ascii?q?MDEJmSuWNBoRnfqwp6HSnmgupr1roluBJFz6yb?=
 =?us-ascii?q?jPdHgJV2VCjnDUf0QeB8jnjYTvXmkB/HKtisGLL0ghNVBZbDaRNZ5ZKu?=
 =?us-ascii?q?MfjBdgARm7inLGgVU03DC8gaNDp9+brF2dWR1WkywXk4YH/Pn9ru5QUc?=
 =?us-ascii?q?6w5u1LvFqyVGGpGKTrCa5gFQ=3D=3D?=
Received: from mail-ej1-f49.google.com ([209.85.218.49])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:38:37 +0100
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf48293ad0so495442466b.0
        for <cocci@inria.fr>; Mon, 03 Mar 2025 22:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741070317; x=1741675117; darn=inria.fr;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+5afpL/Rx5asY41RO6sskHmYoXFs+D81rSZQlM92czo=;
        b=FqXx8j9VdYs0Iyy3LbZYhPzy67LnKF9Dqy9HjtICzv4U+qnDCl6aSol4ANfWpR5DU3
         5HBRHpU4zRID3kFLuqzI7fp4ajx73zBXsFXN05pNaIDEtojoNsWQx+vkReE9J9ekOrT2
         2TY9azHFtix3fqfMP1gLQyD8XG6Tiq7ldLjW+IvCi8Av3Z6t2Jz6So0nNPgNESERGwtC
         yU1tZDKcmTxYLFAuaUGHtx+SOYnEHI2SPU//YSUgkfMAtS0eQHxRGDlp0gCerM5bS0lZ
         Fak/d5vNWr1YIVEQ15uySm0doJaKtgZXXBXo8RXWq3HSbi7AGKX/SNHse68i6yeINnhT
         gWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741070317; x=1741675117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5afpL/Rx5asY41RO6sskHmYoXFs+D81rSZQlM92czo=;
        b=hIzkn+XfveK1K8Z0M7kYViCpUXHhKr/Pd5O1ZVvLZcfB1lP2SPUQ089L1zWV5g/vPf
         INXGBpt7MhRCcBOnJAabXcv0qwLnk6+DbEkKtShsnjDgRHaqXp7JaHU/AX0gJH1+QsCv
         pfMlMgcg0LsP6cpGL1tk5dXEvRwiNJzgE/H2u9dCHTLUa4/g6Lxw//YwH2awMilCBaqy
         zAhU/rPezICui8fb7q7qT8iSXLN51IN2sAykzkCjAlicvTYXalR07kg4SsxwOHNr+Flg
         Q9cBBxfg2K1lPfgZpBO9uknv1ApBjatXz23s9/P5C4Ly1DuCEiOFVSvm3qMX0mddhlia
         sfEA==
X-Forwarded-Encrypted: i=1; AJvYcCVgIDYcXE4prwEBYAXnxc/YH5V3Bxhj1CUWVkoC38ED5BZ7CwfHUIyGqn/5gq4lHtwbwI0FVQ==@inria.fr
X-Gm-Message-State: AOJu0YxD5b5+VZ0SxFJCRF11vmUOaq961ewur8CrTxczUcB/eZk1lZ0K
	pGUvHtyx7ceIL0lH7g8WOmmwuzHAku10nyagXLHnKySDmoE5zw3/3lVJC2YSnl8=
X-Gm-Gg: ASbGncsgJi/dSxDZuyqmQxWsrUL+Pd5Jd80v4DybI8f2GyqaFPZqPcHScKVbxUu0sxk
	Z5f5P4Sps3fzcMT1Fs08puN4w6fTdspXsxP1+PzxPqC4S/8/hjPDohuvA58J3unjKw8teJLjkRT
	RAIlLZkjZ1RgXLCBnBeUkhJXOFolg5StQD1MTe5QHOqTkq3/s1dfg6OF/ZCUCowo6b9M2og/aph
	XmV9u4tMgt4TgsaRd/7QRyj7YD0fD6Ok2abqx7Llak2bwWyqhnmNl+zAZ6I+EF4NRNtY7xHz7Iq
	l0ueMRgbsHXycMk3AXUGrsAx1+O5+H8rv4N1fORbH2ZNYFGRsw==
X-Google-Smtp-Source: AGHT+IGe2iwcRIWzldTGCdfW0AwQOIiSjBUeo6MIzBTmW4OuUn9Z0MsTNtF9xRej5K0PMydq88UZNA==
X-Received: by 2002:a17:907:1ca1:b0:abf:6744:5e9c with SMTP id a640c23a62f3a-abf674462f0mr1005575366b.5.1741070317014;
        Mon, 03 Mar 2025 22:38:37 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac1de83fa49sm199356466b.158.2025.03.03.22.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 22:38:36 -0800 (PST)
Date: Tue, 4 Mar 2025 09:38:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	"cocci@inria.fr" <cocci@inria.fr>,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <b71c4088-4d8b-4613-8af5-e81f32abecf9@stanley.mountain>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <cebfc94f-8fdb-4d5c-56ee-4d37df3430a1@web.de>
 <09fe60d4-8eda-42bf-b2d4-ada265a09ce5@web.de>
 <D873FT11P5M6.JLH3TCARWATJ@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D873FT11P5M6.JLH3TCARWATJ@wdc.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] btrfs: Fix exception handling in
 relocating_repair_kthread()
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2522
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/b71c4088-4d8b-4613-8af5-e81f32abecf9%40stanley.mountain>

On Tue, Mar 04, 2025 at 01:34:00AM +0000, Naohiro Aota wrote:
> On Tue Mar 4, 2025 at 5:31 AM JST, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Wed, 22 Mar 2023 20:10:09 +0100
> >
> > The label “out” was used to jump to another pointer check despite of
> > the detail in the implementation of the function
> > “relocating_repair_kthread” that it was determined already that
> > a corresponding variable contained a null pointer because of
> > a failed call of the function “btrfs_lookup_block_group”.
> >
> > * Thus use more appropriate labels instead.
> >
> > * Delete a redundant check.
> >
> >
> > This issue was detected by using the Coccinelle software.
> 
> Since this function is local to the zoned feature, could I have "zoned: "
> added to the subject line?
> 
> Other than that, it looks reasonable to me.
> 
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
> 
> >
> > Fixes: f7ef5287a63d ("btrfs: zoned: relocate block group to repair IO failure in zoned filesystems")
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Don't use Fixes tags, if it's not a bug fix.

regards,
dan carpenter

