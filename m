Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3680AC4345F
	for <cocci@archiver.kernel.org>; Fri,  3 May 2024 10:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=REytUzcnxWew18jKyyk5sbP6dbmfe0mEP659KwzNBzs=;
  b=sasQC55ibIeq3wrG+341uRc6+Xy2dBECTCceo5prXGBv9Bfzsi1/8+Kz
   Ui9HFzI/tltYhud8yscDIBvB1rZVDtUEY56U7NKgMUDP612MJ+2+o2RiV
   ABZBGpmyQIfyO44hYu6IxMpmQHEqILVGy01WZbO1cHhVXvoM0T47KSqqx
   0=;
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
   d="scan'208";a="164373784"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 May 2024 12:24:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 45EF6E0138; Fri,  3 May 2024 12:24:16 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DE99CE0035
	for <cocci@sympa.inria.fr>; Fri,  3 May 2024 12:24:10 +0200 (CEST)
IronPort-SDR: 6634bb49_qw+Lak8eI7AQYaGTFIsuGi2AUO6YK5yG98ApZ9EY4J5iP1A
 z31E2Nr1OC103U671J8ZN6L1E578+hjl7oSaWXQ==
X-IPAS-Result: =?us-ascii?q?A0EDAAAEujRmh3yBCqpaFgQBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBOwUBAQEBCwGCQ3yBCgQLSIxzX4ZKgiWYL4VbgUA+DwEDA?=
 =?us-ascii?q?QsBATUPBAEBAwSCC4J0AoguAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBAQEiFwcOECeFdA2CZxGBDmUJOAEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBGAINewEBAQECARIoBgEBNwEECwsYLhRINYJeAYJBIwOmFAGMdQEBA?=
 =?us-ascii?q?XaBNIEBggwBAQaCZtsZCYFIAYgtAYlCeicVBoFJRIQ/PoFSiTWaK4xwVH0cA?=
 =?us-ascii?q?1khAhEBVRMXCz4JFgIWAxsUBDAPCQsmAyoGNgISDAYGBlkgFgkEIwMIBAMQN?=
 =?us-ascii?q?AMgbxEDBBoECwd1gXyBNQQTR4E4iX0MgX2BNCmBTimEIUtshAuBeA5ig2GCW?=
 =?us-ascii?q?x1AAwttPTUUGwYiAaEIhHGzL5UDBwOEE4wOlR4EFjODchOBVpFdDDmSNy6HW?=
 =?us-ascii?q?JBcjXSHTo18hR8CCgcXgWU6gVxwFYMiCUYDGQ+OIBmDYYUUlUFCNTsCBwsBA?=
 =?us-ascii?q?QMJiSKBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vRAI5TzOahdFH1s5Q==
IronPort-HdrOrdr: A9a23:FQkRVaPlZ7PgcMBcTtSjsMiBIKoaSvp037BL7SBMoHNuGfBw+/
 rFoB15737JYVQqN03I8OroUJVoJ0mwyXcf2+cs1NmZMDXOiS+DKoZ+5YH+hx3scheOldJg6Q
 ==
X-Talos-CUID: =?us-ascii?q?9a23=3AELChIGqn4VeaSLI6MbeuY57mUZh/TCOFxmfdHxS?=
 =?us-ascii?q?9O0JGFOSXRE6hoLwxxg=3D=3D?=
X-Talos-MUID: 9a23:j5VuLAiZQ6SnmUQWetM9MMMpP8ZZuPu/Jmc2tMsmgefeOAB6B2fFg2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,251,1708383600"; 
   d="scan'208";a="86305313"
X-MGA-submission: =?us-ascii?q?MDHykMidp6Y65bGfeoW5biuSRw4jeKlUnWl41M?=
 =?us-ascii?q?fvB8UvWPg8m3rwTAuhvKY+MT5/qpBzKnqDH+n/IzMTizgUmYjNUY48LX?=
 =?us-ascii?q?Qp7PdIMD/2fAE2RUGofbZXhZb0UpHkV9XswOwOco4bN6AEAjXvqXtNTA?=
 =?us-ascii?q?ZKeJjjiXXp8PDg41vESEKHCQ=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 12:24:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714731847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REytUzcnxWew18jKyyk5sbP6dbmfe0mEP659KwzNBzs=;
	b=abNMoLbJAGCpJu1eV6IEkuwdazSvgKbxCmtfoaomTbKeJHpyYSgKzuAel4x93cLGK8mFzB
	lL+fUGXCjEWhoNjrf8658tl8GjozokvUB/341koD30fpuuZb6XiGah4ztFCBssctcx8VGJ
	rGIYvD9e6w01n2Gv9vAf5B+XpbAQVTA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-SndP1Z3EPXG8db__oA5rZQ-1; Fri, 03 May 2024 06:24:05 -0400
X-MC-Unique: SndP1Z3EPXG8db__oA5rZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BF17800935;
	Fri,  3 May 2024 10:24:05 +0000 (UTC)
Received: from localhost (unknown [10.42.28.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E6615C13FA1;
	Fri,  3 May 2024 10:24:04 +0000 (UTC)
Date: Fri, 3 May 2024 11:24:04 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr
Message-ID: <20240503102404.GG30267@redhat.com>
References: <20240502085433.GA30267@redhat.com>
 <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
 <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
 <20240502164958.GD30267@redhat.com>
 <20240502171930.GE30267@redhat.com>
 <20240502173148.GF30267@redhat.com>
 <alpine.DEB.2.22.394.2405022340080.3439@hadrien>
 <20240503073135.GR7636@redhat.com>
 <f353bd20-1821-4112-b12b-bd1a111f7d20@web.de>
MIME-Version: 1.0
In-Reply-To: <f353bd20-1821-4112-b12b-bd1a111f7d20@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 1691
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/20240503102404.GG30267%40redhat.com>

On Fri, May 03, 2024 at 10:00:20AM +0200, Markus Elfring wrote:
> > Let me keep looking for a bit and see if I can find the root cause.
> 
> Can the analysis become easier anyhow according to questionable software run time characteristics?

I don't understand what this means.

Rich.

> Regards,
> Markus

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v

