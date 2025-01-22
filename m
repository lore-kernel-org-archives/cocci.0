Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD8EC02181
	for <cocci@archiver.kernel.org>; Wed, 22 Jan 2025 16:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0MdJj0eeZBSumDKplGrYISqTSa5eRH7tc/lNerkSSGA=;
  b=HDLQt9R7E9E+olgO6B03zczcW+Mtns9UxMUEbuQeSWCKJqRKhjmmeLCt
   M5yJkILqKFKgw6fbQnqQtO0udTkQjsz13yhk+nz8dTxNb4cfwKSNgXGZK
   70n7QWlQQ5dLPaUjbzTfPNFhuNyGGtvn0ytlQ3+439v/RJACuMp2SUfUW
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
X-IronPort-AV: E=Sophos;i="6.13,225,1732575600"; 
   d="scan'208";a="204504977"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Jan 2025 17:38:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1A00DE0137; Wed, 22 Jan 2025 17:38:41 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B5464E0077
	for <cocci@sympa.inria.fr>; Wed, 22 Jan 2025 17:38:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0MdJj0eeZBSumDKplGrYISqTSa5eRH7tc/lNerkSSGA=;
  b=WN4jI0O8TTbPMxTB0XpaNIUhrSm9FxFLdeTfgTfahY0f5BL1Q1QPLsv3
   jVfhbqYkHWPlHgUUX7LvuzDCAQCx54apBi6ZZPwAOo3wHS/OvYRjsL4jL
   2fpcEeTO9wvCDZTpO8mNwriRryuP6aBCgtIgwGflyU9cyWbv6MbY2/ps4
   E=;
X-IronPort-AV: E=Sophos;i="6.13,225,1732575600"; 
   d="scan'208";a="204504969"
Received: from wifi-pro-83-210.paris.inria.fr (HELO [128.93.83.210]) ([128.93.83.210])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 17:38:37 +0100
Message-ID: <19e808d6-9c84-4582-88db-7917ccec96ee@inria.fr>
Date: Wed, 22 Jan 2025 17:38:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jani Nikula <jani.nikula@intel.com>, Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <87plkrhqu9.fsf@intel.com>
 <40a550cc-984f-8d-6c3b-8c9c0a7fa5c@inria.fr> <87frlmj38x.fsf@intel.com>
 <4ebe30f0-d7b3-59de-4a8b-22668cba59c3@inria.fr> <877c6yirab.fsf@intel.com>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <877c6yirab.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] spatch #include statements and include search path
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2217
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/19e808d6-9c84-4582-88db-7917ccec96ee%40inria.fr>

Hi Jani,

Could you give me a precise example of what you're trying to do? The 
following works on my end (commit 8aa44ca):

.
├── A
│   ├── cocciincludemain.c
│   └── cocciincludemain.cocci
└── B
     └── cocciinclude1.cocci

(...)/A $ spatch --sp-file ./cocciincludemain.cocci ./cocciincludemain.c

Absolute and relative includes in cocciincludemain.cocci both work:

#include 
"/home/vgambier/Documents/git/coccinelle/playground/B/cocciinclude1.cocci"

#include "../B/cocciinclude1.cocci"

Thanks,
Victor

On 13/01/2025 17:59, Jani Nikula wrote:
> On Mon, 13 Jan 2025, Julia Lawall <julia.lawall@inria.fr> wrote:
>> On Mon, 13 Jan 2025, Jani Nikula wrote:
>>
>>> On Mon, 13 Jan 2025, Julia Lawall <julia.lawall@inria.fr> wrote:
>>>> I don't think there is any search path for .cocci files.
>>> Oh, so it's always relative to the current working directory? That's a
>>> bit of a bummer.
>> It's not a well developed feature.  If an include path for it would be
>> useful, we can add that.
> It might be. Or do you have any other ideas for reusing match rules or,
> say, "iterator name" lists, without duplicating them into all .cocci
> files?
>
> So I guess I can try working around not having include search path by
> running spatch outside of my kernel repo. Does spatch otherwise handle
> that scenario well, or any caveats there?
>
>
> BR,
> Jani.
>
>
