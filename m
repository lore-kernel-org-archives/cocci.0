Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4735DC0219B
	for <cocci@archiver.kernel.org>; Tue, 11 Feb 2025 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=O5AnNBdWyOM9Lnfy5vlWhZKZ24ivFUTLTX44gzdjPQI=;
  b=VkhiKO+RomAFb6EKlzAlpzV/Wjja6jWekKeOMYcEdgKAwuHZTDLnmBZM
   2CHbz8V4pugT57pKNAJyRSkPT+uUMJkFyZFSH8MqC04WBv9KwP85jgQvC
   wjChCU46d5P+tDUIyRv+LCQl2+R9eHhMlL/8rhqGmUhxMKUUkxMOVsbx0
   I=;
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
X-IronPort-AV: E=Sophos;i="6.13,277,1732575600"; 
   d="scan'208";a="207660707"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Feb 2025 10:58:26 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 55975E0260; Tue, 11 Feb 2025 10:58:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 40771E0260
	for <cocci@sympa.inria.fr>; Tue, 11 Feb 2025 10:58:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:subject:to:references:
   in-reply-to:content-transfer-encoding;
  bh=O5AnNBdWyOM9Lnfy5vlWhZKZ24ivFUTLTX44gzdjPQI=;
  b=UjwhGa9trITQLPftGfM6fdeGWvy2y39MUXtIV6k/j4KMj5piZLiF6zmo
   NgkbSX2zInpA+J5ORnrhEDrd5uq24gChw9y/L7ioIabP1T5bUd0/0f5Nv
   wt8zy+Lrb7futJdPsdkZOTeocswFP61TzOzO7EptVLyS8h5Wy5IYxrkEN
   A=;
X-IronPort-AV: E=Sophos;i="6.13,277,1732575600"; 
   d="scan'208";a="108760522"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 10:58:25 +0100
Message-ID: <e9273f8b-7e6d-4441-8681-3f9044c23257@inria.fr>
Date: Tue, 11 Feb 2025 10:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Victor Gambier <victor.gambier@inria.fr>
To: Johannes Berg <johannes@sipsolutions.net>, cocci <cocci@inria.fr>
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
Content-Language: en-US
In-Reply-To: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2406
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/e9273f8b-7e6d-4441-8681-3f9044c23257%40inria.fr>


On 06/02/2025 10:31, Johannes Berg wrote:
> With "spatch version 1.1.1 compiled with OCaml version 4.14.2" this
> works just fine; however, we're trying to upgrade our dependencies and
> now with "spatch version 1.2 compiled with OCaml version 5.2.0" it
> doesn't match anything any more? I can't seem to figure out why, I
> thought maybe the types didn't match - not sure why we had added type u8
> to that, but pretty sure it was needed - but adding more types didn't
> really help either.

I ran a git bisect. As far as this match is concerned, the last known 
working commit is 4aa93b35; the first known non-working commit is 
74d791d77 (the intermediary commits do not build). That is not enough to 
narrow it down, I'll see if I can figure out something else.

