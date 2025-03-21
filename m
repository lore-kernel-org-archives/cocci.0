Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2850FC36002
	for <cocci@archiver.kernel.org>; Fri, 21 Mar 2025 14:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Uy+6w9NcSAN8OjzMEMM/HrqnFHOKaGLZkUR3GFvMBt0=;
  b=Xjr8yg3ud/J7PUPJBGkSSIGJ0jVSLJNB+azBBPukAzHzo+5an+ktggaB
   qzJCzoX3CM0MfpNExf3SCf5HQWrUIZgunzGLIc+35C6DNJCDDtDC5ci59
   xZav1iOlYt7BOHRllZEGai/iFTETgb0EjGB6Peo+bxuUD6QR56xrmkJJz
   E=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214155868"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2025 15:45:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B90C2E0D1D; Fri, 21 Mar 2025 15:45:22 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B70FAE007A
	for <cocci@sympa.inria.fr>; Fri, 21 Mar 2025 15:45:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Uy+6w9NcSAN8OjzMEMM/HrqnFHOKaGLZkUR3GFvMBt0=;
  b=JnlBOjJl5sarBJnEgN+btJuR0m49dXiXNZHToCWBQUWmtmaMPcvUIq7p
   /+mhH1+Djzce2RX33QGtz7mQHnQszwPpRDxz6NUiJLLKLZQRNO/1fS9y0
   vWao0Hfy2+LqYDPzU11FFIWwyHGmMOiux5qLnEFAYZ5O5ZcBQRoYynv4g
   I=;
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="112267615"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 15:45:21 +0100
Date: Fri, 21 Mar 2025 15:45:21 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <a5c6c5e1-d04f-4a93-b37a-cfc797a021a2@web.de>
Message-ID: <af3f266-cea-3d1e-6ad9-96fc522db1cf@inria.fr>
References: <99c55fe9-b23f-a6c2-575-9a856a8a358c@inria.fr> <a5c6c5e1-d04f-4a93-b37a-cfc797a021a2@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1584474787-1742568321=:3459"
Subject: Re: [cocci] scoped_guard
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2674
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/af3f266-cea-3d1e-6ad9-96fc522db1cf%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1584474787-1742568321=:3459
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 21 Mar 2025, Markus Elfring wrote:

> > Coccinelle offers the "metavariable" type iterator for the names of things
> > that work like for or while.  That is, they represent the header of a
> > block and they cause a loop.
>
> Does this language construct support already code blocks which would “accidentally”
> be executed only once?

An iterator name matches something whose control flow graph contains a
back edge to the top of the loop.  That is not the case of scoped_guard.
For iterator name, it doesn't matter how many times the body of the loop
is executed at run time.

julia
--8323329-1584474787-1742568321=:3459--
