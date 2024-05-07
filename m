Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CA1C25B4F
	for <cocci@archiver.kernel.org>; Tue,  7 May 2024 09:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=eqaYb6lDAeVnxHNDK2hOV9UrRd/9tAne3nnrQ3faD9M=;
  b=iPTroCMIJmrFbZ6SpMw+U2It/A6WoCKRK/LHegTSJi2V8TxQbh82QYGE
   StHJtGjpgU3OmjpZZU2wsz2eJbagovTLlQcA8KrjfnIFv6UER0ZpHzUO5
   He3CKm2SlZxXsb3c5G1qrI/zOlE6xZiuNLfsV3G9iG0s/GqqpJWOyJ51L
   U=;
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
X-IronPort-AV: E=Sophos;i="6.07,260,1708383600"; 
   d="scan'208";a="164831730"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 May 2024 11:46:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F3E0AE0145; Tue,  7 May 2024 11:46:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1BFFBE0035
	for <cocci@sympa.inria.fr>; Tue,  7 May 2024 11:45:57 +0200 (CEST)
IronPort-SDR: 6639f854_aGm4dBuVMS4iYfQc9v5E6wPfEHN2OHXERgHZXW9G6DPxnCZ
 KS7fWikBHyySV0GJ9wJRe/VLW4EvptX9nvA+0Yg==
X-IPAS-Result: =?us-ascii?q?A0EDAAAn9zlmh3yBCqpaFgQBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBOwUBAQEBCwGCGyh8gQoEC0iMc1+GS4IlmC+FW4FAPg8BA?=
 =?us-ascii?q?wELAQE5CwQBAQMEhH8CiDACHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEIAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEBASIXBw4QJ4V0DYJnEYEOZQk4AQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBFwINfAEBAQMSKAYBATcBDwsYLhRINYJeAYJkAxGlfAGMdQEBAXaBN?=
 =?us-ascii?q?IEBggwBAQaCZtsZCYFIAYgtAYlCeicVBoFJRIQ/PoFSgQ8CAYgjmiqNcVR9H?=
 =?us-ascii?q?ANZIREBVRMXCz4JFgIWAxsUBDAPCQsmAyoGNgISDAYGBlkgFgkEIwMIBAMQN?=
 =?us-ascii?q?AMgcREDBBoECwd1gXyBNQQTR4E4iXoMgX2BNCmBTimEIEtshAqBeA5ig1yEA?=
 =?us-ascii?q?h1AAwttPTUUGwYiAaF+hHUBAYEEQbFplQMHA4QTjA6VHgQWM4NyE4FWkV0MO?=
 =?us-ascii?q?ZI3LodYkFyNdIdOkxsCCgcXgWU6gVxwFYMiCUYDGQ+GQYdgGYEVAQmCQoUUm?=
 =?us-ascii?q?S9CNQI5AgcLAQEDCYkigUgBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 9ViD7XSxKhIFayJ5ICr9A==
IronPort-HdrOrdr: A9a23:LfKpF6P2iQiwNMBcTuKjsMiBIKoaSvp037Dk7TETdfVwSL3lqy
 nOpoVn6faQsl0ssR4b9+xoVJPgfZqYz+8S3WBzB8bEYOCFghrMEGgK1+KLqVGOJ8S9zJ846U
 4KSdkdNDSfNzhHZIrBkXCF+3tK+rS6GCfCv5al85+4JjsaEJ2Jg2pCe36mLnE=
X-Talos-CUID: 9a23:Uuo5IG6S0YSyNOooHtssrW4dPpo5S37m1UjxEQyhMk11V6KnRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AwzDt2A7wCt/U6SxWMHjX65/dxoxBwPSDOUAnvqk?=
 =?us-ascii?q?/psS6MHxCEjukgSSOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,260,1708383600"; 
   d="scan'208";a="86549854"
X-MGA-submission: =?us-ascii?q?MDEmSAdz2Wm7JnIno76Fl3dSl6oJdSH7nySEGW?=
 =?us-ascii?q?k30mzUX/HB1yja0e3AfnV18E+rAV+kyoDS6qXbo0r9q4TkqeVKPDnUET?=
 =?us-ascii?q?fX7243KZRgaU3BPU2osr1RuiGV1LOgQBDd96HKq1be7ymFimXm9kN2qk?=
 =?us-ascii?q?OpbZdhfuVXywAyHP7vzb+gOg=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 11:45:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715075154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eqaYb6lDAeVnxHNDK2hOV9UrRd/9tAne3nnrQ3faD9M=;
	b=aBS1ioJVBDDtUL7YB+WRIH80zVD9m4r35EtvXpfeOnduN6Pp9q800bVcwcDNrCeO8DO7SY
	hPA6mZYk1tCZxTUKD/VyXrVAZPfTjpKVfXPvCA6GqNkY2ErxCqfRas+0LY4+7oBDaSXtpM
	o/IgWWt6nBxs757RUIh9PfiGe1VSlAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-H-AnGm31M0umtf3LRIsXJw-1; Tue, 07 May 2024 05:45:51 -0400
X-MC-Unique: H-AnGm31M0umtf3LRIsXJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D03FD801785;
	Tue,  7 May 2024 09:45:50 +0000 (UTC)
Received: from localhost (unknown [10.42.28.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A09931C033FC;
	Tue,  7 May 2024 09:45:50 +0000 (UTC)
Date: Tue, 7 May 2024 10:45:50 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20240507094550.GG7636@redhat.com>
References: <20240502085433.GA30267@redhat.com>
 <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
 <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
 <20240502164958.GD30267@redhat.com>
 <eb315099-ed3a-d2fe-a353-5fd1b3edacfb@inria.fr>
 <20240503121530.GV7636@redhat.com>
 <6e1424a2-5c65-93e7-998e-8d90dc84dffc@inria.fr>
MIME-Version: 1.0
In-Reply-To: <6e1424a2-5c65-93e7-998e-8d90dc84dffc@inria.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 1710
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/20240507094550.GG7636%40redhat.com>

On Fri, May 03, 2024 at 05:50:28PM +0200, Julia Lawall wrote:
> I don't know if it is worth notifying the OCaml developers.  Maybe they
> know already that this can be a problem.

My colleague had a go at a compiler patch:

https://github.com/ocaml/ocaml/pull/13150

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

