Return-Path: <SRS0=prLC=PX=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF293C433F5
	for <cocci@archiver.kernel.org>; Thu,  4 Nov 2021 17:24:58 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A6761058
	for <cocci@archiver.kernel.org>; Thu,  4 Nov 2021 17:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18A6761058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,209,1631570400"; 
   d="scan'208";a="2052188"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Nov 2021 18:24:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 38D73E006A; Thu,  4 Nov 2021 18:24:56 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A38D1E004C
	for <cocci@sympa.inria.fr>; Thu,  4 Nov 2021 18:24:52 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=kuba@kernel.org; spf=Pass smtp.mailfrom=kuba@kernel.org; spf=None smtp.helo=postmaster@mail.kernel.org
IronPort-PHdr: =?us-ascii?q?A9a23=3AZ2nFuBG64/w1zu4n+mXAE51Gf0hLhN3EVzX9CrI?=
 =?us-ascii?q?Zgr5DOp6u447ldBSGo6k31RmRAc6GtLoE07OQ7/q4HzRYoN6oizMrSNR0TRgLi?=
 =?us-ascii?q?MEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ/iOgV?=
 =?us-ascii?q?rO+/7BpDdj9it1+C15pbffxhEiCCybL9sMRm6txndu8YZjYZiKKs61x/FrmdVd?=
 =?us-ascii?q?+hMym5kO06fkwzg6sus+ZJo7jhdte8m+8NcS6vxYr42TaZfDDQoMmA14NPkuBz?=
 =?us-ascii?q?eRgaR5XUST3sbnANQDwfK8B/1UJHxsjDntuVmwymVIdf2TbEvVju86apgVQLlh?=
 =?us-ascii?q?z0GNz4992HXl9BwgadGqx+vuxBz34jZa5yOOfFgYq3SY88VRWtZXsZQSSNBBJ+?=
 =?us-ascii?q?8b5ASBOYFJOpUspXxq0cLoRa4GAKiBv7gyiVQi3H43aM0zfkvHwLE0wwuEN0Br?=
 =?us-ascii?q?Hvaoc7pNKoQS+250LXEwSndY/5QxDzz6JLIchckofyUWbx/a8nRyVQ0GAjYi1u?=
 =?us-ascii?q?QqJDqPzKT1uQWsGib7vdrWOWsi246sA5+uCOixsQyhYnTgIIa1FTE+T9+wIYvK?=
 =?us-ascii?q?t21UUh2asOrH5VMrS+VLZd2Qt88TGFyviY30qAKtJG6cSUF1Jkq2xDRZuKZf4W?=
 =?us-ascii?q?J/B/uVfudLDd5iX54ZL6ygwu+/0ahx+DzVMS631ZEoCVZntTNuH0D2RLd59SBR?=
 =?us-ascii?q?/Bg/UmhwS6C2x3X5+xHO0w4iKXWJp47zrIukpcfq0DOEyvwlU7rlqGZbF8k9fK?=
 =?us-ascii?q?t6+n/YrXpuJucN4hshwH7KKsum8i/Df47MgcQRWib//qz1Ln58U3+WrVKgeU6k?=
 =?us-ascii?q?qjfsJ/EOcQWvrO1DgtW34o59hqyADer3M4GkXQDNl5IfBaKg5DsO17UIfD4Cfm?=
 =?us-ascii?q?/g06rkDdu3/3GPaDhDY7XIXXYk7fuY6x960hCxwo319xf4IhUCr4ZLPLpRkDxr?=
 =?us-ascii?q?MDYDgM+MwGszObnDch91ocaWW2RGK+UK6LTsV6N5u00OemDfpUZuDf7K/g/5v7?=
 =?us-ascii?q?hl2U1mVEHfaOxx5sYdGi4Huh6I0WeeXfjntABHnsWsQo/V+Hqk12DUTtLZ3moR?=
 =?us-ascii?q?a485zc7CJinDYjZXIytjqaB1j+hHpJKfmBGFkyMEXDweoWAQfgNZjidIstlkjE?=
 =?us-ascii?q?fVLmhSooh2gq0tADg0bZnL+zU+jcZtZ35ztR16ffTxlkO8mlWEsCc2impRn59m?=
 =?us-ascii?q?mdAEz0r2KF250h01V6H1YB5heZZHJpd/aUafB09MMv+xu9nAZjRWwnAeMyKSR7?=
 =?us-ascii?q?yQcisCBkyQ8g3zttIZFxyTYbxxivf1janVudG34eAA4Y5p+eFhyCZzydVzn/H0?=
 =?us-ascii?q?O8igkMgT88JMnep1PYXH+37BIPTlUid0aGwevZEtMYi3GSO12yDuAdfSgEiCM3?=
 =?us-ascii?q?4?=
IronPort-Data: =?us-ascii?q?A9a23=3A9hgkTaI7xjZtV4/uFE+RopQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC/3D8h3jEOmjZNCjuOaaneajCnfIsibYni8kpX7JPXyKc2QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4EfyWlTdhSMkj/jRH+KgULS?=
 =?us-ascii?q?s1h1ZHGeIdg9x0XqPpMZi2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?gm7f/NE4HWLjfOU6JkHU+t6qK20kS4HVuj+BhZbxNOC+7iB3R9zx14NZQv5WYS?=
 =?us-ascii?q?gozOKDI3uMHXHG0FgkkZfAcoeCdSZS4mZXPnh2WKxMA2c5GA0QrOYkV4M5lAGR?=
 =?us-ascii?q?E7/VeKTYXbxnFifje6Lm8QeJtrt8yKdHieoIZoHBpiz/DZd4iSI/KR6Hi995d1?=
 =?us-ascii?q?i05wMFIB/fXIcQDAQeDxjzUO0gSfA0DUcdm2r+83CynNWQI9gyB/v9vpTXHk1l?=
 =?us-ascii?q?Yzp7GNfz5evqrTONphGCM/zqTpyChFnn2L/SawDuBtHGhnOnCmWX8Qo16KVFxz?=
 =?us-ascii?q?dYy6HX7+4DZIER+uZqHTfiFZoqWXtteLwoX9zAooKx081akJjU4d3VUv1bc1iP?=
 =?us-ascii?q?wmfIJewH51O1J4qnZ+QCUAi4DVDEphBkOqpotXTJzvrOWt4qBONGs2YF5jVqe+?=
 =?us-ascii?q?62SoDf0PjIaRYPHTUfoUiNdi+TeTEoPYt4jgzqt/GNZTjE4JN0o/w23kQ=3D?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AEv5+M6DbiWMQuCLlHeiPs8eALOsnbusQ8zAX?=
 =?us-ascii?q?Ph9KJCC9I/bzqynxpp8mPEfP+VAssQIb6Km90ci7MAbhHPtOjbX5Uo3SODUO1F?=
 =?us-ascii?q?HIEGgA1/qX/9SDIVyYygc1784JHMZD4bbLfDtHZLPBkWyF+qEbsbu6Gc6T5dv2?=
 =?us-ascii?q?/jNId0VHeqtg5wB2BkKwCUttXjBcCZ44DpaHouJaujuJYx0sH4WGL0hAe9KGi8?=
 =?us-ascii?q?zAlZrgbxJDLQUg8hO2lj+t6KT3CVyxwgoedz9EwL8k8XLA+jaJppmLgrWe8Fvx?=
 =?us-ascii?q?xmXT55NZlJ/K0d1YHvWWhswUMDn3zi61eYVaXaGYtjxdmpDt1H8a1P335zswNc?=
 =?us-ascii?q?V67H3cOkuvpwH24hLt1DY152Wn4nWz6EGT5vDRdXYfMY5slIhZehzW5w4Lp9dn?=
 =?us-ascii?q?yptR02aYrZZMSSnruU3Glp31fiAvsnDxjWspkOYVgXAae5AZcqVptoAa/FlYCt?=
 =?us-ascii?q?M8Byr88pkgC/RSF8nS6/ZdTEOCYxnizytS6e3pek52MgaNQ0AEtMDQ+SNRhmpB?=
 =?us-ascii?q?1EcdxNYShDMJ8488UYBN46DfOKxunrdIU8MGcMtGdb88aPryLlaIbQPHMWqUL1?=
 =?us-ascii?q?iiProAIWj1sJLy4K84/qWvdIYTxJU/gpLcS1lV3FRCP37GOImr5tlm4xrNSGKy?=
 =?us-ascii?q?UXDG0cdF/aFjtrn9XrbwdSuZSF4vlMOkqfAeDsrHW++6NZ9MD+X4RFGeX7ph7k?=
 =?us-ascii?q?nbYd1/OHMeWMoatpIQQFSVuPvRJonrrODANO/JIrDgCywpVyf1Ej8BWiTpI81E?=
 =?us-ascii?q?7kekM0WI2yT5ajfIQAjS7JhwGK/V86w4044WLLRWvgwUk1iiotyRITpZq6osYV?=
 =?us-ascii?q?ZkKLzpkqmntXC7lFy4tllBC154NAJ48b/gW3RFqUshKEXva4sOvN2ZZCR7wGaH?=
 =?us-ascii?q?DgUXdbKhLCdv43BMvY6nJZ2Zwi4vT/i9NHiBsncVrHWWC78Bh6y449v/cJ9QNO?=
 =?us-ascii?q?duZEUxL3SCK/VGo3chlI5xUn5IeqYZLEKjtUyRtu1eOAgYTagyvO7kG78blZuV?=
 =?us-ascii?q?jzTlmShmfAphY9cFa7/Mve9pfUsiurQ5yd5jvJObhTigJXEjjOkPOEBQYG6XBL?=
 =?us-ascii?q?5AETKeaJ9PmrbtTgF8JF36/wCymlU9fHHn+F4VgXGkJSqIeevTCl4YoXxA1L32?=
 =?us-ascii?q?mWkEBFl1UngAGkySi7cNZlgulkwDrtNjV5DDold5MGFyvt31GAu1HwcvHg=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ALAAACF4RhmGMdkcZaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgUcFAQELAYF6gXw7MZM0XQaBQgOLBZEfgXwLAQMBDUEEAQGFAgK?=
 =?us-ascii?q?CUwIdBwEEMgcOAQIEFQEBBQEBAQIBAwMEARMBAQEBAQEBAQkLEAY6JIVoDYI1K?=
 =?us-ascii?q?QGDZAECAzoGAQE3AQ8LGBwSVwaDBIJiJq4AgTOBAYIIAQEGh18JgToBjSF6Jxx?=
 =?us-ascii?q?9gRCDPlEwPopCjxQBPFEBgRwvoEeBMGCdO4M+g3SabkynKJYPpiuBaAWCCE0wC?=
 =?us-ascii?q?IMkURkPjiAZgQ0BCYdWhWokMDgCBgsBAQMJkBcBAQ?=
X-IPAS-Result: =?us-ascii?q?A0ALAAACF4RhmGMdkcZaHAEBAQEBAQcBARIBAQQEAQFAgUc?=
 =?us-ascii?q?FAQELAYF6gXw7MZM0XQaBQgOLBZEfgXwLAQMBDUEEAQGFAgKCUwIdBwEEMgcOA?=
 =?us-ascii?q?QIEFQEBBQEBAQIBAwMEARMBAQEBAQEBAQkLEAY6JIVoDYI1KQGDZAECAzoGAQE?=
 =?us-ascii?q?3AQ8LGBwSVwaDBIJiJq4AgTOBAYIIAQEGh18JgToBjSF6Jxx9gRCDPlEwPopCj?=
 =?us-ascii?q?xQBPFEBgRwvoEeBMGCdO4M+g3SabkynKJYPpiuBaAWCCE0wCIMkURkPjiAZgQ0?=
 =?us-ascii?q?BCYdWhWokMDgCBgsBAQMJkBcBAQ?=
X-IronPort-AV: E=Sophos;i="5.87,209,1631570400"; 
   d="scan'208";a="2052172"
X-MGA-submission: =?us-ascii?q?MDHSr+4BSrCgpTyg73NOU8J3gSg0irHtWLfZ1D?=
 =?us-ascii?q?4G25vmpTLfjyJTmg9wtkonb4X4hp/4xQQr4qaCood9a5MffTQbuz2Vy5?=
 =?us-ascii?q?/k5Y8la7u5OBAoIt2M9mdiw8mwZSlIIcEb2M77UMosujo+3vCQqDI2uD?=
 =?us-ascii?q?qKhFJn+/ECp9SqHaY5qOEurg=3D=3D?=
Received: from mail.kernel.org ([198.145.29.99])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 18:24:52 +0100
Received: by mail.kernel.org (Postfix) with ESMTPSA id C157A60EBC;
	Thu,  4 Nov 2021 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1636046688;
	bh=yKkYUqQqh+nN+Mg0+SS0al9+PLQPmNSmGp/ei1O+r7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lBuSqD0E6i9VlKQtAWseasIZhfYPiNeFy1OfEDE6om3PdJA/2DbRM1xGCImPR6gcW
	 YPJDZ6oHpbrIH0ql+q1dQrD5uKMvEDnnyQX5cuv1zw9INBfN86IvAt0HbLaA88AMzZ
	 1mh9x2kj626JHKFPbxyMwuAbZUBDK8sFv8jwBZEY0wAnK9/z0Kzrd7nziwa7nvWFkX
	 MFw87sGEWeAbzxW2tmoBIpBJHXT5OYjDiz/RJFaGt3jKkNchHkTKYxD6Cyr28JsCym
	 pbJwZW0O1Mo+l9uP/KN1oMretH5YvJkY5oGsrBSjgyRHM6q7eazyTEEC3xcMznsAD6
	 ZL0/iEeRSfqag==
Date: Thu, 4 Nov 2021 10:24:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Gilles Muller <Gilles.Muller@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, Michal Marek <michal.lkml@markovi.net>,
 cocci@inria.fr
Message-ID: <20211104102448.4c97e7e6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <alpine.DEB.2.22.394.2111041612130.2680@hadrien>
References: <20211103124001.68e76017@kicinski-fedora-PC1C0HJN>
	<alpine.DEB.2.22.394.2111032134360.3289@hadrien>
	<20211103135714.6bfcd45c@kicinski-fedora-PC1C0HJN>
	<alpine.DEB.2.22.394.2111041612130.2680@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Best way to run coccinelle in a CI?
Reply-To: Jakub Kicinski <kuba@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 69
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/20211104102448.4c97e7e6%40kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>

On Thu, 4 Nov 2021 16:16:09 +0100 (CET) Julia Lawall wrote:
> On Wed, 3 Nov 2021, Jakub Kicinski wrote:
> > That'd be quite useful, thanks! Would it have any impact on the
> > performance as well? I see running coccicheck M=net/core/ takes
> > 2 minutes now, for a 15 patch series that adds up quickly.
> >
> > I could run the check on all patches in a series to speed things
> > up. Would it be possible to feed it a git range?  
> 
> There are now two new options:
> 
> --use-diff
> There should also be the name of a directory on the command line.  This
> will run the semantic patches only on the files that have changed in that
> directory
> 
> --use-patch-diff commit
> This will run spatch only on the files that have changed in commit.
> 
> --use-patch-diff commit1..commit2
> This will run spatch only on the files that have changed between commit1
> and commit2.  In recent versions of git, this uses the --merge-base
> option.
> 
> Note that the file names are taken from the commits, but Coccinelle
> doesn't run on the files at the time of the commits.  Coccinelle always
> runs on the current snapshot of the indicated file or directory.  For old
> commits, this may lead to messages about files that don't exist.
> 
> Let me know if this is useful.

Great, sounds like the exact thing I need.

And I would pass these to coccicheck as 

SPFLAGS="--use-patch-diff $hash1..$hash2"

?
