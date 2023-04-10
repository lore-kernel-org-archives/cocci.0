Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82819C77B61
	for <cocci@archiver.kernel.org>; Mon, 10 Apr 2023 06:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=zRxGJ68ailP9udrbMv4uuqBQRz4OvGbSVTRqItSo33U=;
  b=WR4cCHmQGSCCWLEg2LFCj9fvL2/h8ad/VfG8kaVMdoFulqCiY9RR6ioc
   0pHep0QEtxqFLdIQLstm+vG5/fMEhdxS+fNeva2477x0iL3o2xOCMxsat
   7jwBY4MWuFwNpMlUOM85DwQ6JUrs5TaT33pffphvwvJ/LKPPBq/Vc4p6r
   A=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.98,332,1673910000"; 
   d="scan'208";a="102249008"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Apr 2023 08:25:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B69D8E7313; Mon, 10 Apr 2023 08:25:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id EDD0BE72F8
	for <cocci@sympa.inria.fr>; Mon, 10 Apr 2023 08:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zRxGJ68ailP9udrbMv4uuqBQRz4OvGbSVTRqItSo33U=;
  b=MAx8Sy+qZvJVEjxr5HVHUP/nb7gupE2E1vONifzeSb5/uOE0x2Nb/4jm
   oyiPSxMPnAA2XP1cdMZcNkb1WnK0s4OnwB7LELwvmMPNE8KYvTZLKR8cc
   Fkce2Tm6XEUMl2HuXH19dnrvpbGbZ9wExSznkfdgQuAUwOL7aEvyWhpwy
   s=;
X-IronPort-AV: E=Sophos;i="5.98,332,1673910000"; 
   d="scan'208";a="102249005"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 08:25:53 +0200
Date: Mon, 10 Apr 2023 08:25:53 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, kernel-janitors@vger.kernel.org
In-Reply-To: <95caa4c1-2455-2733-ef4b-3ab07783c725@web.de>
Message-ID: <alpine.DEB.2.22.394.2304100824510.3387@hadrien>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de> <1a11455f-ab57-dce0-1677-6beb8492a257@web.de> <alpine.DEB.2.22.394.2304092044020.3028@hadrien> <95caa4c1-2455-2733-ef4b-3ab07783c725@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1380549962-1681107953=:3387"
Subject: Re: [cocci] Reconsidering pointer dereferences before null pointer
 checks (with SmPL)
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1018
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/alpine.DEB.2.22.394.2304100824510.3387%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1380549962-1681107953=:3387
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 10 Apr 2023, Markus Elfring wrote:

> > Setting var to &input->member does not cause any immediate problem.
>
> Undefined behaviour would be involved if the expression variable “input”
> will actually be resolved to a null pointer, wouldn't it?

No.  &input->member adds an offset to the address of input.

julia
--8323329-1380549962-1681107953=:3387--
