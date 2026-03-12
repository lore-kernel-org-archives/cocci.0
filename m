Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D61105F792
	for <cocci@archiver.kernel.org>; Fri, 13 Mar 2026 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=VQXCfPVu6b6dIVECzm0C8AUD7IL7VvpSkD5+M4S95sw=;
  b=cctSIvnsVn7AfMkeanIr3CBh/TdE5DG3oAFHvu6N2LniNkjfsW2r3x6M
   vCi6CrSUtxadOLgM7CX3rjmk31QG/6n/mLBuMY6pmIBtrkmt22BEfOi2u
   tVXjZoxLUiI32CHkW00gwSHCo4e2FLvMw436ZSe9L5aC62qFETL1bzqPB
   c=;
X-CSE-ConnectionGUID: bommAl/IS0KLlf4PwH4kbQ==
X-CSE-MsgGUID: 3eUdDw/pTG6eXhTPfAQ3JA==
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
X-IronPort-AV: E=Sophos;i="6.23,118,1770591600"; 
   d="scan'208";a="267642924"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2026 11:19:50 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 4BB1E81D13; Fri, 13 Mar 2026 11:19:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8729D83647
	for <cocci@sympa.inria.fr>; Thu, 12 Mar 2026 17:54:52 +0100 (CET)
X-CSE-ConnectionGUID: 8Dmt23ynT3CV4btkJFj1fA==
X-CSE-MsgGUID: IKMAocnFQAeXGd5WS/9rUQ==
IronPort-SDR: 69b2efdd_jk4psOmHpWTJoY0KfhcqGpLttZzRzghbQF0Ns6kVuCUue4I
 GlXIN5iDceuqkrmlwh6GsDtF1a7yIAlNfP04njw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EqAwDz7rJpfLSgVdFaHgEBCxIMQIQRgWYzBFSUK1oBA?=
 =?us-ascii?q?QEGgUGLdJQjAg8BAwELAQFPAgQBAQMBA4UAAo0jAh4HAQQ0EwECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEiGQcOEimGTw2CYgEzghYsD?=
 =?us-ascii?q?X4BAQEDEigGAQE3AQ8LGBwSMwEFARwGDCmFAwEGSgOjFoECQos7gTSBAYIMA?=
 =?us-ascii?q?QEG3AyBZwkJAQsBgTeIVAGFWhqEAHonG32BEIEVgTuBbz6LB4ImgQ6JB4odU?=
 =?us-ascii?q?ngcA1ksAVUTFwsHBYEjQwOBBiNLBS0dgSMhHRcUH1gbBwUSISqBRHiCAQ+GZ?=
 =?us-ascii?q?wF5Ay5eGg4iAjlcSj4LUgWCLQIfAwttPTcUGwSPJT2CIhN6CYFOl3awIIQmo?=
 =?us-ascii?q?VgEFjOXUpMZLodVEJBzqRYCCgcHESSBWyOBXE04gyJPAxkPjiEMFhyCbsk7K?=
 =?us-ascii?q?TU8AgcLAQEDCYVFjFmBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:kzknOqnV8Sz7mFEtDvnl0wyA4SLpDfLt3DAbv31ZSRFFG/FwWf
 re+sjz8SWE9Ar5OUtQ5OxoXZPrfZqyz+8R3WB8B8bHYOCighrWEGgA1/qZ/9SDIVyHygc178
 4JGNkceb/N5BpB/L3HCWGDc+rIq+P3iZxA692uqEtFfEVEbbp/5xx1BgvePkp9XxleGJY1fa
 Dx2uN34xSlPVoYB/7UOpDHZYf+Th/w+a4OqCRmOyIa
X-Talos-CUID: 9a23:Xr6C2m8FCl2loIC5qRKVvx44H9x/KWzb8Cz7HROyFWVLZr/MR3bFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AKJwNFg+Q4SwZVNv8/7rP4HuQf+ZLxo2pA0YjqLw?=
 =?us-ascii?q?Li+aIaBNLfGaHsQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,116,1770591600"; 
   d="scan'208";a="267542858"
X-MGA-submission: =?us-ascii?q?MDFvZgwoUjlVcasUC27+oxs3XrDcLqECEMqs0Q?=
 =?us-ascii?q?53oxkeENbYNGS01FBM33IHgL+YLB1beAGU9QRjXH3rQhBSKMgkHHmowg?=
 =?us-ascii?q?Y+icd5RAEmMZOrL42oY5GSf0HXqfB7M5xDXBhlFO0n+9c4Rs6xEz5VWV?=
 =?us-ascii?q?HYPKcMR4vLA3NL5Gz/uf8/jw=3D=3D?=
Received: from mail-qt1-f180.google.com ([209.85.160.180])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 17:54:52 +0100
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5094e1d17d3so7532901cf.3
        for <cocci@inria.fr>; Thu, 12 Mar 2026 09:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334491; x=1773939291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQXCfPVu6b6dIVECzm0C8AUD7IL7VvpSkD5+M4S95sw=;
        b=d5cWumDvlSP7VsEVT13l93VE9Lk/l2MS4UviPAeXTX/LsJZTVs0Cka5cJl0Qc4/jCX
         vIuFw9WG3OIV5bGDIDaOyqKR8syw9RH3+5iD2ghEHwbWMiOVDy8RYf5vcH+7vQjmnTrX
         dKzWnL6BHF+47CTpfFkH4C2zHmtgIIBmbB/uhDKM6xv6hPCmSsl4yU+ZhSNiHIo6M0VB
         HQwTWeUQ87fYQb0mGFwU1yafsxF0xw9iKtVy2vRjxlS6NrVfyStTTQ2yEOfWz5tVC8eZ
         PZgdQtPt2tQ8ThvO4G5HO8j7YwalTne4o9IcjsdhCJlNn2RZD3TErxQrLyKWLk7V+R/o
         Sa5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlXn0ltWnlGMZWV7URvSDgC6G6PTTCjF5RsthYq/mxGMdbXctMQlwr6hJQmxqJ5IA77uX6KA==@inria.fr
X-Gm-Message-State: AOJu0YyJ2wUdtZQjUfCfVQPmmuj6GI0T/q2VIhZAJVdIVza9BstO0H4n
	bYuBUIDjLmEJ1EecxNfmKKye9OOMJ5SKh71jmEmgOSIPz2DKXDm1tLJPgGoOwShFBmw=
X-Gm-Gg: ATEYQzwA2qi4EZZKGya/YIFQgUUEpmyg3c3f1ZoB73zH5Gb9knKlk/BwgxAuvXHnbtz
	/KeBsDf7FzbMtzZ9XbE9LfLNZjOWHxIyqGV4sUoiXhYw4+dBH6N/xpvF4370YJykVrjD0Y/Px90
	G3QpywvwKt7LOR2FN8qmy3kKLFNt9z5sizV0gZ8merRodqg7hAGc1Dkul3g/5jADWJzOxU3qF8M
	P/sOkhT3StNAm0yto8vy6ABfmkCWBOcishQ7CGeFPgEhiUQekwm85fuXW29QD3gQ5qDUkaVINBR
	YzRORE7o0jvds5MPhpApcngHbF+dIf3z9YS6a1l6gaWxMfAFsmm2h2GtU0N8S+JS0gtRmVRcV7w
	tryISBzFYX3FCe+m7he7Yzv/LAIBCLRI9Zc+wSA1RmueucCgJPc0hVxq4Wy85Tf8eAluH39u7cr
	6hhi1I/LKswRNw6G/BZLTMRDKXHpFP1qSjo0fFDmdbpKSc+e4dW5FPVei/rw3vecCPNXs/+S0HS
	ewwUyAhFy6C7hPq9mQ=
X-Received: by 2002:a05:622a:289:b0:509:44c3:5ffa with SMTP id d75a77b69052e-50957e10673mr1403911cf.52.1773334490530;
        Thu, 12 Mar 2026 09:54:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a119602sm36658181cf.28.2026.03.12.09.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 09:54:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0jJA-00000006i8N-40X9;
	Thu, 12 Mar 2026 13:54:48 -0300
Date: Thu, 12 Mar 2026 13:54:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Philipp Hahn <phahn-oss@avm.de>,
	amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Message-ID: <20260312165448.GN1469476@ziepe.ca>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <abBlpGKO842B3yl9@google.com>
 <20260312125730.GI1469476@ziepe.ca>
 <f5688b895eaebabae6545a0d9baf8f1404e8454e.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5688b895eaebabae6545a0d9baf8f1404e8454e.camel@HansenPartnership.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual
 NULL check - refactor
Reply-To: Jason Gunthorpe <jgg@ziepe.ca>
X-Loop: cocci@inria.fr
X-Sequence: 3422
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/2xdwePFvptyOrk_7oZTXFA>

On Thu, Mar 12, 2026 at 11:32:37AM -0400, James Bottomley wrote:
> On Thu, 2026-03-12 at 09:57 -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 11, 2026 at 02:40:36AM +0800, Kuan-Wei Chiu wrote:
> > 
> > > IMHO, the necessity of IS_ERR_OR_NULL() often highlights a
> > > confusing or flawed API design. It usually implies that the caller
> > > is unsure whether a failure results in an error pointer or a NULL
> > > pointer. 
> > 
> > +1
> > 
> > IS_ERR_OR_NULL() should always be looked on with suspicion. Very
> > little should be returning some tri-state 'ERR' 'NULL' 'SUCCESS'
> > pointer. What does the middle condition even mean? IS_ERR_OR_NULL()
> > implies ERR and NULL are semanticly the same, so fix the things to
> > always use ERR.
> 
> Not in any way supporting the original patch.  However, the pattern
> ERR, NULL, PTR is used extensively in the dentry code of filesystems. 
> See the try_lookup..() set of functions in fs/namei.c
> 
> The meaning is
> 
> PTR - I found it
> NULL - It definitely doesn't exist
> ERR - something went wrong during the lookup.
> 
> So I don't think you can blanket say this pattern is wrong.

Lots of places also would return ENOENT, I'd argue that is easier to
use..

But yes, I did use the word "suspicion" not blanket wrong :)

Jason
