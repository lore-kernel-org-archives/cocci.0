Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BCDC4345F
	for <cocci@archiver.kernel.org>; Thu,  2 May 2024 16:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=MusYq3pGBZdG2I2ruA2NuMRwPrT5TRtYE1WfPg3WjU8=;
  b=ReshsBZO8LDM+5LY5M0+D0s4s1FYzQvfAYY/MHjWMntF9jgJyU8tVgy/
   KWXjSBKS1VQ4EWXe0Px5yiQVhjQDG7QjiHhG0BRwdRgi8VdeLSCb/y/pS
   Ffz1tPcRNYuZx21bR8Er83BeevZnus+ctk39sAZNyX9sW1EV5OaK7wR7/
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
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164269665"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 May 2024 18:16:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7D013E0141; Thu,  2 May 2024 18:16:43 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 02046E0035
	for <cocci@sympa.inria.fr>; Thu,  2 May 2024 18:16:41 +0200 (CEST)
IronPort-SDR: 6633bc68_X6BOmqzEy9xW4ZniQ7DAaB/vEEWrmsAdhqmqxKTHfIejeix
 7WM0G/g53p7BTDNpAGvv+nsME6vi/HjlAzuFRZg==
X-IPAS-Result: =?us-ascii?q?A0EDAABouzNmh3yBCqpaFgQBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBOwUBAQEBCwGCQ3yBCgQLSIxzX4ZKgiWYL4VbgUA+DwEDA?=
 =?us-ascii?q?QsBATUPBAEBAwSEfwKILgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQgBAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABAQEBIhcHDhAnhXANgkougQ5lCTgBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARgCDXsBAQEBAgESKAYBATcBBAsLGC4USDWCXgGCQSMDqWgBjHUBAQF2g?=
 =?us-ascii?q?TSBAYIMAQEGgmbbGQmBSAGILQGJQnonFQaBSUSEPz6BUocGgi+UBIVmQYN5i?=
 =?us-ascii?q?DJUfRwDWSECEQFVExcLPgkWAhYDGxQEMA8JCyYDKgY2AhIMBgYGWSAWCQQjA?=
 =?us-ascii?q?wgEAxA0AyBvEQMEGgQLB3WBfIE1BBNHgTiJfQyBfYE0KYFOKYQhS2yEC4F4D?=
 =?us-ascii?q?mKDYYIgHUADC209NRQbBiIBoGCEbSGCH7BvlQMHA4QTjA6VHgQWM4QFgVaRX?=
 =?us-ascii?q?Qw5kjcuh1iQXI10h06TGwIKBxeBZTqBXHAVgyIJRgMZD44gDA0Jg1iFFJgNQ?=
 =?us-ascii?q?jU7AgcLAQEDCYkigUgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vVALpTw6Ilp6Kyc5VFO9Tg0xg==
IronPort-HdrOrdr: A9a23:roP3UK7LnBv75xpXzQPXwNfXdLJyesId70hD6qkRc3xom6Oj5q
 WTdZgguyMc6wx/ZJhDo7y90cC7KBu2n/NICO8qTNSftWHdyQ+VxepZjLcKrQeQeRHDyg==
X-Talos-CUID: 9a23:hRO+h27+ZkmnE4qhCtss6Q0uP88EeVHk3lyMe2+DDX1NQ6bSYArF
X-Talos-MUID: 9a23:abQH3QnXrQQVJIaVTsTRdnpoEMZn+5SvDXtWuq07sNOpCnZ5PiWS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164269662"
X-MGA-submission: =?us-ascii?q?MDE/m/fcsIGnSpvVZpyHo6iQeuytDVqli+p79v?=
 =?us-ascii?q?qRT5Lf4b8pw7dKjx2LPqSpQs7ocH4I97rwDHSXRiERB78x5Tn0FdQkiq?=
 =?us-ascii?q?D8CLTOLiH9w+jzuuXgzMbfHtcRRMt9ALmAMdNYzPIu9M1IP9Y1e0mhmM?=
 =?us-ascii?q?9HXnftxSyhUrDDgk9vVE/8ug=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 18:16:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714666596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MusYq3pGBZdG2I2ruA2NuMRwPrT5TRtYE1WfPg3WjU8=;
	b=CS8ls+GLbfN9fYK1cMehCk7fn56I/HKhhmrxiFW4aUA7aNVQ5F8NN5slXC7wPmzpa+zdXb
	GSmJaOz/SDqi46HarjVFu/FbB6RNeP2JelU5lhfTPiV9Fsg+bgQHmtSUjff4fRNBHt7Yfv
	uFeoHp0mztCLULyj/oZiN3wO6X9Don8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-jqjfl3LZMHWYk9iERlPqoA-1; Thu,
 02 May 2024 12:16:27 -0400
X-MC-Unique: jqjfl3LZMHWYk9iERlPqoA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B44E71C0C656;
	Thu,  2 May 2024 16:16:26 +0000 (UTC)
Received: from localhost (unknown [10.42.28.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6C81740EDEF;
	Thu,  2 May 2024 16:16:25 +0000 (UTC)
Date: Thu, 2 May 2024 17:16:25 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: cocci@inria.fr
Message-ID: <20240502161625.GB30267@redhat.com>
References: <20240502085433.GA30267@redhat.com>
 <4vbt6ijjdgqd23lyqgkydqvzvhqeq37a3uqmxvif3amur3ei7z@lokx6uszecfy>
MIME-Version: 1.0
In-Reply-To: <4vbt6ijjdgqd23lyqgkydqvzvhqeq37a3uqmxvif3amur3ei7z@lokx6uszecfy>
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
X-Sequence: 1680
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/20240502161625.GB30267%40redhat.com>

On Thu, May 02, 2024 at 11:01:14AM +0200, Wolfram Sang wrote:
> Hi Rich,
> 
> > Is this a known issue?
> 
> I can't confirm. On my laptop from 2017 (2 cores, 8 GB RAM), compiling
> from latest git (after 'make clean') takes 90 seconds.
> 
> OCaml: The OCaml toplevel, version 4.14.1

I think there is some significant difference between OCaml 4.x and
OCaml 5.1.1.  Can you see if updating to OCaml 5.1.1 makes it slower?

Rich.

> Menhir: menhir, version 20231231
> 
> Both from Debian Testing.
> 
> Or did I miss a step?
> 
> Happy hacking,
> 
>    Wolfram
> 



-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

