Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989B5D44162
	for <cocci@archiver.kernel.org>; Tue, 19 Nov 2024 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0uRUAcofpKzn4uPghsniYBBv67WNqwMMYqBIvkTb4ts=;
  b=TUHTYHG+IubEp5hz70uU4m5yUQ6sF+uborONENJIwEeWObWBWaW2a2Mv
   o0K4kqV9APNepH+WX31eZHpWtgH+o/U2hbNyj1z0yGJ5iIiuPQE1Wqc3/
   qNmeCIXehRQsBDipDjoSQZVKI21DAyizX5GCiNuopnq8PziUDE075zucb
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.12,166,1728943200"; 
   d="scan'208";a="194697126"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Nov 2024 15:34:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 66337E0D1E; Tue, 19 Nov 2024 15:34:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5FA2FE00B7
	for <cocci@sympa.inria.fr>; Tue, 19 Nov 2024 15:34:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=0uRUAcofpKzn4uPghsniYBBv67WNqwMMYqBIvkTb4ts=;
  b=hgbsnBKv0jSJkY/6uATNQ9kBZPwZat5I+JqcIWiv9I2k/PZ69HZusaU+
   EPufophS/i3IAqiMUckmAS2cU4l/GhMBxtmFu3c5BzO/48mBYyd99NwF2
   cC68E7HlP6fOEqV1IxR6A1kkbwan/nGnJdJOjnOpjHeccUAgiS5NE1Z4d
   c=;
X-IronPort-AV: E=Sophos;i="6.12,166,1728943200"; 
   d="scan'208";a="194697113"
Received: from dt-desouza.paris.inria.fr (HELO [128.93.67.77]) ([128.93.67.77])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 15:34:39 +0100
Message-ID: <c46ce4f9-30b1-4791-860c-e93aeda8a0d0@inria.fr>
Date: Tue, 19 Nov 2024 15:34:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <e3af9f65-c923-4fa0-8a7d-be1b27d47fb5@web.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <e3af9f65-c923-4fa0-8a7d-be1b27d47fb5@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Marking several issues as =?UTF-8?Q?=E2=80=9Cnot_plan?=
 =?UTF-8?Q?ned=E2=80=9D?=
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2089
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/c46ce4f9-30b1-4791-860c-e93aeda8a0d0%40inria.fr>

Hi Markus,

I'm doing a bit of a clean-up and closing issues (from various people) 
from years ago. Some of those were bugs that have since been fixed or 
are otherwise no longer relevant, and some of those were non-issues. 
There are also open issues that have not been resolved, and I did not 
close these. In most of the conversations that you opened and that I 
closed, you brought up things that you perceived to be issues. You then 
were told that this was actually not actually a bug, or that the feature 
you requested did not fit the direction of the project. This was all 
explained very clearly, so I'm not sure what else you were hoping would 
happen with all of these years-old issues. They should have been closed 
back then.

As a reference, out of 336 total GitHub issues, you opened 198 of them. 
That's a lot! If 100% of those were actual issues you found, I would be 
very happy. The unfortunate reality is that this is not the case - 
again, most of these issues go the same way every single time: you raise 
an issue, a maintainer explains this is not an actual issue or that the 
feature is out of scope, and then you ask a lot of vague open-ended 
questions and deplore that the project is not going in the direction 
that you would want. This is not a productive use of our time, and this 
is a pattern of behavior that has persisted over years and over multiple 
free software projects that has ultimately resulted in you being banned 
from other Linux kernel mailing lists. You already know all of this, as 
this has been explained to you multiple times by multiple people. I 
personally explained this to you on November 6, but I will say it again: 
you have to stop constantly bringing up poorly-explained issues and 
feature suggestions; you have to stop endlessly arguing with the 
maintainers; you have to respect the time of everyone on this mailing 
list. This also includes asking vague, seemingly useless questions on 
issues that other people are bringing up. If you want us to keep 
responding to your concerns and retain access to this mailing list, you 
can't keep doing any of this.

I am trying to be respectful, but I also want to be as clear as I can 
possibly be. Either:
- you enjoy the project and want to help it succeed, in which case you 
will accept my feedback and change your behavior; or
- you do not want this project to succeed and you actually want to 
sabotage it by wasting everyone's time, in which case you are obviously 
not welcome in this project

Which is it?

Regards,
Victor

On 11/19/24 14:14, Markus Elfring wrote:
> Hello,
>
> Various issues were marked as “not planned” recently.
> https://github.com/coccinelle/coccinelle/issues?q=is%3Aissue+reason%3A%22not+planned%22
>
> Does such an action trigger questionable impressions?
>
> Regards,
> Markus
