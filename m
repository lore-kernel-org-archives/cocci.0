Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D6CC282DE
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9n7FMFcmeiMDRYqO77onOdenWd1acNSyevcMZWYQ/PU=;
  b=qEzTstNyEm1HTzBoIuAuqI5tuvENXKmKJOemN9APSbSTQ1rSCaIOfxAK
   mMReHtDjL/ILGgyZGOlbp+nVAnYT1oiN5Bwm30hik4JN/EXU3QXNDvFuS
   4A689FYeawXHQvlfkuI3EkB/9yavXtX9j44XlZrX2MXoI0SIThSxYxu9y
   8=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linuxfoundation.org
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211492037"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:10:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B3DB1E0D1E; Thu,  6 Mar 2025 10:10:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1AF54E0260
	for <cocci@sympa.inria.fr>; Wed,  5 Mar 2025 08:57:39 +0100 (CET)
IronPort-SDR: 67c803f2_cYs45y81Zw43Ji/4wXipfzqEiiOquO+nQyZdOPjqp3a+XWS
 +r2yv5od2z1iDhumQqsF5tw+H5RABk3pg8+gFZA==
X-IPAS-Result: =?us-ascii?q?A0ECAAB2AshnhVvBS5NaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE/BQEBAQELAQGCQoFXMwQLSIxzX4ZTgiEDhXqMUhyFUIQGg?=
 =?us-ascii?q?VYUgWoPAQMBDUQEAQEDBIUAAosWAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBAQFASYV7DUkBEAGCBwGBJIEmAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBHQINfgEBAQM6BgEBNwEPCxguVgaDFYJlA69cgTSBAYIMAQEG3gUJgUgBi?=
 =?us-ascii?q?E4BhWsbIINCeicbgg2EPz6EDgESAYZlgjNFgSSCV2eGO5ASgzmOXFJ7HANZL?=
 =?us-ascii?q?AFLCjUMOShIQwOBMg+BFAU0CnGCC4EyOgINAoJAcB+EQoI3hD2DMoEQgWODb?=
 =?us-ascii?q?4IRgWADAxYQgjBvdxyEQzuEch1AA3g9NxQbBqJlhH9MDQwcQlKXcrAHhCWhY?=
 =?us-ascii?q?0WDcI0JhjqTES6HZZBrqTOBZzouPnAzGggoCIMiTwMZD44hGYh0w15CNTwCB?=
 =?us-ascii?q?wsBAQMJihOGCYFLAQE?=
IronPort-PHdr: A9a23:+3PbjRReCj2q53+cvQje6HmvtNpsogCVAWYlg6HPa5pwe6iut67vI
 FbYra00ygOSB8ODs7kd07aM7+jJYi8p39WoiDM4TNR0TRgLiMEbzUQLIfWuLgnFFsPsdDEwB
 89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL58M
 hm6txndutUZjYd/Nqo8xQXFr3RVcOlK2G1kIk6ekBn76sqs5pBv9Dhetew8/MBaS6X6eKo4T
 b1cDDs4Nm0++dPmuxreQwaR/3UQSmoZnAZGDAjD9xH6Q4z+sjDmuepn2SmVJtP5QLYpUjm/9
 ahrSRvoiCAaNz4l9Wzcl8J9gL5HrB+nuhdy2JDfbp2LO/Vif6PdZdIaSnRHXsZNTCxKH4ewY
 5ISA+YdIepUqo/wrEYMoxSjHwmhHO3hxD9WiHLowKM00OohHg7a0wM9Hd0Dq2jUoMnvOasOT
 ey50LfEwDPeZP1Wwzf9743Ifwggr/GWQ71wftfax0w1FwPClFqQqZXpMTGP2eQXr2ib6vBvV
 eSygGMgpAFxuCagxsgvionJnY8VzlHE9SNkwIc6K924T1N7Ydi5H5RKqyGaNox2QsU4T2Fvo
 iY6xaQLtJimdycF1Jop3QTQa+Cbc4eW+BLjUv6cLzl2inxld7+xiBa8/EuuxODhS8S631VHo
 yRbn9TOuX4A1hPe58yDR/Z+/EqtxziC2g7Q5+1aP0w4ibfXJpo/z7M2i5EdslzDEzfrlEj5j
 qKabEcp9+iy5+j6ZrjrqIWQOotphg3mL6gihtCzDf46PwUORWSW/fqw2Kfj8ED6RrhBk+M7k
 q3EsJDBOcQUuLS5DRJU0oci9RmyFyuq3dIFlncdNl1FYgiIj43xNlHOPv/4CfC/jkyqkDZr2
 //KJKbhApLQLnjZjLjuY6xx601Cxwopy9BQ+ZZUBqsGIPLpVU/9rN3YDhknPAyo2+vrFdpw2
 4EEVW+NAqKVKr7evFuG6+41J+SAeZcZuDPnJPgk4/7ug2U5mVgYfaSx0psXcm63HvtlI0WZe
 nfshtYBEWEXvgsxQuzqj0CCUThOaHmoQ6I85zY7CIS8AYfEXICtj6SN3CGgEZJOfGBJFkiME
 Wv0d4WDQ/oAdTqeItV9nTwcSbihV4gh2Amyuw/917VoMuvU9zYDtZPj0dh1//fcmQsz9TxyF
 cSd0nuCQ3t6nmMSFHcK2/U1nFds0VSC1+wwqvhVBdVV6/5TGE9uPJrR3+V8B93oHB/ab8yKS
 VCOQ9O6DDV3RdU0lYwgeUF4Tvq4gx+L/DCtCr9Qt7WRGJk99OqI0GL8KMV943LH0rQxgV47R
 MdGKWyhgOh47QeFVN2BqFmQi6v/LfdU5yXK7mrWiDPW5CmwMSZ1WKTBBjUEY1fO6M/+/gXER
 qOvDrIuNk1Az9SDI+1EcI6hlk1IEdHkPtmWeGetgyGoHx/dyamBY4nqU2Ec2jjNBk8ZlQwa4
 XeBM045HCjy63nGAmlWHEn0K1jp7fE4rXq6SkEuyATfYFds2Lm10hoUg+GMRfQO2L4NpCYmr
 XNzBlnul8nOBY+moAxsNL5Zfct74FpD0jfBsBdhO5W7M614rlgPeEJsuF703BgxCYhal8Uu6
 nQww2KeMIq+11VMP3Od1JH0YfjML3XquQuoc+jQ003f19Cf/uEO7u45ohPtplPhEE1q6Hhh3
 9RPthnUrpzXEAofV47wWUcr5lB7ob/deCw0+4LT0zVlL6C1tjbI399hCvEiz16seNJWMaXME
 wGXcYVSCNKjJ+8qs1yoaA8UMudP8qI9I8Khcb2BwqHqdOdskTS6jHhWtZhn2xHplWI0QerJ0
 pAZhvCAi1LbCHGj0RH445uxyNkXAFNaVnCywiXlGoNLM6h7fIJQTHyrP9Xy3dJmwZjkR39f8
 lenQVIAws6gPxSIPDmflUVd01oapXu/lG621TtxxnsmtKeQ3yzmx+XkaQoJPXNNSGB+jFDqZ
 4+ugJpJOSrgJxhsjxaj6UvgkuJUvqlwLGn7RUZOYjj4KHxkXqKst72EJclV59l71EcfGPT5a
 lecRLnnphIc2C62BGpSygcwcDSys4n4lRh34I6EBE56t2GROcR5xBOEocfZWeYUxT0eAi9xl
 TjQAFG4ediv59Sd0ZnZ4KiyUGeoV5sbdieOr8vIuzG26m5qKRm+me2jlNr6FwQzzS780Z9tT
 yqAoBvnY4bt3ri3Kqo+IhYuWwK6spshXNAn2oIr4fNYkWAXnJCU4WYKnS/oPNNX1Li/JHsBS
 DgXwsLEtQ3s2UltNHWMlMryUnSQxNckZsHvOz9JnH1gqZkbU+HFte8h/2M9uFezoAPPbOIom
 z4czaBr83sGm6QSvxJryCyBA7cUFE0ePCr2lh3O4crtyccfLGupb7W001Jz2N67C7TX6A5GV
 Xn6er8mHClt/st4LVTA2WHy7Yeif8PfJ4F21FXcg1Lbgu5ZJYhk3PUQiCVkOUr5vHs42+A8k
 Bpi1I27u47BLH9itvHcYFYQJnj+YMUd/SvohKBVk5ON3oyhKZ5mHy0CQJriSf/7WCJXr/nsM
 ByCVSEtsnrOU6SKBheRsQ01yhCHW4DuLXycI2MViMlvVAXIblIKmxgaBX07hsJrS1rsnpGnK
 RwooGlNvhb5skcek7k5cUCgAiGP+EHyM2hRKtDXLQIKvFgeugGJaYrAvqQsQmlZ5sHz9VDQb
 DDDIVsTSzxUEk2cWwK6YubouoSGqrnDQLvnSpmGKbSW9b4HCK3OnMrylNcgpWvQfsSXYis7U
 Kd9gBEfGyokQYKCwn0ZQigT3Uohdua9oxGxsm1yp8G7q7HwXR73oJCIE/1UOMlu/Ba/heGCM
 fSRjWB3M2QQ0JRE3nLOxLUFuTxawyhzazmgF6gBvi/RXerRnKFQFRsSdyJ0MoNB8as92gBHP
 cOThMny0/Z0ifs8ClENUlKE+InhfcsRP2S0L0/KHm6NJb/APjrW2cr6J6CxU7tdiKNTrRLx8
 TeXHkn/PyiSwjnkUxf8VIMExCqfPRFYpMS8akM0VTelE4+gM0zgdo4u3lhUifUui3jHNHARK
 215ekJJ9fiL6D9Ax+54AypH52ZkKu+Nn2CY6fPZI9AYq6gOYGw8muRE7XA907YQ4jtDQak/l
 zHfod1ui1WnlPSfxD16VhZHtjdMgsSMp0ooasC7vtFQHG3J+h4A9zDaExMRu95sEcHioYhW2
 9OJj6XuMjxPtdHZ580RA47TMs3NYx9DeVL5XTXTCgUCVzuiM2rS0ldcnP+l/XqQtpEmq5Lol
 fLmpZdfVVooBv0dF0JpFcADJ5ExWSkrw+fzZCsg4Xu4sQnfQ9hcspnbV/WUR/L1J2TB5VGlT
 x0ZyvXjKpkJPYC92EF4bFR+2oPQFBiINe0=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:OqtM3K9o+qZswrzZ80Ruk+EHdb1zdoMgy1knxilNoENuH/Bwxv
 rFoB1E73TJYW4qKQ4dcKO7Sde9qBLnhOtICOwqUYtKMzOWxVdAQLsSi7cKoAeQbxEWlNQtqZ
 uIGpIWYLKffDsK77eekW3IdOrM2OPmzEnBv5ao854Hd3ATV0gU1XYCNu/tKDwMeOApP+tBKH
 Op3Lswm9PsQwVYUu2LQl0+G8TTrdzCk5zrJTYAGh4c8QGLyQil7bbreiLokyv3B1l0oIsKwC
 zgqUjU96+ju/a0xlv3zGnI9albn9Pn159qGNGMotJ9EESqti+YIKBaH5GStjE8p++irHwwls
 PXnhsmN8Nvr1vMY2COpwf30QWI6kdr15bb8y7fvZLfm726eNt6MbsDuWthSGqY16P0hqA47E
 pJt1jp/aa/QymwxRgVrOK4Ji2CrXDE6kbKodRjxkC3GbFuGIO5krZvtH+9MK1wUB4Su7pXX9
 WGSvuspcp+YBeXaH3BuGlp3cahVGgpHgqXBhESt8DFi3xbgxlCvjklLeIk7wQ9yK4=
X-Talos-CUID: 9a23:0teOAmG2RaLUSWrVqmJe71wUI8oVT0bb52z8c1SBKkFqc/q8HAo=
X-Talos-MUID: 9a23:QNzh7wVwicSwip3q/DavixtHDNti2fWJGXA2moQo6tGIExUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,222,1736809200"; 
   d="scan'208";a="110688777"
X-MGA-submission: =?us-ascii?q?MDFcviQpG2uzpezfpEEXaQaESTkEc/p5Z84qD1?=
 =?us-ascii?q?osP8vtykF4MrfMX5OLlgkgkKagCzjVXpR+s4+q1/JyUxtZ3x9NbDmUeA?=
 =?us-ascii?q?D+mamWPoSX0B6pmIC630rMlhStaeVJKcVZ3jjcmvcQqBod8dZmvZFdSt?=
 =?us-ascii?q?6OeivWrp3HrtXsj3p1MmFBrg=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:57:38 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0A828A44DF9;
	Wed,  5 Mar 2025 07:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E045C4CEE2;
	Wed,  5 Mar 2025 07:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741161456;
	bh=1qfqTAY5g4rU5BKvohe/wSQnKZRFwIwUMMFb18lwqUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWpWHrmM6FO5slFEe1awm0P61uonDdfX3ReUfsTLsL7J86m5wr+uuhUcH+qImGhCX
	 SB46SjNYa6B1UYlZl6TrKQDxTT9vpRnYwNXt65iGD+vs1lRX5+4k8rilVsH1TF0Rn7
	 WnAmmnavwtnnrgNysNzXEnisr77zmZJ+hv5bcsX8=
Date: Wed, 5 Mar 2025 08:57:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, "cocci@inria.fr" <cocci@inria.fr>,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <2025030508-iodize-diagram-3e0f@gregkh>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
 <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
 <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
 <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
 <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
 <ccdac63a-4a04-4243-9350-05acc23f413b@web.de>
 <CY5PR11MB6366E6F52B68E8258EE47F3FEDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6366E6F52B68E8258EE47F3FEDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [v2] mei: Improve exception handling in
 mei_cl_irq_read_msg()
Reply-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Loop: cocci@inria.fr
X-Sequence: 2562
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/2025030508-iodize-diagram-3e0f%40gregkh>

On Wed, Mar 05, 2025 at 07:41:25AM +0000, Usyskin, Alexander wrote:
> > >
> > > In general, why not, but the label naming is bad.
> > > It hides the original intent to discard this message.
> > > Let's rename existing label to discard_nocb: and leave a new one as discard:.
> > > Also, the patch will be smaller in this way.
> > 
> > Do you expect a third patch version according to your naming preferences?
> > 
> > Regards,
> > Markus
> 
> I prefer to, as the current patch reduces this code readability.
> 
> - - 
> Thanks,
> Sasha
> 
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
