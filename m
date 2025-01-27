Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BAFC02188
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 16:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=iSICvdaoDkJ3lwAiBbYxse7mWi6vCkHlVH08HNDag6c=;
  b=MJNEY33WyixYG2TO4IEq4+ZGLhKRpJ0ljeVBe3h4eYqwyKY1SaMKiDMG
   FYlQsl4RorxjZ/1qH0Ch5Nwi2LMCv8Kk9b4zx0U3lbdwStYyw6SVGwGOx
   aoqJptBbdh1LIk7kjvXYo0CcguM80+JM5q6VwAHwUbGuxf/lSyYqYqC5Z
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="205239807"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2025 17:23:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 011D0E0D1E; Mon, 27 Jan 2025 17:23:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BD377E0035
	for <cocci@sympa.inria.fr>; Mon, 27 Jan 2025 17:23:54 +0100 (CET)
IronPort-SDR: 6797b31a_BP4m7/lYpjyv/vI1t1q1h/J+9pGBleo6N0aFOn2z9txFvEF
 uf5c7whX79k4KuH0vRSg8FY3Q+gr3vGAjkFznVg==
X-IPAS-Result: =?us-ascii?q?A0FlAQD4sZdnhUDyp9VaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRH1aJwwHCEgEhFKDT4UtiA1nA4E/mwOBaoFqDwEDAQ05CwQBAQMBA4IMg?=
 =?us-ascii?q?nQCinUCHwYBBDQTAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?QEBQEmFew2CYgEzcYElAQEBAQEBAQEBAQEBAQEBAQEBARcCDX4BAQEDIw8BD?=
 =?us-ascii?q?QEBLgkBDwsYAgIRBw4CAlYGExSCbgGCZAcBDLZHgTKBAYIMAQEGgQjbF4FkC?=
 =?us-ascii?q?YEaLoVrgkkaAXKEeYN9eicPgVVEgUqBc08zPoN8gQaDHIJpgjOBEGSBKoEKJ?=
 =?us-ascii?q?WeHNYNdgTtfgV8WISV7LIRnPgQEEVwvPohBUnscA1ksAVUTFwsHBYEpSAOBE?=
 =?us-ascii?q?iOBJgU1Cjc6gg1pSTcCDQI1gh58giuCIYI7hEWEUYVeghSBZQMDFhIBgjVye?=
 =?us-ascii?q?R6BTR1AAwttPTcUG51yPYN/AoEhCBAgAk8KCgwHNQ0kIRQEQJJACINHr000B?=
 =?us-ascii?q?4QegV0GDIopkiSDCgRJhASBV4svmUmYfIsyWYF5lVOFJTGBfiOBXE0jgzcJC?=
 =?us-ascii?q?jwDGQ+OIQwNCRaDQoUTLsFjQTUCATkCBwEKAQEDCZAdgUsBAQ?=
IronPort-PHdr: A9a23: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
 5mltX4G0AVmPoZdGA==
IronPort-Data: A9a23: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
 uGQ3kUD
IronPort-HdrOrdr: A9a23:WB6EN6lR8fqwA4Rs6PDoBbl7cYrpDfIv3DAbv31ZSRFFG/FwWf
 rBoB0+726RtN93YgBGpTngAtjkfZq4z/RICOYqUItKMDOLhILsFvAF0WKA+UyDJ8SdzI5gPM
 5bGsAUNDSzNykYsS+Q2miF+rgbr+W6zA==
X-Talos-CUID: =?us-ascii?q?9a23=3ArdqpA2ssFfkW/68/F8x6nxIO6Is9Q03F6GmAGXP?=
 =?us-ascii?q?oJkQzWZCcZG6CwY9rxp8=3D?=
X-Talos-MUID: 9a23:PBQgQwZiC7iP9eBT9AD9uz5Sd8dUw6HyAhsgrrNWm8OrDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="205239791"
X-MGA-submission: =?us-ascii?q?MDEVJ+R+Ad3IESJEnvm5ZKG/8bTAWu+80v3Cjd?=
 =?us-ascii?q?pO6iN+Tgl6+x8w1rHPSuDpuNBXv157a+Mbxr9KyUaTKUllJkYXBE95NX?=
 =?us-ascii?q?sB/NBd2xgfmk324ZEeJAFJPgwnI9Mc5O3oHsUL33BzENCXdYr52hFVDQ?=
 =?us-ascii?q?PLQ0WOqO0WK88LgdGLWSDaWA=3D=3D?=
Received: from perceval.ideasonboard.com ([213.167.242.64])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 17:23:54 +0100
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C0798675;
	Mon, 27 Jan 2025 17:22:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1737994967;
	bh=6zUwpmXcP9sqo9jb0I0ccycMtTDmbn6zwGoPKCJgbxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSVoiWHZLYNNorgTiyJ1vOgJPJAa9OsIjHTRl1SWNLQSSjxNtKu9J1Ofc4h9RPPtj
	 wJYCPVvWdVeLtDZTshLC4hJ2ldaKE55SD2vMgXUvqN92OQSra4vs2nxJilw2ShoYsY
	 KU82qfPJhqGEpMn72MGPJH+e0q8qr0T9xCdCB7h0=
Date: Mon, 27 Jan 2025 18:23:42 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Vignesh Raman <vignesh.raman@collabora.com>,
	kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, mripard@kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org, pawiecz@collabora.com,
	tales.aparecida@gmail.com, workflows@vger.kernel.org,
	kunit-dev@googlegroups.com, nfraprado@collabora.com,
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr,
	kernel@collabora.com, torvalds@linuxfoundation.org,
	gregkh@linuxfoundation.org, daniels@collabora.com,
	shreeya.patel@collabora.com, denys.f@collabora.com,
	louis.chauvet@bootlin.com, hamohammed.sa@gmail.com,
	melissa.srw@gmail.com, simona@ffwll.ch, airlied@gmail.com,
	Tim.Bird@sony.com, broonie@kernel.org, groeck@google.com,
	rdunlap@infradead.org, geert@linux-m68k.org,
	michel.daenzer@mailbox.org, sakari.ailus@iki.fi, jarkko@kernel.org
Message-ID: <20250127162342.GJ17899@pendragon.ideasonboard.com>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <f779c9af4133629f724e366241fab7421d13d227.camel@gmail.com>
 <20250124081250.GA24731@pendragon.ideasonboard.com>
 <20250124135203.040d0852@foz.lan>
 <20250124130021.GA6853@pendragon.ideasonboard.com>
 <f1c73327073c98ade56dfeabf629e2f9cd7d1663.camel@collabora.com>
 <bd37528d1c704951cb86a751a5c81e4c76962f51.camel@gmail.com>
 <20250127060738.GA16795@pendragon.ideasonboard.com>
 <c08e5bd0e55b7d9f87ba007455e92da553284dfb.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c08e5bd0e55b7d9f87ba007455e92da553284dfb.camel@collabora.com>
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Loop: cocci@inria.fr
X-Sequence: 2237
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250127162342.GJ17899%40pendragon.ideasonboard.com>

Hi Nicolas,

On Mon, Jan 27, 2025 at 09:43:23AM -0500, Nicolas Dufresne wrote:
> Le lundi 27 janvier 2025 à 08:07 +0200, Laurent Pinchart a écrit :
> > On Fri, Jan 24, 2025 at 06:12:24PM -0300, Leonardo Brás wrote:
> > > On Fri, 2025-01-24 at 10:45 -0500, Nicolas Dufresne wrote:
> > > > Le vendredi 24 janvier 2025 à 15:00 +0200, Laurent Pinchart a écrit :
> > > > > On Fri, Jan 24, 2025 at 01:52:03PM +0100, Mauro Carvalho Chehab wrote:
> > > > > > Em Fri, 24 Jan 2025 10:12:50 +0200 Laurent Pinchart escreveu:
> > > > > > 
> > > > > > > > It's been a few years since I first thought on finding a good way of helping
> > > > > > > > kernel developers testing their patches, while making use of the free runner
> > > > > > > > minutes Gitlab offers. It can greatly simplify the testing for people who are
> > > > > > > > new to kernel development, or students trying to understand it better.
> > > > > > > > 
> > > > > > > > And this patchset allows that to happen :)
> > > > > > > > 
> > > > > > > > Actually, I spoke to Helen last year, and to enable it to run on the free
> > > > > > > > Gitlab-CI runners, there is a small extra patch which is needed:
> > > > > > > > 
> > > > > > > > https://lore.kernel.org/all/20240327013055.139494-2-leobras@redhat.com/  
> > > > > > 
> > > > > > Sounds interesting!
> > > > > > 
> > > > > > > Gitlab as an open-source software project (the community edition) is one
> > > > > > > thing, but can we please avoid advertising specific proprietary services
> > > > > > > in the kernel documentation ?
> > > > > > 
> > > > > > Every time Gitlab is mentioned, the brand of the company that
> > > > > > developed it and has been providing proprietary services is also
> > > > > > advertised. If you're not happy with that, you should move to use
> > > > > > a git forge developed by some open source community.
> > > > > 
> > > > > I'm fine mentioning the gitlab community edition, I'm not fine
> > > > > advertising gitlab.com SaaS in the kernel source tree.
> > > 
> > > Hello Laurent,
> > > 
> > > I see your point, and I see no issue on removing the two last lines of CI_TAGS
> > > documentation.
> > > 
> > > I just added this information on documentation because the default runner used
> > > for the Free Tier of Gitlab does not work for this CI, as it needs more
> > > resources to run. This information can be added on some other place, but at the
> > > time I thought it would be ok to let it be there. 
> > > This other runner I mentioned in the patch is also available on the Free Tier
> > > (free as in beer).
> > > 
> > > I would like to make it clear that I have no connection/affiliation to Gitlab,
> > > other than a free account in their system, which I use for some CI. I have no
> > > interest on advertising anything from them.
> > > 
> > > My only objective is to make it easier to hobbyists/beginners to use those
> > > available free minutes to test some change before sending the patch, if they
> > > think that's valuable.
> > 
> > Given the 400 free computes minute per month, and the fact that the
> > saas-linux-medium-amd64 runner consumers two minutes per minute, how
> > many of the proposed CI runs would be available per month ?
> > 
> > CI pipeline runs always compile the kernel from scratch as far as  can
> > see. This may not be an issue for final testing before submission of a
> > patch series, but it just won't work for incremental testing of changes.
> > Think of how inefficient it would be to run a full pipeline just to get
> > the checkpatch.pl output for instance. This is why I believe tests
> > should focus first and foremost on ease of use in developers' local
> > environments. A standardized, from-scratch, comprehensive test run as a
> > gate keeper for integration has value as well, but that won't help
> > beginners much.
> 
> Perhaps we can provide pointers how to run a private gitlab runner on your local
> computer. My experience is that this take few minutes, unlike figuring all the
> foreign bash scripts dependency, and debugging issues related to some tools not
> having the right version, which inevitably lead to folks criticizing distro
> choices and other counter productive discussions. Of course, it can only work if
> that process is used and tested.

I've run that before. It's not necessarily extremely complicated
(we of course all know that in IT "a few minutes" means at least half a
day - the rule of thumb is to multiple any time estimate by two and bump
to the next unit :-)), but it will still take a massive amount of CPU
time to run CI loads designed for a large number of powerful runners on
a development laptop. As I said before, it has its uses, but mostly as a
last check before merging (or sending patches), and not as an iterative
process during development. And yes, if we run a gitlab runner locally
we could also set up a cache that makes builds incremental, but that
will only work if incremental builds are supported as a first class
citizen by the CI pipeline developers. I don't see that happening very
often.

The point I'm trying to make is that I believe it would be more valuable
for beginners (and also more experienced developers) if we could provide
them with the ability to run individual tests incrementally with the
lowest overheard, even if the setup time is a bit longer.

> > > > I've just looked attentively, the intention is just to explain you may need to
> > > > set gitlab variable in your project fork in order to select correctly sized
> > > > sized runners in your own instance.
> > > 
> > > That's correct
> > > 
> > > >  Its is not strictly about commercial gitlab.com instance. 
> > > 
> > > Exactly, the change is about being able to choose the runner you want.
> > > 
> > > > The default only works with the original project used
> > > > instance (which is not gitlab.com as far as I know), but the comment refer to
> > > > companies that will choose gitlab.com internally to reduce their IT cost.
> > > 
> > > Correct.
> > > Companies can benefit on that, but my focus was on hobbyist (or begginers) who
> > > may want to test their patches on free CI before sending them to the ML.
> > > 
> > > > Its quite a stretch to call this "advertisement", that makes it looks very
> > > > dramatic. I personally believe its quite ahead of most other gitlab CI to take
> > > > into consideration running these pipelines on foreign (to the project)
> > > > instances.
> > > > 
> > > > > > The way I see, the best would be if the CI integration could work
> > > > > > with more than one type of forge and being able to use any
> > > > > > free Git??b-CI runners that would be available for developers to
> > > > > > use, as this would allow testing more subsystems with CI, thus
> > > > > > increasing code quality.

-- 
Regards,

Laurent Pinchart
