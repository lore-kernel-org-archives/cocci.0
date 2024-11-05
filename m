Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012DED2B933
	for <cocci@archiver.kernel.org>; Tue,  5 Nov 2024 14:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=y4UuaW30OdzXjWoTkpeW0BCxAGOHRlQUuDYHTDWVgNs=;
  b=VewC+ahxUSVQGtYSisU/6KHv+QJgGqNeBgd//ZlQ+9+mYO/wkOC3qYsv
   qbju09OugviJqXwT6CkMD3jR+hkm9Gxp6hk8KYVcQ5p7ja8Gj/k74Vs1l
   GYCfrJ3IxvOK7tRKhsJ8of4ngA58hCURXUUIrb4pHL1JKAg3SIbdLUO9/
   M=;
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
X-IronPort-AV: E=Sophos;i="6.11,260,1725314400"; 
   d="scan'208";a="192294372"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2024 15:34:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C04BCE0D1C; Tue,  5 Nov 2024 15:34:19 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B1527E00B7
	for <cocci@sympa.inria.fr>; Tue,  5 Nov 2024 15:34:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=y4UuaW30OdzXjWoTkpeW0BCxAGOHRlQUuDYHTDWVgNs=;
  b=gWCBuqcBJYZZCbbwsFHqdpyfrouYQ/LLuMb9xwm5OpN+4+ZqpSkndeQI
   LDC97tIBhPTfh5eUqp1Eud5VV5g4H6iZ5y+8NbLxuzp/VLRvOLyGDY+Vk
   DcOW85530VmxGirifWqzorSca3x6ZDNsnVVUZy9rABdWYvi3jdlgosPf9
   s=;
X-IronPort-AV: E=Sophos;i="6.11,260,1725314400"; 
   d="scan'208";a="100806559"
Received: from dt-desouza.paris.inria.fr (HELO [128.93.67.77]) ([128.93.67.77])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 15:34:18 +0100
Message-ID: <6f6d90f8-1027-46ed-a518-0c3b4d6285d6@inria.fr>
Date: Tue, 5 Nov 2024 15:34:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Tojnar <jtojnar@gmail.com>
References: <c3a8f4e3da654c061f7160c75dd0c4e155f3b51d.camel@gmail.com>
 <35a285c7-bed4-8c72-15ea-e22a672d9373@inria.fr>
 <ee969df771df6e87e92fa714fbb94529ad80e77f.camel@gmail.com>
Content-Language: en-US
Cc: cocci@inria.fr, Julia Lawall <julia.lawall@inria.fr>
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <ee969df771df6e87e92fa714fbb94529ad80e77f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Flatpak package for Coccinelle
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1968
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/6f6d90f8-1027-46ed-a518-0c3b4d6285d6%40inria.fr>

Hi everyone,

As Julia mentioned above, I started working on Coccinelle earlier this 
fall. I'd love to help package Coccinelle into Flatpak! I've read the 
discussion above, but some time has passed since then and things might 
have changed, so, in short: how can I help? Are you still interested? 
What questions remain?

On 6/25/24 11:38, Jan Tojnar wrote:
> Personally, I am fond of Creative Commons Attribution-ShareAlike for
> websites.
>
> (...)
>
> Also it might depend on the agreement you have with your employer. I am
> not a lawyer but I believe that typically, the company/university owns
> the copyright (well economic rights, at least) to works you produced
> “on their time” so they might need to agree to any relicensing.
>
> It might be easier to write a new description if you are not sure about
> the legal status.
(2) Regarding the license, CC should be fine (in my opinion). You're 
right that this depends on the employer. From what I understand, at 
INRIA this question has occasionally come up in the last 2 years and we 
still don't have a clear answer. In the mean time, using the text as-is 
with the CC is fine.
> The procedure consists of updating the version and release date in the
> metainfo file (the following line):
>
>      <release version="1.2" date="2024-03-28" type="stable"/>
>
> I would say it is easy to forget and pretty amenable to automation.
(3) I can update the release script to update the version of the 
AppStream metadata, that does seem like the best solution.
> (4) is already implemented in
> https://github.com/coccinelle/coccinelle/pull/370
(4) If I understand correctly, you've already written the manifest, and 
this is something we only have to do once, right? If the license was the 
last thing you needed, feel free to mark your PR as ready and I'll 
review/merge it.
> (5) would require introduction of GitHub/GitLab CI configuration file
> into the repository and perhaps some configuration changes to
> GitHub/GitLab repository (regarding storage of built assets).
(5) That integration seems nice. I'd like to improve the way we do CI 
and releases, and this seems like a nice addition. We might have to 
think about whether or not master is, as it stands, the best branch for 
this. What would this look like in practice from the point of view of 
the user? Would they just download a .flatpak file from the 
GitHub/GitLab releases page?
> Cheers,
> Jan
