Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEA2C4345F
	for <cocci@archiver.kernel.org>; Fri,  3 May 2024 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=POB+Qk9817vEfzSrpD7t/XpzqTCMec9mNaDiZWNb3d4=;
  b=ocdPts3cYjOdy2GZx1b6tr/bhMESFF/sbG/yhDYkXxa7R/I1GwtJBCSN
   w2DjKLDmxB3hhfTP6Lju73kSX9a8TsZ70WIwRrk5jHuhKydXBzo0x+/Wb
   2A2VNFhUzUVuwrxvCFdEXFuTDnX5veS1yo3qTbDZaG697RbzIByrm/y6j
   4=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="164378248"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 May 2024 12:59:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 678BFE0145; Fri,  3 May 2024 12:59:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B3F83E0035
	for <cocci@sympa.inria.fr>; Fri,  3 May 2024 12:59:21 +0200 (CEST)
IronPort-SDR: 6634c388_RD1qJHLre2NUu+IMJO3whb3vgEHR3Lpp0vXu+FXAJWg4kYz
 f8/ygBN+iQgh7cdF7owySPeM4f3s1Crar+/FiUA==
X-IPAS-Result: =?us-ascii?q?A0EDAADuwTRmh3yFCqpaFgQBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBOwUBAQEBCwGCQ3yBCgQLSIxzX4ZKgiIDngqBQD4PAQMBC?=
 =?us-ascii?q?wEBOQsEAQEDBIILgnQCiC4CHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEBASIXBw4QJ4V0DYJnEYEOZQk4AQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBFwINDm0BAQEBAgESKAYBATcBBAsLGC4USDWCXgGCQSMDEaVsAYx1A?=
 =?us-ascii?q?QEBdoE0gQGCDAEBBoJm2xkJgUgBiC0BiUJ6JxUGgUlEhD8+gVKBDwKIJIUSl?=
 =?us-ascii?q?RmMcFR9HANZIQIRAVUTFws+CRYCFgMbFAQwDwkLJgMqBjYCEgwGBgZZIBYJB?=
 =?us-ascii?q?CMDCAQDRAMgbxEDBBoECwd1gXyBNQQTR4E4iX0MgzEpgU4phCFLbIQLgXgOY?=
 =?us-ascii?q?oNhglsdQAMLbT01FBsGIgGhCIRGKwGBRQgfsUKVAwcDhBOMDpUeBBYzhAWBV?=
 =?us-ascii?q?pFdDDmSN5hiixaCXodOkxsCCgcXgWU6gVxwFYMiCUYDGQ+OIBmDYYRZO5UMQ?=
 =?us-ascii?q?jU7AgcLAQEDCYkigUgBAQ?=
IronPort-PHdr: A9a23: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
 o8F9dhHFZ6pghmwxSLPNrMJyRwxog/sIQfdZMk=
IronPort-Data: A9a23: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
 vdALpT+6Im4xJht5YCr
IronPort-HdrOrdr: A9a23:rpya7asJmFLOaWkwAUs/8abn7skDVdV00zEX/kB9WHVpmwKj5q
 OTddAgpGPJYVcqKQwdcLW7U5VoLkmzyXcY2+gs1PKZLW/bUQiTXeZfBOnZsljd8kTFn4Y2uc
 hdmupFebnN5DNB/KTHCWeDc+rIjOP3iZxBKIzlokuEympRGttdB9MTMHfhLqUbKTM2faYEKA
 ==
X-Talos-CUID: =?us-ascii?q?9a23=3A+ePsaGlH+D+z8mBDXSjhrKqu+a/XOUaH0ijTfBS?=
 =?us-ascii?q?hMHhCcO2pUVyO6eR4t8U7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AA5Xigg6HVd8xjyOZnubChLz9xoxF3I2sE3gxla4?=
 =?us-ascii?q?l4ZagCTU3FRbBkRC4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="86307534"
X-MGA-submission: =?us-ascii?q?MDFN8KF31zfsMIElp6AMpP3w4Jd3rra9JuKl2Z?=
 =?us-ascii?q?u99J4CiCswUzPY7Qz5WWAjyayPbH207gy/jHc0+mjyacPIT/AdioERCb?=
 =?us-ascii?q?Ie/H0HA4WbJjbzlyZ85/jKUY6WB923y+SxfwTwPrl3VKkyXYWZJhgd6k?=
 =?us-ascii?q?n7D5O5cwQxrZawFQdDdfeMgw=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 12:59:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714733959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=POB+Qk9817vEfzSrpD7t/XpzqTCMec9mNaDiZWNb3d4=;
	b=cW0p1DUVRtzTd4MOR12bWHGoDj5oQ2DS9otPkSfNLAtZEjuKXD+6EuQSxzUBtxH2vV34nJ
	BbAmWo/CaOBG8GnX4SvzdBgxH2ELE/FQe4kgS1bvRMKnfbuD3rQN2hFyvdVBqMx148BNgi
	4P1kBNXS/5sx7yaS3io6NUjFqvM7JAU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-TAi2vwrYPR-kg1DmA0aAhQ-1; Fri,
 03 May 2024 06:59:17 -0400
X-MC-Unique: TAi2vwrYPR-kg1DmA0aAhQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 166462932487;
	Fri,  3 May 2024 10:59:17 +0000 (UTC)
Received: from localhost (unknown [10.42.28.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 90AB42166B31;
	Fri,  3 May 2024 10:59:16 +0000 (UTC)
Date: Fri, 3 May 2024 11:59:15 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Message-ID: <20240503105915.GU7636@redhat.com>
References: <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
 <20240502164958.GD30267@redhat.com>
 <20240502171930.GE30267@redhat.com>
 <20240502173148.GF30267@redhat.com>
 <alpine.DEB.2.22.394.2405022340080.3439@hadrien>
 <20240503073135.GR7636@redhat.com>
 <f353bd20-1821-4112-b12b-bd1a111f7d20@web.de>
 <20240503102404.GG30267@redhat.com>
 <72b79221-63f7-4095-a5f9-d4502deced43@web.de>
MIME-Version: 1.0
In-Reply-To: <72b79221-63f7-4095-a5f9-d4502deced43@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [cocci] Analysing software build processes
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 1693
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/20240503105915.GU7636%40redhat.com>

On Fri, May 03, 2024 at 12:40:59PM +0200, Markus Elfring wrote:
> >> Can the analysis become easier anyhow according to questionable software run time characteristics?
> >
> > I don't understand what this means.
> 
> Do you know further profiling tools?
> 
> Example:
> https://bashdb.sourceforge.net/remake/

The problem seems to be entirely inside ocamlopt.opt, so I don't
understand how tracing make will help.

> You managed to generate a flamegraph with a special software build process.
> Can we benefit any more from such data representations?

There's no "special software build process".  The flamegraph was
collected by running 'perf record -a -g' on the machine while
ocamlopt.opt was compiling a single file, and converting the perf data
to a flamegraph using Brendan's tools here:
https://github.com/brendangregg/FlameGraph

Rich.

> Would you like to help to achieve out of source builds
> for affected programs?
> 
> Regards,
> Markus

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

