Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270F3C4345F
	for <cocci@archiver.kernel.org>; Fri,  3 May 2024 07:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=D4148aqJpCBBPS76rs/mV1D8b6v86Q1UKx0l97/Wi+k=;
  b=EjNRo5NcXwnuFANqqY9syva++PfbcdSqRLlR+r7fzxsw4TOwVrTz47RY
   a8nDfrB4oq2V4mRt+iq4Z7LSvQ9kF6xLVs/WmZQpDHDfUgWbnHK5rRvmd
   9db+gVTX/vOG6MUwuJrBUoLvJsAnKIIBBVmXH1Yw05dYBVEmkq6T1/Sex
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164331244"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 May 2024 09:31:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3E51DE0145; Fri,  3 May 2024 09:31:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B6447E0133
	for <cocci@sympa.inria.fr>; Fri,  3 May 2024 09:31:42 +0200 (CEST)
IronPort-SDR: 663492dd_PNXUi8okeGyzWsz39NB/7D/hQsx0n6nRP59ralsboNhXEBy
 net8vpYzlZh5yId2Z27wDzirt9W2FbPb39Li8pw==
X-IPAS-Result: =?us-ascii?q?A0EDAADkkTRmh3yBCqpaFgQBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBOwUBAQEBCwGCQ3yBCgQLSIglhE5fhkqCJZgvhVuBQD4PA?=
 =?us-ascii?q?QMBCwEBPQcEAQEDAQOEfwKILgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABAQEBIhcHDhAnhXQNgmcRI2tjAgYDNwEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBEwINXAEBHQEBAQECARIoBgEBNwEECwsYLhQ0ARM1g?=
 =?us-ascii?q?l4BgkEjAxEGpkIBjHUBAQF2gTSBAYIMAQEGgQg+AwsCQ03bGQmBSAGILQGJQ?=
 =?us-ascii?q?nonFQaBSUSBFYMqPoFSgQ8BAQKIIoFsD4xIiQSCJj6BKYFpEQgJCgSBOj6HN?=
 =?us-ascii?q?lR9HANZIQIRAVUTFws+CRYCFgMbFAQwDwkLJgMqBjYCEgwGBgZZIBYJBCMDC?=
 =?us-ascii?q?AQDEDQDIG8RAwQaBAsHdYF8gTUEE0eBOIl9DIF9gTQpgU4phCFLbIQLgXgOY?=
 =?us-ascii?q?oNhglsdQAMLbT01FBsGIgGhCINigQ8BgUWxaZUDBwOEE4wOlR4EFjOEBYFWk?=
 =?us-ascii?q?V0MOZI3LodYkFyNdIdOjXyFHwIKBxeBZTqBXHAVgyIJCT0DGQ+OIBmDYYUUl?=
 =?us-ascii?q?g1CNQIJMAIHCwEBAwmJIoFIAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 tVh3pTmOHm4FQ==
IronPort-HdrOrdr: A9a23:0B+pAqy8/IpUa2L+tsx1KrPw971zdoMgy1knxilNoH1uHvBw8v
 rEoB1173/JYVoqNU3I5+rgBEDwexzhHPdOiOF6AV7IZmfbUQWTXeJfBPPZsl/dMhy7z/Va06
 h4dah4FZnfMXhW5PyKhTWQIpIY29+A/7mvheDCi1FXbS8vRZ1Bwm5Ce2Km+msffnghOXP8Lu
 v62vZ6
X-Talos-CUID: 9a23:aK5WkWxX8oCCJscIzYmkBgUMNf9ibSz91EyNeUalImouUIG4FWCPrfY=
X-Talos-MUID: 9a23:sKUHmAr7uYtUaCexCPAezy9wbOZ6/52TM2sMvJYUgeiqPnZRIw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="86285464"
X-MGA-submission: =?us-ascii?q?MDE07Kc7SWI35dP1feSfhYL9amoczJ2zl7y08i?=
 =?us-ascii?q?kd+dlZdmYoDh8cc8ZuQvQy9ihxnA9fU3Nxy+ULNTfZ7+OatZyxS7RxBy?=
 =?us-ascii?q?HdvU7/Uao7x1QgiS2inQV1iSNmyepwP+wQNtNbPc6ucu6MHtQ6xa+yuM?=
 =?us-ascii?q?9dHMVL9vDXtyzsxUnIeTixGA=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 09:31:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714721500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4148aqJpCBBPS76rs/mV1D8b6v86Q1UKx0l97/Wi+k=;
	b=U8SEvJkcNY1q9Y/Wv8oFGS/upj8IhUBC1P7KU9R/8U0KhpowGr0Xjdvps+8at16Qr/eV1e
	bqYkfZ4QdcXugFZFUxMWobxHOVE4y9uhkudx5Hs1+4Vp1VdRoUEbFkv6x0goNeJavp2TSg
	1hEZ2+3ulyZX4KVyXzMAkXdFSzTL9h8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-wYN1zi8kOAyL0-hYXpdDkQ-1; Fri, 03 May 2024 03:31:37 -0400
X-MC-Unique: wYN1zi8kOAyL0-hYXpdDkQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFF301005055;
	Fri,  3 May 2024 07:31:36 +0000 (UTC)
Received: from localhost (unknown [10.42.28.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7FD7C492BC7;
	Fri,  3 May 2024 07:31:36 +0000 (UTC)
Date: Fri, 3 May 2024 08:31:35 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20240503073135.GR7636@redhat.com>
References: <20240502085433.GA30267@redhat.com>
 <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
 <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
 <20240502164958.GD30267@redhat.com>
 <20240502171930.GE30267@redhat.com>
 <20240502173148.GF30267@redhat.com>
 <alpine.DEB.2.22.394.2405022340080.3439@hadrien>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2405022340080.3439@hadrien>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 1689
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/20240503073135.GR7636%40redhat.com>

On Thu, May 02, 2024 at 11:41:22PM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 2 May 2024, Richard W.M. Jones wrote:
> 
> > On Thu, May 02, 2024 at 06:19:30PM +0100, Richard W.M. Jones wrote:
> > > FWIW this is the flamegraph.  It's not very informative, but maybe
> >
> > ... except that 86% of the entire time is taken in these two functions
> > (and stuff called from there):
> >
> > https://github.com/ocaml/ocaml/blob/e202de7439afaec4671da56b59dce240447ea174/middle_end/flambda/invariant_params.ml#L99-L108
> >
> > whatever that means.
> 
> I don't know what it means.  Do you want me to contact the OCaml people?
> Or do you want to contact them?
> 
> I made another test on another machine and still can't reproduce the
> problem.

Let me keep looking for a bit and see if I can find the root cause.

Rich.

> julia
> 
> 
> >
> > > means a bit more to people familiar with the internals of the OCaml
> > > compiler.
> > >
> > > http://oirase.annexia.org/2024-05-ocamlopt.svg
> >
> > Rich.
> >
> > --
> > Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> > Read my programming and virtualization blog: http://rwmj.wordpress.com
> > Fedora Windows cross-compiler. Compile Windows programs, test, and
> > build Windows installers. Over 100 libraries supported.
> > http://fedoraproject.org/wiki/MinGW
> >
> >

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

