Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B726D606A330
	for <cocci@archiver.kernel.org>; Fri, 13 Nov 2026 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=fr2Ls5C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Kdb9bBgAcOZS0+QxO3gwBuSQ6iT+It6F3p0UKX9sZB8=;
  b=fr2Ls5C6yzBz/TPc9Hz5ZAzPKV3zTSug3ANbZhPu3SooElhuFaxnIUvo
   xU0LGUV0KUcHIBkaV9XFgApS42L/9mHE+BY+sDetvxExT3b1lo5bIjTIv
   yz5kduM6u2YKN++Md08wLF4yEYpn7M6VVLaiYx9qfnq2dRqu1M8z8Cy0L
   c=;
X-CSE-ConnectionGUID: InTX1OR9QGix/fvwU0rJNA==
X-CSE-MsgGUID: NeF33WKGQvG6bxToPGfA2w==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,212,1787004000"; 
   d="scan'208";a="305356649"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2026 23:07:56 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id A60FD80F8C; Fri, 13 Nov 2026 23:07:56 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id DE4C480587
	for <cocci@sympa.inria.fr>; Fri, 13 Nov 2026 23:07:50 +0100 (CET)
X-CSE-ConnectionGUID: fZFuXF4PTee4qC9PA0R2Tg==
X-CSE-MsgGUID: ZJLmO/EoTHWsgw6uR58qRA==
X-IronPort-AV: E=Sophos;i="6.27,212,1787004000"; 
   d="scan'208";a="305356630"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien1.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 23:07:51 +0100
Date: Fri, 13 Nov 2026 23:07:50 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: picca <picca@debian.org>
cc: cocci@inria.fr
In-Reply-To: <b4048ae138808c03693d43cd183c7ab8@debian.org>
Message-ID: <f7e0d31a-d8a5-cdb7-9cd0-998511f1216c@inria.fr>
References: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org> <b225b777-9216-635a-76b8-fc46f6d6a3@inria.fr> <b4048ae138808c03693d43cd183c7ab8@debian.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3807
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/AcodIWcmB29MqmVUpu3A8A>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The macros in standard.h get expanded before any other processing.

Some options:

* We remove the #define INLINE inline in standard.h
I don't know if anyone is relying on this macro.

* You make your own copy of standard.h for your software.  Then you would
need to include it on the command line with --macro-file-builtins
yourfile.h.  This is a good solution if you have eg multiple macros that
are causing problems for parsing.

* There is a command line option --undefined NAME, which makes NAME be
considered to be undefined for the purposes of evaluating ifdefs.  Maybe
this could be extended to all uses of the macro name.  Then you would need
to write --undefined NAME on the command line.

Rather than adding options on the command line, you can also put them in
the semantic patch, with a line like

--undefined NAME

Do any of these seem acceptable?

thanks,
julia
