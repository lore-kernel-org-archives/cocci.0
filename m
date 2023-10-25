Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D30C25B47
	for <cocci@archiver.kernel.org>; Wed, 25 Oct 2023 06:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+fWHb8Q8sE+PiYDCLKC7uloxSThuv697InMnmEdi2gs=;
  b=thMMqmPkncorNVbaFbdbR70hZrDTea7jnYcpJKjBKxrTmk/fBpCu1bxB
   +L8CnnvoQzOPGd5pi1fVSDNRZyL/ly5tTv7+EjY7/PjCP9NuOGo9jZn2z
   EdbnOTihwnMxFPMcWJqWyZJEP/Z42Y9sAMLUfPrUVVsfi7vTcTo34RKUg
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.03,249,1694728800"; 
   d="scan'208";a="133035596"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2023 08:31:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9701DE0CD5; Wed, 25 Oct 2023 08:31:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E6340E00BA
	for <cocci@sympa.inria.fr>; Wed, 25 Oct 2023 08:31:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+fWHb8Q8sE+PiYDCLKC7uloxSThuv697InMnmEdi2gs=;
  b=VUPfIyAq+CfzQ0GnHrxj+Z8AoHPJ2JCcc5YokQV6Rl6CQy7it7FwRWUs
   TW8FVVQjwc5JtTMRghLMJjLy8+Okoonl6CP4ozUDfiBBs0/u8q+r7JXyU
   jw9YcXFxcu5Frf7sJHX65oFJneRzLiLakhmUcUfPLsz6ndUOkkQ+Y5+zb
   A=;
X-IronPort-AV: E=Sophos;i="6.03,249,1694728800"; 
   d="scan'208";a="133035588"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 08:31:27 +0200
Date: Wed, 25 Oct 2023 08:31:27 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr, 
    =?ISO-8859-15?Q?Martin_Schr=F6der?= <info@swedishembedded.com>
In-Reply-To: <9e9bd6fe-10bc-4754-bde9-d3ba2743fb02@web.de>
Message-ID: <alpine.DEB.2.22.394.2310250831040.3084@hadrien>
References: <CAEqMKof5Ke4yV0KBZm2FW8z-Ct1UHZRDz5=Sd3gaO3a-f4+y_w@mail.gmail.com> <6213b47a-3ae7-d316-b1a4-8fb5d3bf9b5@inria.fr> <608e77e0-a36d-44ef-a2fd-9c0c50cf61b3@web.de> <CAEqMKoco-UjiPu4bwm69t1HexJi0y+cCPEH6NZ10xZCfn36=5w@mail.gmail.com>
 <alpine.DEB.2.22.394.2310240750150.3911@hadrien> <9e9bd6fe-10bc-4754-bde9-d3ba2743fb02@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Dependencies between key words =?UTF-8?Q?=E2=80=9Cgot?=
 =?UTF-8?Q?o=E2=80=9D?= and =?UTF-8?Q?=E2=80=9Creturn=E2=80=9D=3F?=
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1275
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/alpine.DEB.2.22.394.2310250831040.3084%40hadrien>



On Wed, 25 Oct 2023, Markus Elfring wrote:

> >> if(r){ ... }
> >
> > Put a return ...; after the ... to require the branch to return.
>
> Can any more restrictions become relevant for such SmPL code?
>
>
> > This will cover the case where there is a goto that leads to the return.
>
> Would you like to explain this information a bit more?

The ... follows the control-flow patch over the goto until it reaches a
return.

julia
