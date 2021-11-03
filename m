Return-Path: <SRS0=6LBi=PW=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E32C4332F
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 20:57:26 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7DE7611AE
	for <cocci@archiver.kernel.org>; Wed,  3 Nov 2021 20:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7DE7611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,206,1631570400"; 
   d="scan'208";a="1881885"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Nov 2021 21:57:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BC010E006B; Wed,  3 Nov 2021 21:57:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1F335E004C
	for <cocci@sympa.inria.fr>; Wed,  3 Nov 2021 21:57:18 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=kuba@kernel.org; spf=Pass smtp.mailfrom=kuba@kernel.org; spf=None smtp.helo=postmaster@mail.kernel.org
IronPort-PHdr: =?us-ascii?q?A9a23=3AeFAxfxItj6dbC/3fOdmcuAxhWUAX0o4c3iYr45Y?=
 =?us-ascii?q?qw4hDbr6kt8y7ehCFvLM11hSQB9STq6odzbaM6+a4AS1IyK3CmUhKSIZLWR4Bh?=
 =?us-ascii?q?JdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBxrwKxd?=
 =?us-ascii?q?+KPjrFY7OlcS30P2594HObwlSizexf65+IA+qoQnPucUanJVuJ6IswRfNvndEZ?=
 =?us-ascii?q?v5ayGx2KV6PhRrw+tu88Jt++ClMpvwt8NJNX7/ndKoiV7xYCzomM2Ex5ML1sBT?=
 =?us-ascii?q?IUBWC6HgBXGgIixREGwfK4g30UZf3qSv6q/Fy2DKGMs3sTLA7Qiqt4qF2QxL1k?=
 =?us-ascii?q?igHNjo58GbKisxsia9QvRysqwBjz4PSfYqYL+R1cL/DctwGRGpBRsdRWDJHAoO?=
 =?us-ascii?q?gdIsEEu4NMf9Fo4Xhu1cCqB2zDhSuCuzy0D9FnnH4060k3eo8Eg/J3gIgEN0Sv?=
 =?us-ascii?q?3rbt9j1KKUfXPqpwKXU0TnPcfVb0ir95ojSdRAhpOmBU7ZqfsrS1EkgDB7OgFC?=
 =?us-ascii?q?RqYP5PjOV0P8Ns2ua7+F9Uu+viHMnpBprrTW0xccjlJPJhoQLxVDA7yl5x5w1J?=
 =?us-ascii?q?dKhRUN9fNWrH4deuTuAOItqXsMtXXtouCAix7EbtpO2fScHxYg7yhDRdfGLbYm?=
 =?us-ascii?q?F7wziWeqMITp1hW9pdK67ihqv/0aty+LxW8u73lhKoSRJjtjBu34D2RLd9sWKT?=
 =?us-ascii?q?OZ28ES52TuXygze7uJJLVopmafUK5Mt2KA8m54JvUnHGiL7nlj9grWMeUU+4Oe?=
 =?us-ascii?q?o7vzqYrX4qZ+YMI95kgT+Pb4vmsy7G+g4MRYBX3Kd+eui0L3v50r5QK9FjvEuk?=
 =?us-ascii?q?6nZto7VJdgDq6KkBwJY0Zwv5wuwAjqmytgUg30KIEhBdR+Dl4TpPkvBIPH8Dfe?=
 =?us-ascii?q?xmVSslzJryujFPr38GZrCNGPOkLT/crZn7U5T1g4zwcpY55JOBbENOOjzVVPpt?=
 =?us-ascii?q?NzEEh85NBS5w+niCNVg0oMeXXyAArWCPaLTsF+I4/kgI/OWa4MPuTb9LeIl5//?=
 =?us-ascii?q?0gnMjl18dZ7Gj3YELZ3CgAvRmP0KZbGLwjdcGDWgFogs+QffxiFyCVD5Tf2y9U?=
 =?us-ascii?q?7g95jE9EoKmDJ3MSpqjgLybxC27BIFZZnhaClCQFnflb4GEVO0CaS2IJs9hlic?=
 =?us-ascii?q?JVLmgS48kzh6urhX1x6BmLurS4C0YtIjs2MJ75+3JxlkO8mlWEsCc2impRn59m?=
 =?us-ascii?q?mdAEz0r2KF250h01V6H1YB5heZZHJpd/aUafB09MMv+xu9nAZjRWwnAeMyKSR7?=
 =?us-ascii?q?yQcisCBkyQ8g3zttIZFxyTYbxxivf1janVudG34eAA4Y5p+eFhyCZzydVzn/H0?=
 =?us-ascii?q?O8igkMgT88JMnep1PYXH+37BIPTlUid0aGwevZEtMYi3GSO12yDuAdfSgEiCM3?=
 =?us-ascii?q?4?=
IronPort-Data: =?us-ascii?q?A9a23=3ArIlt9a83FaUUKTVMfOSwDrUD83+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUp2gj1SzmUdCmmFMvyJMDHwKo1wPIq1/RwOscWGy4M3T3M5pCpnJ55og?=
 =?us-ascii?q?ZqcVI7Bdi8cHAvLc5adFBo/hykmh2ipwPkcFhcwnT/wdOi+xZVA/fvQHOOlUba?=
 =?us-ascii?q?fYnsZqTJMEU/Ntzozw4bVvaYz2bBVMyvV0T/Di5W31G2Ng1aYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57+e0wOBL3fJw6DjjxRQafKbhpq/31ilP9nabxGOAEG2l1lnPgpoDlJnZ+tQ?=
 =?us-ascii?q?w4BPaDWnukZFR5CHEmSOIUfqO+ecSfh2SCU5xSaIiu8m52CFnoeMogF/uJ6G0l?=
 =?us-ascii?q?c9PkSMjlLbxaZhuvwzqjTYuJrjc8iBNL6OZsW/HBm1zDQS/g8KbjHSrrD4dtwz?=
 =?us-ascii?q?jY1jNpHW/fYfcsQLzR1BCksyTVbYgJKTsgqxbLwwCHrKWgA7gvF+/QjuD2LilF?=
 =?us-ascii?q?lj+3ELvz+f/qmReN0l2CkvETSpjysWlVCILRz0hKA+3OowOzChyX2XMQVDrLQy?=
 =?us-ascii?q?xKju3XLrkR7NfHcfQLTTTiFZk+CtxZ3LkUV/mwtoLI0+UjtScPyN/F9iBZooTZ?=
 =?us-ascii?q?EM+e80cVjgO1O9kYQywWUHG4JSnhGctNOWAoeW2kxzlHQ9z/2LWUHjVBWIE5xM?=
 =?us-ascii?q?p+XoCm0NCxTKnUNDcPBZWPp/PG7yLwOYtnzohqP3UJ7YhAZ2d09/txSkBUDug?=
 =?us-ascii?q?=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AqxBPd6hmk2MGuLxe0zjBfTmMXHBQXgAji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHKoB11726OtN98YgBHpTmgAtjifZq+z/FICPcqTM+ftVLdyQ?=
 =?us-ascii?q?yVxehZhOOI/9SHIVyGygc378pdmsZFYuHYPBxRrv7KzGCDf+oI8Z2j0YiWo47l?=
 =?us-ascii?q?r0tFfEVMVYEI1XYcNu9tKCxLrFkvP+taKHJgjvAomwad?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AaAACT9oJhmGMdkcZaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUgEAQELAYF6gXw7MZMzXQaBRYsFhmmMMgsBAwENQQQBAYUCAoJ?=
 =?us-ascii?q?TAh0HAQQzBg4BAgQVAQEFAQEBAgEDAwQBEwEBAQEBAQEBCQsQBjokhWgNgjUpA?=
 =?us-ascii?q?YNkAQIDOgYBASwLAQ8LGBwSVwYTgnGCYiauEIEzgQGCCAEBBodfCYE6AY0ceic?=
 =?us-ascii?q?cfYEQhA8wPopCjwCBDQGBHHqhK2CdO4M+g3Saa0wUpxSWDqYqgXeBfk0wCDuCa?=
 =?us-ascii?q?VEZD44gGYENAQmHVoVqJDA4AgYLAQEDCZErAQE?=
X-IPAS-Result: =?us-ascii?q?A0AaAACT9oJhmGMdkcZaHAEBAQEBAQcBARIBAQQEAQFAgUg?=
 =?us-ascii?q?EAQELAYF6gXw7MZMzXQaBRYsFhmmMMgsBAwENQQQBAYUCAoJTAh0HAQQzBg4BA?=
 =?us-ascii?q?gQVAQEFAQEBAgEDAwQBEwEBAQEBAQEBCQsQBjokhWgNgjUpAYNkAQIDOgYBASw?=
 =?us-ascii?q?LAQ8LGBwSVwYTgnGCYiauEIEzgQGCCAEBBodfCYE6AY0ceiccfYEQhA8wPopCj?=
 =?us-ascii?q?wCBDQGBHHqhK2CdO4M+g3Saa0wUpxSWDqYqgXeBfk0wCDuCaVEZD44gGYENAQm?=
 =?us-ascii?q?HVoVqJDA4AgYLAQEDCZErAQE?=
X-IronPort-AV: E=Sophos;i="5.87,206,1631570400"; 
   d="scan'208";a="1881876"
X-MGA-submission: =?us-ascii?q?MDHdf5RCThFgiqgdjpxCbF+3MmANoEQ4x36DlE?=
 =?us-ascii?q?GHwHZaHjsulGyjdm4P9NVn7J8syKBjXbNMK3oV7gP7fYqTctMyvmEsni?=
 =?us-ascii?q?6ZmCp2M2Jps1jLFuLADuWWuBuAODl2Hr0oTQ9GwoccjeQ0RQqMi099U+?=
 =?us-ascii?q?7kT7GV2D+ZFKa7q/rk5djvBw=3D=3D?=
Received: from mail.kernel.org ([198.145.29.99])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 21:57:17 +0100
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1ADC161183;
	Wed,  3 Nov 2021 20:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1635973035;
	bh=kkae86YA5Oz/4hNq/gyBNlrgSKbuGxyKQ7nO2NTqMPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n7Kpcv+czwDPiYoAJ9jzU47FFL6xUB9p21bUVpIr1D8fYLoMWe+bEID3aA61GnWIZ
	 ntEjcgvB8roKcj8eUQJPb/LARO0oOA6zBLnecJsgogAMIqcthx9zryGYdZ6/qncv35
	 NiMYxra2YWxLfNjKR238eQUHBir9akWmi/+ELr1O8i/LehXqzRgKBPoofffZToKwOD
	 t2f5JzG77tvm77Wr+Ec0O+bgzOAPFMQAfdaXlDnJbKTBYLqlT9bq6EQ+dnU7zYqUTB
	 p631IAavJlSHeG2fE3gkC/8yeAGn1HKGMtFpQcPDTiAwO/tgNJYst2HCxXYBLFFIcL
	 opU5v0glFXaew==
Date: Wed, 3 Nov 2021 13:57:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Gilles Muller <Gilles.Muller@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, Michal Marek <michal.lkml@markovi.net>,
 cocci@inria.fr
Message-ID: <20211103135714.6bfcd45c@kicinski-fedora-PC1C0HJN>
In-Reply-To: <alpine.DEB.2.22.394.2111032134360.3289@hadrien>
References: <20211103124001.68e76017@kicinski-fedora-PC1C0HJN>
	<alpine.DEB.2.22.394.2111032134360.3289@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Best way to run coccinelle in a CI?
Reply-To: Jakub Kicinski <kuba@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 64
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/20211103135714.6bfcd45c%40kicinski-fedora-PC1C0HJN>

On Wed, 3 Nov 2021 21:37:07 +0100 (CET) Julia Lawall wrote:
> On Wed, 3 Nov 2021, Jakub Kicinski wrote:
> > Hi folks!
> >
> > I'd like to run coccicheck on all patches before they are committed
> > to Linux networking trees. Is there a recommended way of doing that?
> >
> > I'm looking for a way to run the checks only on files which were
> > touched and in the fastest way possible..  
> 
> I had an intern who worked on an extension to Coccinelle to take a patch
> and then only apply spatch to that file.  Perhaps I can resurrect that
> code.

That'd be quite useful, thanks! Would it have any impact on the
performance as well? I see running coccicheck M=net/core/ takes 
2 minutes now, for a 15 patch series that adds up quickly.

I could run the check on all patches in a series to speed things 
up. Would it be possible to feed it a git range?

> [Note the new mailing list: cocci@inria.fr]

Thanks, FWIW I was going by addresses in MAINTAINERS in Linus's tree.
