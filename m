Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D948C433EF
	for <cocci@archiver.kernel.org>; Wed, 11 May 2022 08:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=nYZEvvNwN/fO4CamU7SOQ101CVIas3HNCtgI4egg5Ns=;
  b=auAuIs0Lsb/PSlwQEIBb5PjsGFObynNHnGCn1PKJ8Aa4zZFDXRYWTrZw
   OoLYEXv76YDwd8utOHTDYarYfR0K+me5+jjskuUQy32YOXg4XYh7yzoAA
   /X7Ma6wY1Otc5u1EYXkt5MnIZIqlAvKdbGaLyGoVEa+QFbj1FpcY2rlNq
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
X-IronPort-AV: E=Sophos;i="5.91,216,1647298800"; 
   d="scan'208";a="35704117"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2022 10:14:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1237AE00A7; Wed, 11 May 2022 10:14:03 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 58661E0098
	for <cocci@sympa.inria.fr>; Wed, 11 May 2022 10:14:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nYZEvvNwN/fO4CamU7SOQ101CVIas3HNCtgI4egg5Ns=;
  b=WqCCEiFQd7cKTv2MAzYEkZNFKcmJgoIOEWrhTfNemDbBH+VV1GDUcb/W
   Mgum7i7LexpADlDU5Qg3UuK7LkWmYOP8e3h5Eh0L5q5WIKD57XAocXP73
   ndQVJ3JtXkGlLnvv+PBVdb2RfauUUpsKH7zh57VX5EG8DaKrZQBQHDvQw
   s=;
X-IronPort-AV: E=Sophos;i="5.91,216,1647298800"; 
   d="scan'208";a="35704108"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:14:01 +0200
Date: Wed, 11 May 2022 10:14:01 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Alessandro Carminati <alessandro.carminati@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205111011380.2811@hadrien>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com> <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com> <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de> <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com> <alpine.DEB.2.22.394.2205100957160.2667@hadrien> <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien> <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com> <alpine.DEB.2.22.394.2205101236050.2667@hadrien> <CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-275075886-1652256841=:2811"
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 381
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/alpine.DEB.2.22.394.2205111011380.2811%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-275075886-1652256841=:2811
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

> It is a suboptimal version of Julia's last proposition.
> It happens that in a file a statement I expect to be matched is not detected.
> Troubleshooting the issue, I see a behavior that does not fit the model I have in my mind. This suggests to me that things (coccinelle under the hood mechanisms) are more complicated than I think.
> back to the point:
> Running the script and printing only the rule "rr", which is the same as "r" without positions, the results presents a set of entries containing the entry I'm interested in.
> Running the same script but printing only the rule "excluded", I see that the result is an empty set.
> Finally, running the script using only the "r" rule, the entry I'm interested in is not there.
> Surprisingly (for me), removing the position constraints coming from the rule "excluded" (position q != excluded.p;) from the rule "r", the entry appears.

You haven't provided tihs semantic patch, so I don't know in detail what
it does.

In my opinion, the rule excluded is completely irrelevant for this
example.  The code that you want to detect is:

const struct snd_soc_component_driver mtk_afe_pcm_platform = {
        .name           = AFE_PCM_NAME,
        .pointer        = mtk_afe_pcm_pointer,
	.pcm_construct  = mtk_afe_pcm_new,
};

{
        .name           = AFE_PCM_NAME,
        .pointer        = mtk_afe_pcm_pointer,
        .pcm_construct  = mtk_afe_pcm_new,
}

is not considered to be an ordinary expression, but rather as an
initializer.  Everything should work find if you just replace E by ...

julia
--8323329-275075886-1652256841=:2811--
