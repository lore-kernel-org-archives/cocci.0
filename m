Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63536C10F1A
	for <cocci@archiver.kernel.org>; Tue,  7 May 2024 09:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=C5tyMV1XCVcWK+8V62yXRSUVYZKhsXDYTGkxndb5mGI=;
  b=NNvnIgjt3hcefb65qtOjRWc+A4z+7YgZT4GsXh23wFVlmTcJbezOLXxM
   RXK0wDouxdIC9fDCAouF0jHSoniVQFWksTzkfIVJRDNsuiidXn06Td8Lz
   E9gZBvYn4hby5KPbGzbihin4Ek1N8IylviZT0ExAT/DUIGVE/oFZ3gQzP
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.07,260,1708383600"; 
   d="scan'208";a="164834937"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 May 2024 11:56:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 60C8EE0138; Tue,  7 May 2024 11:56:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1E090E0035
	for <cocci@sympa.inria.fr>; Tue,  7 May 2024 11:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=C5tyMV1XCVcWK+8V62yXRSUVYZKhsXDYTGkxndb5mGI=;
  b=SmbxBhKbYgMWI+ijdE/gk4Mg8yfs05VyfvySulH+fYWMkZuRs/U0pUJ2
   tmX3m1SGremK7KjrIaQxKTi+83ot2xdiPh1Gd3ZT+7nFHqOmi7jy1kDgv
   x4j9Epbltc5OwqBB/YUDZj7Y/u1kwtOyrBXSWS/baVH6Yv31nrW0KNqbB
   w=;
X-IronPort-AV: E=Sophos;i="6.07,260,1708383600"; 
   d="scan'208";a="86551361"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 11:56:15 +0200
Date: Tue, 7 May 2024 11:56:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: "Richard W.M. Jones" <rjones@redhat.com>
cc: cocci@inria.fr
In-Reply-To: <20240507094550.GG7636@redhat.com>
Message-ID: <eff9496-f762-9333-b69e-b2fdbb2a8b18@inria.fr>
References: <20240502085433.GA30267@redhat.com> <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr> <20240502163131.GC30267@redhat.com> <6881602e-5f8e-db48-323d-139673441398@inria.fr> <20240502164958.GD30267@redhat.com> <eb315099-ed3a-d2fe-a353-5fd1b3edacfb@inria.fr>
 <20240503121530.GV7636@redhat.com> <6e1424a2-5c65-93e7-998e-8d90dc84dffc@inria.fr> <20240507094550.GG7636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1711
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/eff9496-f762-9333-b69e-b2fdbb2a8b18%40inria.fr>



On Tue, 7 May 2024, Richard W.M. Jones wrote:

> On Fri, May 03, 2024 at 05:50:28PM +0200, Julia Lawall wrote:
> > I don't know if it is worth notifying the OCaml developers.  Maybe they
> > know already that this can be a problem.
>
> My colleague had a go at a compiler patch:
>
> https://github.com/ocaml/ocaml/pull/13150

That's great.  Thanks!

julia


>
> Rich.
>
> --
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> virt-builder quickly builds VMs from scratch
> http://libguestfs.org/virt-builder.1.html
>
>
