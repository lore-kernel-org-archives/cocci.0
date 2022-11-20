Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2451C433FE
	for <cocci@archiver.kernel.org>; Sun, 20 Nov 2022 04:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bZq18OZnRSfbpXSB+XefMRP4B9OmZ7ohS2Dn73Tozw8=;
  b=kLLoVGYLOmbPcinkquqTGNeFqZxH7I9cYa4kXTp9+2hoSY9pW0GjE/9P
   6SqSYVQssdooD6vhhSbouzkPlgYrZejckb4jeKGwBIh76avIW/4ukeMHU
   fJ66aD396kBgo3T/LjcojHS5Wrt3dQPbSU/y8oD3zMDnOPO/znfQGtTFM
   Q=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.96,178,1665439200"; 
   d="scan'208";a="79101349"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2022 05:48:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CE85EE027D; Sun, 20 Nov 2022 05:48:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9B65EE027C
	for <cocci@sympa.inria.fr>; Sun, 20 Nov 2022 05:48:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=bZq18OZnRSfbpXSB+XefMRP4B9OmZ7ohS2Dn73Tozw8=;
  b=ROSwRFbx6KBuIxnVdORuvNwaL0ftVdgQOuRARixsdmIxvACnGkaf9jlJ
   tFBxZG6SKOupcAo+06jnKs2MmbApl8nAsiYcn1EID/8Yjvmrk9jsd+ezO
   NUPBDVw6Vc3VT2ehmyJgKKzYQ5JzlDNI3NNYGZ8MeCcs1wLplXXPTytL4
   w=;
X-IronPort-AV: E=Sophos;i="5.96,178,1665439200"; 
   d="scan'208";a="79101348"
X-MGA-submission: =?us-ascii?q?MDEBq3kCWwLsQ/DvWFieT+YfNMxabmJVHTKfDp?=
 =?us-ascii?q?mFY2Xt1vOGvwKlBjZCizhctC5m2r+7+eS0foD0ulVC9HfDu2v03/OQs2?=
 =?us-ascii?q?eWzbvkQTWHxF4zEFv3HNBHAxLiJ83/Bv1Tzf7vFgxEDXr6SDPgmqg9Yt?=
 =?us-ascii?q?s4C434ZbdtZKItUtxGimpjzg=3D=3D?=
Received: from zcs-store9.inria.fr ([128.93.142.36])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2022 05:48:46 +0100
Date: Sun, 20 Nov 2022 05:48:45 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: cocci <cocci@inria.fr>, gregkh@linuxfoundation.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	nicolas palix <nicolas.palix@imag.fr>
Message-ID: <1149742048.11906171.1668919725846.JavaMail.zimbra@inria.fr>
In-Reply-To: <44c42da0-aa89-41ec-d539-8bc5ee168ddc@loongson.cn>
References: <alpine.DEB.2.22.394.2209212125590.2783@hadrien> <44c42da0-aa89-41ec-d539-8bc5ee168ddc@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.2.7.122]
X-Mailer: Zimbra 8.8.15_GA_4464 (ZimbraWebClient - FF106 (Linux)/8.8.15_GA_4468)
Thread-Topic: scripts: coccicheck: use "grep -E" instead of "egrep"
Thread-Index: /wvYSdZmgka+dfRQqzNi/gIC6kJo4Q==
Subject: Re: [cocci] [PATCH] scripts: coccicheck: use "grep -E" instead of
 "egrep"
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 750
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/1149742048.11906171.1668919725846.JavaMail.zimbra%40inria.fr>



> Hi,
> 
> This patch can not be found in the torvalds/linux.git or
> next/linux-next.git tree, please take a look, thank you.

I missed the last merge window.  It is in my tree on kernel.org, though.

julia
