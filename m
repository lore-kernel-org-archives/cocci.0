Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0239BC02196
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=SxO7ARA8fcTorfSNOM9Gq3qcDZaO1hqLFFQ67P4ylKY=;
  b=pUROurZAiPxuXfiWimREU2UW4evGWr7U59Y8BsLMZ1UsZejzzc7uKezS
   hZJv6t1/wGqHkTSRn9jbfOLHnf7oU7H4pJtKzZ9sQbDPAQ+knEFrtqD1j
   jN4kgBZhM7A3XJlU5ETm+xwOhtfepyYPzhufIsmK7zBCfeHjEm8gj3c5g
   0=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@collabora.com
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="scan'208";a="205325522"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1032CE0EAA; Tue, 28 Jan 2025 10:13:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D823FE0035
	for <cocci@sympa.inria.fr>; Mon, 27 Jan 2025 15:43:32 +0100 (CET)
IronPort-SDR: 67979b93_ua40tQCGZDMukjSOlO2rO5IwrjSXlTW7jY92kOHgAxiS8a9
 Zb62SLg4V0xoVFHUONdbWroupbz07W4RiQkA4Eg==
X-IPAS-Result: =?us-ascii?q?A0HDAwARmpdnhcNp+5RagQmBVYFwUn1aMwQLSASEUoNPj?=
 =?us-ascii?q?ACCIQOcQoFqgWoPAQMBDTkIAQIEAQEDAQOCDIJwAgICinUCHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQEmFew1JARABggcBM?=
 =?us-ascii?q?3GBJQEBAQEBAQEBAQEBAQEBAQEBAQEXAggFXgEfAQEBAyMPAQ0BAS4JAQ8LG?=
 =?us-ascii?q?AICERUCAlYGARIUgm4BgmQDAQQMtjOBMoEBggwBAQaBCIFg2TeBZAmBGi6Fa?=
 =?us-ascii?q?4JJGgFyeoN/O4NCeicPgVVEgz1PMz6DfIEGgxyCaYNDZIEqgQqBDIc1g12BO?=
 =?us-ascii?q?1+BXxYhJXsshGc+BAQRXC8+iEEJSXscA1ksAVUTFwsHBYEpSAMrNjEjgSYFN?=
 =?us-ascii?q?Qo3OoINaUk3Ag0CNYIefIIrgiGCO4RFhFGFXoIUgWUDAxYSAYI1cnkegU0dQ?=
 =?us-ascii?q?AMLbT03FBsGnWw9g3+BIwgQIAJPIAc1DSQ1BECSQAiDR45+oE80B4QegV0GD?=
 =?us-ascii?q?IopkiSDV4QEgVeLL5lJmHwiixBZgXmVU4UlMYF+I4FcTSODNwkKPAMZD446H?=
 =?us-ascii?q?4NChRMuwXUlNQIBOQIHAQoBAQMJhUUBAQGHfIJZgUsBAQ?=
IronPort-PHdr: A9a23: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
 guHyWMrkI0kXP0upvtg8Vk0fe+HynC4u4M=
IronPort-Data: A9a23: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
 RvKeodG34xaNrH/d0fkVxLFTJKY0c62I/U=
IronPort-HdrOrdr: A9a23:/M039KGYzRl8JPrCpLqE0ceALOsnbusQ8zAXPo5KKCC9Ffbo7v
 xG/c5rsSMc7Qx7ZJhOo7C90cW7Lk80sKQFgrX5Xo3SOjUO2lHEEGiz1/qG/9SIIUSXnNK1l5
 0QEZSWY+edMbEVt6jHCUWDYrEd/OU=
X-Talos-CUID: =?us-ascii?q?9a23=3ADScfX2pL8hhPUSzGW3ChqT7mUZoaK0De43PCGXS?=
 =?us-ascii?q?DU2tibqa/RFys56wxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AUNRDrw8NZc21yLwqUJYWp5mQf/9X252RBxoprcg?=
 =?us-ascii?q?b59CmCSosY2/Fqh3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="107462948"
X-MGA-submission: =?us-ascii?q?MDEC2SuMYaFb4A9CkBYMxg/OgPagGwAIiSGcfi?=
 =?us-ascii?q?TI4SuUIfro5Mw2dXq786JvpP7QcYHo1oPkgyYAXGeDJ3cB4r3Ed1+yhi?=
 =?us-ascii?q?NtIMg7EkJG+8CNJf82DJQpF0Y1r2nOsTsniVoB3misOjM/j1lg/Vg2R9?=
 =?us-ascii?q?vWNc8GG8R9glHnUC6MsOSgJw=3D=3D?=
Received: from bali.collaboradmins.com ([148.251.105.195])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 15:43:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737989009;
	bh=t8H13PU+dE/XDOeVe03jIrdQNLu7F3mQVdhS5tLlG6Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pGD/enfL8kpK87zQuoRfa+HLMtoYy4vYF3/PJkP6xitwVDD5pFD7XQGG/orOFK4UA
	 AvM2kx0BgCQrlrkZ5bGHksoau6SrO9w8Wus+63FSvMulP9kOUs9Vj76uGBfmSdSHy0
	 EKAO+ozERr2vk+UvVMEDq3eae9g1suBwc4ERF2Ko5u5O3fo88tFmLWckr6J96RFDhL
	 bwo0yrAQK4z1pUPiZuH5+ykUzqUaRUBAZ4bkxqPFzlRog0PTveq+9nNBVLMqXQlYiw
	 FZyyUslpppKaMu6f7fB/p8oQ4k669fS1XbeVTKO1ZYnVf1imNzEND5aq7/bWjRJ9jX
	 csRNkYEwFbJDA==
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:11:e976::7a9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3517517E083A;
	Mon, 27 Jan 2025 15:43:25 +0100 (CET)
Message-ID: <c08e5bd0e55b7d9f87ba007455e92da553284dfb.camel@collabora.com>
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Leonardo
 =?ISO-8859-1?Q?Br=E1s?=
	 <leobras.c@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Vignesh Raman	
 <vignesh.raman@collabora.com>, kernelci@lists.linux.dev,
 linuxtv-ci@linuxtv.org, 	dave.pigott@collabora.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, 	dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, 	pawiecz@collabora.com,
 tales.aparecida@gmail.com, workflows@vger.kernel.org, 
	kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com, 
	cocci@inria.fr, Julia.Lawall@inria.fr, kernel@collabora.com, 
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org,
 daniels@collabora.com, 	shreeya.patel@collabora.com, denys.f@collabora.com,
 louis.chauvet@bootlin.com, 	hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 simona@ffwll.ch, airlied@gmail.com, 	Tim.Bird@sony.com, broonie@kernel.org,
 groeck@google.com, rdunlap@infradead.org, 	geert@linux-m68k.org,
 michel.daenzer@mailbox.org, sakari.ailus@iki.fi, 	jarkko@kernel.org
Date: Mon, 27 Jan 2025 09:43:23 -0500
In-Reply-To: <20250127060738.GA16795@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
	 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
	 <20250124081250.GA24731@pendragon.ideasonboard.com>
	 <20250124135203.040d0852@foz.lan>
	 <20250124130021.GA6853@pendragon.ideasonboard.com>
	 <f1c73327073c98ade56dfeabf629e2f9cd7d1663.camel@collabora.com>
	 <bd37528d1c704951cb86a751a5c81e4c76962f51.camel@gmail.com>
	 <20250127060738.GA16795@pendragon.ideasonboard.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Loop: cocci@inria.fr
X-Sequence: 2270
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/c08e5bd0e55b7d9f87ba007455e92da553284dfb.camel%40collabora.com>

Le lundi 27 janvier 2025 à 08:07 +0200, Laurent Pinchart a écrit :
> On Fri, Jan 24, 2025 at 06:12:24PM -0300, Leonardo Brás wrote:
> > On Fri, 2025-01-24 at 10:45 -0500, Nicolas Dufresne wrote:
> > > Le vendredi 24 janvier 2025 à 15:00 +0200, Laurent Pinchart a écrit :
> > > > On Fri, Jan 24, 2025 at 01:52:03PM +0100, Mauro Carvalho Chehab wrote:
> > > > > Em Fri, 24 Jan 2025 10:12:50 +0200 Laurent Pinchart escreveu:
> > > > > 
> > > > > > > It's been a few years since I first thought on finding a good way of helping
> > > > > > > kernel developers testing their patches, while making use of the free runner
> > > > > > > minutes Gitlab offers. It can greatly simplify the testing for people who are
> > > > > > > new to kernel development, or students trying to understand it better.
> > > > > > > 
> > > > > > > And this patchset allows that to happen :)
> > > > > > > 
> > > > > > > Actually, I spoke to Helen last year, and to enable it to run on the free
> > > > > > > Gitlab-CI runners, there is a small extra patch which is needed:
> > > > > > > 
> > > > > > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/  
> > > > > 
> > > > > Sounds interesting!
> > > > > 
> > > > > > Gitlab as an open-source software project (the community edition) is one
> > > > > > thing, but can we please avoid advertising specific proprietary services
> > > > > > in the kernel documentation ?
> > > > > 
> > > > > Every time Gitlab is mentioned, the brand of the company that
> > > > > developed it and has been providing proprietary services is also
> > > > > advertised. If you're not happy with that, you should move to use
> > > > > a git forge developed by some open source community.
> > > > 
> > > > I'm fine mentioning the gitlab community edition, I'm not fine
> > > > advertising gitlab.com SaaS in the kernel source tree.
> > 
> > Hello Laurent,
> > 
> > I see your point, and I see no issue on removing the two last lines of CI_TAGS
> > documentation.
> > 
> > I just added this information on documentation because the default runner used
> > for the Free Tier of Gitlab does not work for this CI, as it needs more
> > resources to run. This information can be added on some other place, but at the
> > time I thought it would be ok to let it be there. 
> > This other runner I mentioned in the patch is also available on the Free Tier
> > (free as in beer).
> > 
> > I would like to make it clear that I have no connection/affiliation to Gitlab,
> > other than a free account in their system, which I use for some CI. I have no
> > interest on advertising anything from them.
> > 
> > My only objective is to make it easier to hobbyists/beginners to use those
> > available free minutes to test some change before sending the patch, if they
> > think that's valuable.
> 
> Given the 400 free computes minute per month, and the fact that the
> saas-linux-medium-amd64 runner consumers two minutes per minute, how
> many of the proposed CI runs would be available per month ?
> 
> CI pipeline runs always compile the kernel from scratch as far as  can
> see. This may not be an issue for final testing before submission of a
> patch series, but it just won't work for incremental testing of changes.
> Think of how inefficient it would be to run a full pipeline just to get
> the checkpatch.pl output for instance. This is why I believe tests
> should focus first and foremost on ease of use in developers' local
> environments. A standardized, from-scratch, comprehensive test run as a
> gate keeper for integration has value as well, but that won't help
> beginners much.

Perhaps we can provide pointers how to run a private gitlab runner on your local
computer. My experience is that this take few minutes, unlike figuring all the
foreign bash scripts dependency, and debugging issues related to some tools not
having the right version, which inevitably lead to folks criticizing distro
choices and other counter productive discussions. Of course, it can only work if
that process is used and tested.

> 
> > > I've just looked attentively, the intention is just to explain you may need to
> > > set gitlab variable in your project fork in order to select correctly sized
> > > sized runners in your own instance.
> > 
> > That's correct
> > 
> > >  Its is not strictly about commercial gitlab.com instance. 
> > 
> > Exactly, the change is about being able to choose the runner you want.
> > 
> > > The default only works with the original project used
> > > instance (which is not gitlab.com as far as I know), but the comment refer to
> > > companies that will choose gitlab.com internally to reduce their IT cost.
> > 
> > Correct.
> > Companies can benefit on that, but my focus was on hobbyist (or begginers) who
> > may want to test their patches on free CI before sending them to the ML.
> > 
> > > Its quite a stretch to call this "advertisement", that makes it looks very
> > > dramatic. I personally believe its quite ahead of most other gitlab CI to take
> > > into consideration running these pipelines on foreign (to the project)
> > > instances.
> > > 
> > > > > The way I see, the best would be if the CI integration could work
> > > > > with more than one type of forge and being able to use any
> > > > > free Git??b-CI runners that would be available for developers to
> > > > > use, as this would allow testing more subsystems with CI, thus
> > > > > increasing code quality.
> 

