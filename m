Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483CEC433FE
	for <cocci@archiver.kernel.org>; Sun, 20 Nov 2022 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=ASG3LKacWsjArkXSZr6B6GjOmExilNCLu6Gu55gyNgk=;
  b=vGZ0BdC6vesfyX+WYBpHM3VR1xO0N9rBEL7w7gDbSvaonZgHN08eYCLm
   fhOrskFkYgqRaeW1AaqVKA0QyNj2C11EvKia8L9RSsEABTBmW+WToEw3z
   jH2J0x8LiDLqRMYK5Uf7yJXLA7mrDQ0yMXFpXBiZedRBSx0nxphwn348w
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
X-IronPort-AV: E=Sophos;i="5.96,179,1665439200"; 
   d="scan'208";a="79131891"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2022 16:41:50 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B8859E0290; Sun, 20 Nov 2022 16:41:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 916D8E027C
	for <cocci@sympa.inria.fr>; Sun, 20 Nov 2022 16:41:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ASG3LKacWsjArkXSZr6B6GjOmExilNCLu6Gu55gyNgk=;
  b=PCO7in7IK2tBIxmAGFA9wce+egUJ8bD+lGVmnv50a/3MnJrCOdIiExo0
   XgPGzfSM/hhz+blmBgMVC/1I11ihah/oOHx1eNWJSlxAMTWv5qIR0njEx
   citdUggywgPNzV63IycPhIsiJykCcsJcDnUzC+nvv/At3sOpaICT+xRbk
   k=;
X-IronPort-AV: E=Sophos;i="5.96,179,1665439200"; 
   d="scan'208";a="79131888"
Received: from ip-122.net-89-2-7.rev.numericable.fr (HELO hadrien) ([89.2.7.122])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 16:41:49 +0100
Date: Sun, 20 Nov 2022 16:41:49 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <dce20c86-de6b-92ef-3bc3-af39ca99b5c4@web.de>
Message-ID: <alpine.DEB.2.22.394.2211201641340.40755@hadrien>
References: <dce20c86-de6b-92ef-3bc3-af39ca99b5c4@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Data structures for source file analyses
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 752
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/alpine.DEB.2.22.394.2211201641340.40755%40hadrien>



On Sun, 20 Nov 2022, Markus Elfring wrote:

> Hello,
>
> The semantic patch language (Coccinelle software) can read some source files.
> They are converted to internal data structures.
>
> How do you call the intermediate data representations according to the involved
> processing pipelines?

Abstrat syntax tree? Control-flow graph?

julia
