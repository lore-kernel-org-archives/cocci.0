Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0B5FD2D6A
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 12:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5U3NeXHJE8lfg4BXS8esFmXtZQ5l+VHcEWPXt89DuYc=;
  b=pdJsNTLa3XBs5TCwaoGZ8dM2DOx8IzLbiTGtUQ6hKtCwHJDHSyM/G2oh
   OwFnafwW91ACrcvQgq/5k9qrto7SYlPTnWqASxiZge2suBbOLP48UxDUs
   p6z5nmyDt0pnBDI63+FiyiF5d5WKfa6AreB8SIVRWyQQgyFDGnmzt5aLX
   g=;
X-CSE-ConnectionGUID: HStbfTtySWKeEz+/6aVYGQ==
X-CSE-MsgGUID: Id8Fhn3lRGKNvIOa7gXEPw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267089988"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 13:46:04 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id CDE26833BB; Tue, 10 Mar 2026 13:46:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 1E5CA806FF
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 13:23:13 +0100 (CET)
X-CSE-ConnectionGUID: jTRKK6stTZityURe6fkytg==
X-CSE-MsgGUID: KZBluhouSMCvhLjtuRL+rw==
IronPort-SDR: 69b00d30_GRxa9qW8Ahq6COJHKkqzUoug+dxHziZ6/nH41w3FIZnRzj1
 XxLzPdr3Jd27cKa8nNYgIvn3kSO3FoKsYrqV2cg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FfAQDJC7Bphf4EaaxaHgEBCxIMQIFFC4JBgWYzBAtJh?=
 =?us-ascii?q?FiIe4h8nEWBVYF9Ag8BAwENUQQBAQMEhQACjSECHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBAUBJhk8NgmIBgSSBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CDX4BAQEDIwQZAQE3AQ8LDgoCAiYCAlYGARKDAoIjB0oDr?=
 =?us-ascii?q?U5/M4EBggwBAQaCadlBgWcJFAGBCi6IVAGBcIQEO4NFeicbgUlEhD8+hAo5F?=
 =?us-ascii?q?YNGgkcigiaBDokKihYJSXgcA1ksAVUTFwsHBV5FEDMDIAovLQIUDRASDwQWB?=
 =?us-ascii?q?S0dcAwnEg8dFxQfWBsHBRIhKoFJeIFmGw+GankDLl4aDiICOgNZSj4LWgWCP?=
 =?us-ascii?q?wMLbT03Bg4bBI8nPoIzAYEOgikXxxqEJqFyM5dSkxkuh2WQcyKjQj6FH4FoO?=
 =?us-ascii?q?oFcMxoIKAiDIk8DGQ+OIQwNCYhxiiq5Yic1PAIHCwEBAwmRajSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Qkix0DN
IronPort-HdrOrdr: A9a23:zDSmGqpmlN+icLdAe7u6k8QaV5ofeYIsimQD101hICF9WtCEkc
 q0jO0HvCWE7Ar5lktBpTnmAtjnfZq8z+8T3WB1B9qftWbdyQiVxe1Zg7cKhgeQeREWldQtrZ
 uIEZITNDSYNzET5qzHCUuDYrMdKbK8n5xA692+854gd3ASV51d
X-Talos-CUID: =?us-ascii?q?9a23=3AFj2qT2ofOnAMIr/3eQIReATmUcIZSF7+kmzMH32?=
 =?us-ascii?q?5FXdUcrDLR1yB5Kwxxg=3D=3D?=
X-Talos-MUID: 9a23:HRq7FQRox0Vk56JWRXTPthtmKcdv/p+LI14NtZcapvOgdjZvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="140920546"
X-MGA-submission: =?us-ascii?q?MDFWF1aUoXZ6bkUHobU+BVd1yN/hyR1Meh8DTY?=
 =?us-ascii?q?uhdRHx9/3tTBx9Fy2Kv0I3kk6rlhnkD4vc3f+W+zShBnQRR5Vbjj22/O?=
 =?us-ascii?q?+FCa9EQ0Z3ZcuC4Y7HrjbnO1to24/xOOKMpG2puArzhdQOUwK6UMcWKF?=
 =?us-ascii?q?Ld9SOLp5Tp14nHSbDTDqb2ew=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:23:12 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A441D60054;
	Tue, 10 Mar 2026 12:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C6FC19423;
	Tue, 10 Mar 2026 12:23:04 +0000 (UTC)
Message-ID: <2ff39929dad06ca7d009ccd6dfe873da22a07c8a.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, 	linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, 	linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, 	linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, 	linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, 	samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, 	target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, 	v9fs@lists.linux.dev
Cc: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Mar 2026 08:23:01 -0400
In-Reply-To: <20260310-b4-is_err_or_null-v1-61-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	 <20260310-b4-is_err_or_null-v1-61-bd63b656022d@avm.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 61/61] file: Drop unlikely() around
 IS_ERR_OR_NULL()
Reply-To: Jeff Layton <jlayton@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3370
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/iRSbkwLbqjKVbi2JHgJdmw>

On Tue, 2026-03-10 at 12:49 +0100, Philipp Hahn wrote:
> IS_ERR_OR_NULL() already uses likely(!ptr) internally. checkpatch does
> not like nesting it:
> > WARNING: nested (un)?likely() calls, IS_ERR_OR_NULL already uses
> > unlikely() internally
> Remove the explicit use of unlikely().
>=20
> Change generated with coccinelle.
>=20
> To: Christian Brauner <brauner@kernel.org>
> To: Jeff Layton <jlayton@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  include/linux/file.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 27484b444d3155685cdbb89f546f26ef66e3e1b4..007b9b9d365a052c1c056e125=
71eaf4f8ef5a45c 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -163,7 +163,7 @@ static inline void class_fd_prepare_destructor(const =
struct fd_prepare *fdf)
>  {
>  	if (unlikely(fdf->__fd >=3D 0))
>  		put_unused_fd(fdf->__fd);
> -	if (unlikely(!IS_ERR_OR_NULL(fdf->__file)))
> +	if (!IS_ERR_OR_NULL(fdf->__file))
>  		fput(fdf->__file);
>  }
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
