Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D76C433EF
	for <cocci@archiver.kernel.org>; Wed, 11 May 2022 08:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=A1cj8NtvNCKZB7aklfrVwcqJ0NxKtl23a51LvNAdtz8=;
  b=qWdkphSxc55ZbYyhXM++ZLqW1xDSCuoGVrpEAcabpJFWDTJWwhH/mdMm
   UqMUKdZ12LNCWIuRQ77S6ZCGzPqRp8e6ZYmh04Hhb8RTM/FTRqB4IuCzF
   Pn96lBvYWsAG5OYjgfFsAH1bSLRo70VGk+KLf3Dxumi3Tj2nF8Eym905l
   4=;
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
   d="scan'208";a="35712329"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 May 2022 10:46:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B7CFDE0269; Wed, 11 May 2022 10:46:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CE363E0098
	for <cocci@sympa.inria.fr>; Wed, 11 May 2022 10:46:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=A1cj8NtvNCKZB7aklfrVwcqJ0NxKtl23a51LvNAdtz8=;
  b=YIdjTzpKGdkNWZgLasw5Y3tXhZTGedcnkyGuWoN/xGDMLNpnGHwJjxGy
   eKUMOGkW6VyrYhKsG8GW7y7Qpd9wk0QPFFVlQPYg+IwUzyaKY9BLbPdaf
   9hjPmKJK89e16R7JbKYaC5yZUIBt8+yzFsr4wAOkYrl9MJyuYuiVguaRE
   w=;
X-IronPort-AV: E=Sophos;i="5.91,216,1647298800"; 
   d="scan'208";a="35712306"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 10:46:30 +0200
Date: Wed, 11 May 2022 10:46:30 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Alessandro Carminati <alessandro.carminati@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <CAPp5cGSVQ5YjQjfvjt3UwHmnRyJsrDEvt92bQoGyNewkAkNLEA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2205111037530.2811@hadrien>
References: <CAPp5cGQV6Lm7fwhUcVs6sqXrA00XYAem2ZopE1eFW_v2EExJQQ@mail.gmail.com> <alpine.DEB.2.22.394.2205091216530.2394@hadrien> <CAPp5cGRMAOanfvuhV1LAV9eZka8ZJHRPy6ncMwO=Q+C=GUA2gA@mail.gmail.com> <CAPp5cGS+ANKVuE+QThN=Byqm=BR0FotbCe7aQgjX77Ee65UDuQ@mail.gmail.com>
 <6a926cad-e15a-5c04-1fc9-34d20bd18618@web.de> <CAPp5cGQRKxk5RXn7a=7R3s4y=fsvi_O9aFUj6HudPSX+06-_2w@mail.gmail.com> <alpine.DEB.2.22.394.2205100957160.2667@hadrien> <CAPp5cGS+4snNh+8S3vFw01MMbUjYgpL2qm0tUPrZ1FUtK8bz9Q@mail.gmail.com>
 <alpine.DEB.2.22.394.2205101123120.2667@hadrien> <CAPp5cGQMuy3aM5cLYk4HH8Ny=uH_t2yhWasfmT2AS7M12YDiWA@mail.gmail.com> <alpine.DEB.2.22.394.2205101236050.2667@hadrien> <CAPp5cGQzYtDVjE-K_Vpt3cbqYW-cwNTLmt_KwdpMdds9L7rXug@mail.gmail.com>
 <alpine.DEB.2.22.394.2205111011380.2811@hadrien> <CAPp5cGSVQ5YjQjfvjt3UwHmnRyJsrDEvt92bQoGyNewkAkNLEA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2145881150-1652258790=:2811"
Subject: Re: [cocci] List global variables with SmPL
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 383
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-05/alpine.DEB.2.22.394.2205111037530.2811%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2145881150-1652258790=:2811
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 11 May 2022, Alessandro Carminati wrote:

>
> Alessandro
>
>
>
> Il giorno mer 11 mag 2022 alle ore 10:14 Julia Lawall <julia.lawall@inria.fr> ha scritto:
>       > It is a suboptimal version of Julia's last proposition.
>       > It happens that in a file a statement I expect to be matched is not detected.
>       > Troubleshooting the issue, I see a behavior that does not fit the model I have in my mind. This suggests to me that things (coccinelle under the hood mechanisms) are more complicated than I think.
>       > back to the point:
>       > Running the script and printing only the rule "rr", which is the same as "r" without positions, the results presents a set of entries containing the entry I'm interested in.
>       > Running the same script but printing only the rule "excluded", I see that the result is an empty set.
>       > Finally, running the script using only the "r" rule, the entry I'm interested in is not there.
>       > Surprisingly (for me), removing the position constraints coming from the rule "excluded" (position q != excluded.p;) from the rule "r", the entry appears.
>
>       You haven't provided tihs semantic patch, so I don't know in detail what
>       it does.
>
> It appears I do not know what a semantic patch is.
> I was convinced that what I called the "script" included inline in the mail I sent was the semantic patch.

It is, but you said that you removed something.  Removing that thing is
not trivial because other things depend on it.  So I don't know exactly
what you did.

In your rr.cocci rule, an isomorphism applies to the pattern T i; to allow
it to match T i = ...; so the problem is solved.  This isomorphism does
not apply when there are position variables attached to the declared
identifier.  This information is provided when running spatch
--parse-cocci by the following message:

warning: iso decl_init does not match the code below on line 26
T i@p@q;

context metavariable Z is matched against the following
noncontext code:
i@p@q

You can see the definition of decl_init in the file standard.iso.

I'm not sure that this strategy for isomorphisms is correct.  At least in
this case, there seems to be no harm in considering i to be in a context
position.  It's not removed or added.  I'm not sure why having a position
metavariable disqualifies is.

julia

>
>
>       In my opinion, the rule excluded is completely irrelevant for this
>       example.  The code that you want to detect is:
>
>       const struct snd_soc_component_driver mtk_afe_pcm_platform = {
>               .name           = AFE_PCM_NAME,
>               .pointer        = mtk_afe_pcm_pointer,
>               .pcm_construct  = mtk_afe_pcm_new,
>       };
>
>       {
>               .name           = AFE_PCM_NAME,
>               .pointer        = mtk_afe_pcm_pointer,
>               .pcm_construct  = mtk_afe_pcm_new,
>       }
>
>       is not considered to be an ordinary expression, but rather as an
>       initializer.  Everything should work find if you just replace E by ...
>
>
> Indeed, replacing the E with ... solves the issue.
> The explanation makes sense to me,  but why does the rule rr in the following context matches mtk_afe_pcm_platform and presents the following resulting set?
> ```
> $ spatch  -sp_file  simple.cocci mtk-afe-platform-driver.c
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> HANDLING: mtk-afe-platform-driver.c
> afe
> dai
> dai_idx
> dev
> hw_base
> hw_ptr
> memif
> memif_data
> mtk_afe_pcm_platform
> num_dai_drivers
> pcm
> pcm_ptr_bytes
> reg_ofs_base
> reg_ofs_cur
> regmap
> ret
> rtd
> size
> ```
> and simple.cocci is
> ```
> @rr@
> type T;
> identifier i;
> expression E;
> attribute name __randomize_layout;
> @@
>
> (
>  T i;
> |
>  T i=E;
> )
>
> @script:python@
> i << rr.i;
> @@
> print (i)
> ```
>
>
>       julia
>
>
>
--8323329-2145881150-1652258790=:2811--
