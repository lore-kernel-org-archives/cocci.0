Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857CA10ED659
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2026 10:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:reply-to:references:
   in-reply-to:content-transfer-encoding:subject:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1oqw+tgtaWGsdfVUGR61ND4t47OdaAtlYYvPKq8rfWk=;
  b=cxGl/DvFYEFsP1OjVbGdH2hbDVz+sWFauPL1ywWKVAf+GVC9gktakYJM
   JDI5h5Bv0rdiSJkZP3pnupiVwszat5xPAZOkQC2qp/zbIBodN+57+Rd7N
   nwwchhZUwtnNc64/gf82iK5S3nojlL9x3eYWOYB6Ff163JJSRjup3DfgW
   U=;
X-CSE-ConnectionGUID: ui0IIYWZQnSdWyp/Wm+OKQ==
X-CSE-MsgGUID: HCk00i8ySXCWgRQipsgOHQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,144,1770591600"; 
   d="scan'208";a="269789408"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2026 11:43:54 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id C3BC281910; Fri, 27 Mar 2026 11:43:53 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id BC0468176C
	for <cocci@sympa.inria.fr>; Fri, 27 Mar 2026 11:43:50 +0100 (CET)
X-CSE-ConnectionGUID: MBK0pSC8QKqT68jvhiMG5g==
X-CSE-MsgGUID: XZZzdCmhSFGELeToRRkwUw==
X-IronPort-AV: E=Sophos;i="6.23,144,1770591600"; 
   d="scan'208";a="269789363"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 11:43:50 +0100
Message-ID: <15727dea-42b9-4dda-a006-2c383cbc7619@inria.fr>
Date: Fri, 27 Mar 2026 11:43:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Victor Gambier <victor.gambier@inria.fr>
To: Johannes Berg <johannes@sipsolutions.net>, cocci <cocci@inria.fr>
Reply-To: Victor Gambier <victor.gambier@inria.fr>
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <e9273f8b-7e6d-4441-8681-3f9044c23257@inria.fr>
Content-Language: en-US
In-Reply-To: <e9273f8b-7e6d-4441-8681-3f9044c23257@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
X-Loop: cocci@inria.fr
X-Sequence: 3459
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/y7TOjHFTs91odZP_INVYmQ>

I'm happy to report this performance issue was identified and will be 
fixed in the next release.

Victor

On 2/11/25 10:58, Victor Gambier wrote:
>
> On 06/02/2025 10:31, Johannes Berg wrote:
>> With "spatch version 1.1.1 compiled with OCaml version 4.14.2" this
>> works just fine; however, we're trying to upgrade our dependencies and
>> now with "spatch version 1.2 compiled with OCaml version 5.2.0" it
>> doesn't match anything any more? I can't seem to figure out why, I
>> thought maybe the types didn't match - not sure why we had added type u8
>> to that, but pretty sure it was needed - but adding more types didn't
>> really help either.
>
> I ran a git bisect. As far as this match is concerned, the last known 
> working commit is 4aa93b35; the first known non-working commit is 
> 74d791d77 (the intermediary commits do not build). That is not enough 
> to narrow it down, I'll see if I can figure out something else.
>
