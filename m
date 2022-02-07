Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63935C433EF
	for <cocci@archiver.kernel.org>; Mon,  7 Feb 2022 13:48:30 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="20087958"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Feb 2022 14:48:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 622FAE0385; Mon,  7 Feb 2022 14:48:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E896FE0380
	for <cocci@sympa.inria.fr>; Mon,  7 Feb 2022 14:48:25 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.88,349,1635199200"; 
   d="scan'208";a="20087953"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 14:48:26 +0100
Date: Mon, 7 Feb 2022 14:48:25 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
cc: cocci@inria.fr
In-Reply-To: <98066af4-1d26-dead-4e85-71ef0ec45d47@linux.com>
Message-ID: <alpine.DEB.2.22.394.2202071447030.52266@hadrien>
References: <cd9a37f0-9a90-1df5-cec7-853a783e5538@linux.com> <alpine.DEB.2.22.394.2202061941500.3126@hadrien> <f07ed61b-96e5-d99f-dc0f-d3f39b8291bf@linux.com> <alpine.DEB.2.22.394.2202062047220.3126@hadrien> <412f6138-c5de-38f4-553b-6b34a0650005@linux.com>
 <alpine.DEB.2.22.394.2202062158390.3126@hadrien> <efdc5e18-fdc4-56d6-f78e-0e47fe24ef02@linux.com> <alpine.DEB.2.22.394.2202070752260.3105@hadrien> <bb419c62-f560-e918-2eb2-94f489a93f4a@linux.com> <alpine.DEB.2.22.394.2202071053010.3105@hadrien>
 <d3e3961b-b0d5-6107-c14b-1e745ce1a631@linux.com> <alpine.DEB.2.22.394.2202071355350.52266@hadrien> <98066af4-1d26-dead-4e85-71ef0ec45d47@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] spatch 1.1.1 segmentation fault report
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 138
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/alpine.DEB.2.22.394.2202071447030.52266%40hadrien>

> Thank you! I don't need a new release. But if there is a way to slightly change the pattern
> to avoid the crash this will be useful to me.

I don't think so.  The log message on the commit is:

GC full major collection prevents dangling references on Python objects to
be collected after Python unloading, which led to segmentation fault.

So maybe in the future it will be possible to get the fix from a more
recent version of pyml from opam.

julia
