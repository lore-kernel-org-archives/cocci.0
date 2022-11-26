Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927B9C4332F
	for <cocci@archiver.kernel.org>; Sat, 26 Nov 2022 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=0Ip/z1MyMSEUmDl+hFaKc0l6KUw1PadRtyXm66GYI2Q=;
  b=g/rJZf/d1KLxbi49S19HZ6cX7s6DaJh8EWMWqcNY0ksh4u1zs6JFBEhb
   eP2TTdWhuYC4paQ7yQ2oFYseC5yHmx6Q4cI5Ro9ET+tHq1kbRqD+6vxQM
   PeONOkVO2oQvDxeuPuque5VvGwNnum50NE2LfsLAhksVuqswxhEZCBDYe
   U=;
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
X-IronPort-AV: E=Sophos;i="5.96,194,1665439200"; 
   d="scan'208";a="80173647"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2022 11:31:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9FB57E02A3; Sat, 26 Nov 2022 11:31:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 54B77E0010
	for <cocci@sympa.inria.fr>; Sat, 26 Nov 2022 11:31:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0Ip/z1MyMSEUmDl+hFaKc0l6KUw1PadRtyXm66GYI2Q=;
  b=YpxGSCX06ZV4Z5rnaAAObjKLcI37lZs8vprvELCCiSV+tWVpvODVg8EV
   MegZdyA/T22FDWaDMwZ1jK5QnNofs6C0xPgY9/bngth+XOZwCnltk2WP9
   rmrzDGQUUsfEIdACN25SRRvqJLTURQUalEUZzeb01CtwPp4ialsb4TFo4
   A=;
X-IronPort-AV: E=Sophos;i="5.96,194,1665439200"; 
   d="scan'208";a="40861653"
Received: from 214.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 11:31:44 +0100
Date: Sat, 26 Nov 2022 11:31:42 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <79bb70c9-3257-504c-7d52-55ccaf51f640@web.de>
Message-ID: <alpine.DEB.2.22.394.2211261130330.15234@hadrien>
References: <dce20c86-de6b-92ef-3bc3-af39ca99b5c4@web.de> <alpine.DEB.2.22.394.2211201641340.40755@hadrien> <79bb70c9-3257-504c-7d52-55ccaf51f640@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Data structures for source file analyses
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 756
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/alpine.DEB.2.22.394.2211261130330.15234%40hadrien>



On Sat, 26 Nov 2022, Markus Elfring wrote:

> >> How do you call the intermediate data representations according to the involved
> >> processing pipelines?
> > Abstrat syntax tree? Control-flow graph?
>
>
> How are preprocessor directives (for example) integrated into the taxonomy of
> the Coccinelle software?

I have no real idea what the above question means.  Things that Coccinelle
is able to parse are put into the AST.  Things that it is not able to
parse are attached as comments to neighboring tokens.  There is no general
anser for preprocessing directives.  Some are parsed and some are not.

julia
