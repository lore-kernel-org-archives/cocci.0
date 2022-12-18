Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B8CC4332F
	for <cocci@archiver.kernel.org>; Sun, 18 Dec 2022 16:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=vrmEkAlIXOX7vc3PqDYKPwhg3a62Zd8gTgblqrNrYXk=;
  b=cKipNRUz8xqfabuJdEHCKCBrPsGvCEjbX/aphT0Rag8gAMUT8SmGM1Ab
   AvvZ8RtG4/nLAD4kqNcxxXzeBoQ2cwXqOz4BMHcnS87+fMTOr2ioZoivf
   Ei4+ppRsydcGyqPtHWHsejnq5UP0qjhq2bXWfV1lVKPKAlQAO1vjoJIO6
   A=;
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
X-IronPort-AV: E=Sophos;i="5.96,254,1665439200"; 
   d="scan'208";a="84029594"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Dec 2022 17:13:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 22305E0133; Sun, 18 Dec 2022 17:13:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 41110E0128
	for <cocci@sympa.inria.fr>; Sun, 18 Dec 2022 17:13:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vrmEkAlIXOX7vc3PqDYKPwhg3a62Zd8gTgblqrNrYXk=;
  b=HZkkLFgTi7GDbRXEdOZ2ZDFo6PdgDtIWuJsckNrfHEoOKA5ikLSRZVh7
   z5rX62LcZmeo2usunq4xqJG09N0QJtOO5t/cBGdqyjmx5PjQk/je6d7wB
   z5A6yjY5TTWfyvWqSvD0Gt/ctLZFZFFzyun3cG8iZG0up+E80qwBNv2dn
   4=;
X-IronPort-AV: E=Sophos;i="5.96,254,1665439200"; 
   d="scan'208";a="84029586"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2022 17:13:37 +0100
Date: Sun, 18 Dec 2022 17:13:36 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Andrzej Hajda <andrzej.hajda@intel.com>
cc: cocci@inria.fr
In-Reply-To: <c2cb22fd-81aa-a27b-7ac7-77ee8bf74e11@intel.com>
Message-ID: <alpine.DEB.2.22.394.2212181712570.37242@hadrien>
References: <c2cb22fd-81aa-a27b-7ac7-77ee8bf74e11@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-991223633-1671380017=:37242"
Subject: Re: [cocci] Another space oddity
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 780
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/alpine.DEB.2.22.394.2212181712570.37242%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-991223633-1671380017=:37242
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 14 Dec 2022, Andrzej Hajda wrote:

> Hi,
>
> I have found another strange space/newline behavior when changing iterator
> loops:
> Following script:
> @@
> iterator name for0;
> @@
>         for0()
> -       {
>                 0;
> -       }
>
> @@
> iterator name for0;
> @@
>         for0()
> -               { 1; }
> +               1;
>
> @@
> iterator name for0;
> @@
> -       for0() { 2; }
> +       for0() 2;
> -----------
> On file:
> int f() {
>         for0() {
>                 0;
>         }
>
>         for0() {
>                 1;
>         }
>
>         for0() {
>                 2;
>         }
> }
> Produces output:
> int f() {
>         for0()
>
>                 0;
>
>         for0() 1;
>
>         for0 ()
>                 2;
> }
> ---
> Ie. in cases:
> 0 - it adds extra line,
> 1 - removes existing line,
> 2 - produces correct output, but modifies iterator header (I would like to
> avoid, extra space between for0 and '('.

To avoid the space, you can use the argument --smpl-spacing.  Then it will
follow the spacing strategy found in the semantic patch.

julia
--8323329-991223633-1671380017=:37242--
